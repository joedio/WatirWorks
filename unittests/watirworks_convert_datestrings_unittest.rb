#--
#=============================================================================#
# File: watirworks_convert_datestrings_unittest.rb
#
#  Copyright (c) 2008-2010, Joe DiMauro
#  All rights reserved.
#
# Description: Unit tests for WatirWorks STRING methods:
#                convert_date(...)
#
#
#
#=============================================================================#

#=============================================================================#
# Require and Include section
# Entries for additional files or methods needed by this test
#=============================================================================#
require 'rubygems'

# WatirWorks
require 'watirworks'  # The WatirWorks library loader
include WatirWorks_Utilities    #  WatirWorks General Utilities
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
bIncludeInSuite = true
sRun_TestType = "nobrowser"
iRun_TestLevel = 0
#=============================================================================#

#=============================================================================#
# Class: UnitTest_Convert_Date
#
#
# Test Case Methods: setup, teardown
#                   test_Convert_Date_001_DateObjects
#                   test_Convert_Date_002_DatesAsStrings
#                   test_Convert_Date_003_InvalidDatesAsStrings
#
#
#=============================================================================#
class UnitTest_Convert_Date < Test::Unit::TestCase


  #===========================================================================#
  # Method: setup
  #
  # Description: Setup is run by Test::Unit before every testcase
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
  # Description: Teardown is run by Test::Unit after every testcase
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
  # Testcase method: test_Convert_Date_001_DateObjects
  #
  # Description: Test method convert_date(..) with date objects
  #===========================================================================#
  def test_Convert_Date_001_DateObjects

    require 'date'

    sToday = Date.today.to_s

    puts2("")
    puts2("#######################")
    puts2("Testcase: test_Convert_Date_001_DateObjects")
    puts2("#######################")

    puts2("Testing Timespan between dates and " + sToday + "\n\n")

    dDate = Date.today + 182
    puts2("#{dDate.to_s}  converted to  " + convert_date(dDate))

    dDate = Date.today + 181
    puts2("#{dDate.to_s}  converted to  " + convert_date(dDate))


    iMin = -60
    iMax = 61

    while  iMin < iMax  do
      dDate = Date.today + iMin
      puts2("#{dDate.to_s}  converted to  " + convert_date(dDate))
      iMin +=1
    end

    dDate = Date.today - 181
    puts2("#{dDate.to_s}  converted to  " + convert_date(dDate))

    dDate = Date.today - 182
    puts2("#{dDate.to_s}  converted to  " + convert_date(dDate))


  end # End of testcase - test_Convert_Date_001_DateObjects


  #===========================================================================#
  # Testcase method: test_Convert_Date_002_DatesAsStrings
  #
  # Description: Test the method convert_date(...) with dates expressed as strings
  #===========================================================================#
  def test_Convert_Date_002_DatesAsStrings

    require 'date'

    puts2("")
    puts2("#######################")
    puts2("Testcase: test_Convert_Date_002_DatesAsStrings")
    puts2("#######################")

    puts2("Testing dates expressed as STRINGS\n\n")

    # Array of date strings to test
    aDateStrings = [
    "12/31/2000",
    "1/1/01",
    "01/02/01",
    "1/3/1",
    "1/4/01",
    "1/5/01",
    "1/6/01",
    "2/1/01",
    "3/1/01",
    "4/1/01",
    "5/1/01",
    "6/1/01",
    "7/1/01",
    "8/1/01",
    "9/1/01",
    "10/1/01",
    "11/1/01",
    "12/1/01"
    ]

    # Loop through the list, converting each date string
    aDateStrings.each do | sDateString |
      puts2("#{sDateString}  converted to  " + convert_date(sDateString))
    end

  end # End of testcase - test_Convert_Date_002_DatesAsStrings

  #===========================================================================#
  # Testcase method: test_Convert_Date_003_InvalidDatesAsStrings
  #
  # Description: Test the method convert_date(...) with invalid dates expressed as strings
  #===========================================================================#
  def test_Convert_Date_003_InvalidDatesAsStrings

    require 'date'

    puts2("")
    puts2("#######################")
    puts2("Testcase: test_Convert_Date_003_InvalidDatesAsStrings")
    puts2("#######################")

    puts2("Testing invalid dates expressed as STRINGS\n\n")

    sDateString = "6/31/08"
    puts2("\nTrying an invalid month specific date")
    puts2("#{sDateString}  converted to  " + convert_date(sDateString))

    sDateString = "14/04/2010"
    puts2("\nTrying an invalid month specific date")
    puts2("#{sDateString}  converted to  " + convert_date(sDateString))

    sDateString = "12-88-2010"
    puts2("\nTrying an invalid date in any month")
    puts2("#{sDateString}  converted to  " + convert_date(sDateString))

    sDateString = "02/29/2001"
    puts2("\nTrying an invalid Leap Year date")
    puts2("#{sDateString}  converted to  " + convert_date(sDateString))

  end # End of testcase - test_Convert_Date_003_InvalidDatesAsStrings


end # end of Class - UnitTest_Convert_Date
