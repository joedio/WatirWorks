#--
#=============================================================================#
# File: string_unittest.rb
#
# Copyright (c) 2008-2018, Joe DiMauro
#  All rights reserved.
#
# Description: Unit tests for WatirWorks STRING methods:
#                   wordcount()
#                   prefix(...)
#                   suffix(...)
#                   format_dateString_mdyy(...)
#                   format_dateString_mmddyyyy(...)
#                   to_sentence()
#
#              Unit tests for other string related methods:
#                   compare_strings_in_arrays(...)
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
# Class: UnitTest_String
#
#
# Test Case Methods: setup, teardown
#
#
#
#=============================================================================#
class UnitTest_String < Test::Unit::TestCase
  
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
  # Testcase method: test_String_001_isBlank
  #
  # Description: Test the method is_blank?()
  #              This method is  a extension of the STRING class
  #===========================================================================#
  def test_String_001_isBlank
    
    puts2("")
    puts2("#######################")
    puts2("Testcase: test_String_001_isBlank")
    puts2("#######################")
    
    # Space, tab, empty, and formatting strings that should test as blank
    aStrings = [" ", ' ', " ", "", "\n", "\t"]
    aStrings.each do | sString |
      puts2("Expeced Blank: " + sString.is_blank?.to_s)
    end
    
    # Strings that  should test and NOT blank
    aStrings = ["a", "a b", " a ",  " b ", 120.chr]
    
    aStrings.each do | sString |
      puts2("Expected NOT Blank: " + sString.is_blank?.to_s)
    end
    
    
  end # End of test method - test_String_001_isBlank
  
  
  #===========================================================================#
  # Testcase method: test_String_002_wordcount
  #
  # Description: Test the method wc()
  #===========================================================================#
  def test_String_002_wordcount
    
    puts2("")
    puts2("#######################")
    puts2("Testcase: test_String_002_wordcount")
    puts2("#######################")
    
    
    sStringVariable = "Doesn't count contractions or hyphens as two-words"
    aArrayofStrings = [
   "  Multiple   Whitespace is \tignored. New line\n also. \n123-456 \n a+b i:2  1/2    ",
   "#{sStringVariable}",
   "THE END"
    ]
    
    aArrayofStrings.each do |  sString |
      puts2("\nString: #{sString}")
      puts2("Word count: #{sString.wc.to_s}")
      
    end
    
  end # End of test method - test_String_002_wordcount
  
  #===========================================================================#
  # Testcase method: test_String_003_ToSentence
  #
  # Description: Test the method to_sentence()
  #              This method is as extension of the STRING object,
  #===========================================================================#
  def test_String_003_ToSentence
    
    puts2("")
    puts2("#######################")
    puts2("Testcase: test_String_003_ToSentence")
    puts2("#######################")
    
    
    puts2("\nA specific string...")
    sString = "oNCE UPON a time Long ago and far away"
    puts2("\n String: " + sString)
    sSentence = sString.to_sentence
    puts2(" Sentence: " + sSentence)
    
    puts2("\nFour sets of 2 pseudo words as sentences...")
    4.times {
      sString = random_pseudowords(2,10)
      puts2("\n String: " + sString)
      sSentence = sString.to_sentence
      puts2(" Sentence: " + sSentence)
    }
    
    puts2("\nTwo sets of 3 pseudo words ending in a period as sentences...")
    2.times {
      sString = random_pseudowords(3,10) + "."
      puts2("\n String: " + sString)
      sSentence = sString.to_sentence
      puts2(" Sentence: " + sSentence)
    }
    
    puts2("\nTwo sets of 4 pseudo words ending in a exclamation point as sentences...")
    2.times {
      sString = random_pseudowords(4,10) + "!"
      puts2("\n String: " + sString)
      sSentence = sString.to_sentence
      puts2(" Sentence: " + sSentence)
    }
    
    puts2("\nTwo sets of 5 pseudo words ending in a question mark as sentences...")
    2.times {
      sString = random_pseudowords(5,10) + "?"
      puts2("\n String: " + sString)
      sSentence = sString.to_sentence
      puts2(" Sentence: " + sSentence)
    }
    
  end # End of test method - test_String_003_ToSentence
  
  #===========================================================================#
  # Testcase method: test_String_004_prefix
  #
  # Description: Test the method prefix()
  #===========================================================================#
  def test_String_004_prefix
    
    puts2("")
    puts2("#######################")
    puts2("Testcase: test_String_004_prefix")
    puts2("#######################")
    
    sMyFile = "some_long_filename.log"
    puts2("\nReturn the file name without its extension for: " + sMyFile)
    sMyFilePrefix = sMyFile.prefix(".")
    puts2("File name: " + sMyFilePrefix)
    #
    sMyEmailAddress = "joe@gmail.net"
    puts2("\nReturn the user account of the Email address: " + sMyEmailAddress)
    sMyUserAccount = sMyEmailAddress.prefix("@")
    puts2("User account: " + sMyUserAccount)
    
    sMyString = "This is a test"
    puts2("\nReturn the first word in the string: " + sMyString)
    sMyFirstWord = sMyString.prefix(" ")
    puts2("First word: " +  sMyFirstWord)
    
    sMyString = "   String with leading & trailing white space "
    puts2("\nReturn the first word of the String: " + sMyString)
    sMyFirstWord = sMyString.prefix(" ")
    puts2("First word: " +  sMyFirstWord)
    
    sMyString = "   No delimiter specified "
    puts2("\nReturn the whole String if: " + sMyString)
    sMyFirstWord = sMyString.prefix("")
    puts2("String: " +  sMyFirstWord)
    
    sMyString = "   Multiple delimiter-characters that are in the specified string   "
    puts2("\nReturn the first word of the String: " + sMyString)
    sMyFirstWord = sMyString.prefix(" #")
    puts2("First word: " +  sMyFirstWord)
    
    sMyString = "   Delimiter character is NOT in the string "
    puts2("\nReturn the whole String if: " + sMyString)
    sMyFirstWord = sMyString.prefix(".")
    puts2("String: " +  sMyFirstWord)
    
  end # End of test method - test_String_004_prefix
  
  
  #===========================================================================#
  # Testcase method: test_String_005_suffix
  #
  # Description: Test the method suffix()
  #===========================================================================#
  def test_String_005_suffix
    
    puts2("")
    puts2("#######################")
    puts2("Testcase: test_String_005_suffix")
    puts2("#######################")
    
    sMyFile = "some_long_filename.log"
    puts2("\nReturn the file extension for: " + sMyFile)
    sMyFileSuffix = sMyFile.suffix(".")
    puts2("File name extension: " + sMyFileSuffix)
    #
    sMyEmailAddress = "joe@gmail.net"
    puts2("\nReturn the domain of the Email address: " + sMyEmailAddress)
    sMyDomain = sMyEmailAddress.suffix("@")
    puts2("Domain: " + sMyDomain)
    
    sMyString = "This is a test"
    puts2("\nReturn the last word in the string: " + sMyString)
    sMyLastWord = sMyString.suffix(" ")
    puts2("Last word: " +  sMyLastWord)
    
    sMyString = "   String with leading & trailing white space "
    puts2("\nReturn the last word of the String: " + sMyString)
    sMyLastWord = sMyString.suffix(" ")
    puts2("Last word: " +  sMyLastWord)
    
    sMyString = "   No delimiter specified "
    puts2("\nReturn the whole String if: " + sMyString)
    sMyLastWord = sMyString.suffix("")
    puts2("String: " +  sMyLastWord)
    
    sMyString = "   Multiple delimiter-characters that are in the specified string   "
    puts2("\nReturn the last word of the String: " + sMyString)
    sMyLastWord = sMyString.suffix(" #")
    puts2("Last word: " +  sMyLastWord)
    
    sMyString = "   Delimiter character is NOT in the string "
    puts2("\nReturn the whole String if: " + sMyString)
    sMyLastWord = sMyString.suffix(".")
    puts2("String: " +  sMyLastWord)
    
  end # End of test method - test_String_005_suffix
  
  #===========================================================================#
  # Testcase method: test_String_006_remove_prefix
  #
  # Description: Test the method remove_prefix()
  #===========================================================================#
  def test_String_006_remove_prefix
    
    puts2("")
    puts2("#######################")
    puts2("Testcase: test_String_006_remove_prefix")
    puts2("#######################")
    
    sMyFile = "some_long_filename.log"
    puts2("\nReturn the file extension for: " + sMyFile)
    sMyFilePrefix = sMyFile.remove_prefix(".")
    puts2("File name: " + sMyFilePrefix)
    #
    sMyEmailAddress = "joe@gmail.net"
    puts2("\nReturn the Domain Name of the Email address: " + sMyEmailAddress)
    sMyUserAccount = sMyEmailAddress.remove_prefix("@")
    puts2("User account: " + sMyUserAccount)
    
    sMyString = "This is a test"
    puts2("\nReturn the string with the first word removed: " + sMyString)
    sMyFirstWord = sMyString.remove_prefix(" ")
    puts2("First word: " +  sMyFirstWord)
    
    sMyString = "   String with leading & trailing white space "
    puts2("\nReturn the first word of the String: " + sMyString)
    sMyFirstWord = sMyString.remove_prefix(" ")
    puts2("First word: " +  sMyFirstWord)
    
    sMyString = "   No delimiter specified "
    puts2("\nReturn the whole String if: " + sMyString)
    sMyFirstWord = sMyString.remove_prefix("")
    puts2("String: " +  sMyFirstWord)
    
    sMyString = "   Multiple delimiter-characters that are in the specified string   "
    puts2("\nReturn the string with the first word removed: " + sMyString)
    sMyFirstWord = sMyString.remove_prefix(" #")
    puts2("First word: " +  sMyFirstWord)
    
    sMyString = "   Delimiter character is NOT in the string "
    puts2("\nReturn the whole String if: " + sMyString)
    sMyFirstWord = sMyString.remove_prefix(".")
    puts2("String: " +  sMyFirstWord)
    
  end # End of test method - test_String_006_remove_prefix
  
  
  #===========================================================================#
  # Testcase method: test_String_007_remove_suffix
  #
  # Description: Test the method remove_suffix()
  #===========================================================================#
  def test_String_007_remove_suffix
    
    puts2("")
    puts2("#######################")
    puts2("Testcase: test_String_007_remove_suffix")
    puts2("#######################")
    
    sMyFile = "some_long_filename.log"
    puts2("\nReturn the file name with the extension removed: " + sMyFile)
    sMyFileSuffix = sMyFile.remove_suffix(".")
    puts2("File name extension: " + sMyFileSuffix)
    #
    sMyEmailAddress = "joe@gmail.net"
    puts2("\nReturn the User Account of the Email address: " + sMyEmailAddress)
    sMyDomain = sMyEmailAddress.remove_suffix("@")
    puts2("Domain: " + sMyDomain)
    
    sMyString = "This is a test"
    puts2("\nReturn the string with the last word removed: " + sMyString)
    sMyLastWord = sMyString.remove_suffix(" ")
    puts2("Last word: " +  sMyLastWord)
    
    sMyString = "   String with leading & trailing white space "
    puts2("\nReturn the string with the last word removed: " + sMyString)
    sMyLastWord = sMyString.remove_suffix(" ")
    puts2("Last word: " +  sMyLastWord)
    
    sMyString = "   No delimiter specified "
    puts2("\nReturn the whole String if: " + sMyString)
    sMyLastWord = sMyString.remove_suffix("")
    puts2("String: " +  sMyLastWord)
    
    sMyString = "   Multiple delimiter-characters that are in the specified string   "
    puts2("\nReturn the string with the last word removed: " + sMyString)
    sMyLastWord = sMyString.remove_suffix(" #")
    puts2("Last word: " +  sMyLastWord)
    
    sMyString = "   Delimiter character is NOT in the string "
    puts2("\nReturn the whole String if: " + sMyString)
    sMyLastWord = sMyString.remove_suffix(".")
    puts2("String: " +  sMyLastWord)
    
  end # End of test method - test_String_007_remove_suffix
  
  #===========================================================================#
  # Testcase method: test_String_008_format_dateString_mdyy
  #
  # Description: Test the method dateString_mdyy(...) with dates expressed as strings
  #===========================================================================#
  def test_String_008_format_dateString_mdyy
    
    # require 'date'
    
    puts2("")
    puts2("#######################")
    puts2("Testcase: test_String_008_format_dateString_mdyy")
    puts2("#######################")
    
    puts2("\nTesting slash delimited dates expressed as STRINGS")
    
    # Array of date strings to test
    aDateStrings = [
    "12/31/2000",
    "1/1/01",
    "01/02/2002",
    "01/3/2003",
    "11/5/1900",
    "10/06/1901"
    ]
    
    # Loop through the list, converting each date string
    aDateStrings.each do | sDateString |
      puts2("#{sDateString}  formatted as  " + sDateString.format_dateString_mdyy("/"))
    end
    
    puts2("\nTesting period delimited dates expressed as STRINGS")
    # Array of date strings to test
    aDateStrings = [
    "12.31.2000",
    "1.1.01",
    "01.02.2002",
    "01.3.2003",
    "11.5.1900",
    "10.06.1901"
    ]
    
    # Loop through the list, converting each date string
    aDateStrings.each do | sDateString |
      puts2("#{sDateString}  formatted as  " + sDateString.format_dateString_mdyy("."))
    end
    
  end # End of testcase - test_String_008_format_dateString_mdyy
  
  #===========================================================================#
  # Testcase method: test_String_009_format_dateString_mmddyyyy
  #
  # Description: Test the method format_dateString_mmddyyyy(...) with dates expressed as strings
  #===========================================================================#
  def test_String_009_format_dateString_mmddyyyy
    
    #require 'date'
    
    puts2("")
    puts2("#######################")
    puts2("Testcase: test_String_009_format_dateString_mmddyyyy")
    puts2("#######################")
    
    puts2("\nTesting slash delimited dates expressed as STRINGS to the 1900's")
    
    # Array of date strings to test
    aDateStrings = [
    "1/1/01",
    "01/02/01",
    "11/1/01",
    "1/10/01",
    "12/31/2000",
    ]
    
    # Loop through the list, converting each date string
    aDateStrings.each do | sDateString |
      puts2("#{sDateString}  formatted as  " + sDateString.format_dateString_mmddyyyy("/" ,"19"))
    end
    
    
    puts2("\nTesting period delimited dates expressed as STRINGS to the 2300's")
    
    # Array of date strings to test
    aDateStrings = [
    "1.1.01",
    "01.02.01",
    "11.1.01",
    "1.10.01",
    "12.31.2000",
    ]
    
    # Loop through the list, converting each date string
    aDateStrings.each do | sDateString |
      puts2("#{sDateString}  formatted as  " + sDateString.format_dateString_mmddyyyy("." ,"23"))
    end
    
  end # End of testcase - test_String_009_format_dateString_mmddyyyy
  
  #===========================================================================#
  # Testcase method: test_String_010_compare_strings_in_arrays
  #
  # Description: Test the method compare_strings_in_arrays(...)
  #              This method is NOT a extension of the STRING object, but
  #              is unit tested here as it deals with STRINGS
  #===========================================================================#
  def test_String_010_compare_strings_in_arrays
    
    puts2("")
    puts2("#######################")
    puts2("Testcase: test_String_010_compare_strings_in_arrays")
    puts2("#######################")
    
    sString = "Some strings are identical, and some strings are not identical"
    sString.scan(/(^|\s)(\S+)(?=\s.*?\2)/) { puts2 $2 }
    
    
    puts2("\nTesting Compare strings...")
    aFirstArray = ["the", "end", "the end", "stop"]
    aSecondArray = ["The end", "end", "start", "the", "Stop"]
    puts2("Compare first array:")
    puts2(aFirstArray.to_s)
    puts2("\nWith second array:")
    puts2(aSecondArray.to_s)
    aFound = compare_strings_in_arrays(aFirstArray, aSecondArray)
    puts2("Exact Matches Found: "+ aFound[0].to_s)
    puts2(" Matching text: "+ aFound[1].to_s)
    
    puts2("\nTesting Compare strings Ignore case...")
    aFirstArray = ["the", "end", "the end", "stop"]
    aSecondArray = ["The end", "end", "start", "the", "Stop"]
    puts2("Compare first array:")
    puts2(aFirstArray.to_s)
    puts2("\nWith second array:")
    puts2(aSecondArray.to_s)
    aFound = compare_strings_in_arrays(aFirstArray, aSecondArray, true)
    puts2("Exact Matches Found: "+ aFound[0].to_s)
    puts2(" Matching text: "+ aFound[1].to_s)
    
    puts2("\nTesting Compare Regexp (Ignore case)...")
    aFirstArray = ["the", "end", "the end", "stop"]
    aSecondArray = ["The end", "end", "start", "the", "Stop"]
    puts2("Compare first array:")
    puts2(aFirstArray.to_s)
    puts2("\nWith second array:")
    puts2(aSecondArray.to_s)
    aFound = compare_strings_in_arrays(aFirstArray, aSecondArray, true, true)
    puts2("Close Matches Found: "+ aFound[0].to_s)
    puts2(" Matching text: "+ aFound[1].to_s)
    
  end # End of test method - test_String_010_compare_strings_in_arrays
  
  
end # end of Class - UnitTest_String
