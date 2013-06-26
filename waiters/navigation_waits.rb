

module NavigationWaits

    def wait_while_block(timeout_ms)

        #waits for timeout to pass or
        #for block passed to result to false

        retry_c = 0

         while yield and retry_c < timeout_ms
            #puts "waiting while condition"
            retry_c += 1
            sleep(0.1)
         end

         puts "Block Wait Timed out!!!" if retry_c >= timeout_ms
         retry_c  #<--- reply with the wait time needed
    end

    def wait_until_block(timeout_ms)
        #waits for timeout to pass or
        #for block passed to result to false

        retry_c = 0

         while !yield and retry_c < timeout_ms
            puts "waiting until condition"
            retry_c += 1
            sleep(0.1)
         end

         puts "Block Wait Timed out!!!" if retry_c >= timeout_ms
         retry_c  #<--- reply with the wait time needed
    end

    def wait_for_url_change(timeout_ms=100)  #<--- default timeout is 10 seconds
        cur_url = url
        wait_while_block(timeout_ms) {cur_url == url}
    end

    def ready_state()
        @pg.execute_script( 'return document.readyState;' )
    end

    def ready_state_complete?()
        !ready_state.nil? and ready_state == 'complete'
    end

    def wait_for_ready_state()
        wait_until_block(150) { ready_state_complete? }        
    end

    def set_body_id()
        puts "first : #{@pg.element(:tag_name => 'body').__id__.inspect}"
        puts "second : #{@pg.element(:tag_name => 'body').__id__.inspect}"

    end
    
    def body_exists?()
      begin
        @pg.element(:tag_name => 'body').exists? and !@pg.element(:tag_name => 'body').text.empty?
      rescue Selenium::WebDriver::Error::StaleElementReferenceError => err
        puts "got stale error"
        false
      end
    end

    def body_visible?()
        @pg.element(:tag_name => 'body').visible?
    end
    
    def wait_for_body()
        #set_body_id
        #puts "body visible start ? #{@pg.element(:tag_name => 'body').visible?}"
        #wait_until_block(150) { !body_exists?  }

        wait_until_block(150) { body_exists?  }
        #puts "body id after : #{body_id.inspect}"
        puts "body visible? #{@pg.element(:tag_name => 'body').visible?}"
    end

end
