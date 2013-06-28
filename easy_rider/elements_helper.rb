
#our specific element patches

module Watir
    class Element

        def element_info()
            puts "info for element: #{@element.class.to_s}:#{@element.__id__}"
            puts @element.methods.inspect
            puts "@parent: #{@parent.class.to_s} -- #{@element.__id__}"
            puts "@slector : #{@selector.class.to_s} -- #{@selector.__id__} -- #{@selector.inspect}"
        end

        def flash( num_times, sleep_interval )

            background_color = style("backgroundColor")
            element_color = driver.execute_script("arguments[0].style.backgroundColor", @element)

            num_times.to_i.times do |n|
              color = (n % 2 == 0) ? "red" : background_color
              driver.execute_script("arguments[0].style.backgroundColor = '#{color}'", @element)
              sleep sleep_interval.to_f
            end

            driver.execute_script("arguments[0].style.backgroundColor = arguments[1]", @element, element_color)

            self
        end
        
        def hover_js()#(type, selector, options = {})
        # Get element to mouse over
        e = @element
        # Use Javascript to mouseover
        browser.execute_script(%Q[
              if(document.createEvent){
                  var evObj = document.createEvent('MouseEvents');
                  evObj.initEvent('mouseover', true, false); 
                  arguments[0].dispatchEvent(evObj);
              } else if(document.createEventObject) { 
                arguments[0].fireEvent('onmouseover');
              }], e)
        end


        def list_attributes
            attributes = browser.execute_script(%Q[
                var s = {};
                var attrs = arguments[0].attributes;
                for (var l = 0; l < attrs.length; ++l) {
                    var a = attrs[l]; s[a.name]=a.value;
                } ;
                return s;],
                self )
        end

        def children_for_element( get_invisible=false )
            invis_method = get_invisible ? :exists? : :present?
            send( :elements, :xpath, "*" ).to_a.find_all{ |ele| ele.send( invis_method ) }
            
            #next line breaks things when changing element to subtype
            #found.map{ |ele_found| ele_found.to_subtype  }
        end

    end
end


class EasyRider

    module ElementsHelper

        def root_element()
            @conn.bodys.first
        end

        def root_parent( element )
            parent = element.parent
            parent ? root_parent( parent ) : element
        end

        def children_for_element( get_invisible=false )
            root_element.children_for_element( get_invisible )
        end

    end
end
