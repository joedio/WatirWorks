#--
#=============================================================================#
# File: watirworks_variable_watchlist_unittest.rb
#
#  Copyright (c) 2008-2015, Joe DiMauro
#  All rights reserved.
#
# Description: Unit tests for WatirWorks methods:
#                       watchlist(...)
#=============================================================================#
require 'rubygems'

# WatirWorks
require 'watirworks'  # The WatirWorks library loader
include WatirWorks_Utilities   #  WatirWorks  General Utilities
include WatirWorks_RefLib      #  WatirWorks Reference data module
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
# Class: UnitTest_Watchlist
#
#
# Test Case Methods: setup, teardown
#                    test_watchlist
#
#
#=============================================================================#
class UnitTest_Watchlist < Test::Unit::TestCase

  @@sMyClassVar = "Class Var defined in this unittest's class"

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
  # Testcase method: test_Watchlist_001_watchlist
  #--
  # TODO: Uncomment Class Var trials once watchlist supports them
  #
  # Description: Test the method watchlist(...)
  #===========================================================================#
  def test_Watchlist_001_watchlist

    puts2("")
    puts2("#######################")
    puts2("Testcase: test_Watchlist_001_watchlist")
    puts2("#######################")

    @sMyInstanceVar = "Instance Var defined in this test"
    @@sMyClassVar = "Class Var defined in this test"
    $My_GlobVar = "Global Var defined in this test"

    puts2("\n\n### Test a specific Global var from Ruby")
    watchlist(["$PROGRAM_NAME"])

    puts2("\n\n### Test a specific CONSTANT from Watir_RefLib")
    watchlist(["THIS_YEAR"])

    puts2("\n\n### Test a specific Instance var defined within the scope of this test")
    watchlist(["@sMyInstanceVar"])

    puts2("\n\n### Test a specific Global var defined within the scope of this test")
    watchlist(["$My_GlobVar"])

    puts2("\n\n### Test multiple Global vars from Ruby")
    watchlist(["$0", "$PROGRAM_NAME", "$DEBUG", "$VERBOSE","$logger",  "$LOAD_PATH", "$LOADED_FEATURES"])

    puts2("\n\n### Test multiple IE specific Global vars from Watir")
    watchlist(["$FAST_SPEED",  "$HIDE_IE "])

    puts2("\n\n### Test multiple CONSTANTS from Watir_RefLib")
    watchlist(["THIS_YEAR", "THIS_YR", "MONTH_ABBREVIATION"])

    puts2("\n\n### Test combination of a CONSTANT, and a Global var, and a Local var")
    watchlist(["THIS_YEAR", "$VERBOSE", "@sMyInstanceVar"])

    puts2("\n\n### Test all vars: Global vars, and Class vars, and CONSTANTS from WatirWorks_RefLib")
    watchlist(nil, WatirWorks_RefLib)

    puts2("\n\n### Test all Global vars - passed nil")
    watchlist(nil)

    puts2("\n\n### Test all: Global vars - no parameters passed")
    watchlist()

    # Negative test cases
    #puts2("\n\n### Negative test cases")

    #puts2("\n\n### Test an Class var defined within this unit test - Should be ignored")
    #watchlist(["@@sMyClassVar"])

    puts2("\n\n")

  end # End of test method - test_Watchlist_001_watchlist

end # end of Class - UnitTest_Watchlist
