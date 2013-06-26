

class EasyRider

    class Client

      PHANTOM_PATH = 'C:/lwb-siteposter/dependancies/lb_worker.exe'
      DEFAULT_PORT = 7878

      attr_reader :pid, :proxy, :port

      def initialize( port = nil, options = {} )
          @port              ||= find_available_port
	        @proxy               = options[:proxy]

          start
      end

      def conn_info()
          "[PID: #{@pid.inspect}] -- [PORT: #{@port}]"
      end

      def find_available_port
          server = TCPServer.new('127.0.0.1', 0)
          server.addr[1]
      ensure
          server.close if server
      end

      def connect
        begin
          Timeout.timeout(5) do
              while @socket.nil?
                  attempt_connect
              end
          end
        ensure
          @socket.close if @socket
        end
      end

      def attempt_connect
          @socket = TCPSocket.open("127.0.0.1", @port)
      rescue Errno::ECONNREFUSED
      end

      def spawn(*args)
          args = args.map(&:to_s)
          Process.spawn(*args)
      end

      def start
          @pid = spawn(*command)
          connect
          puts "*** Client Started : #{conn_info} ***"
      end

      def stop

        if @pid
          begin
            #Process.kill('TERM', @pid)
            #Process.wait(pid)
            Process.spawn("taskkill /F /pid #{@pid} /T")
            puts "*** Client Stopped : #{conn_info}"
          rescue Errno::ESRCH, Errno::ECHILD
            # Zed's dead, baby
            puts "Error Stopping EasyRider Client -- [PID: #{@pid.inspect}]"
          end

          @pid = nil
        end
      end

      def restart
          stop
          start
      end

=begin
         ["c:/lwb-siteposter/dependancies/lb_worker.exe",
          "--ignore-ssl-errors=yes",
          "--load-images=no",
          "--cookies-file=c:/lwb-siteposter/cookies/cookie-1356727557-2592.txt",
          "--proxy=66.232.112.97:60099",
          "C:/jruby-gem-repository/gems/poltergeist-1.7.0/lib/capybara/poltergeist/client/compiled/main.js"
          , 62915        #<--- phantomjs port sent to script
          , 1024, 768]   #<--- window size sent to script
=end

      def fiddler_proxy()
          '--proxy=127.0.0.1:8888'
      end

      def command
        @command ||= begin
            #add out persistent cookie
            #phantomjs_options.push( cookie_directive )

            #set up our proxy phantom JS directives here
            #p_host_directive = proxy_host_directive
            #p_auth_directive = proxy_auth_directive
            #phantomjs_options.push( p_host_directive ) if p_host_directive
            #phantomjs_options.push( p_auth_directive ) if p_auth_directive

            #next line used just for testing.
            #phantomjs_options.push( proxy_test_directive )


            options = [ PHANTOM_PATH ]
            #options << fiddler_proxy
            options << '--ignore-ssl-errors=yes'
            options << '--load-images=no'
            options << "--webdriver=#{@port}"
            #options << "--webdriver-selenium-grid-hub=http://#{@hub.host}:#{@hub.port}"

            puts "Using Client Start Options: #{options.inspect}"
            options
        end
      end

    end
end
