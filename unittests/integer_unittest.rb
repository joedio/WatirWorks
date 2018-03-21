#--
#=============================================================================#
# File: integer_unittest.rb
#
#  Copyright (c) 2008-2018, Joe DiMauro
#  All rights reserved.
#
# Description: Unit tests for WatirWorks Integer methods:
#                 ordinal()
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
bIncludeInSuite = true
sRun_TestType = "nobrowser"
iRun_TestLevel = 0
#=============================================================================#

#=============================================================================#
# Class: UnitTest_IntgerOrdinal
#
#
# Test Case Methods: setup, teardown
#                    test_Intger_001_ordinal
#
#
#=============================================================================#
class UnitTest_Intger < Test::Unit::TestCase
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
  # Testcase method: test_Intger_001_ordinal
  #
  # Description: Test the Intger method ordinal()
  #===========================================================================#
  def test_Intger_001_ordinal

    puts2("")
    puts2("#######################")
    puts2("Testcase: test_Intger_001_ordinal")
    puts2("#######################")

    # Print the Ordinal values from iMin to iMax
    iMin = -1
    iMax = 20
    iMin.upto(iMax) { | iInteger |  puts2("#{iInteger.to_s} " + " has an ordinal of " + iInteger.ordinal) }

  end # End of test method - test_Intger_001_ordinal

end # end of Class - UnitTest_Integer
