#encoding: ISO-8859-1
#--
#=============================================================================#
# File: watirworks_currency_unittest.rb
#
#  Copyright (c) 2008-2010, Joe DiMauro
#  All rights reserved.
#
# Description: Unit tests for WatirWorks methods:
#                  format_to_currency(...)
#                  format_from_currency(...)
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
# Class: UnitTest_Currency
#
#=============================================================================#
class UnitTest_Currency < Test::Unit::TestCase

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
  # Description: Before every testcase Test::Unit runs setup
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
  # Testcase method: test_Currency_001_Format_To_Amount
  #
  # Description: Tests PyWorks method: format_to_currency(...)
  #                   Attempts to convert strings to amounts
  #===========================================================================#
  def te_st_Currency_001_CommaDelimit

    puts2("")
    puts2("#######################")
    puts2("Testcase: test_Currency_001_CommaDelimit")
    puts2("#######################")


    fFloatsToDelimit = [1.00, 12.00, 123.00, 1234.00, 12345.00, 123456.00, 1234567.00,12345678.1234, 0.000000]

    for fFloat in fFloatsToDelimit
      sFloat = fFloat.comma_delimit(",")
      puts2("Delimited: " + fFloat.to_s + " to: " + sFloat.to_s)
    end

    #end convert_StringToCurrency

  end # End of test method - test_Currency_001_CommaDelimit

  #===========================================================================#
  # Testcase method: test_Currency_002_Format_To_Amount
  #
  # Description: Tests WatirWorks method: format_to_currency(...)
  #                   Attempts to convert strings to amounts
  #===========================================================================#
  def test_Currency_002_Format_To_Amount

    puts2("")
    puts2("#######################")
    puts2("Testcase: test_Currency_002_Format_To_Amount")
    puts2("#######################")

    begin # convert_ToCurrency

      ############################
      sThisTaskName = "1000 to $1,000.00"
      puts2(" # BEGIN: " + sThisTaskName + " #")

      sConvertedValue = "1000".format_to_currency()

      puts2("Formatted value = #{sConvertedValue.to_s}")
      ############################
      sThisTaskName = "1000 to £1.000.00"
      puts2("")
      puts2(" # BEGIN: " + sThisTaskName + " #")

      sConvertedValue = "1000".format_to_currency("£", ".")

      puts2("Formatted value = #{sConvertedValue.to_s}")
      ############################
      sThisTaskName = "  1000   to €1.000.00"
      puts2("")
      puts2(" # BEGIN: " + sThisTaskName + " #")

      sConvertedValue = "  1000  ".format_to_currency("€", ".")

      puts2("Formatted value = #{sConvertedValue.to_s}")
      ############################
      sThisTaskName = "1000.5 to $1,000.50"
      puts2("")
      puts2(" # BEGIN: " + sThisTaskName + " #")

      sConvertedValue = "1000.5".format_to_currency()

      puts2("Formatted value = #{sConvertedValue.to_s}")
      ############################
      sThisTaskName = "1.1 to $1.10"
      puts2("")
      puts2(" # BEGIN: " + sThisTaskName + " #")

      sConvertedValue = "1.1".format_to_currency()

      puts2("Formatted value = #{sConvertedValue.to_s}")
      ############################
      sThisTaskName = "1 to $1.00"
      puts2("")
      puts2(" # BEGIN: " + sThisTaskName + " #")

      sConvertedValue = "1".format_to_currency()

      puts2("Formatted value = #{sConvertedValue.to_s}")

      ############################
      sThisTaskName = ".01 to $0.01"
      puts2("")
      puts2(" # BEGIN: " + sThisTaskName + " #")

      sConvertedValue = ".01".format_to_currency()

      puts2("Formatted value = #{sConvertedValue.to_s}")
      ############################
      sThisTaskName = ".1 to $0.10"
      puts2("")
      puts2(" # BEGIN: " + sThisTaskName + " #")

      sConvertedValue = ".1".format_to_currency()

      puts2("Formatted value = #{sConvertedValue.to_s}")
      ############################
      sThisTaskName = "1. to $1.00"
      puts2("")
      puts2(" # BEGIN: " + sThisTaskName + " #")

      sConvertedValue = "1.".format_to_currency()

      puts2("Formatted value = #{sConvertedValue.to_s}")
      ############################
      sThisTaskName = "1000000.99 to 1,000,000.99"
      puts2("")
      puts2(" # BEGIN: " + sThisTaskName + " #")

      sConvertedValue = "1000000.99".format_to_currency("", ",")

      puts2("Formatted value = #{sConvertedValue.to_s}")
      ############################
      sThisTaskName = "1000000.99 to £1.000.000.99"
      puts2("")
      puts2(" # BEGIN: " + sThisTaskName + " #")

      sConvertedValue = "1000000.99".format_to_currency("£", ".")
      puts2("Formatted value = #{sConvertedValue.to_s}")
      ############################
      sThisTaskName = "1000000.999 to ¥1:000:000.99"
      puts2("")
      puts2(" # BEGIN: " + sThisTaskName + " #")

      sConvertedValue = "1000000.999".format_to_currency("¥", ":")
      puts2("Formatted value = #{sConvertedValue.to_s}")
      ############################


    rescue => e

      puts2("*** ERROR and Backtrace: " + e.message + "\n" + e.backtrace.join("\n"),"ERROR")

      # Raise the error
      raise("*** TESTCASE - test_Currency_002_Format_To_Amount")

    ensure

    end # convert_StringToCurrency


  end # End of test method - test_Currency_002_Format_To_Amount

  #=============================================================================#
  # Testcase method: test_Currency_003_Format_From_Amount
  #
  # Description: Tests WatirWorks method: format_from_currency(...)
  #                    Attempts to convert amounts to strings
  #=============================================================================#
  def test_Currency_003_Format_From_Amount


    puts2("")
    puts2("#######################")
    puts2("Testcase: test_Currency_003_Format_From_Amount")
    puts2("#######################")

    begin # convert_StringFromCurrency


      ############################
      sThisTaskName = "$1,000 to 1000"
      puts2("")
      puts2(" # BEGIN: " + sThisTaskName + " #")

      sConvertedValue = "$1,000".format_from_currency("$", ",", true)

      puts2("Formatted value = #{sConvertedValue.to_s}")
      ############################
      sThisTaskName = "$1,000,000.00 to 1000000.00"
      puts2("")
      puts2(" # BEGIN: " + sThisTaskName + " #")

      sConvertedValue = "$1,000,000.00".format_from_currency("$", ",", false)

      puts2("Formatted value = #{sConvertedValue.to_s}")
      ############################
      sThisTaskName = "£1.000.50 to 1000"
      puts2("")
      puts2(" # BEGIN: " + sThisTaskName + " #")

      sConvertedValue = "£1.000.50".format_from_currency("£", ".", true)

      puts2("Formatted value = #{sConvertedValue.to_s}")
      ############################
      sThisTaskName = "$1.000.5 to 1000.50"
      puts2("")
      puts2(" # BEGIN: " + sThisTaskName + " #")

      sConvertedValue = "$1.000.5".format_from_currency("$", ",", false)

      puts2("Formatted value = #{sConvertedValue.to_s}")
      ############################
      sThisTaskName = "$1,000,000.50 to $1000000"
      puts2("")
      puts2(" # BEGIN: " + sThisTaskName + " #")

      sConvertedValue = "$1,000,000.50".format_from_currency( "", ",",true)

      puts2("Formatted value = #{sConvertedValue.to_s}")
      ############################
      sThisTaskName = "¥1,000,000.5 to 1000000.50"
      puts2("")
      puts2(" # BEGIN: " + sThisTaskName + " #")

      sConvertedValue = "¥1,000,000.5".format_from_currency("¥", ",", false)

      puts2("Formatted value = #{sConvertedValue.to_s}")
      ############################
      sThisTaskName = "0.5 to 0.50"
      puts2("")
      puts2(" # BEGIN: " + sThisTaskName + " #")

      sConvertedValue = "0.5".format_from_currency("", ",", false)

      puts2("Formatted value = #{sConvertedValue.to_s}")
      ############################
      sThisTaskName = ".5 to 0.50"
      puts2("")
      puts2(" # BEGIN: " + sThisTaskName + " #")

      sConvertedValue = ".5".format_from_currency("", ",", false)

      puts2("Formatted value = #{sConvertedValue.to_s}")
      ############################
      sThisTaskName = "$1. to 1.00"
      puts2("")
      puts2(" # BEGIN: " + sThisTaskName + " #")

      sConvertedValue = "$1.".format_from_currency("$", ",", false)

      puts2("Formatted value = #{sConvertedValue.to_s}")
      ############################
      sThisTaskName = "$. to 0.00"
      puts2("")
      puts2(" # BEGIN: " + sThisTaskName + " #")

      sConvertedValue = "$.".format_from_currency("$", ",", false)

      puts2("Formatted value = #{sConvertedValue.to_s}")
      ############################


    rescue => e

      puts2("Error and Backtrace: " + e.message + "\n" + e.backtrace.join("\n"),"error")

      # Raise the error
      raise("*** TESTCASE - test_Currency_003_Format_From_Amount")

    ensure

    end # convert_StringFromCurrency

  end # End of test method - test_Currency_003_Format_From_Amount

end # end of Class - UnitTest_Currency
