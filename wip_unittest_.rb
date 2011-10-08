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
  #$sTestEnvironment = "PROD_16"
end

$sBaseURL = ENV_ROOT_URL[$sTestEnvironment]

if($iNetDelay == nil)
  $iNetDelay = 2
end

# Ruby global variables
#

# Watir global variables
#

# WatirWorks global variables
#
sRun_TestType = "browser"
iRun_TestLevel = 0

#$bUseWebDriver = true
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

    # Record the time that current test case starts
    @@tTestCase_StartTime = Time.now

  end # end of setup

  #===========================================================================#
  # Method: teardown
  #
  # Description: After every testcase Test::Unit runs teardown
  #===========================================================================#
  def teardown

    # Calculate and record the elapsed time for the current test case
    puts2("\nTestcase finished in  " + calc_elapsed_time(@@tTestCase_StartTime, true))

    # Check if the $browser needs to be closed
    # NOTE: RAutomation currently only runs on Windows
    if(@@bCloseBrowser == true)

=begin
      if($browser.link(:href => "/logout").exists?)
        puts2("Logging out...")
        $browser.link(:href => "/logout").click
        sleep($iNetDelay) # Short delay before closing the browser
      end
=end

      # Force any open $browsers to exit
      case @@sCurrentBrowser.downcase.strip
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
      end

    end # Check if the $browser needs to be closed


    # Restore the Global variable's original settings
    $VERBOSE = @@VERBOSE_ORIG
    $DEBUG = @@DEBUG_ORIG
    $FAST_SPEED = @@FAST_SPEED_ORIG
    $HIDE_IE = @@HIDE_IE_ORIG

    puts2("#"*40)

  end # end of teardown


  #===========================================================================#
  # Testcase: test_DOL_000_RecordEnvironment
  #
  # Description: Records information about the testing environment
  #
  #===========================================================================#
  def test_DOL_000_RecordEnvironment

    # Only run if this task has not been performed by another script
    if($bEnvironmentRecorded != true)

      sTestCase_Name = "test_DOL_000_RecordEnvironment"
      puts2("Starting Testcase: #{sTestCase_Name}")

      @@bContinue = false # Clear flag since test has NOT passed yet

      #$VERBOSE = true

      begin

        ################################
        # Collect Test Environment Info
        ################################
        sleep(@@iDelay)

        puts2("")
        puts2("##### Test Environment Info #####")
        puts2("IE version: " + get_ie_version.to_s)
        puts2("Firefox version: " + get_firefox_version.to_s)
        puts2("Default browser: " + $sDefaultBrowser)
        puts2("")

        display_ruby_env()
        display_watir_env()
        display_watirworks_env()
        puts2("")


        printenv("COMPUTERNAME") # Is this one platform independent?
        printenv("USERDNSDOMAIN") # Is this one platform independent?
        printenv("NUMBER_OF_PROCESSORS") # Is this one platform independent?
        printenv("OS") # Is this one platform independent?
        printenv("PROCESSOR_IDENTIFIER") # Is this one platform independent?
        printenv("USERNAME") # Is this one platform independent? Yes on: Win, Ubuntu
        printenv("TMP")
        puts2("")


        #puts2("Test Script version: " + DISHONLINE_ACCESSTEST_VERSION)
        puts2(" DishOnlineTest_RefLib " + DISHONLINE_TEST_REFLIB_VERSION)
        puts2(" DishOnlineTest_Utilities: " + DISHONLINE_TEST_UTILTIES_VERSION)
        puts2(" Test Environment: " + $sTestEnvironment)
        puts2(" URL: " + $sBaseURL)
        puts2("")

        $bEnvironmentRecorded = true # Set flag indicating that this task was run
        @@bContinue = true # Set flag since testcase passed

      rescue => e

        @@bContinue = false

        puts2("*** ERROR Backtrace: " + e.message + "\n" + e.backtrace.join("\n"), "ERROR")

        raise("*** TESTCASE - #{sTestCase_Name}")

      ensure

      end

    end # Only run if this task has not been performed by another script
  end # END TestCase - test_DOL_000_RecordEnvironment


  #===========================================================================#
  # Testcase: test_DOL_002_AccessSite
  #
  # Description:
  #
  #===========================================================================#
  def test_DOL_002_AccessSite

    sTestCase_Name = "test_DOL_002_AccessSite"
    sPageName = "Home"
    puts2("")
    puts2("Starting Testcase: #{sTestCase_Name}")

    puts2("\t URL = " + $sBaseURL)

    # Define default values
    @@sCurrentBrowser = $sDefaultBrowser

    # Continue since prior test cases have passed
    if(@@bContinue != false)
      @@bContinue = false # Clear flag since this test has NOT passed yet

      begin  # Access DOL landing page


        puts2("\t Browser: " + @@sCurrentBrowser)

        #=begin
        #        if($sDefaultBrowser == "firefox")
        #          $browser = start_browser($sDefaultBrowser, "about:blank", $sBrowserProfile)
        #        else
        $browser = start_browser($sDefaultBrowser)
        #        end
        #=end
=begin
        case @@sCurrentBrowser.downcase.strip
          when /ie/
          $browser = Watir::IE.new
          when /firefox/
          $browser = FireWatir::Firefox.new
          when /safari/
          $browser = Watir::Safari.new
        end
=end
        # Capture time before navigating to next page
        tPageLoadTime = Time.now

        puts2("Accessing page - " + sPageName + ": " + $sBaseURL)
        $browser.goto($sBaseURL)

        $browser.wait_until_status("Done")

        # Calculate and record the elapsed time for the current test case
        puts2("\t Page load time - " + sPageName + ",  " + calc_elapsed_time(tPageLoadTime, false))
        puts2("\t Url - " + sPageName + " :   "+ $browser.url)

=begin
    ################## HOME ##################
=end

        puts2("\t Validating on the page: Home")
        assert($browser.isPage_dishonline_Home?() == true)

        @@bContinue = true # Set flag since testcase passed

      rescue => e

        puts2("*** ERROR Backtrace: " + e.message + "\n" + e.backtrace.join("\n"), "ERROR")

        puts2("")
        puts2("\t Current Url - :   "+ $browser.url)
        puts2("\t Current Title - :   "+ $browser.title)
        #$browser.save_screencapture("DishHome", false) # Save the desktop
        #$browser.save_html("DishHome")

        #$browser.generate_testcode_html_tag_counts()
        #$browser.generate_testcode_html_tag_attributes()

        raise("*** TESTCASE - #{sTestCase_Name}")

      ensure

      end # Access DOL landing page

    end # Continue since prior test cases have passed

  end # END TestCase - test_DOL_002_AccessSite


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
  def test_DOL_015_Access_MetaTags

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
  # Testcase method: test_WIP
  #
  # Description: Test the method
  #
  #===========================================================================#
  def test_WIP

    sTestCase_Name = "test_DOL_000_RecordEnvironment"
    puts2("Starting Testcase: #{sTestCase_Name}")

    puts2("Close the window")

    # Set the flag to close the $browser after the last test case runs
    @@bCloseBrowser = true

  end # test_WIP

end # class UnitTest_WIP
