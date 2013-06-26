

module Watir
    class Element
        def list_attributes
            attributes = browser.execute_script(%Q[
                var s = [];
                var attrs = arguments[0].attributes;
                for (var l = 0; l < attrs.length; ++l) {
                    var a = attrs[l]; s.push(a.name + ': ' + a.value);
                } ;
                return s;],
                self )
        end

        def inner_html()
            browser.execute_script(%Q[
                var s = [];
                ele = arguments[0]
                return ele.innerHTML;],
                self )
        end

        def append_stuff()
              #uuid = '9939'
              #browser.execute_script(%Q[
              #  var s = [];
              #  ele = arguments[0]
              #  ele.appendChild("<div id='#{uuid}'></div>");
              #  return 1;],
              #  self )
              browser.execute_script("document.body.appendChild(document.createTextNode('Great Success!'));")
        end
    end
end


