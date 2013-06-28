
require 'uri'
require 'watir-webdriver'
require 'easy_rider/elements_helper'
require 'easy_rider/easy_driver'

#  "--proxy-auth=#{@proxy[:user]}:#{@proxy[:pass]}"
#  "--proxy=64.120.63.126:55555"
#  "--ignore-ssl-errors=yes"
#  "--load-images=no"
#  "--ignore-ssl-errors=[true|false]"  default == false
#  "--cookies-file=/path/to/cookies.txt"
#  "--load-styles=[yes|no]"  #<--- might not be implemented

class EasyRider
  
    include ElementsHelper

    attr_reader   :conn

    def initialize( options={} )

        @proxy              = options[:proxy]             || nil
        @use_images         = options[:use_images]        || false
        @load_js            = options[:load_js]           || true
        @load_css           = options[:load_css]          || true
        @ignore_ssl_errors  = options[:ignore_ssl_errors] || true
        @window_size        = options[:window_size]       || [ 1024, 768 ]
        @browser_type       = options[:browser_type]      || :phantomjs
        @user_agent         = options[:user_agent]        || nil

        @conn         = nil

        @load_css = @load_css ? 'yes' : 'no'

        init_connection()
    end

    def switches()
        args = []
        args << "--ignore-ssl-errors=#{@ignore_ssl_errors}"
        #args << "--load-styles=#{@load_css}"
        args << "--proxy=#{@proxy[:ip]}:#{@proxy[:port]}" if @proxy
        args << "--proxy-auth=#{@proxy[:user]}:#{@proxy[:pass]}" if @proxy and @proxy[:user]
        args << "--load-images=#{@use_images}"
        args
    end

    def init_connection()
        if @browser_type == :phantomjs
           @conn = Watir::Browser.new( @browser_type, :args => switches )
        else
           @conn = Watir::Browser.new( @browser_type )
        end
        @conn.window.resize_to( @window_size[0], @window_size[1] )
    end

    def screenshot( filename )
        @conn.screenshot.save filename
    end

    def url()
        @conn.url
    end

    def uri()
        cur_url = url
        return nil if cur_url.nil? or cur_url.empty?
        URI( cur_url )
    end

    def html()
        @conn.html
    end

    def get( url, header={} )
        @conn.goto( url )
    end

    def method_missing( method, *args)
        @conn.respond_to?( method ) ? @conn.send( method, *args ) : super
    end

end
