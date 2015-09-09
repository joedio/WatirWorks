#--
#=============================================================================#
# File: watirworks_random_unittest.rb
#
# Description: Unit tests for WatirWorks rondom methods:
#                   random_alphanumeric(...)
#                   random_number(...)
#                   random_boolean()
#                   random_char(...)
#                   random_chars(...)
#                   random_pseudowords(...)
#                   random_paragraph(...)
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
# Class: UnitTest_String
#
#
# Test Case Methods: setup, teardown
#
#
#
#=============================================================================#
class UnitTest_Random < Test::Unit::TestCase

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
  # Testcase method: test_String_001_RandomNumber
  #
  # Description: Test the method random_number()
  #              This method is NOT a extension of the STRING object, but
  #              is unit tested here along with other random STRING manipulation methods
  #===========================================================================#
  def test_Random_001_RandomNumber

    puts2("")
    puts2("#######################")
    puts2("Testcase: test_Random_001_RandomNumber")
    puts2("#######################")

    puts2("\nTwenty-five random numbers between 100 and 125...")

    20.times {
      puts2(" Random number: " + random_number(100,125).to_s)
    }

  end # End of test method - test_Random_001_RandomNumber

  #===========================================================================#
  # Testcase method: test_Random_002_RandomBoolean
  #
  # Description: Test the method random_boolean()
  #              This method is NOT a extension of the STRING object, but
  #              is unit tested here along with other random STRING manipulation methods
  #===========================================================================#
  def test_Random_002_RandomBoolean

    puts2("")
    puts2("#######################")
    puts2("Testcase: test_Random_002_RandomBoolean")
    puts2("#######################")

    puts2("\nTen random BOOLEAN values...")

    10.times {
      puts2(" Random BOOLEAN value: " + random_boolean().to_s)
    }

  end # End of test method - test_Random_002_RandomBoolean


  #===========================================================================#
  # Testcase method: test_Random_003_RandomAlphaNumeric
  #
  # Description: Test the method random_alphanumeric()
  #              This method is NOT a extension of the STRING object, but
  #              is unit tested here along with other random STRING manipulation methods
  #===========================================================================#
  def test_Random_003_RandomAlphaNumeric

    puts2("")
    puts2("#######################")
    puts2("Testcase: test_Random_003_RandomAlphaNumeric")
    puts2("#######################")

    puts2("")
    sMyString = random_alphanumeric(10)
    puts2("Random 10 " + " AlphaNumeric character string: "+ sMyString)

    puts2("Random 20 " + " AlphaNumeric character string: "+ random_alphanumeric())
    puts2("")

    # Print the random sting of lengths from iMin to iMax
    iMin = -1
    iMax = 25
    iMin.upto(iMax) { | iInteger |  puts2("Random " + iInteger.to_s + " character string: " + random_alphanumeric(iInteger)) }

  end # End of test method - test_Random_003_RandomAlphaNumeric

  #===========================================================================#
  # Testcase method: test_Random_004_RandomChar
  #
  # Description: Test the method random_char()
  #              This method is NOT a extension of the STRING object, but
  #              is unit tested here along with other random STRING manipulation methods
  #===========================================================================#
  def test_Random_004_RandomChar

    puts2("")
    puts2("#######################")
    puts2("Testcase: test_Random_004_RandomChar")
    puts2("#######################")

    puts2("\nThirty random lower case ASCII characters...")
    30.times {
      puts2(" Random lower case character: " + random_char())
    }

    puts2("\nThirty random UPPER CASE Characters...")
    30.times {
      puts2(" Random UPPER CASE Character: " + random_char(true))
    }

  end # End of test method - test_Random_004_RandomChar

  #===========================================================================#
  # Testcase method: test_Random_005_RandomChars
  #
  # Description: Test the method random_chars()
  #              This method is NOT a extension of the STRING object, but
  #              is unit tested here along with other random STRING manipulation methods
  #===========================================================================#
  def test_Random_005_RandomChars

    puts2("")
    puts2("#######################")
    puts2("Testcase: test_Random_005_RandomChars")
    puts2("#######################")

    puts2("\nTen random sets of 10 ASCII characters...")
    10.times {
      puts2(" Random lower case character set: " + random_chars())
    }

    puts2("\nFive random Capitalized sets of 10 ASCII characters...")
    5.times {
      puts2(" Random Capitalized Character set: " + random_chars(10, true))
    }

    puts2("\nTen random Capitalized sets of a random number of ASCII characters...")
    5.times {
      puts2(" Random Capitalized Character set: " + random_chars(random_number(0,10), true))
    }
    5.times {
      puts2(" Random Capitalized Character set: " + random_chars(random_number(10,20), true))
    }

  end # End of test method - test_Random_005_RandomChars

  #===========================================================================#
  # Testcase method: test_Random_006_RandomPseudoWords
  #
  # Description: Test the method random_pseudowords()
  #              This method is NOT a extension of the STRING object, but
  #              is unit tested here along with other random STRING manipulation methods
  #===========================================================================#
  def test_Random_006_RandomPseudoWords

    puts2("")
    puts2("#######################")
    puts2("Testcase: test_Random_006_RandomPseudoWords")
    puts2("#######################")

    puts2("\nFour random lower case sets of 2 pseudo words of up to 10 ASCII characters...")
    4.times {
      puts2(" Random lower case pseudo word set: " + random_pseudowords(2,10))
    }

    puts2("\nTwo random Capitalized sets of 10 pseudo words of up to 5 ASCII characters...")
    2.times {
      puts2(" Random Capitalized pseudo word set: " + random_pseudowords(10, 5, true))
    }

    puts2("\nTen random Capitalized sets of a random pseudo words comprised of a random number of ASCII characters...")
    5.times {
      puts2(" Random Capitalized pseudo word set: " + random_pseudowords(random_number(2,10), random_number(2,10), true))
    }
    5.times {
      puts2(" Random Capitalized pseudo word set: " + random_pseudowords(random_number(10,20), random_number(2,10), true))
    }

  end # End of test method - test_Random_006_RandomPseudoWords

  #===========================================================================#
  # Testcase method: test_Random_007_RandomParagraph
  #
  # Description: Test the method random_paragraph()
  #              This method is NOT a extension of the STRING object, but
  #              is unit tested here along with other random STRING manipulation methods
  #===========================================================================#
  def test_Random_007_RandomParagraph

    puts2("")
    puts2("#######################")
    puts2("Testcase: test_Random_007_RandomParagraph")
    puts2("#######################")

    puts2("\n Paragraph of 4 sentences with a max of 6 words per sentence, and 10 chard per word.")
    puts2(random_paragraph(4, 6, 10))

    puts2("\n More paragraphs...")
    puts2(random_paragraph(5, 6, 10))
    puts2(random_paragraph(7, 10, 10))
    puts2(random_paragraph(random_number(3,5), random_number(4,6), random_number(5,7)))


  end # End of test method - test_Random_007_RandomParagraph


  #===========================================================================#
  # Testcase method: test_Random_008_RandomWord
  #
  # Description: Test the method random_word()
  #              This method is NOT a extension of the STRING object, but
  #              is unit tested here along with other random STRING manipulation methods
  #===========================================================================#
  def test_Random_008_RandomWord

    $VERBOSE = true

    puts2("")
    puts2("#######################")
    puts2("Testcase: test_Random_008_RandomWord")
    puts2("#######################")

    puts2("\nTwenty lower case random words read from the WatirWorks dictionary....")
    20.times {
      puts2("Word: " + random_word())
    }

    puts2("\nTwenty Capitalized random words read from the WatirWorks dictionary....")
    20.times {
      puts2("Word: " + random_word(true))
    }


  end # End of test method - test_Random_008_RandomWord

  #===========================================================================#
  # Testcase method: test_Random_009_RandomSentence
  #
  # Description: Test the method random_word()
  #              This method is NOT a extension of the STRING object, but
  #              is unit tested here along with other random STRING manipulation methods
  #===========================================================================#
  def test_Random_009_RandomSentence

    puts2("")
    puts2("#######################")
    puts2("Testcase: test_Random_009_RandomSentence")
    puts2("#######################")

    puts2("\nTen random sentences of 5 words read from the WatirWorks dictionary....")
    10.times {
      puts2("Sentence: " + random_sentence(5))
    }

    puts2("\nTen random sentences of a random number of words read from the WatirWorks dictionary....")
    10.times {
      puts2("Sentence: " + random_sentence(random_number(2,5)))
    }

    # Clear the global variable so it doesn't impact other unittests
    $Dictionary = nil

  end # End of test method - test_Random_009_RandomSentence

end # end of Class - UnitTest_Random
