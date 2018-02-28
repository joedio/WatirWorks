#--
#=============================================================================#
# File: watirworks_filesave_unittest.rb
#
#
#  Copyright (c) 2008-2015, Joe DiMauro
#  All rights reserved.
#
# Description: Unit tests for the IE browser using WatirWorks methods:
#                          save_html(...)
#                          save_screencapture_win(...)
#=============================================================================#

#=============================================================================#
# Require and Include section
# Entries for additional files or methods needed by this test
#=============================================================================#
require 'rubygems'

$bUseWebDriver = true

if($bUseWebDriver == nil)
  $bUseWebDriver = false
end

#
# Watir
#require 'firewatir'  # This is pulled in through WatirWorks_WebUtilities

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

#=============================================================================#

#=============================================================================#
# Global Variables section
# Set global variables that will be inherited by each of the test files
#=============================================================================#

# Ruby global variables
#

# Watir global variables
#

# WatirWorks global variables
bIncludeInSuite = false
sRun_TestType = "browser"
iRun_TestLevel = 0
#=============================================================================#

#=============================================================================#
# Class: UnitTest_Save
#
# Test Case Methods: setup, teardown
#
#
#=============================================================================#
class UnitTest_Save < Test::Unit::TestCase
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

    # Minimize the Ruby Console window
    minimize_ruby_console()

    @@tTestCase_StartTime = Time.now

  end # end of setup

  #===========================================================================#
  # Method: teardown
  #
  # Description: After every testcase Test::Unit runs teardown
  #===========================================================================#
  def teardown

    puts2("\nTestcase finished in  " + calc_elapsed_time(@@tTestCase_StartTime) + " seconds.")

    # Restore the Global variable's original settings
    $VERBOSE = @@VERBOSE_ORIG
    $DEBUG = @@DEBUG_ORIG
    $FAST_SPEED = @@FAST_SPEED_ORIG
    $HIDE_IE = @@HIDE_IE_ORIG

  end # end of teardown

  #===========================================================================#
  # Testcase method: test_Save_001_SaveHTML
  #
  # Description: Test methods: save_html(...)
  #===========================================================================#
  def test_Save_001_SaveHTML

    # Uncomment this line to test with a global logger
    #$logger = capture_results()

    puts2("")
    puts2("#######################")
    puts2("Testcase: test_Save_001_SaveHTML")
    puts2("#######################")

    sGoogleURL = "http://google.com"
    sBingURL = "http://www.bing.com"

    begin # Start local browsers

      # Find a location on the local filesystem that will allow this unit test to write a file
      if(is_win?)
        # Get the TEMP Environment Variable setting
        hEnvVars = getenv("TEMP")
        sOutputDir = hEnvVars["TEMP"].to_s
      else
        sOutputDir = "/tmp"
      end

      puts2("\nFiles created by this unit test will be saved in: " + sOutputDir + "\n")

      puts2("Create a new local Browser Object")
      browser = start_browser("firefox", sGoogleURL)
      sleep 2

      sCurrentURL = browser.url
      puts2("Current URL: " + sCurrentURL)

      puts2("\nSave the Web page")
      browser.save_html("Google-HomePage", sOutputDir)

      puts2("\nLoad a different URL")
      browser.goto(sBingURL)
      sleep 2

      sCurrentURL = browser.url
      puts2("Current URL: " + sCurrentURL)

      puts2("\nSave the Web page")
      browser.save_html("Bing")
      #browser.save_html("Bing", sOutputDir)

    rescue => e

      puts2("*** ERROR and Backtrace: " + e.message + "\n" + e.backtrace.join("\n"), "ERROR")

      # Close the browser
      browser.close

      # Raise the error with a custom message after the rest of the rescue actions
      raise("*** TESTCASE - test_Save_001_SaveHTML")

    ensure

      # Close the browser
      browser.close

    end # Start local browsers

  end # End of test method - test_Save_001_SaveHTML

  #===========================================================================#
  # Testcase method: test_Save_002_SaveScreenCapture_win
  #
  # Description: Test methods: save_screencapture(...)
  #===========================================================================#
  def test_Save_002_SaveScreenCapture_win

    puts2("")
    puts2("#######################")
    puts2("Testcase: test_Save_002_SaveScreenCapture_win")
    puts2("#######################")

    # Skip these tests if not run on the Windows platform
    if(is_win? != true) # Only run on Windows
      puts2("Skipping unit test, incompatible platform")
      assert(false, "Incompatible browser")
    end

    sGoogleURL = "http://google.com"
    sBingURL = "http://www.bing.com"

    begin # Start local browsers

      # Find a location on the local filesystem that will allow this unit test to write a file
      if(is_win?)
        # Get the TEMP Environment Variable setting
        hEnvVars = getenv("TEMP")
        sOutputDir = hEnvVars["TEMP"].to_s
      elsif(is_linux?)
        sOutputDir = "/tmp"
      end

      puts2("\nFiles created by this unit test will be saved in: " + sOutputDir + "\n")

      puts2("Create a new local Browser Object")

      # Start a browser,
      browser = Watir::Browser.new

      # Load the page
      browser.goto(sGoogleURL)

      sCurrentURL = browser.url
      puts2("Current URL: " + sCurrentURL)

      # browser.focus()

      puts2("\nSave a screen capture of the Desktop as a JPG")
      browser.save_screencapture()
      puts2("\nSave another screen capture of the Desktop as a JPG")
      browser.save_screencapture("Google-HomePage")
      puts2("\nSave a screen capture of the Browser window as a BMP")
      browser.save_screencapture("Google-HomePage", false, false, "")

      puts2("\nLoad a different URL")
      browser.goto(sBingURL)
      sleep 2

      sCurrentURL = browser.url
      puts2("Current URL: " + sCurrentURL)

      puts2("\nSave a screen capture of the Web page as a JPG")
      browser.save_screencapture("Bing", true, true, sOutputDir)

    rescue => e

      puts2("*** ERROR and Backtrace: " + e.message + "\n" + e.backtrace.join("\n"), "ERROR")

      # Close the browser
      browser.close

      # Raise the error with a custom message after the rest of the rescue actions
      raise("*** TESTCASE - test_Save_002_SaveScreenCapture_win")

    ensure

      # Close the browser
      browser.close

    end # Start local browsers

  end # End of test method - test_Save_002_SaveScreenCapture_win

end # end of Class - UnitTest_Save
