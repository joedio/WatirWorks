#--
#=============================================================================#
# File: reflib_unittest.rb
#
#  Copyright (c) 2008-2018, Joe DiMauro
#  All rights reserved.
#
# Description:  The WatirWorks Reference Library's unit test
#
#=============================================================================#

#=============================================================================#
# Require and Include section
# Entries for additional files or methods needed by this test
#=============================================================================#
require 'rubygems'

# WatirWorks
require 'watirworks'  # The WatirWorks library loader
include WatirWorks_RefLib      #  WatirWorks Reference data module
include WatirWorks_Utilities    # WatirWorks General Utilities
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
# Class: UnitTest_RefLib
#
#
# Test Case Methods: setup, teardown
#                   test_Year
#
#
#=============================================================================#
class UnitTest_RefLib < Test::Unit::TestCase
  
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
  # Testcase method: test_RefLib_001_Dates
  #
  # Description: Test the Reference date values
  #=============================================================================#
  def test_RefLib_001_Dates
    
    puts2("")
    puts2("#######################")
    puts2("Testcase: test_RefLib_001_Dates")
    puts2("#######################")
    puts2("")
    puts2(" This year is " + THIS_YEAR  + ", a.k.a. '" + THIS_YR)
    puts2(" Next year is " + NEXT_YEAR + ", a.k.a. '" + NEXT_YR)
    puts2(" Last year was " + LAST_YEAR + ", a.k.a. '" + LAST_YR)
    puts2(" It's month nunber " + THIS_MONTH)
    puts2(" It's day " + THIS_DAY + " of the month")
    
    puts2(" TODAY \t " + TODAY)
    puts2(" TOMORROW \t " + TOMORROW)
    puts2(" YESTERDAY \t " + YESTERDAY)
    
    puts2(" DAYS_FUTURE_7 \t " + DAYS_FUTURE_7)
    puts2(" DAYS_FUTURE_30 \t " + DAYS_FUTURE_30)
    puts2(" DAYS_FUTURE_60 \t " + DAYS_FUTURE_60)
    puts2(" DAYS_FUTURE_90 \t " + DAYS_FUTURE_90)
    puts2(" DAYS_FUTURE_365 \t " + DAYS_FUTURE_365)
    
    puts2(" DAYS_PAST_7 \t" + DAYS_PAST_7)
    puts2(" DAYS_PAST_30 \t " + DAYS_PAST_30)
    puts2(" DAYS_PAST_60 \t " + DAYS_PAST_60)
    puts2(" DAYS_PAST_90 \t " + DAYS_PAST_90)
    puts2(" DAYS_PAST_365 \t " + DAYS_PAST_365)
    
    puts2(" WEEKS_FUTURE_1 \t " + WEEKS_FUTURE_1)
    puts2(" WEEKS_FUTURE_2 \t " + WEEKS_FUTURE_2)
    puts2(" WEEKS_FUTURE_4 \t " + WEEKS_FUTURE_4)
    puts2(" WEEKS_FUTURE_8 \t " + WEEKS_FUTURE_8)
    puts2(" WEEKS_FUTURE_12 \t " + WEEKS_FUTURE_12)
    puts2(" WEEKS_FUTURE_52 \t " + WEEKS_FUTURE_52)
    
    puts2(" WEEKS_PAST_1 \t " + WEEKS_PAST_1)
    puts2(" WEEKS_PAST_2 \t " + WEEKS_PAST_2)
    puts2(" WEEKS_PAST_4 \t " + WEEKS_PAST_4)
    puts2(" WEEKS_PAST_8 \t " + WEEKS_PAST_8)
    puts2(" WEEKS_PAST_12 \t " + WEEKS_PAST_12)
    puts2(" WEEKS_PAST_52 \t " + WEEKS_PAST_52)
    
  end # End of test method - test_RefLib_001_Dates
  
  #===========================================================================#
  # Testcase method: test_RefLib_002_States
  #
  # Description: Test the Reference State values
  #===========================================================================#
  def test_RefLib_002_States
    
    puts2("")
    puts2("#######################")
    puts2("Testcase: test_RefLib_002_States")
    puts2("#######################")
    puts2("")
    puts2("Canadian Provinces")
    CANADIAN_PROVINCES.sort.each do | abbrev, name|
      puts2(" Abbreviation of #{name}, is  #{abbrev}")
    end
    
    puts2("")
    puts2("Mexican States")
    MEXICAN_STATES.sort.each do | abbrev, name|
      puts2(" Abbreviation of #{name}, is  #{abbrev}")
    end
    
    puts2("")
    puts2("USPS States")
    USPS_STATES.sort.each do | abbrev, name|
      puts2(" Abbreviation of #{name}, is #{abbrev}")
    end
    
  end # End of test method - test_RefLib_002_States
  
  #===========================================================================#
  # Testcase method: test_RefLib_003_Streets
  #
  # Description: Test the Reference address values
  #===========================================================================#
  def test_RefLib_003_Streets
    
    puts2("")
    puts2("#######################")
    puts2("Testcase: test_RefLib_003_Streets")
    puts2("#######################")
    
    puts2("")
    puts2("USPS Street Suffix")
    USPS_STREET_SUFFIX.sort.each do | name, abbrev |
      puts2(" Abbreviation of #{name}, is #{abbrev}")
    end
    
    puts2("")
    puts2("USPS Secondary Unit Designators")
    USPS_SECONDARY_UNIT_DESIGNATOR.sort.each do | name, abbrev |
      puts2(" #{name}, is abbreviated #{abbrev}")
    end
    
  end # End of test method - test_RefLib_003_Streets
  
  #=============================================================================#
  # Testcase method: test_RefLib_004_Months
  #
  # Description: Test the Reference month values
  #===========================================================================#
  def test_RefLib_004_Months
    
    puts2("")
    puts2("#######################")
    puts2("Testcase: test_RefLib_004_Months")
    puts2("#######################")
    
    puts2("")
    puts2("Months")
    MONTH_ABBREVIATION.sort.each do | abbrev, name |
      puts2(" Abbreviation of #{name}, is #{abbrev}")
    end
    
  end # End of test method - test_RefLib_004_Months
  
  #===========================================================================#
  # Testcase method: test_RefLib_005_TopLevelDomains
  #
  # Description: Test the Reference Top Level Domain values
  #===========================================================================#
  def test_RefLib_005_TopLevelDomains
    
    puts2("")
    puts2("#######################")
    puts2("Testcase: test_RefLib_005_TopLevelDomains")
    puts2("#######################")
    
    puts2("")
    puts2("Valid Top Level Domains:")
    TOP_LEVEL_DOMAINS.sort.each do | tld |
      puts2("#{tld}")
    end
    
  end # End of test method - test_RefLib_005_TopLevelDomains
  
  #=============================================================================#
  # Testcase method: test_RefLib_006_Countries
  #
  # Description: Test the Reference Country 2-Character values
  #===========================================================================#
  def test_RefLib_006_Countries
    
    puts2("")
    puts2("#######################")
    puts2("Testcase: test_RefLib_006_Countries")
    puts2("#######################")
    
    puts2("")
    puts2("Countries 2-Char")
    COUNTRY_CODES_2CHAR.each do  |key, value | 
      puts2(" Abbreviation " + key + ", is " + value)
    end
    
    puts2("-"*20)
    
    puts2("")
    puts2("Countries 3-Char")
    COUNTRY_CODES.each do  | key, value | 
      puts2(" Abbreviation " + key + ", is " + value)
    end
  end # End of test method - test_RefLib_006_Countries
  
end # end of Class - UnitTest_RefLib

# End of file - reflib_unittest.rb
