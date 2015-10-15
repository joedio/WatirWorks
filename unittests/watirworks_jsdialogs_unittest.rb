#--
#=============================================================================#
# File: watirworks_jsdialogs_unittest.rb
#
#  Copyright (c) 2008-2011, Joe DiMauro
#  All rights reserved.
#
# Description: Unit tests for WatirWorks JavaScript Dialog start_browser:
#                          get_watirworks_install_path()
#                          handle_win_dialog_generic_modal(...)
#
#=============================================================================#

#=============================================================================#
# Require and Include section
# Entries for additional files or start_browser needed by this test
#=============================================================================#
require 'rubygems'

$bUseWebDriver = true

if($bUseWebDriver == nil)
  $bUseWebDriver = false
end

# WatirWorks
require 'watirworks'  # The WatirWorks library loader

include WatirWorks_Utilities    #  WatirWorks General Utilities
include WatirWorks_WebUtilities    #  WatirWorks Web Utilities

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
bIncludeInSuite = true
sRun_TestType = "browser"
iRun_TestLevel = 0

# Inherit or set the default browser
if($sDefaultBrowser == nil)
  # Uncomment the browser to be used for this test run
  #$sDefaultBrowser = "ie"
  $sDefaultBrowser = "firefox"
  #$sDefaultBrowser = "chrome"
  #$sDefaultBrowser = "safari"
end

#=============================================================================#

#=============================================================================#
# Class: UnitTest_JSDialogs
#
# Description:
#
#=============================================================================#
class UnitTest_JSDialogs < Test::Unit::TestCase
  #===========================================================================#
  # Method: setup
  #
  # Description: Before every testcase Test::Unit runs setup
  #===========================================================================#
  def setup

    @@tTestCase_StartTime = Time.now

    # Save the Global variable's original settings so that they can be changed in this
    # test without affecting other test, so long as they are restored by teardown
    @@VERBOSE_ORIG = $VERBOSE
    @@DEBUG_ORIG = $DEBUG
    @@FAST_SPEED_ORIG = $FAST_SPEED
    @@HIDE_IE_ORIG = $HIDE_IE

    # Minimize the Ruby Console window
    minimize_ruby_console()

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
  # Testcase method: test_JSDialog_001_Alert
  #
  # Description: Attempts to access and dismiss a JavaScript Alert dialog
  #===========================================================================#
  def test_JSDialog_001_Alert

    puts2("")
    puts2("#######################")
    puts2("Testcase: test_JSDialog_001_Alert")
    puts2("#######################")

    # Only run if NOT using Watir-WebDriver
    if(is_webdriver? == true)
      puts2("Not supported with WebDriver")
      return
    end

    # Only run on windows
    if(is_win?() == true)

      #$VERBOSE = true
      #$DEBUG = true

      # Text on the buttons to select
      sButtonCaption = "Display an Alert"
      sControlID = "OK"

      # Define components of  the URL
      sProtocol = "file:///"
      sRootURL = Dir.pwd
      sPage = "data/html/jsdialogs.html"

      # Construct the URL
      sURL = sProtocol  + sRootURL + "/" + sPage

      begin # Alert Dialog

        # Start a browser,
        #browser = Watir::Browser.new
        browser = start_browser($sDefaultBrowser)

        # Load a blank page (Workaround for issues with click_no_wait)
        browser.goto("about:blank")

        # Load the page
        browser.goto(sURL)

        if(browser.is_ie?)
          sDialogTitle = "Message from webpage"
        elsif(browser.is_firefox?)
          sDialogTitle = "[JavaScript Application]"
        end

        puts2("  Selecting button \"#{sButtonCaption}\" ")

        # The method click_no_wait does not work in ruby186-27_rc2.exe
        #  also does not work with Firewatir
        # See:  http://wiki.openqa.org/display/WTR/JavaScript+Pop+Ups
        #
        # Raise a popup JS Alert Dialog
        browser.button(:value, /#{sButtonCaption}/).click_no_wait
        #
        if(browser.is_firefox?)
          # Use this workaround until click_no_wait is fixed in firewatir
          #pause("Manually select the button: " + sButtonCaption + "\nThen dismiss this pause dialog")
        end

        puts2("Dismissing JS Alert dialog...")

        browser.handle_win_dialog_generic_modal(sDialogTitle, sControlID)

      rescue => e

        puts2("*** ERROR and Backtrace: " + e.message + "\n" + e.backtrace.join("\n"), "ERROR")

        # Raise the error with a custom message after the rest of the rescue actions
        raise("*** TESTCASE - test_JSDialog_001_Alert")

      ensure

        # Close the  browser
        browser.close()

      end # Alert Dialog

    else
      puts2("*** Skipping - Non-Windows platform")
    end # Only run on windows

  end # End of test method - test_JSDialog_001_Alert

  #===========================================================================#
  # Testcase method: test_JSDialog_002_Confirmation
  #
  # Description: Attempts to access and dismiss a JavaScript Confirmation dialog
  #===========================================================================#
  def test_JSDialog_002_Confirmation

    puts2("")
    puts2("###############################")
    puts2("# BEGIN: test_JSDialog_002_Confirmation #")
    puts2("###############################")

    # Only run if NOT using Watir-WebDriver
    if(is_webdriver? == true)
      puts2("Not supported with WebDriver")
      return
    end

    # Only run on windows
    if(is_win?() == true)

      # Text on the buttons to select
      sButtonCaption = "Display a Confirmation"

      # Define components of  the URL
      sProtocol = "file:///"
      sRootURL =Dir.pwd
      sPage = "data/html/jsdialogs.html"

      # Construct the URL
      sURL = sProtocol  + sRootURL + "/" + sPage

      begin # Confirmation Dialog

        # Start a browser,
        #browser = Watir::Browser.new
        browser = start_browser($sDefaultBrowser)

        # Load a blank page (Workaround for issues with click_no_wait)
        browser.goto("about:blank")

        # Load the page
        browser.goto(sURL)

        if(browser.is_ie?)
          sDialogTitle = "Message from webpage"
        elsif(browser.is_firefox?)
          sDialogTitle = "[JavaScript Application]"
        end

        puts2("  Selecting button \"#{sButtonCaption}\" ")

        browser.button(:value, /#{sButtonCaption}/).click_no_wait
        #
        if(browser.is_firefox?)
          # Use this workaround until click_no_wait is fixed in firewatir
          #pause("Manually select the button: " + sButtonCaption + "\nThen dismiss this pause dialog")
        end

        # Define the text on the control that AutoIt should select
        sControlID = "OK"

        # Dismiss the JS-Dialog
        puts2("Dismissing JS Confirmation dialog via the #{sControlID} button...")
        browser.handle_win_dialog_generic_modal(sDialogTitle, sControlID)

        #
        # Do it again but dismiss the JS dialog by selecting the other button
        #

        sButtonCaption = "Display a Confirmation"
        puts2("  Selecting button \"#{sButtonCaption}\" ")

        # Raise a JS-Prompt-Dialog
        #
        browser.button(:value, /#{sButtonCaption}/).click_no_wait
        #
        if(browser.is_firefox?)
          # Use this workaround until click_no_wait is fixed in firewatir
          #pause("Manually select the button: " + sButtonCaption + "\nThen dismiss this pause dialog")
        end

        # Define the text on the control that AutoIt should select
        sControlID = "Cancel"

        # Dismiss the JS-Dialog
        puts2("Dismissing JS Confirmation dialog via the #{sControlID} button...")
        browser.handle_win_dialog_generic_modal(sDialogTitle, sControlID)

      rescue => e

        puts2("*** ERROR and Backtrace: " + e.message + "\n" + e.backtrace.join("\n"), "ERROR")

        # Raise the error with a custom message after the rest of the rescue actions
        raise("*** TESTCASE - test_JSDialog_002_Confirmation")

      ensure

        # Close the  browser
        browser.close()

      end # Confirmation Dialog

    else
      puts2("*** Skipping - Non-Windows platform")
    end # Only run on windows

  end # End of test method - test_JSDialog_002_Confirmation

  #===========================================================================#
  # Testcase method: test_JSDialog_003_Prompt
  #
  # Description: Attempts to access and dismiss a JavaScript Prompt dialog
  #===========================================================================#
  def test_JSDialog_003_Prompt

    puts2("")
    puts2("###############################")
    puts2("# BEGIN: test_JSDialog_003_Prompt #")
    puts2("###############################")

    # Only run if NOT using Watir-WebDriver
    if(is_webdriver? == true)
      puts2("Not supported with WebDriver")
      return
    end

    # Only run on windows
    if(is_win?() == true)

      # Text on the buttons to select
      sButtonCaption = "Display a Prompt"

      # Define components of  the URL
      sProtocol = "file:///"
      sRootURL =Dir.pwd
      sPage = "data/html/jsdialogs.html"

      # Construct the URL
      sURL = sProtocol  + sRootURL + "/" + sPage

      begin # Prompt Dialog

        # Start a browser,
        #browser = Watir::Browser.new
        browser = start_browser($sDefaultBrowser)

        # Load a blank page (Workaround for issues with click_no_wait)
        browser.goto("about:blank")

        # Load the page
        browser.goto(sURL)

        if(browser.is_ie?)
          sDialogTitle = "Explorer User Prompt"
        elsif(browser.is_firefox?)
          sDialogTitle = "[JavaScript Application]"
        end

        puts2("  Selecting button \"#{sButtonCaption}\" ")

        # Raise a popup JS Dialog by using the  method - click_no_wait
        browser.button(:value, /#{sButtonCaption}/).click_no_wait
        #
        if(browser.is_firefox?)
          # Use this workaround until click_no_wait is fixed in firewatir
          #pause("Manually select the button: " + sButtonCaption + "\nThen dismiss this pause dialog")
        end

        # Define the text on the control that AutoIt should select
        sControlID = "Cancel"

        # Dismiss the JS-Dialog
        puts2("Dismissing JS Confirmation dialog via the #{sControlID} button...")
        browser.handle_win_dialog_generic_modal(sDialogTitle, sControlID)

        #
        # Do it again but dismiss the JS dialog by selecting the other button after entering some text
        #

        sButtonCaption = "Display a Prompt"
        puts2("  Selecting button \"#{sButtonCaption}\" ")

        # Raise a JS-Prompt-Dialog
        #
        browser.button(:value, /#{sButtonCaption}/).click_no_wait
        #
        if(browser.is_firefox?)
          # Use this workaround until click_no_wait is fixed in firewatir
          #pause("Manually select the button: " + sButtonCaption + "\nThen dismiss this pause dialog")
        end

        sInputTextControlID="Edit1"
        sInputText = random_sentence(5)

        # Define the text on the control that AutoIt should select
        sControlID = "OK"

        # Dismiss the JS-Dialog
        puts2("Dismissing JS Confirmation dialog via the #{sControlID} button...")
        browser.handle_win_dialog_generic_modal(sDialogTitle,  sControlID, sInputTextControlID, sInputText)

      rescue => e

        puts2("*** ERROR and Backtrace: " + e.message + "\n" + e.backtrace.join("\n"), "ERROR")

        # Raise the error with a custom message after the rest of the rescue actions
        raise("*** TESTCASE - test_JSDialog_003_Prompt")

      ensure

        # Close the browser
        browser.close()

      end # Confirmation Dialog

    else
      puts2("*** Skipping - Non-Windows platform")
    end # Only run on windows

  end # End of test method - test_JSDialog_003_Prompt

end # end of Class - UnitTest_JSDialogs
