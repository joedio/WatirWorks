#--
#=============================================================================#
# File: watirworks_date_unittest.rb
#
#  Copyright (c) 2008-2010, Joe DiMauro
#  All rights reserved.
#
# Description: Unit test showing various examples of date manipulation using
#               Ruby's methods to split various date strings into their components.
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
#
sRun_TestType = "nobrowser"
iRun_TestLevel = 0
#=============================================================================#

#=============================================================================#
# Class: UnitTest_Date
#
#
# Test Case Methods: setup, teardown
#                    test_Date_001_Ruby_DateManipulation
#
#=============================================================================#
class UnitTest_Date < Test::Unit::TestCase


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
  # Testcase method: test_Date_001_Ruby_DateManipulation
  #
  # Description: Ruby's methods to split various date strings into their components.
  #===========================================================================#
  def test_Date_001_Ruby_DateManipulation

    require 'date'

    puts2("")
    puts2("#######################")
    puts2("Testcase: test_Date_001_Ruby_DateManipulation")
    puts2("#######################")

    sDateString = "2/29/2000"
    puts2("Convert #{sDateString}")

    aDate = sDateString.split("/")

    iMonth = aDate[0].to_i
    iDay = aDate[1].to_i
    iYear = aDate[2].to_i

    puts2(" Month: #{iMonth.to_s}, Day #{iDay.to_s}, Year #{iYear.to_s}")

    puts2("")
    puts2("Create a date object from the MM, DD, YY strings")

    # Convert 2 digit years into 4-digit years
    if(iYear <= 99)
      iYear = (2000 + iYear)
      puts2("4-digit year: #{iYear.to_s}")
    end

    # Create a date object
    #
    # Syntax: Date.new(y=-4712, m=1, d=1, sg=ITALY)
    tDate = Date.new(iYear, iMonth, iDay)
    puts2("The date is #{tDate.to_s}")

    tDayBefore = tDate -1
    puts2("The day before is #{tDayBefore.to_s}")
    puts2("The day before is also #{tDayBefore.strftime("%m/%d/%Y")}")

    tDayAfter = tDate.next
    puts2("The day after is #{tDayAfter.to_s}")

    tMonthBefore = tDate << 1
    puts2("The month before is #{tMonthBefore.to_s}")

    tMonthAfter= tDate >> 1
    puts2("The month after is #{tMonthAfter.to_s}")

    tYearBefore = tDate << 12
    puts2("The year before is #{tYearBefore.to_s}")

    tYearAfter = tDate >> 12
    puts2("The year after is #{tYearAfter.to_s}")

    ######################
    sDateString = "2/29/2004"
    puts2("######################")
    puts2("Convert #{sDateString}")

    aDate = sDateString.split("/")

    iMonth = aDate[0].to_i
    iDay = aDate[1].to_i
    iYear = aDate[2].to_i

    puts2(" Month: #{iMonth.to_s}, Day #{iDay.to_s}, Year #{iYear.to_s}")

    puts2("")
    puts2("Create a date object from the MM, DD, YY strings")

    # Convert 2 digit years into 4-digit years
    if(iYear <= 99)
      iYear = (2000 + iYear)
      puts2("4-digit year: #{iYear.to_s}")
    end

    # Create a date object
    #
    # Syntax: Date.new(y=-4712, m=1, d=1, sg=ITALY)
    tDate = Date.new(iYear, iMonth, iDay)
    puts2("The date is #{tDate.to_s}")

    tDayBefore = tDate -1
    puts2("The day before is #{tDayBefore.to_s}")
    puts2("The day before is also #{tDayBefore.strftime("%m/%d/%Y")}")

    tDayAfter = tDate.next
    puts2("The day after is #{tDayAfter.to_s}")

    tMonthBefore = tDate << 1
    puts2("The month before is #{tMonthBefore.to_s}")

    tMonthAfter= tDate >> 1
    puts2("The month after is #{tMonthAfter.to_s}")

    tYearBefore = tDate << 12
    puts2("The year before is #{tYearBefore.to_s}")

    tYearAfter = tDate >> 12
    puts2("The year after is #{tYearAfter.to_s}")

    ######################
    sDateString = "12/31/2018"

    puts2("######################")
    puts2("Convert #{sDateString}")

    aDate = sDateString.split("/")

    iMonth = aDate[0].to_i
    iDay = aDate[1].to_i
    iYear = aDate[2].to_i

    puts2(" Month: #{iMonth.to_s}, Day #{iDay.to_s}, Year #{iYear.to_s}")

    puts2("")
    puts2("Create a date object from the MM, DD, YY strings")

    # Convert 2 digit years into 4-digit years
    if(iYear <= 99)
      iYear = (2000 + iYear)
      puts2("4-digit year: #{iYear.to_s}")
    end

    # Create a date object
    #
    # Syntax: Date.new(y=-4712, m=1, d=1, sg=ITALY)
    tDate = Date.new(iYear, iMonth, iDay)
    puts2("The date is #{tDate.to_s}")

    tDayBefore = tDate -1
    puts2("The day before is #{tDayBefore.to_s}")
    puts2("The day before is also #{tDayBefore.strftime("%m/%d/%Y")}")

    tDayAfter = tDate.next
    puts2("The day after is #{tDayAfter.to_s}")

    tMonthBefore = tDate << 1
    puts2("The month before is #{tMonthBefore.to_s}")

    tMonthAfter= tDate >> 1
    puts2("The month after is #{tMonthAfter.to_s}")

    tYearBefore = tDate << 12
    puts2("The year before is #{tYearBefore.to_s}")

    tYearAfter = tDate >> 12
    puts2("The year after is #{tYearAfter.to_s}")

    ######################
    sDateString = "12-31-18"
    puts2("######################")
    puts2("Convert #{sDateString}")

    aDate = sDateString.split("-")

    iMonth = aDate[0].to_i
    iDay = aDate[1].to_i
    iYear = aDate[2].to_i

    puts2(" Month: #{iMonth.to_s}, Day #{iDay.to_s}, Year #{iYear.to_s}")

    puts2("")
    puts2("Create a date object from the MM, DD, YY strings")

    # Convert 2 digit years into 4-digit years
    if(iYear <= 99)
      iYear = (2000 + iYear)
      puts2("Now try with a 4-digit year: #{iYear.to_s}")
    end

    # Create a date object
    #
    # Syntax: Date.new(y=-4712, m=1, d=1, sg=ITALY)
    tDate = Date.new(iYear, iMonth, iDay)
    puts2("The date is #{tDate.to_s}")

    tDayBefore = tDate -1
    puts2("The day before is #{tDayBefore.to_s}")
    puts2("The day before is also #{tDayBefore.strftime("%m/%d/%Y")}")

    tDayAfter = tDate.next
    puts2("The day after is #{tDayAfter.to_s}")

    tMonthBefore = tDate << 1
    puts2("The month before is #{tMonthBefore.to_s}")

    tMonthAfter= tDate >> 1
    puts2("The month after is #{tMonthAfter.to_s}")

    tYearBefore = tDate << 12
    puts2("The year before is #{tYearBefore.to_s}")

    tYearAfter = tDate >> 12
    puts2("The year after is #{tYearAfter.to_s}")
    ######################

  end # End of test method - test_Date_001_Ruby_DateManipulation


end # end of Class - UnitTest_Date
