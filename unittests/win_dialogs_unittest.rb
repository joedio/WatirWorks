#--
#=============================================================================#
# File: win_dialogs_unittest.rb
#
#  Copyright (c) 2008-2018, Joe DiMauro
#  All rights reserved.
#
# Description: Unit tests for WatirWorks Windows Message box methods:
#                          open_messagebox_win(...)
#                          pause()
#                          watchlist(...)
#                          popup_watchpoint()
#                          random_alphanumeric(...)
#                          compare_StringsInArrays(...)
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

# WatirWorks
require 'watirworks'               # The WatirWorks library loader
include WatirWorks_Utilities       #  WatirWorks General Utilities
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
# Class: UnitTest_WinDialogs
#
#
# Test Case Methods: setup, teardown
#                    test_WinDialogs_001_WinMessageBox
#                    test_WinDialogs_002_Pause
#                    test_WinDialogs_003_popup_watchpoint
#
#=============================================================================#
class UnitTest_WinDialogs < Test::Unit::TestCase

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
  # Testcase method: test_WinDialogs_001_WinMessageBox
  #
  # Description: Test the methods:
  #                               pause()
  #                               watchlist(...)
  #                               random_alphanumeric(...)
  #                               watchpoint(...)
  #===========================================================================#
  def test_WinDialogs_001_WinMessageBox

    puts2("")
    puts2("#######################")
    puts2("Testcase: test_WinDialogs_001_WinMessageBox")
    puts2("#######################")

    $VERBOSE = true

    if(is_win? == false)
	    puts2("Only supported in Windows")
	    return
    end

    puts2("Open a 1 button dialog")
    sPrompt = "Select OK to continue"
    sTitle = "Windows OK Dialog"
    iButtons = BUTTONS_OK
    iMyChoice = open_messagebox_win(sPrompt, sTitle, iButtons)
    if(iMyChoice == SELECTED_OK
      )
      puts2("  You picked: OK") # 1
    else
      puts2("  You picked button number: " + iMyChoice.to_s)
    end

    puts2("Open a 2 button dialog")
    sPrompt = "Are you OK?"
    sTitle = "Windows Yes, No Dialog"
    iButtons = BUTTONS_YES_NO
    iMyChoice = open_messagebox_win(sPrompt, sTitle, iButtons)

    case iMyChoice
      when SELECTED_YES
      puts2("  You picked: YES") # 6

      when SELECTED_NO # 2
      puts2("  You picked: NO")

    else
      puts2("  You picked button number: " + iMyChoice.to_s)
    end

    puts2("Open a 3 button dialog")
    sPrompt = "What's your choice?"
    sTitle = "Windows Yes, No, Cancel Dialog"
    iButtons = BUTTONS_YES_NO_CANCEL
    iMyChoice = open_messagebox_win(sPrompt, sTitle, iButtons)
    case iMyChoice
      when SELECTED_YES
      puts2("  You picked: YES") # 6

      when SELECTED_NO
      puts2("  You picked: NO") # 2

      when SELECTED_CANCEL # 7
      puts2("  You picked: CANCEL")

    else
      puts2("  You picked button number: " + iMyChoice.to_s)
    end



  end # END Testcase - test_WinDialogs_001_WinMessageBox

  #===========================================================================#
  # Testcase method: test_WinDialogs_002_Pause
  #
  # Description: Test the methods:
  #                               pause()
  #===========================================================================#
  def test_WinDialogs_002_Pause

    puts2("")
    puts2("#######################")
    puts2("Testcase: test_WinDialogs_002_Pause")
    puts2("#######################")

    if(is_win? == false)
	    puts2("Only supported in Windows")
	    return
    end

    pause()

  end # END Testcase - test_WinDialogs_002_Pause

  #===========================================================================#
  # Testcase method: test_WinDialogs_003_popup_watchpoint
  #
  # Description: Test the methods:
  #                               pause()
  #                               watchlist(...)
  #                               popup_watchpoint(...)
  #===========================================================================#
  def test_WinDialogs_003_popup_watchpoint

    puts2("")
    puts2("#######################")
    puts2("Testcase: test_WinDialogs_003_popup_watchpoint")
    puts2("#######################")

    if(is_win? == false)
	    puts2("Only supported in Windows")
	    return
    end

    puts2("### 1st watchpoint for one Global variable ###")
    popup_watchpoint(["$FAST_SPEED"])

    puts2("### 2nd watchpoint for a specified set of Global variables ###")
    popup_watchpoint(["$VERBOSE", "$FAST_SPEED", "$PROGRAM_NAME", "$0", "$.", "@sName"])

    puts2("### 3rd watchpoint for ALL Global variables ###")
    popup_watchpoint(nil)

  end # End of test method - test_WinDialogs_003_popup_watchpoint


end # end of Class - UnitTest_WinDialogs
