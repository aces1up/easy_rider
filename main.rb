

puts "Current Runtime Version: #{JRUBY_VERSION} -- Ruby Version: #{RUBY_VERSION}"
puts "Host OS: #{RbConfig::CONFIG['host_os'].inspect}"
puts "Arch: #{ENV_JAVA['sun.arch.data.model'].inspect}"


#require 'rubygems'
$LOAD_PATH << 'C:\jruby-gem-repository\gems\watir-webdriver-0.6.1\lib'
$LOAD_PATH << 'C:\jruby-gem-repository\gems\net-http-persistent-2.8\lib'
$LOAD_PATH << 'C:\jruby-gem-repository\gems\selenium-webdriver-2.25.0\lib'

require 'watir-webdriver'
require 'net/http/persistent'
sleep(1)

require 'easy_rider'


snap_path = 'C:/lwb-siteposter/screenshots/'
begin
rider = EasyRider.new
puts rider.inspect
rider.get('http://linkwheelbandit.com')
rider.get('http://weebly.com')
rider.get('http://dude.com')

  #rider.get('http://linkwheelbandit.com')
rider.get('http://weebly.com')
rider.get('http://dude.com')

#puts rider.url.inspect
#puts rider.url.inspect
#sleep(5)
#rider.save_html('c:/temp/html.htm')
#puts rider.html
rider.snapshot("#{snap_path}snap-#{rand(9999)}.png")



#puts "readystate : #{rider.wait_for_ready_state.inspect}"
ensure
   rider.quit if rider
end

=begin
threads = []
#5.times do
    #begin
    rider = EasyRider.new

      #100.times do


        puts "loop handler "
        rider.get('http://weebly.com')
        sleep(3)
        rider.all_elements
        rider.pg.divs.each do |field|
            puts field.id.inspect
            puts "   #{field.list_attributes}"
            #puts "   #{field.attribute_list}"
            puts "innerhtml"
            #puts field.inner_html.inspect
            field.append_stuff
            puts field.onkeypress if field.respond_to?(:onkeypress)
            puts field.respond_to?(:name).inspect
            #puts field.onkeypress.inspect
            #field(:xpath, "//div[@ignoreesc = 'true']").exists?
        end

        #puts rider.url
        #sleep(1)
        #rider.snapshot("#{snap_path}snap-#{rand(9999)}.png")

        #rider.get('http://weebly.com')
        #puts rider.url
        #rider.snapshot("#{snap_path}snap-#{rand(9999)}.png")

        #rider.get('http://skype.com')
        #puts rider.url
        #sleep(2)
        #rider.snapshot("#{snap_path}snap-#{rand(9999)}.png")

      #end
    #ensure
    #    rider.quit if rider
    #end
    rider.quit

#3.times do |count|
#    puts "loop count: #{count}"
#    rider.get('http://linkwheelbandit.com')
#    puts rider.url
#    rider.get('http://weebly.com')
#    puts rider.url
#    rider.get("http://skype.com")
#end


#}
#end
=end
#threads.each do |thr| thr.join end

