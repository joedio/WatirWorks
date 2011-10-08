#--
#=============================================================================#
# File: waitrworks_calc_time_unittest.rb
#
#  Copyright (c) 2008-2010, Joe DiMauro
#  All rights reserved.
#
# Description: Unit test for time calculations. Tests method:
#                calc_elapsed_time(...)
#                Exercises various Ruby methods to show Ruby's flexibility
#                to manipulate Dates as Strings
#
# Test cases:    UnitTest_CalcTime
#=============================================================================#

#=============================================================================#
# Require and Include section
# Add entries for any additional files or methods needed by this testsuite
#=============================================================================#
require 'rubygems'

# WatirWorks
require 'watirworks'  # The WatirWorks library loader
include WatirWorks_Utilities    #  WatirWorks  General Utilities
#include WatirWorks_RefLib      #  WatirWorks Reference data module
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
# Class: UnitTest_CalcTime
#
#
# Test Case Methods: setup, teardown
#                   test_Year
#
#
#=============================================================================#
class UnitTest_CalcTime < Test::Unit::TestCase


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
  # Testcase method: test_CalcTime_001_CalcElapsedTime
  #
  # Description: Tests method calc_elapsed_time(...)
  #===========================================================================#
  def test_CalcTime_001_CalcElapsedTime

    puts2("")
    puts2("#######################")
    puts2("Testcase: test_CalcTime_001_CalcElapsedTime")
    puts2("#######################")

    # Activate Ruby's Verbose flag during this test and
    # use the methods verbose statements for output
    #$VERBOSE = true

    tStartTime = Time.new

    puts2("Start time = " + tStartTime.to_s)

    sleep 2
    puts2("Elapsed time = " + calc_elapsed_time(tStartTime))

    sleep 3
    puts2("Elapsed time = " + calc_elapsed_time(tStartTime))

  end # End of test method - test_CalcTime_001_CalcElapsedTime

  #===========================================================================#
  # Testcase method: test_CalcTime_002_CalcYear
  #
  # Description: Exercises various Ruby methods to show
  #              Ruby's flexibility to manipulate Dates as Strings
  #===========================================================================#
  def test_CalcTime_002_CalcYear

    puts2("")
    puts2("#######################")
    puts2("Testcase: test_CalcTime_002_CalcYear")
    puts2("#######################")

    # String holding 4-character year
    sCurrentYear = Time.new.year.to_s

    # Another string holding a different 4-character year
    sNextYear = (Time.new.year + 1).to_s

    puts2 ""
    puts2 "This year string = " + sCurrentYear
    puts2 "Next year string = " + sNextYear

    sTHIS_YEAR_YY = sCurrentYear[2,3]
    puts2 ""
    puts2 "This year string [yy] = " + sTHIS_YEAR_YY

    iCurrentYear = sCurrentYear.to_i
    iNextYear = sNextYear.to_i

    puts2 ""
    puts2 "This year int.to_s = " + iCurrentYear.to_s
    puts2 "This Year as an int: iCurrentYear"
    puts2 iCurrentYear

    puts2 "Next year int.to_s = " + iNextYear.to_s
    puts2 "Next Year as an int: iNextYear"
    puts2 iNextYear

    iCalculatedYear_plus1 = iCurrentYear + 1
    iCalculatedYear_minus1 = iCurrentYear - 1

    puts2 ""
    puts2 "This year int plus 1 year = " + iCalculatedYear_plus1.to_s
    puts2 "This year int minus 1 year = " + iCalculatedYear_minus1.to_s

    #######################

    iVariance = 1

    while iVariance < 10

      puts2 ""
      puts2 "This year int plus #{iVariance.to_s} years = " + (iCurrentYear + iVariance).to_s
      puts2 "This year int minus #{iVariance.to_s} years = " + (iCurrentYear - iVariance).to_s
      puts2 ""
      puts2 "This year string plus #{iVariance.to_s} years = " + (sCurrentYear.to_i + iVariance).to_s
      puts2 "This year string minus #{iVariance.to_s} years = " + (sCurrentYear.to_i - iVariance).to_s

      iVariance = iVariance + 1

    end

    if(iCurrentYear > iNextYear)
      puts2 "Current year int is larger than next year"
    else
      puts2 "Next year is int larger than Current year"
    end

    if(sCurrentYear > sNextYear)
      puts2 "Current year string is larger than next year"
    else
      puts2 "Next year is string larger than Current year"
    end
    ##########################

  end # End of test method - test_CalcTime_002_CalcYear


end # end of Class - UnitTest_CalcTime
