

#elements
require 'elements/all_elements'
require 'elements/watir_element_patches'

#navigation
require 'waiters/navigation_waits'


require 'rider_client'
require 'easy_driver'

class EasyRider

    include NavigationWaits
    include ALLelements

    attr_reader :pg

    RESET_METHODS = []
    RESET_VARS    = []

    def initialize()

      begin

        @client = EasyRider::Client.new()
        @driver = EasyRider::Driver.new( @client.port )
        @pg     = @driver.browser

      rescue => err
          puts "EasyRider Intialization Error : #{err.message}\n#{err.backtrace}"
          quit
      end

    end

    def quit()
        @driver.stop if @driver
        @client.stop if @client
    end

    def restart()
       
    end



    def snapshot(filename)
        @pg.screenshot.save filename
    end

    def url()
        @pg.url
    end

    def html()
        @pg.html
    end

    def page_size()
        html.length
    end

    def rider_stats()
        "#{url} -- #{page_size}"
    end

    def save_html(filename)
        File.open( filename, 'w' ) {|f| f.write( html ) }
    end

    def body()
        #@pg.body
        @pg.element(:tag_name => 'body').text
    end

    def get( fetch_url )
        puts "[EasyRider] -- Fetching : #{fetch_url}"
        @pg.goto( fetch_url )
        wait_for_ready_state
        wait_for_url_change
        wait_for_body

        #puts rider_stats
    end



    

end


=begin
   sleep(2)
            script = "_.defer(function() { $('body').append(\"<div id='9939'></div>\");});"

            cur_url = @browser.url
            @browser.goto "http://linkwheelbandit.com"

            retry_count = 0
            while @browser.url == cur_url
                retry_count += 1
                puts  "still the same #{retry_count}"
                sleep(0.1)
            end
            #@browser.execute_script <<-JS
            #    document.addEventListener('load', function(){document.body.appendChild(\"<div id='9939'></div>\");}, false);
            #JS
            #sleep(0.7)
            h1s = @browser.h1s
            arefs = @browser.as
            brs = @browser.brs
            puts brs[0].class
            puts brs[0].text.inspect
            puts arefs[0].text.inspect
            puts h1s.length
            puts @browser.div(:id=>'9939').exists?.inspect

=end