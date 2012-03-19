#--
#=============================================================================#
# File: wip_unittest.rb
#
#
#  Copyright (c) 2008-2010, Joe DiMauro
#  All rights reserved.
#
# Description: WIP Unit tests for WatirWorks:
#
#=============================================================================#

#=============================================================================#
# Require and Include section
# Entries for additional files or methods needed by this test
#=============================================================================#
require 'rubygems'
require "test/unit"               # Require Ruby's Unit Test framework files

#  Inherit or set to run with Watir-Webdriver (true), or Watir (false)
if($bUseWebDriver == nil)
  $bUseWebDriver = false
end

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

# DishOnline
require 'dishonline-test'
include DishOnlineTest_RefLib # DishOnline Reference Library
include DishOnlineTest_Utilities # DishOnline Utilities Library

#=============================================================================#

#=============================================================================#
# Global Variables section
# Set global variables that will be inherited by each of the test files
#=============================================================================#

# Application specific variables
#
# Inherit or set the default test environment
if($sTestEnvironment == nil)
  # Set Test environment to one of these choices:
  #  PROD, PROD_NC, PROD_xx, PROD_xx_IP, STAGING, STAGING_NC, INT, INT_NC, QA, QA_NC
  $sTestEnvironment = "QA"
  #$sTestEnvironment = "PROD"
end

$sBaseURL = ENV_ROOT_URL[$sTestEnvironment]

if($iNetDelay == nil)
  $iNetDelay = 2
end

# Ruby global variables
#

# Watir global variables
#

$iNetDelay = 2

# Inherit or set the browser type
if($sDefaultBrowser == nil)
  # Uncomment the browser to be used for this test run
  $sDefaultBrowser = "firefox"
  #$sDefaultBrowser = "ie"
  #$sDefaultBrowser = "chrome"
  #$sDefaultBrowser = "opera"
  #$sDefaultBrowser = "safari"
  #$sDefaultBrowser = "android"
  #$sDefaultBrowser = "iphone"
  #$sDefaultBrowser = "remote"
end

=begin
if($sBrowserProfile == nil)
  #$sBrowserProfile = "default"
  #$sBrowserProfile = "Auto_DOL_NoAdd-Ons"
  $sBrowserProfile = "Auto_DOL_Add-Ons"
end

if(is_webdriver? != true)
  Watir::Browser.default = $sDefaultBrowser
end
=end

#Watir::Browser.default = $sDefaultBrowser

# WatirWorks global variables
#
sRun_TestType = "wip"
iRun_TestLevel = 0

#=============================================================================#
# Class: UnitTest_WIP
#
# Test Case Methods: setup, teardown
#
#
#=============================================================================#
class UnitTest_WIP < Test::Unit::TestCase

  @@bCloseBrowser = false
  @@bLogOutput = false  # Set to ture to enable logging to a file
  @@iDelay = 2    # Set a default delay time to be used as necessary
  @@bClearCache = false  # Set to true to clear the browesr's cache and cookies each voting cycle
  @@bCollectHTMLData = false # Set to true to capture HTML info (For Debugging only)
  @@bVerifyHTMLData = false # Set to true to verify HTML info
  @@sCurrentBrowser = ""
  @@bContinue = true

  #===========================================================================#
  # Method: setup
  #
  # Description: Before every testcase Test::Unit runs setup
  #===========================================================================#
  def setup

    # Save the Global variable's original settings so that they can be changed in this
    # test without affecting other test, so long as they are restored by teardown
    @@VERBOSE_ORIG = $VERBOSE
    @@DEBUG_ORIG = $DEBUG
    @@FAST_SPEED_ORIG = $FAST_SPEED
    @@HIDE_IE_ORIG = $HIDE_IE

    # Record the time that current test case starts
    @@tTestCase_StartTime = Time.now

    # Start a new Logger Object and assign it to a Global Object
    #
    # Using the default values:
    #   Create a "waitr_works/results" directory within the OS's Temporary directory
    #   That directory will contain the single log file used for all tests.
    #   If the current log file gets too big, output rolls to another log file.
    if(@@bLogOutput == true)
      $logger = capture_results()
    end

    # Hide the annoying console window so that it doesn't cover any of the screen
    minimize_ruby_console()

    # Record the test environment if it hasen't already been recorded
    if($bEnvironmentRecorded != true)
      $bEnvironmentRecorded = record_environment()
      @@bContinue = $bEnvironmentRecorded
    end

    # Open the Workbook containing the data for the test cases,
    # and read the data into memory if it hasen't already been read
    if((@@bContinue == true) and ($bDataSetRead != true))
      #$bDataSetRead = read_dataset()
      @@bContinue = $bDataSetRead
    end

    # Open a browser and access the site if it hasen't already been recorded
    #if((@@bContinue == true) and ($bWebSiteAccessed != true))

     $browser = start_browser($sDefaultBrowser)
     #$browser.goto("www.ask.com")

      #$bWebSiteAccessed = access_dishonline()
      @@bContinue = $bWebSiteAccessed
    #end



  end # end of setup

  #===========================================================================#
  # Method: teardown
  #
  # Description: After every testcase Test::Unit runs teardown
  #===========================================================================#
  def teardown

    # Calculate and record the elapsed time for the current test case
    puts2("\nTestcase finished in  " + calc_elapsed_time(@@tTestCase_StartTime, true))

    # Check for any Errors
    #$browser.recover_from_error()

    # Check if the $browser needs to be closed
    # NOTE: RAutomation currently only runs on Windows
    if(@@bCloseBrowser == true)

      puts2("Attempting to close the current browser...")
      if(($browser.link(:href => "/logout").exists?) and ($browser.link(:href => "/logout").visible?))
        puts2("Logging out...")
        $browser.link(:href => "/logout").click
        sleep($iNetDelay) # Short delay before closing the browser
      end

      puts2("\t Attempting to stop: " + $sDefaultBrowser.downcase.strip)

      # Force any open $browsers to exit
      case $sDefaultBrowser.downcase.strip
        when /ie/
        $browser.exit_browsers("ie")
        sleep($iNetDelay)
        when /firefox/
        $browser.exit_browsers("ff")
        sleep($iNetDelay)
        when /safari/
        $browser.exit_browsers("safari")
        sleep($iNetDelay)
      end

      if(@@bClearCache == true)
        puts2("Clear the $browser cache...")
        clear_cache()

        # Turn it off again
        @@bClearCache == false
      end

      # Turn it off again
      @@bCloseBrowser = false

    end # Check if the $browser needs to be closed


    # Restore the Global variable's original settings
    $VERBOSE = @@VERBOSE_ORIG
    $DEBUG = @@DEBUG_ORIG
    $FAST_SPEED = @@FAST_SPEED_ORIG
    $HIDE_IE = @@HIDE_IE_ORIG

    puts2("#"*40)

  end # end of teardown

  #===========================================================================#
  # Testcase: test_002_wip
  #
  # Description:
  #  http://www.w3schools.com/js/js_browser.asp
  #  http://www.quirksmode.org/js/detect.html
  #
  #===========================================================================#
  def test_002_wip

    begin

      sTestCase_Name = "test_002_wip"
      puts2("Starting Testcase: #{sTestCase_Name}")

      sleep(2)

    #puts2("Is jQuery active?")
    #$browser.execute_script("return jQuery.active == 0")

    if($bUseWebDriver == false)
	    puts2("Browser name: " + $browser.execute_script("window.navigator.appName").to_s)
	    puts2("Browser version: " + $browser.execute_script("window.navigator.appVersion").to_s)
	    puts2("Cookies Enabled: " + $browser.execute_script("window.navigator.cookieEnabled").to_s)
	    puts2("Platform: " + $browser.execute_script("window.navigator.platform").to_s)
	    puts2("User Agent: " + $browser.execute_script("window.navigator.userAgent").to_s)
	    puts2("appCodeName: " + $browser.execute_script("window.navigator.appCodeName").to_s)
    else
	    puts2("Browser Name: " + $browser.execute_script("navigator.appName").to_s)
	    puts2("Browser version: " + $browser.execute_script("window.navigator.appVersion").to_s)
	    puts2("Cookies Enabled: " + $browser.execute_script("window.navigator.cookieEnabled").to_s)
	    puts2("Platform: " + $browser.execute_script("window.navigator.platform").to_s)
	    puts2("User Agent: " + $browser.execute_script("window.navigator.userAgent").to_s)
	    puts2("appCodeName: " + $browser.execute_script("window.navigator.appCodeName").to_s)
    end

    puts2("Brand: " + $browser.brand())
    puts2("Version: " + $browser.version())

=begin
   #def brand()

	   sRawType = $browser.execute_script("window.navigator.userAgent")
	   #sRawType = self.execute_script("window.navigator.userAgent")

	if(sRawType =~ /MSIE \d/)
		sType = "IE"
	elsif(sRawType =~ /Firefox\//)
		sType = "Firefox"
	elsif(sRawType =~ /Chrome\//)
		sType = "Chrome"
	elsif(sRawType =~ /Safari\/\d\.\d/)
		sType = "Safari"
	elsif(sRawType =~ /Opera\//)
		sType = "Opera"
	else
		sType = "Unknown"
	end

        puts2(sType)

	#return sType

   #end

=end

=begin
#def version()

           # Use this as a URL   javascript:alert(window.navigator.userAgent);
	   sRawType = $browser.execute_script("window.navigator.userAgent")
	   #sRawType = self.execute_script("window.navigator.userAgent")

	if(sRawType =~ /MSIE \d/)
	        # IE 8.0 returns this:
		#   Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 6.0; WOW64; Trident/4.0; SLCC1; .NET CLR 2.0.50727; Media Center PC 5.0; .NET CLR 3.5.30729; .NET CLR 3.0.30729; .NET4.0C; MS-RTC LM 8)
		sVersion = sRawType.remove_prefix(";").prefix(";").remove_prefix(" ")
	elsif(sRawType =~ /Firefox\//)
		# Firefox 3.6.28 returns this:
		#   Mozilla/5.0 (Windows; U; Windows NT 6.0; en-US; rv:1.9.2.28) Gecko/20120306 Firefox/3.6.28
		sVersion = sRawType.suffix("/")
	elsif(sRawType =~ /Chrome\//)
		# Chrome 17.0.963.79 returns this:
		#   Mozilla/5.0 (Windows NT 6.0; WOW64) AppleWebKit/535.11 (KHTML, like Gecko) Chrome/17.0.963.79 Safari/535.11
		sVersion = sRawType.suffix(")").remove_prefix("/").prefix(" ")
	elsif(sRawType =~ /Safari\/\d\.\d/)
		# Safari 5.1.4 returns this:
		#   Mozilla/5.0 (Windows NT 6.0; WOW64) AppleWebKit/534.54.16 (KHTML, like Gecko) Version/5.1.4 Safari/5.3.4.54.16
		sVersion = sRawType.suffix(")").remove_prefix("/").prefix(" ")
	elsif(sRawType =~ /Opera\//)
		# Opera 11.61 returns this:
		#   Opera/9.80 (Windows NT 6.0; U; en) Presto/2.10.229 Version/11.61
		sVersion = sRawType.suffix("/")
	else
		sVersion = "-1"
	end

        puts2(sVersion)

	#return sVersion

   #end
=end

=begin

# Example outputs on Win7 64bit for FF3.6.28 and IE 8

Browser name: Netscape
Browser version: 5.0 (Windows; en-US)
Cookies Enabled: true
Platform: Win32
User Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; en-US; rv:1.9.2.28) Gecko/20120306 Firefox/3.6.28
appCodeName: Mozilla

Browser name: Microsoft Internet Explorer
Browser version: 4.0 (compatible; MSIE 8.0; Windows NT 6.0; WOW64; Trident/4.0; SLCC1; .NET CLR 2.0.50727; Media Center PC 5.0; .NET CLR 3.5.30729; .NET CLR 3.0.30729; .NET4.0C; MS-RTC LM 8)
Cookies Enabled: true
Platform: Win32
User Agent: Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 6.0; WOW64; Trident/4.0; SLCC1; .NET CLR 2.0.50727; Media Center PC 5.0; .NET CLR 3.5.30729; .NET CLR 3.0.30729; .NET4.0C; MS-RTC LM 8)
appCodeName: Mozilla

=end

    #$browser.execute_script("BrowserDetect.OS")
    #$browser.execute_script("BrowserDetect.browser")
    #$browser.execute_script("BrowserDetect.version")

    rescue => e

    puts2("*** ERROR Backtrace: " + e.message + "\n" + e.backtrace.join("\n"), "ERROR")

  ensure

   $browser.close()

  end

end

#===========================================================================#
# Testcase: test_DOL_015_Access_MetaTags
#
# Description: Gets the Header tag and access its various tags (META>, <Script>, <TITLIE>
#
#                   INvestigating how to create methods: browser.head(), browser.meta_tag()
#
#  Based on info at:
#         http://groups.google.com/group/watir-general/browse_thread/thread/1ea0ecb1166c8c9f/ee0d7df541721ae4?lnk=gst&q=meta+tag#ee0d7df541721ae4
#         http://groups.google.com/group/watir-general/browse_thread/thread/6955c09c22a5ee4f/fb77d5b1ea6e1340?lnk=gst&q=meta+tag#fb77d5b1ea6e1340
#===========================================================================#
def te_st_DOL_015_Access_MetaTags

  sTestCase_Name = "test_DOL_015_Access_MetaTags"
  #sPageName = "Home"
  puts2("")
  puts2("Starting Testcase: #{sTestCase_Name}")


  begin
    #puts2("Reading HTML <HEAD>")

=begin
#          Watir-WebDriver
=end
    if(is_webdriver? == true)

      puts2("WebDriver META tag code")


      sMetaTag = $browser.meta(:index => 0).html
      puts2("Meta tag[0]: " + sMetaTag.to_s)

      iMetaTagCount = $browser.metas.length
      puts2("Meta tag count: " + iMetaTagCount.to_s)

      aMetaTags = $browser.metas

      aMetaTags.each do | oMetaTag |
        sMetatag = oMetaTag.html
        puts2("Meta tag: '" + sMetaTag + "'")
      end


    end # WWD

=begin
#          Watir
=end
    if((is_webdriver? != true) and ($browser.is_ie? == true))
      puts2("Watir::IE META tag code")

      oFullHtml = $browser.document.body.parentElement   # $browser.document.body.parentElement()
      puts2(oFullHtml)
      sFullXML = oFullHtml.invoke("innerHTML")

      #puts2("\t" + oFullHtml.invoke("innerHTML"))


      puts2("\n Get the <head> tag")
      sTag = "HEAD"
      sHeadTag = getXMLTagValue(sFullXML, sTag)
      #puts2("Head tag class: " + sHeadTag.class.to_s)
      #puts2("Head tag: " + sHeadTag)

      puts2("\n Get Watir::IE Meta tags")
      sTag = "META"

      # Populate array with separate lines, spilt at new line
      aHeadTagArray = sHeadTag.split("\n")

      aMetaTags = []
      aHeadTagArray.each do |sLine |
        #puts2(sLine)
        #puts2("#"*10)
        if(sLine =~ /#{sTag}/)
          #puts2(sLine)
          # Remove the Carriage Return
          aMetaTags << sLine.sub("\r","")
        end
      end

      aMetaTags.each do | sMetaTag |
        puts2("Meta tag: '" + sMetaTag.strip + "'")
      end
    end # IE

=begin
#          FireWatir
=end
    if((is_webdriver? != true) and ($browser.is_ff? == true))
      puts2("FireWatir::Firefox META tag code")

      sPageHTML = $browser.html
      #getXMLTagValue(sXML, sTag)
      sPageHeader = getXMLTagValue(sPageHTML, "head")
      #puts2("Page Header: " + sPageHeader)

      sTag = "meta"

      # Populate array with separate lines, spilt at new line
      aHeadTagArray = sPageHeader.split("\n")

      aMetaTags = []
      aHeadTagArray.each do |sLine |
        #puts2(sLine)
        #puts2("#"*10)
        if(sLine =~ /#{sTag}/)
          #puts2(sLine)
          # Remove the Carriage Return
          aMetaTags << sLine.sub("\r","")
        end
      end

      aMetaTags.each do | sMetaTag |
        puts2("Meta tag: '" + sMetaTag.strip + "'")
      end


=begin

	aMetaTags = sPageHeader.grep("<meta")
	puts2("Meta tags: '" + aMetaTags.to_s + "'")

	aMetaTags.each do | sMetaTag |
          puts2("Meta tag: '" + sMetaTag + "'")
        end
=end

=begin
	# Try the webdriver code
	#  *** ERROR Backtrace: undefined method `meta' for #<FireWatir::Firefox:0x4fb95d0>
	sMetaTag = $browser.meta(:index => 0).html
	puts2("Meta tag[0]: " + sMetaTag.to_s)

	iMetaTagCount = $browser.metas.length
	puts2("Meta tag count: " + iMetaTagCount.to_s)

	aMetaTags = $browser.metas

	aMetaTags.each do | oMetaTag |
		sMetatag = oMetaTag.html
		puts2("sMetatag: " + sMetatag.to_s)
	end
=end
    end  # FF

  rescue => e

    puts2("*** ERROR Backtrace: " + e.message + "\n" + e.backtrace.join("\n"), "ERROR")

    #puts2("")
    #puts2("\t Current Url - :   "+ $browser.url)
    #puts2("\t Current Title - :   "+ $browser.title)
    #$browser.save_screencapture("Dish" + sPageName , false) # Save the desktop
    #$browser.save_html("Dish" + sPageName)

    #$browser.generate_testcode_html_tag_counts()
    #$browser.generate_testcode_html_tag_attributes()

    raise("*** TESTCASE - #{sTestCase_Name}")

  ensure

    #@@bContinue = true # Set flag since testcase passed

    # Set the flag to close the $browser after the last test case runs
    #@@bCloseBrowser = true

  end

end

#===========================================================================#
# Testcase: test_DOL_016_Access_SupportHome
#
# Description: Gets the ID of the Dish Online window then validates that the
#              Support Home page open in a new window. Finally closes the
#              Help window and returns focus to the Dish Online window.
#
#===========================================================================#
def te_st_DOL_016_Access_SupportHome

  sTestCase_Name = "test_DOL_016_Access_SupportHome"
  sPageName = "Support Home"
  puts2("")
  puts2("Starting Testcase: #{sTestCase_Name}")

  # Continue since prior test cases have passed
  if(@@bContinue == true)
    #@@bContinue = false # Clear flag since this test has NOT passed yet

    begin  # Access Validation DOL page: Support Home

      puts2("\t Get the identifiers of the current window...")
      sMainWindowTitle = $browser.title
      sMainWindowURL = $browser.url
      puts2("\t sMainWindowTitle:  '" + sMainWindowTitle + "'")
      puts2("\t sMainWindowURL:  " + sMainWindowURL)
      if($browser.is_ie? == true)
        iMainWindowHWND = $browser.hwnd() # Not supported in FireWatir
        puts2("\t iMainWindowHWND " + iMainWindowHWND.to_s)
      end

=begin
    ################## Support Home ##################
=end

      # Capture time before navigating to next page
      tPageLoadTime = Time.now

      puts2("Accessing page - " + sPageName)
      assert($browser.access_quicklink_Help?())

      puts2("\t Attach to the new window...")

      # Secondary window
      $browser.window(:url => EXTERNAL_SITE_URL["SupportHome"]).use do

        $browser.wait_until_status("Done")

        # Calculate and record the elapsed time for the current test case
        puts2("\t Page load time - " + sPageName + ",  " + calc_elapsed_time(tPageLoadTime, false))
        puts2("\t Url - " + sPageName + " :   "+ $browser.url)
        puts2("\t Title - " + sPageName + " :   "+ $browser.title)

        sActualSecondaryBrowserUrl = $browser.url
        sExpectedSecondaryBrowserUrl = EXTERNAL_SITE_URL["SupportHome"]

        puts2("\t Validating on the page: " + sPageName)
        if(sExpectedSecondaryBrowserUrl != sActualSecondaryBrowserUrl)
          raise("*** URL's don't match. \n\t Expected: " + sExpectedSecondaryBrowserUrl + "\n\t Actual: " + sActualSecondaryBrowserUrl)
        else
          assert($browser.isPage_dishonline_SupportHome?()== true)
        end

        puts2("Close the second window...")
        $browser.window(:url => EXTERNAL_SITE_URL["SupportHome"]).close

      end # Secondary window

      puts2("Back to the main window...")
      puts2("\t Current browser Url: " + $browser.url.to_s)
      puts2("\t Current browser Title: " + $browser.title.to_s)

      puts2("\t Validating on the page: Home")
      assert($browser.isPage_dishonline_Home?() == true)


    rescue => e

      puts2("*** ERROR Backtrace: " + e.message + "\n" + e.backtrace.join("\n"), "ERROR")

      puts2("")
      puts2("\t Current Url - :   "+ $browser.url)
      puts2("\t Current Title - :   "+ $browser.title)
      #$browser.save_screencapture("Dish" + sPageName , false) # Save the desktop
      $browser.save_html("Dish" + sPageName)

      #$browser.generate_testcode_html_tag_counts()
      #$browser.generate_testcode_html_tag_attributes()

      raise("*** TESTCASE - #{sTestCase_Name}")

    ensure

      #@@bContinue = true # Set flag since testcase passed

      # Set the flag to close the $browser after the last test case runs
      #@@bCloseBrowser = true


    end # Access Validation DOL page: Support Home

  end # Continue since prior test cases have passed

end # END TestCase - test_DOL_016_Access_SupportHome


#===========================================================================#
# Testcase method: test_099_WIP
#
# Description: Test the method
#
#===========================================================================#
def te_st_099_WIP

  sTestCase_Name = "test_099_WIP"
  puts2("Starting Testcase: #{sTestCase_Name}")

  puts2("Close the window")

  # Set the flag to close the $browser after the last test case runs
  @@bCloseBrowser = true

end # test_WIP

end # class UnitTest_WIP
