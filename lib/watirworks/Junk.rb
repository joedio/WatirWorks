require 'rubygems'
require 'watir-webdriver'
#require 'selenium-webdriver'

# WatirWorks
require 'watirworks'  # The WatirWorks library loader
include WatirWorks_Utilities    # WatirWorks General Utilities
include WatirWorks_WebUtilities # WatirWorks Web Utilities

# Include the platform specific modules
if(is_win?)
  include WatirWorks_WinUtilities # WatirWorks Windows Utilities
elsif(is_linux?)
  include WatirWorks_LinuxUtilities # WatirWorks Linux Utilities
elsif(is_mac?)
  include WatirWorks_MacUtilities # WatirWorks MacOSX Utilities
end




puts RUBY_PLATFORM.downcase

#puts2(" Watir: " + Watir::VERSION)

puts2("is_webdriver? " + is_webdriver?.to_s)
puts2("is_selenium_webdriver? " + is_selenium_webdriver?.to_s)


sSupportedBrowserTypes = ["firefox", "chrome", "ie"]

# Loop on browser types
sSupportedBrowserTypes.each do | sBrowserType |

	puts2("="*15)

	#sBrowserType = "firefox"
	$browser = start_browser(sBrowserType)

=begin
	puts2($browser.class.to_s) #   With Watir => "Watir::IE"    with WebDriver => "Watir::Browser"

	#puts2($LOADED_FEATURES)


	case $LOADED_FEATURES.to_s
		when /selenium\/webdriver\/ie/
			puts2("Browser =  IE")
			#selenium/webdriver/ie/bridge.rb
			#selenium/webdriver/ie.rb
		when /selenium\/webdriver\/chrome/
			puts2("Browser =  Chrome")
			#selenium/webdriver/chrome/bridge.rb
			#selenium/webdriver/chrome.rb
		when /selenium\/webdriver\/firefox/
			puts2("Browser = Firefox")
			#selenium/webdriver/firefox/bridge.rb
			#selenium/webdriver/firefox.rb
		else
			puts2("Browser = Unknown")
	end
=end

	      puts2("\nIs it a Chrome browser?: " + $browser.is_chrome?.to_s)

	      puts2("\nIs it an IE browser?: " + $browser.is_ie?.to_s)
	      puts2("Is it an IE 6.x browser?: " + $browser.is_ie6?.to_s)
	      puts2("Is it an IE 7.x browser?: " + $browser.is_ie7?.to_s)
	      puts2("Is it an IE 8.x browser?: " + $browser.is_ie8?.to_s)
	      puts2("Is it an IE 9.x browser?: " + $browser.is_ie9?.to_s)

	      puts2("\nIs it a Firefox browser?: " + $browser.is_firefox?.to_s)
	      puts2("Is it a Firefox 2.x browser?: " + $browser.is_firefox2?.to_s)
	      puts2("Is it a Firefox 3.x browser?: " + $browser.is_firefox3?.to_s)
	      puts2("Is it a Firefox 4.x browser?: " + $browser.is_firefox4?.to_s)
	      puts2("Is it a Firefox 5.x browser?: " + $browser.is_firefox5?.to_s)
	      puts2("Is it a Firefox 6.x browser?: " + $browser.is_firefox6?.to_s)
	      puts2("Is it a Firefox 7.x browser?: " + $browser.is_firefox7?.to_s)

	      puts2("\nIs it a Opera browser?: " + $browser.is_opera?.to_s)
	      puts2("Is it a Safari browser?: " + $browser.is_safari?.to_s)
	      puts2("Is it a Android browser?: " + $browser.is_android?.to_s)

	# $LOADED_FEATURES.to_s =~ /selenium\/webdriver\/ie/

        puts2("$browser ...")
	puts2($browser)
	#display_ruby_global_variables()


	$browser.close
	sleep(2)
	$browser = nil
	$bBrowserStarted = false
	$bStartedBrowser = false

end # Loop on browser types

# FF = $browser =
#<Watir::Browser:0x4d3ae88>,	  Class: Watir::Browser
#<Watir::Browser:0x4c5b790>


# CR = $browser =
#<Watir::Browser:0x9051480>,	  Class: Watir::Browser
#<Watir::Browser:0x8d32820>

# IE = $browser =
#<Watir::Browser:0x8fa6510>,	  Class: Watir::Browser
#<Watir::Browser:0x8c907a8>
