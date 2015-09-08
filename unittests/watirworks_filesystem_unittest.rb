#--
#=============================================================================#
# File: watirworks_filesystem_unittest.rb
#
#  Copyright (c) 2008-2010, Joe DiMauro
#  All rights reserved.
#
# Description: Unit tests for WatirWorks methods:
#                     find_folder(...)
#                     compare_files(...)
#                     parse_dictionary()
#                     get_watirworks_install_path()
#                     parse_ascii_file(...)
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
# Class: UnitTest_FileSytem
#
#
# Test Case Methods: setup, teardown
#                    find_folder(...)
#                    compare_files(...)
#                    parse_csv_file(...)
#
#=============================================================================#
class UnitTest_FileSytem < Test::Unit::TestCase

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
  # Testcase method: test_FileSytem_001_find_folder_in_tree
  #
  # Description: Test the method find_folder_in_tree(...)
  #===========================================================================#
  def test_FileSystem_001_find_folder_in_tree

    puts2("")
    puts2("#######################")
    puts2("Testcase: test_FileSytem_001_find_folder_in_tree")
    puts2("#######################")

    # For additional output during this test activate Ruby's Verbose flag
    #$VERBOSE = true

    puts2("\nSearch for parent or sub-folders from the location: \n " + Dir.getwd)

    aFoldersToFind = ["lib", "gems", "ruby", "unittests", "data", "subfolder"]

    aFoldersToFind.each do | sFolder |
      puts2("\nSearching for folder: " + sFolder)
      sPath = find_folder_in_tree(sFolder)
      puts2(" Full path to folder: " + sPath)
    end

    puts2("\nSearch for the parent top level folder of this file...\n")

    # Platform specific search for a Top-level-folder
    #
    if(is_win?)

      sFolder = "ruby"
      puts2("Search for folder: " + sFolder)
      # NOTE : This trial will give a false positive if there is a "ruby" folder under the "Ruby" tree
      #        The Ruby methods used in the search are NOT case sensitive, it will also match
      #        the sub-folder "ruby" and NOT a Top-Level-Dir "Ruby"
      sPath = find_folder_in_tree(sFolder)
      puts2("Full path to folder: " + sPath)

    else # Search for a Linux or Mac/OSX Top-level-folder
      sFolder = "opt"
      puts2("Searching for folder: " + sFolder)
      sPath =find_folder_in_tree(sFolder)  # Presuming that your Ruby install dir is /opt/ruby/
      puts2("Full path to folder: " + sPath)
    end

    puts2("\nSearch for a non-existant folder...")
    sFolder = "no such folder exists"
    puts2("Searching for folder: " + sFolder)
    sPath = find_folder_in_tree(sFolder)
    puts2("Full path to folder: "  + sPath)

  end # End of test method - test_FileSytem_001_find_folder_in_tree

  #===========================================================================#
  # Testcase method: test_FileSystem_002_compare_files
  #
  # Description: Test the method compare_files(...)
  #===========================================================================#
  def test_FileSystem_002_compare_files

    #$VERBOSE = true

    puts2("")
    puts2("#######################")
    puts2("Testcase: test_FileSystem_002_compare_files")
    puts2("#######################")

    sFile_1 = "data/FileOne.txt"
    sFile_2 = "data/FileTwo.txt"
    sFile_3 = "data/subfolder/FileThree.txt"

    sCSVFile_1 = "data/data.csv"
    sCSVFile_2 = "data/data2.csv"
    sCSVFile_3 = "data/data3.csv"

    puts2("\nCompare a text file to itself")
    if(compare_files(sFile_1, sFile_1))
      puts2("Files match")
    else
      puts2("Files DIFFER")
    end

    puts2("\nCompare 2 text files that should match")
    if(compare_files(sFile_1, sFile_2))
      puts2("Files match")
    else
      puts2("Files DIFFER")
    end

    puts2("\nCompare 2 text files that should NOT match")
    if(compare_files(sFile_1, sFile_3))
      puts2("Files match")
    else
      puts2("Files DIFFER")
    end

    puts2("\nCompare a CSV file to itself")
    if(compare_files(sCSVFile_1, sCSVFile_1))
      puts2("Files match")
    else
      puts2("Files DIFFER")
    end

    puts2("\nCompare 2 CSV files that should match")
    if(compare_files(sCSVFile_1, sCSVFile_2))
      puts2("Files match")
    else
      puts2("Files DIFFER")
    end

    puts2("\nCompare 2 CSV files that should NOT match")
    if(compare_files(sCSVFile_1, sCSVFile_3))
      puts2("Files match")
    else
      puts2("Files DIFFER")
    end

  end # End of test method - test_FileSystem_002_compare_files


  #===========================================================================#
  # Testcase method: test_FileSystem_003_get_text_from_file
  #
  # Description: Test the method get_text_from_file(...)
  #===========================================================================#
  def test_FileSystem_003_get_text_from_file

    puts2("")
    puts2("#######################")
    puts2("Testcase: test_FileSystem_003_get_text_from_file")
    puts2("#######################")

    #$VERBOSE = true

    sSearchString = "OK"
    sFile = "./data/FileOne.txt"

    puts2("\nDown 1) Search file " + sFile + " for string " + sSearchString + " from first line(0) DOWN to last line (0)")
    aMatches = get_text_from_file(sSearchString, sFile, 0, 0)

    # Iterate through the array to display each of its values (A row  of data read from the file)
    aMatches.each do | aMatch|
      puts2("Match: " + aMatch[0].to_s)
      puts2("Line: " + aMatch[1].to_s + "  Text: " + aMatch[2].to_s)
    end

    puts2("\nDown 2) Search file " + sFile + " for string " + sSearchString + " from first line (0) DOWN for (2) lines")
    aMatches = get_text_from_file(sSearchString, sFile, 0, 2)

    # Iterate through the array to display each of its values (A row  of data read from the file)
    aMatches.each do | aMatch|
      puts2("Match: " + aMatch[0].to_s)
      puts2("Line: " + aMatch[1].to_s + "  Text: " + aMatch[2].to_s)
    end

    puts2("\nDown 3) Search file " + sFile + " for string " + sSearchString + " from line (2) DOWN for (3) lines")
    aMatches = get_text_from_file(sSearchString, sFile, 2, 3)

    # Iterate through the array to display each of its values (A row  of data read from the file)
    aMatches.each do | aMatch|
      puts2("Match: " + aMatch[0].to_s)
      puts2("Line: " + aMatch[1].to_s + "  Text: " + aMatch[2].to_s)
    end

    puts2("\nDown 4) Search file " + sFile + " for string " + sSearchString + " from first line (0) DOWN for out of bounds lines (9999)")
    aMatches = get_text_from_file(sSearchString, sFile, 0, 9999)

    # Iterate through the array to display each of its values (A row  of data read from the file)
    aMatches.each do | aMatch|
      puts2("Match: " + aMatch[0].to_s)
      puts2("Line: " + aMatch[1].to_s + "  Text: " + aMatch[2].to_s)
    end

    puts2("\nDown 5) Search file " + sFile + " for string " + sSearchString + " from line (3) DOWN for out of bounds lines (9999)")
    aMatches = get_text_from_file(sSearchString, sFile, 3, 9999)

    # Iterate through the array to display each of its values (A row  of data read from the file)
    aMatches.each do | aMatch|
      puts2("Match: " + aMatch[0].to_s)
      puts2("Line: " + aMatch[1].to_s + "  Text: " + aMatch[2].to_s)
    end

    puts2("\nDown 6) Search file " + sFile + " for string " + sSearchString + " from out-of-bounds line (9999) DOWN for out of bounds lines (9999)")
    aMatches = get_text_from_file(sSearchString, sFile, 9999, 9999)

    # Iterate through the array to display each of its values (A row  of data read from the file)
    aMatches.each do | aMatch|
      puts2("Match: " + aMatch[0].to_s)
      puts2("Line: " + aMatch[1].to_s + "  Text: " + aMatch[2].to_s)
    end

    #===================================================================#

    puts2("\nUp 1) Search file " + sFile + " for string " + sSearchString + " from last line (-1) UP for (5) lines")
    aMatches = get_text_from_file(sSearchString, sFile, -1, -5)

    # Iterate through the array to display each of its values (A row  of data read from the file)
    aMatches.each do | aMatch|
      puts2("Match: " + aMatch[0].to_s)
      puts2("Line: " + aMatch[1].to_s + "  Text: " + aMatch[2].to_s)
    end

    puts2("\nUp 2) Search file " + sFile + " for string " + sSearchString + " from line (5) UP for (4) lines")
    aMatches = get_text_from_file(sSearchString, sFile, 5, -4)

    # Iterate through the array to display each of its values (A row  of data read from the file)
    aMatches.each do | aMatch|
      puts2("Match: " + aMatch[0].to_s)
      puts2("Line: " + aMatch[1].to_s + "  Text: " + aMatch[2].to_s)
    end


    puts2("\Up 3) Search file " + sFile + " for string " + sSearchString + " from last line (-1) UP for (4) lines")
    aMatches = get_text_from_file(sSearchString, sFile, -1, -4)

    # Iterate through the array to display each of its values (A row  of data read from the file)
    aMatches.each do | aMatch|
      puts2("Match: " + aMatch[0].to_s)
      puts2("Line: " + aMatch[1].to_s + "  Text: " + aMatch[2].to_s)
    end

    puts2("\Up 4) Search file " + sFile + " for string " + sSearchString + " from out of bounds line (9999) up for out of bounds lines (-9999)")
    aMatches = get_text_from_file(sSearchString, sFile, 9999, -9999)

    # Iterate through the array to display each of its values (A row  of data read from the file)
    aMatches.each do | aMatch|
      puts2("Match: " + aMatch[0].to_s)
      puts2("Line: " + aMatch[1].to_s + "  Text: " + aMatch[2].to_s)
    end

  end # End of test method - test_FileSystem_003_get_text_from_file


  #===========================================================================#
  # Testcase method: test_FileSystem_004_parse_dictionary
  #
  # Description: Test the methods: parse_dictionary()
  #                                             get_watirworks_install_path()      # Called by parse_dictionary()
  #                                             parse_ascii_file(...)      # Called by parse_dictionary()
  #===========================================================================#
  def test_FileSystem_004_parse_dictionary

    puts2("")
    puts2("#######################")
    puts2("Testcase: test_FileSystem_004_parse_dictionary")
    puts2("#######################")

    $VERBOSE = true

    aDictionaryContents = parse_dictionary("english.dictionary")

    # NoMethodError: undefined method `[]' for #<Enumerator:0x34ccae8>
    puts2("First word in dictionary: " + aDictionaryContents[0])
    puts2("Second word in dictionary: " + aDictionaryContents[1])

    iLastLineInFile = (aDictionaryContents.length) -1
    puts2("Words in dictionary:" + iLastLineInFile.to_s)

    puts2("Last word in dictionary: " + aDictionaryContents[iLastLineInFile])

    # Clear the global variable so it doesn't impact other unittests
    $Dictionary = nil

  end # End of test method - test_FileSystem_004_parse_dictionary

end # end of Class - UnitTest_FileSytem
