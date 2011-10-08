#--
#=============================================================================#
# File: watirworks_numeric_unittest.rb
#
#  Copyright (c) 2008-2010, Joe DiMauro
#  All rights reserved.
#
# Description: Unit tests for WatirWorks NUMERIC methods:
#                 comma_delimit(...)
#=============================================================================#

#=============================================================================#
# Require and Include section
# Entries for additional files or methods needed by this test
#=============================================================================#
require 'rubygems'

# WatirWorks
require 'watirworks'  # The WatirWorks library loader
include WatirWorks_Utilities    #  WatirWorks General Utilities
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
#
sRun_TestType = "nobrowser"
iRun_TestLevel = 0
#=============================================================================#

#=============================================================================#
# Class: UnitTest_Numeric
#
#
# Test Case Methods: setup, teardown
#                    test_NUMERIC_CommaDelimit
#
#
#=============================================================================#
class UnitTest_Numeric < Test::Unit::TestCase

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
  # Testcase method: test_Numeric_001_CommaDelimit
  #
  # Description: Test the NUMERIC method comma_delimit(...)
  #===========================================================================#
  def test_Numeric_001_CommaDelimit

    puts2("")
    puts2("#######################")
    puts2("Testcase: test_Numeric_001_CommaDelimit")
    puts2("#######################")

    iNumber = 1
    puts2("Delimit " + iNumber.to_s + " with a comma: " + iNumber.comma_delimit(","))

    iNumber = 12
    puts2("Delimit " + iNumber.to_s + " with a comma: " + iNumber.comma_delimit(","))

    iNumber = 123
    puts2("Delimit " + iNumber.to_s + " with a comma: " + iNumber.comma_delimit(","))

    iNumber = 1234
    puts2("Delimit " + iNumber.to_s + " with a comma: " + iNumber.comma_delimit(","))

    iNumber = 1234.0
    puts2("Delimit " + iNumber.to_s + " with a comma: " + iNumber.comma_delimit(","))

    iNumber = 1234.56
    puts2("Delimit " + iNumber.to_s + " with a comma: " + iNumber.comma_delimit(","))

    iNumber = 1234.567
    puts2("Delimit " + iNumber.to_s + " with a comma: " + iNumber.comma_delimit(","))

    iNumber = 1234.5678
    puts2("Delimit " + iNumber.to_s + " with a comma: " + iNumber.comma_delimit(","))

    iNumber = -1234567890.01
    puts2("Delimit " + iNumber.to_s + " with a comma: " + iNumber.comma_delimit)

    iNumber = 1234567890.99
    puts2("Delimit " + iNumber.to_s + " with a period: " + iNumber.comma_delimit("."))

    iNumber = 1234567890.0123
    puts2("Delimit " + iNumber.to_s + " with a space: " + iNumber.comma_delimit(" "))

  end # End of test method - test_Numeric_001_CommaDelimit

end # end of Class - UnitTest_Numeric
