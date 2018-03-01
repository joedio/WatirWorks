#--
#=============================================================================#
# File: log_unittest.rb
#
#
#  Copyright (c) 2008-2018, Joe DiMauro
#  All rights reserved.
#
# Description: Unit tests for the IE browser using WatirWorks methods:
#
#=============================================================================#

#=============================================================================#
# Require and Include section
# Entries for additional files or methods needed by this test
#=============================================================================#
require 'rubygems'

# FireWatir
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
bIncludeInSuite = true
sRun_TestType = "nobrowser"
iRun_TestLevel = 2

#=============================================================================#

#=============================================================================#
# Class: UnitTest_Browser_IE
#
# Test Case Methods: setup, teardown
#
#
#=============================================================================#
class UnitTest_Log < Test::Unit::TestCase

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
  # Testcase method: test_WIP
  #
  # Description: Test the method: capture_results(...)
  #
  #===========================================================================#
  def test_Log_capture_results

    puts("")
    puts("#######################")
    puts("Testcase: test_Log_capture_results")
    puts("#######################")

    # Start a new Logger Object and assign it to a Global Object
    #
    # Using the default values:
    #   Create a "waitr_works/results" directory within the OS's Temporary directory
    #   This directory will contain the single log file used for all tests.
    #   Then create a Global Logger Object to manage that log file.
    $logger = capture_results()

    # Try it again, but specify values intead of relying on the defaults
    # Should be ignored, as the Global Logger Object pre-exists. You only get one, Hey its global!
    $logger = capture_results(true, "results", "logfile")

    # Try it again, but specify other values intead of relying on the defaults
    # Should be ignored, as the Global Logger Object pre-exists. You only get one, Hey its global!
    $logger = capture_results(false, "bad_results", "bogus_logfile")

  end # END testcase - test_Log_capture_results

  #===========================================================================#
  # Testcase method: test_Log_puts2
  #
  # Description: Test the method: puts2(...)
  #                               is_global_var_set(...)
  #
  #===========================================================================#
  def test_Log_puts2

    puts("")
    puts("#######################")
    puts("Testcase: test_Log_puts2")
    puts("#######################")

    # Write only to stdout using Ruby's puts()
    puts("Message sent only to stdout.")

    # Continue test only if a global logger ($logger) exists
    # Presume it exists if it is NOT nil
    if(($logger.nil?) == false)

      # Write to the log file using Ruby's log()
      $logger.log("The log file is open for writing")

      # Write to the log file and stdout, with Logger level set to INFO
      puts2(" Informational message sent to the log file and STDOUT.")
      puts2(" Second informational message sent to the log file and STDOUT.", "INFO")
      puts2(" Debug message supressed in the log file but sent to STDOUT.", "DEBUG")
      puts2(" Warning message sent to the log file and STDOUT.", "WARN")
      puts2(" Fatal message sent to the log file and STDOUT.", "FATAL")
      puts2(" Mystery message sent to the log file and STDOUT.", "WXYZ")

      puts2(" Message sent ONLY to the log file.", "INFO", -1)
      puts2(" Message sent ONLY to STDOUT.", "INFO", 0)

    else
      puts("*** WARNING - No Global logger named $logger found")
    end

  end # END testcase - test_Log_puts2

  #===========================================================================#
  # Testcase method: test_Log_raise
  #
  # Description: Test the Ruby method: raise(...), begin/rescue/ensure/end
  #
  #                    If this runs as expected you should see the following at the end of your STDOUT
  #
  #                            Written from ensure
  #                            E
  #                            Finished in 0.024 seconds.
  #
  #                            1) Error:
  #                            test_Log_raise(UnitTest_Log):
  #                            RuntimeError: *** ERROR - Written from rescue after backtrace
  #                            log_unittiest_.rb:194:in `test_Log_ForcedError'
  #
  #                            3 tests, 0 assertions, 0 failures, 1 errors
  #                            >Exit code: 1
  #
  #===========================================================================#
  def test_Log_ForcedError

    puts2("")
    puts2("#######################")
    puts2("Testcase: test_Log_ForcedError")
    puts2("#######################")

    begin
      puts2("Written from begin")
      # This line should make execution jump to the rescue section, the text in it will then be output by e.message
      raise("Simulating a Runtime issue in begin")
      puts2("Also written from begin, but not run due to the raise statement")

    rescue => e
      puts2("Written from rescue")
      puts2("The following backtrace is a WARN level, thus it does NOT raise a counted error")
      puts2("*** WARN Backtrace: " + e.message + "\n" + e.backtrace.join("\n"), "WARN")
      puts2("\n\nThe following backtrace is a ERROR level, and raise a counted error")
      puts2("*** ERROR Backtrace: " + e.message + "\n" + e.backtrace.join("\n"), "ERROR")

      raise("*** TESTCASE - Written from rescue after backtrace")

    ensure
      puts2("Written from ensure")
    end

    puts2("Written from after ensure, and NOT run due to the raise statement in rescue")

  end # END testcase - test_Log_ForcedError

end # END class - UnitTest_Log
