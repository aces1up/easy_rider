

module Selenium
  module WebDriver
    module PhantomJS

      class Service

          def self.find_phantom_exe()
              defined?( PhantomJSEXE ) ? PhantomJSEXE : nil
          end

          def self.executable_path()
              @executable_path ||= (
                path = find_phantom_exe
                path or raise Error::WebDriverError, "Cannot find PhantomJS.exe Please Set Constant: PhantomJSEXE with exe path."
                path
              )
          end

          def create_process(args)
              server_command = [@executable, "--webdriver=#{@uri.port}", *args]
              #next line breaks stuff in windows
              #process = ChildProcess.build(*server_command.compact)
              process = ChildProcess::JRuby::Process.new( server_command.compact )

              if $DEBUG == true
                process.io.inherit!
              elsif Platform.jruby?
                # apparently we need to read the output for phantomjs to work on jruby
                process.io.stdout = process.io.stderr = File.new(Platform.null_device, 'w')
              end

              process
          end

      end

    end
  end
end


