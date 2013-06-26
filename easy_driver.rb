

require 'selenium/webdriver/remote/http/persistent'

module Selenium
  module WebDriver
    module Remote
      class Capabilities
         #Add a Sweet New Entry for our Phantom Js Client
         def self.phantomjs(opts = {})
            new({
              :browser_name          => "phantomjs",
              :javascript_enabled    => true,
              :takes_screenshot      => true,
              :css_selectors_enabled => true
            }.merge(opts))
          end
      end
    end
  end
end


class EasyRider

    class Driver

        DEFAULT_SERVER_IP = '127.0.0.1'

        attr_reader :browser

        def initialize( port, server_ip = DEFAULT_SERVER_IP )

            @server_ip   = server_ip
            @port        = port
            @browser     = nil
            @path        = '/wd/hub'

            start
        end

        def start()

            #next line is for starting hub
            #@agent = Watir::Browser.new(:remote, :http_client => @http_client, :url => "http://#{@server_ip}:#{@port}#{@path}")

            url = "http://#{@server_ip}:#{@port}"
            puts "*** Driver Connecting to Hub URL #{url.inspect}"

            #client = Selenium::WebDriver::Remote::Http::Persistent.new

            @browser = Watir::Browser.new(:remote, :url => url, :desired_capabilities => :phantomjs )

            puts "*** Started Driver on : #{url} ***"
        end

        def stop()
            
        end

    end

end
