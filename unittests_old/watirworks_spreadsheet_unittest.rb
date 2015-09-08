#--
#=============================================================================#
# File: watirworks_spreadsheet_unittest.rb
#
#  Copyright (c) 2008-2011, Joe DiMauro
#  All rights reserved.
#
# Description: Unit tests for WatirWorks methods:
#                     parse_csv_file(...)
#                     parse_spreadsheet()
#                     parse_workbook()
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
# Class: UnitTest_Spreadsheet
#
#
# Test Case Methods: setup, teardown
#                    find_folder(...)
#                    compare_files(...)
#                    parse_csv_file(...)
#
#=============================================================================#
class UnitTest_Spreadsheet < Test::Unit::TestCase

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
    @@Dictionary = $Dictionary

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
    $Dictionary  = @@Dictionary

  end # end of teardown

  #===========================================================================#
  # Testcase method: test_Spreadhseet_001_parse_csv_file
  #
  # Description: Test the method parse_csv_file(...)
  #===========================================================================#
  def test_Spreadhseet_001_parse_csv_file

    puts2("")
    puts2("#######################")
    puts2("Testcase: test_Spreadhseet_001_parse_csv_file")
    puts2("#######################")

    #$VERBOSE = true

    sCSVFile = "data.csv"
    sDataDir = "data"

    aCSV_DataArray = parse_csv_file(sCSVFile, sDataDir)

    # Iterate through the array to display each of its values (A row  of data read from the CSV file)
    aCSV_DataArray.each do | sRowRecord |
      puts2("Row: ")
      sRowRecord.each do | sCellData |
        puts2(" Cell: " + sCellData.to_s)
      end
    end

  end # End of test method - test_Spreadhseet_001_parse_csv_file


  #===========================================================================#
  # Testcase method: test_Spreadhseet_002_parse_spreadsheet
  #
  # Description: Test the method parse_spreadsheet(...)
  #===========================================================================#
  def test_Spreadhseet_002_parse_spreadsheet

    puts2("")
    puts2("#######################")
    puts2("Testcase: test_Spreadhseet_002_parse_spreadsheet")
    puts2("#######################")

    #$VERBOSE = true

    sDataDir = "data"

    aWorkbookFiles = ["Book1.xls", "Book1.xlsx", "Book1.ods"]

    sSpreadsheet = nil
    #sSpreadsheet = "Employees"

    # true = read only to the first blank row
    # false = Read whole sheet
    bStopatBlankRow = true

    # Loop through workbook types
    aWorkbookFiles.each do | sWorkbookFile |

      aSpreadsheetContents_byRow = parse_spreadsheet(sWorkbookFile, sSpreadsheet, bStopatBlankRow, sDataDir)

      aSpreadsheetContents_byRow.each do | sRowData |
        puts2(sRowData)
      end

      puts2("\n")

    end  # Loop through workbook types




  end # End of test method - test_Spreadhseet_002_parse_spreadsheet

  #===========================================================================#
  # Testcase method: test_Spreadhseet_003_parse_workbook
  #
  # Description: Test the method parse_workbook(...)
  #===========================================================================#
  def test_Spreadhseet_003_parse_workbook

    puts2("")
    puts2("#######################")
    puts2("Testcase: test_Spreadhseet_003_parse_workbook")
    puts2("#######################")

    #$VERBOSE = true

    sDataDir = "data"
    aSpreadsheetContents_byRow = []

    aWorkbookFiles = ["Book1.xls", "Book1.xlsx", "Book1.ods"]

    aSpreadsheets = ["Employees", "Sheet2", "Sheet3"]
    #aSpreadsheets = [nil, "Sheet2", "Sheet3"]

    # Loop through workbook types
    aWorkbookFiles.each do | sWorkbookFile |

      puts2("Data read from Workbook File: " + sWorkbookFile)
      hSpreadsheetData = parse_workbook(sWorkbookFile, aSpreadsheets, true, sDataDir)

      hSpreadsheetData.sort.each do |sSpreadsheet, aSpreadsheetContents_byRow|

        puts2("Data read from Spreadsheet: " + sSpreadsheet.to_s)

        aSpreadsheetContents_byRow.each do | sRowData |
          puts2(sRowData)
          puts2("")
        end
      end

      puts2("\n")

    end  # Loop through workbook types
  end # End of test method - test_Spreadhseet_003_parse_workbook



end # end of Class - UnitTest_Spreadsheet
