#--
#=============================================================================#
# File: watirworks_html_text_unittest.rb
#
#
#  Copyright (c) 2008-2010, Joe DiMauro
#  All rights reserved.
#
# Description: Unit tests for the HTML text using WatirWorks methods:
#                isTextIn_DivClass?(...)
#                isTextIn_DivID?(...)
#                isTextIn_DivIndex?(...)
#                isTextIn_SpanClass?(...)
#                isTextIn_SpanID?(...)
#                isTextIn_SpanIndex?(...)
#                isTextIn_TableClass?(...)
#                isTextIn_TableID?(...)
#                isTextIn_TableIndex?(...)
#                isTextIn_TableName?(...)
#                parse_table_by_row(...)
#                find_string_in_div(...)
#                find_string_in_span(...)
#                find_string_in_table(...)
#                find_strings_in_table(...)
#
#
#=============================================================================#

#=============================================================================#
# Require and Include section
# Entries for additional files or methods needed by this test
#=============================================================================#
require 'rubygems'

$bUseWebDriver = true

if($bUseWebDriver == nil)
  $bUseWebDriver = true
end

# FireWatir
#require 'firewatir' # This is pulled in through WatirWorks_WebUtilities

# WatirWorks
require 'watirworks'  # The WatirWorks library loader

include WatirWorks_Utilities    # WatirWorks General Utilities
include WatirWorks_WebUtilities # WatirWorks Web Utilities

# Include the platform specific modules
if(is_win?)
  include WatirWorks_WinUtilities # WatirWorks Windows Utilities
elsif(is_linux?)
  include WatirWorks_LinuxUtilities # WatirWorks Linux Utilities
elsif(is_mac?)
  include WatirWorks_MacUtilities # WatirWorks MacOSX Utilities
end

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
sRun_TestType = "browser"
iRun_TestLevel = 0

# Inherit or set the default browser
if($sDefaultBrowser == nil)
  # Uncomment the browser to be used for this test run
  #$sDefaultBrowser = "ie"
  $sDefaultBrowser = "firefox"
  #$sDefaultBrowser = "chrome"
  #$sDefaultBrowser = "safari"
end

#=============================================================================#

#=============================================================================#
# Class: UnitTest_HTMLText
#
# Test Case Methods: setup, teardown
#
#
#=============================================================================#
class UnitTest_HTMLText < Test::Unit::TestCase
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

    # Minimize the Ruby Console window
    minimize_ruby_console()

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

    sleep 2 # delay between test cases to allow time for browsers to fully exit

  end # end of teardown

  #===========================================================================#
  # Testcase method: test_HTMLText_001_isTextIn_DivClass
  #
  # Description: Test the method: isTextIn_DivClass?(...)
  #
  #===========================================================================#
  def test_HTMLText_001_isTextIn_DivClass

    puts2("")
    puts2("#######################")
    puts2("Testcase: test_HTMLText_001_isTextIn_DivClass")
    puts2("#######################")

    #$VERBOSE = true
    #$DEBUG = true
    iDelay = 2

    # Define components of  the URL
    sProtocol = "file:///"
    sRootURL = Dir.pwd
    sPage = "data/html/html_tags.html"

    # Construct the URL
    sURL = sProtocol  + sRootURL + "/" + sPage

    # Array of trial data with the Expected Text, the Class Name, and the Save file prefix
    aSearchCriteria = [
      ["Text in First Div", "first", false, "isTextIn_DivClass_Trial_1"],
      ["Second Div", "second", false, "isTextIn_DivClass_Trial_2"],
      ["in Second", "third", false, "isTextIn_DivClass_Trial_3"],
      ["in Fifth", "fifth", false, "isTextIn_DivClass_Trial_4"],
      ["no such text", "first", true, "isTextIn_DivClass_Trial_5"]
    ]

    begin # Test the method

      # Start a browser,
      #browser = Watir::Browser.new
      browser = start_browser($sDefaultBrowser)

      # Load the page
      browser.goto(sURL)

      sleep(iDelay)

      sCurrentURL = browser.url
      puts2("Current URL: " + sCurrentURL)

      # Loop
      aSearchCriteria.each do | aTrial |

        # String to search for
        sExpectedText = aTrial[0].to_s

        # Class name to search
        sClass=aTrial[1].to_s

        # Save HTML & Screen capture if no match
        bSaveIssues = aTrial[2]

        # Name to be pre-pended to the file name of any screen capture or HTML saves
        sCaptureFileNamePrefix = aTrial[3].to_s

        puts2("\nSerching Div class:  \"#{sClass}\"  for the text \"#{sExpectedText}\"")

        if((browser.isTextIn_DivClass?(sExpectedText, sClass, bSaveIssues, sCaptureFileNamePrefix)) == true)
          puts2(" Found text: " + sExpectedText)
        else
          puts2("*** WARNING - Text not found: " + sExpectedText, "WARN")
        end

      end # Loop

    rescue => e

      puts2("*** ERROR and Backtrace: " + e.message + "\n" + e.backtrace.join("\n"),"ERROR")

      # Close the browser
      browser.close

      # Raise the error with a custom message after the rest of the rescue actions
      raise("*** TESTCASE - test_HTMLText_001_isTextIn_DivClass")

    ensure

      # Close the browser
      browser.close

    end # Test the method

  end # END TestCase - test_HTMLText_001_isTextIn_DivClass

  #===========================================================================#
  # Testcase method: test_HTMLText_002_isTextIn_DivID
  #
  # Description: Test the method: isTextIn_DivID?(...)
  #
  #===========================================================================#
  def test_HTMLText_002_isTextIn_DivID

    puts2("")
    puts2("#######################")
    puts2("Testcase: test_HTMLText_002_isTextIn_DivID")
    puts2("#######################")

    #$VERBOSE = true
    #$DEBUG = true
    iDelay = 2

    # Define components of  the URL
    # Define components of  the URL
    sProtocol = "file:///"
    sRootURL = Dir.pwd
    sPage = "data/html/html_tags.html"

    # Construct the URL
    sURL = sProtocol  + sRootURL + "/" + sPage

    # Array of trial data with the Expected Text, the Class Name, and the Save file prefix
    aSearchCriteria = [
      ["Text in First Div", "div_1", false, "isTextIn_DivID_Trial_1"],
      ["Second Div", "div_2", false, "isTextIn_DivID_Trial_2"],
      ["in Second", "div_3", false, "isTextIn_DivID_Trial_3"],
      ["in Fifth", "div_5", false, "isTextIn_DivID_Trial_4"],
      ["no such text", "div_1", true, "isTextIn_DivID_Trial_5"]
    ]

    begin # Test the method

      # Start a browser,
      #browser = Watir::Browser.new
      browser = start_browser($sDefaultBrowser)

      # Load the page
      browser.goto(sURL)

      sleep(iDelay)

      sCurrentURL = browser.url
      puts2("Current URL: " + sCurrentURL)

      # Loop
      aSearchCriteria.each do | aTrial |

        # String to search for
        sExpectedText = aTrial[0].to_s

        # Div ID name to search
        sDivID=aTrial[1].to_s

        # Save HTML & Screen capture if no match
        bSaveIssues = aTrial[2]

        # Name to be pre-pended to the file name of any screen capture or HTML saves
        sCaptureFileNamePrefix = aTrial[3].to_s

        puts2("\nSerching Div ID:  \"#{sDivID}\"  for the text \"#{sExpectedText}\"")

        if((browser.isTextIn_DivID?(sExpectedText, sDivID, bSaveIssues, sCaptureFileNamePrefix)) == true)
          puts2(" Found text: " + sExpectedText)
        else
          puts2("*** WARNING - Text not found: " + sExpectedText, "WARN")
        end

      end # Loop

    rescue => e

      puts2("*** ERROR and Backtrace: " + e.message + "\n" + e.backtrace.join("\n"),"ERROR")

      # Close the browser
      browser.close

      # Raise the error with a custom message after the rest of the rescue actions
      raise("*** TESTCASE - test_HTMLText_002_isTextIn_DivID")

    ensure

      # Close the browser
      browser.close

    end # Test the method

  end # END TestCase - test_HTMLText_002_isTextIn_DivID

  #===========================================================================#
  # Testcase method: test_HTMLText_003_isTextIn_DivIndex
  #
  # Description: Test the method: isTextIn_DivIndex?(...)
  #
  #===========================================================================#
  def test_HTMLText_003_isTextIn_DivIndex

    puts2("")
    puts2("#######################")
    puts2("Testcase: test_HTMLText_003_isTextIn_DivIndex")
    puts2("#######################")

    #$VERBOSE = true
    #$DEBUG = true
    iDelay = 2

    # Define components of  the URL
    sProtocol = "file:///"
    sRootURL = Dir.pwd
    sPage = "data/html/html_tags.html"

    # Construct the URL
    sURL = sProtocol  + sRootURL + "/" + sPage

    # Array of trial data with the Expected Text, the Class Name, and the Save file prefix
    # Adjust index for Watir-Webdriver's 0-based indexing vs. Watir's 1-based indexing
    #if(is_webdriver? == true)
    #  aSearchCriteria = [
    #  ["Text in First Div", 4, false, "isTextIn_DivID_Trial_1"],
    #  ["Second Div", 5, false, "isTextIn_DivID_Trial_2"],
    #  ["in Second", 6, false, "isTextIn_DivID_Trial_3"],
    #  ["in Fifth", 8, false, "isTextIn_DivID_Trial_4"],
    #  ["no such text", 4, true, "isTextIn_DivID_Trial_5"]
    #  ]
    #else
    aSearchCriteria = [
      ["Text in First Div", 5, false, "isTextIn_DivID_Trial_1"],
      ["Second Div", 6, false, "isTextIn_DivID_Trial_2"],
      ["in Second", 7, false, "isTextIn_DivID_Trial_3"],
      ["in Fifth", 9, false, "isTextIn_DivID_Trial_4"],
      ["no such text", 5, true, "isTextIn_DivID_Trial_5"]
    ]
    #end

    begin # Test the method

      # Start a browser,
      #browser = Watir::Browser.new
      browser = start_browser($sDefaultBrowser)

      # Load the page
      browser.goto(sURL)

      sleep(iDelay)

      sCurrentURL = browser.url
      puts2("Current URL: " + sCurrentURL)

      # Loop
      aSearchCriteria.each do | aTrial |

        # String to search for
        sExpectedText = aTrial[0].to_s

        # Div Index name to search
        iDivIndex=aTrial[1].to_i

        # Save HTML & Screen capture if no match
        bSaveIssues = aTrial[2]

        # Name to be pre-pended to the file name of any screen capture or HTML saves
        sCaptureFileNamePrefix = aTrial[3].to_s

        puts2("\nSerching Div Index:  \"#{iDivIndex.to_s}\"  for the text \"#{sExpectedText}\"")

        if((browser.isTextIn_DivIndex?(sExpectedText, iDivIndex, bSaveIssues, sCaptureFileNamePrefix)) == true)
          puts2(" Found text: " + sExpectedText)
        else
          puts2("*** WARNING - Text not found: " + sExpectedText, "WARN")
        end

      end # Loop

    rescue => e

      puts2("*** ERROR and Backtrace: " + e.message + "\n" + e.backtrace.join("\n"),"ERROR")

      # Close the browser
      browser.close

      # Raise the error with a custom message after the rest of the rescue actions
      raise("*** TESTCASE - test_HTMLText_003_isTextIn_DivIndex")

    ensure

      # Close the browser
      browser.close

    end # Test the method

  end # END TestCase - test_HTMLText_003_isTextIn_DivIndex

  #===========================================================================#
  # Testcase method: test_HTMLText_004_isTextIn_SpanClass
  #
  # Description: Test the method: isTextIn_SpanClass?(...)
  #
  #===========================================================================#
  def test_HTMLText_004_isTextIn_SpanClass

    puts2("")
    puts2("#######################")
    puts2("Testcase: test_HTMLText_004_isTextIn_SpanClass")
    puts2("#######################")

    #$VERBOSE = true
    #$DEBUG = true
    iDelay = 2

    # Define components of  the URL
    sProtocol = "file:///"
    sRootURL = Dir.pwd
    sPage = "data/html/html_tags.html"

    # Construct the URL
    sURL = sProtocol  + sRootURL + "/" + sPage

    # Array of trial data with the Expected Text, the Class Name, and the Save file prefix
    aSearchCriteria = [
      ["Text in First Span", "first", false, "isTextIn_SpanClass_Trial_1"],
      ["Second Span", "second", false, "isTextIn_SpanClass_Trial_2"],
      ["in Second", "third", false, "isTextIn_SpanClass_Trial_3"],
      ["in Fifth", "fifth", false, "isTextIn_SpanClass_Trial_4"],
      ["no such text", "first", true, "isTextIn_SpanClass_Trial_5"]
    ]

    begin # Test the method

      # Start a browser,
      #browser = Watir::Browser.new
      browser = start_browser($sDefaultBrowser)

      # Load the page
      browser.goto(sURL)

      sleep(iDelay)

      sCurrentURL = browser.url
      puts2("Current URL: " + sCurrentURL)

      # Loop
      aSearchCriteria.each do | aTrial |

        # String to search for
        sExpectedText = aTrial[0].to_s

        # Class name to search
        sClass=aTrial[1].to_s

        # Save HTML & Screen capture if no match
        bSaveIssues = aTrial[2]

        # Name to be pre-pended to the file name of any screen capture or HTML saves
        sCaptureFileNamePrefix = aTrial[3].to_s

        puts2("\nSerching Span class:  \"#{sClass}\"  for the text \"#{sExpectedText}\"")

        if((browser.isTextIn_SpanClass?(sExpectedText, sClass, bSaveIssues, sCaptureFileNamePrefix)) == true)
          puts2(" Found text: " + sExpectedText)
        else
          puts2("*** WARNING - Text not found: " + sExpectedText, "WARN")
        end

      end # Loop

    rescue => e

      puts2("*** ERROR and Backtrace: " + e.message + "\n" + e.backtrace.join("\n"),"ERROR")

      # Close the browser
      browser.close

      # Raise the error with a custom message after the rest of the rescue actions
      raise("*** TESTCASE - test_HTMLText_004_isTextIn_SpanClass")

    ensure

      # Close the browser
      browser.close

    end # Test the method

  end # END TestCase - test_HTMLText_004_isTextIn_SpanClass

  #===========================================================================#
  # Testcase method: test_HTMLText_005_isTextIn_SpanID
  #
  # Description: Test the method: isTextIn_SpanID?(...)
  #
  #===========================================================================#
  def test_HTMLText_005_isTextIn_SpanID

    puts2("")
    puts2("#######################")
    puts2("Testcase: test_HTMLText_005_isTextIn_SpanID")
    puts2("#######################")

    #$VERBOSE = true
    #$DEBUG = true
    iDelay = 2

    # Define components of  the URL
    sProtocol = "file:///"
    sRootURL = Dir.pwd
    sPage = "data/html/html_tags.html"

    # Construct the URL
    sURL = sProtocol  + sRootURL + "/" + sPage

    # Array of trial data with the Expected Text, the Class Name, and the Save file prefix
    aSearchCriteria = [
      ["Text in First Span", "span_1", false, "isTextIn_SpanID_Trial_1"],
      ["Second Span", "span_2", false, "isTextIn_SpanID_Trial_2"],
      ["in Second", "span_3", false, "isTextIn_SpanID_Trial_3"],
      ["in Fifth", "span_5", false, "isTextIn_SpanID_Trial_4"],
      ["no such text", "span_1", true, "isTextIn_SpanID_Trial_5"]
    ]

    begin # Test the method

      # Start a browser,
      #browser = Watir::Browser.new
      browser = start_browser($sDefaultBrowser)

      # Load the page
      browser.goto(sURL)

      sleep(iDelay)

      sCurrentURL = browser.url
      puts2("Current URL: " + sCurrentURL)

      # Loop
      aSearchCriteria.each do | aTrial |

        # String to search for
        sExpectedText = aTrial[0].to_s

        # Div ID name to search
        sSpanID=aTrial[1].to_s

        # Save HTML & Screen capture if no match
        bSaveIssues = aTrial[2]

        # Name to be pre-pended to the file name of any screen capture or HTML saves
        sCaptureFileNamePrefix = aTrial[3].to_s

        puts2("\nSerching Span ID:  \"#{sSpanID}\"  for the text \"#{sExpectedText}\"")

        if((browser.isTextIn_SpanID?(sExpectedText, sSpanID, bSaveIssues, sCaptureFileNamePrefix)) == true)
          puts2(" Found text: " + sExpectedText)
        else
          puts2("*** WARNING - Text not found: " + sExpectedText, "WARN")
        end

      end # Loop

    rescue => e

      puts2("*** ERROR and Backtrace: " + e.message + "\n" + e.backtrace.join("\n"),"ERROR")

      # Close the browser
      browser.close

      # Raise the error with a custom message after the rest of the rescue actions
      raise("*** TESTCASE - test_HTMLText_005_isTextIn_SpanID")

    ensure

      # Close the browser
      browser.close

    end # Test the method

  end # END TestCase - test_HTMLText_005_isTextIn_SpanID

  #===========================================================================#
  # Testcase method: test_HTMLText_006_isTextIn_SpanIndex
  #
  # Description: Test the method: isTextIn_SpanIndex?(...)
  #
  #===========================================================================#
  def test_HTMLText_006_isTextIn_SpanIndex

    puts2("")
    puts2("#######################")
    puts2("Testcase: test_HTMLText_006_isTextIn_SpanIndex")
    puts2("#######################")

    #$VERBOSE = true
    #$DEBUG = true
    iDelay = 2

    # Define components of  the URL
    sProtocol = "file:///"
    sRootURL = Dir.pwd
    sPage = "data/html/html_tags.html"

    # Construct the URL
    sURL = sProtocol  + sRootURL + "/" + sPage

    # Array of trial data with the Expected Text, the Class Name, and the Save file prefix
    # Adjust index for Watir-Webdriver's 0-based indexing vs. Watir's 1-based indexing
    #if(is_webdriver? == true)
    #  aSearchCriteria = [
    #  ["Text in First Span", 0, false, "isTextIn_SpanID_Trial_1"],
    #  ["Second Span", 1, false, "isTextIn_SpanID_Trial_2"],
    #  ["in Second", 3, false, "isTextIn_SpanID_Trial_3"],
    #  ["in Fifth", 4, false, "isTextIn_SpanID_Trial_4"],
    #  ["no such text", 0, true, "isTextIn_SpanID_Trial_5"]
    #  ]
    #else
    aSearchCriteria = [
      ["Text in First Span", 1, false, "isTextIn_SpanID_Trial_1"],
      ["Second Span", 2, false, "isTextIn_SpanID_Trial_2"],
      ["in Second", 3, false, "isTextIn_SpanID_Trial_3"],
      ["in Fifth", 5, false, "isTextIn_SpanID_Trial_4"],
      ["no such text", 1, true, "isTextIn_SpanID_Trial_5"]
    ]
    #end

    begin # Test the method

      # Start a browser,
      #browser = Watir::Browser.new
      browser = start_browser($sDefaultBrowser)

      # Load the page
      browser.goto(sURL)

      sleep(iDelay)

      sCurrentURL = browser.url
      puts2("Current URL: " + sCurrentURL)

      # Loop
      aSearchCriteria.each do | aTrial |

        # String to search for
        sExpectedText = aTrial[0].to_s

        # Div Index name to search
        iSpanIndex=aTrial[1].to_i

        # Save HTML & Screen capture if no match
        bSaveIssues = aTrial[2]

        # Name to be pre-pended to the file name of any screen capture or HTML saves
        sCaptureFileNamePrefix = aTrial[3].to_s

        puts2("\nSerching Span Index:  \"#{iSpanIndex.to_s}\"  for the text \"#{sExpectedText}\"")

        if((browser.isTextIn_SpanIndex?(sExpectedText, iSpanIndex, bSaveIssues, sCaptureFileNamePrefix)) == true)
          puts2(" Found text: " + sExpectedText)
        else
          puts2("*** WARNING - Text not found: " + sExpectedText, "WARN")
        end

      end # Loop

    rescue => e

      puts2("*** ERROR and Backtrace: " + e.message + "\n" + e.backtrace.join("\n"),"ERROR")

      # Close the browser
      browser.close

      # Raise the error with a custom message after the rest of the rescue actions
      raise("*** TESTCASE - test_HTMLText_006_isTextIn_SpanIndex")

    ensure

      # Close the browser
      browser.close

    end # Test the method

  end # END TestCase - test_HTMLText_006_isTextIn_SpanIndex

  #===========================================================================#
  # Testcase method: test_HTMLText_007_isTextIn_TableClass
  #
  # Description: Test the method: isTextIn_TableClass?(...)
  #
  #===========================================================================#
  def test_HTMLText_007_isTextIn_TableClass

    puts2("")
    puts2("#######################")
    puts2("Testcase: test_HTMLText_007_isTextIn_TableClass")
    puts2("#######################")

    #$VERBOSE = true
    #$DEBUG = true
    iDelay = 2

    # Define components of  the URL
    sProtocol = "file:///"
    sRootURL = Dir.pwd
    sPage = "data/html/html_tags.html"

    # Construct the URL
    sURL = sProtocol  + sRootURL + "/" + sPage

    # Array of trial data with the Expected Text, the Class Name, and the Save file prefix
    aSearchCriteria = [
      ["Bonzo", "music", false, "isTextIn_TableClass_Trial_1"],
      ["Parent Row 1 Cell 1", "second", false, "isTextIn_TableClass_Trial_2"],
      ["Nested row_2", "third", false, "isTextIn_TableClass_Trial_3"],
      ["no such text", "second", true, "isTextIn_TableClass_Trial_4"]
    ]

    begin # Test the method

      # Start a browser,
      #browser = Watir::Browser.new
      browser = start_browser($sDefaultBrowser)

      # Load the page
      browser.goto(sURL)

      sleep(iDelay)

      sCurrentURL = browser.url
      puts2("Current URL: " + sCurrentURL)

      # Loop
      aSearchCriteria.each do | aTrial |

        # String to search for
        sExpectedText = aTrial[0].to_s

        # Class name to search
        sClass=aTrial[1].to_s

        # Save HTML & Screen capture if no match
        bSaveIssues = aTrial[2]

        # Name to be pre-pended to the file name of any screen capture or HTML saves
        sCaptureFileNamePrefix = aTrial[3].to_s

        puts2("\nSerching Table class:  \"#{sClass}\"  for the text \"#{sExpectedText}\"")

        if((browser.isTextIn_TableClass?(sExpectedText, sClass, bSaveIssues, sCaptureFileNamePrefix)) == true)
          puts2(" Found text: " + sExpectedText)
        else
          puts2("*** WARNING - Text not found: " + sExpectedText, "WARN")
        end

      end # Loop

    rescue => e

      puts2("*** ERROR and Backtrace: " + e.message + "\n" + e.backtrace.join("\n"),"ERROR")

      # Close the browser
      browser.close

      # Raise the error with a custom message after the rest of the rescue actions
      raise("*** TESTCASE - test_HTMLText_007_isTextIn_TableClass")

    ensure

      # Close the browser
      browser.close

    end # Test the method

  end # END TestCase - test_HTMLText_007_isTextIn_TableClass

  #===========================================================================#
  # Testcase method: test_HTMLText_008_isTextIn_TableID
  #
  # Description: Test the method: isTextIn_TableID?(...)
  #
  #===========================================================================#
  def test_HTMLText_008_isTextIn_TableID

    puts2("")
    puts2("#######################")
    puts2("Testcase: test_HTMLText_008_isTextIn_TableID")
    puts2("#######################")

    #$VERBOSE = true
    #$DEBUG = true
    iDelay = 2

    # Define components of  the URL
    sProtocol = "file:///"
    sRootURL = Dir.pwd
    sPage = "data/html/html_tags.html"

    # Construct the URL
    sURL = sProtocol  + sRootURL + "/" + sPage

    # Array of trial data with the Expected Text, the Class Name, and the Save file prefix
    aSearchCriteria = [
      ["Bonzo", "zeppelin", false, "isTextIn_TableID_Trial_1"],
      ["Parent Row 1 Cell 1", "parent", false, "isTextIn_TableID_Trial_2"],
      ["Nested row_2", "child", false, "isTextIn_TableID_Trial_3"],
      ["no such text", "zeppelin", true, "isTextIn_TableID_Trial_5"]
    ]

    begin # Test the method

      # Start a browser,
      #browser = Watir::Browser.new
      browser = start_browser($sDefaultBrowser)

      # Load the page
      browser.goto(sURL)

      sleep(iDelay)

      sCurrentURL = browser.url
      puts2("Current URL: " + sCurrentURL)

      # Loop
      aSearchCriteria.each do | aTrial |

        # String to search for
        sExpectedText = aTrial[0].to_s

        # Div ID name to search
        sTableID=aTrial[1].to_s

        # Save HTML & Screen capture if no match
        bSaveIssues = aTrial[2]

        # Name to be pre-pended to the file name of any screen capture or HTML saves
        sCaptureFileNamePrefix = aTrial[3].to_s

        puts2("\nSerching Table ID:  \"#{sTableID}\"  for the text \"#{sExpectedText}\"")

        if((browser.isTextIn_TableID?(sExpectedText, sTableID, bSaveIssues, sCaptureFileNamePrefix)) == true)
          puts2(" Found text: " + sExpectedText)
        else
          puts2("*** WARNING - Text not found: " + sExpectedText, "WARN")
        end

      end # Loop

    rescue => e

      puts2("*** ERROR and Backtrace: " + e.message + "\n" + e.backtrace.join("\n"),"ERROR")

      # Close the browser
      browser.close

      # Raise the error with a custom message after the rest of the rescue actions
      raise("*** TESTCASE - test_HTMLText_008_isTextIn_TableID")

    ensure

      # Close the browser
      browser.close

    end # Test the method

  end # END TestCase - test_HTMLText_008_isTextIn_TableID

  #===========================================================================#
  # Testcase method: test_HTMLText_009_isTextIn_TableIndex
  #
  # Description: Test the method: isTextIn_TableIndex?(...)
  #
  #===========================================================================#
  def test_HTMLText_009_isTextIn_TableIndex

    puts2("")
    puts2("#######################")
    puts2("Testcase: test_HTMLText_009_isTextIn_TableIndex")
    puts2("#######################")

    #$VERBOSE = true
    #$DEBUG = true
    iDelay = 2

    # Define components of  the URL
    sProtocol = "file:///"
    sRootURL = Dir.pwd
    sPage = "data/html/html_tags.html"

    # Construct the URL
    sURL = sProtocol  + sRootURL + "/" + sPage

    # Array of trial data with the Expected Text, the Class Name, and the Save file prefix
    # Adjust index for Watir-Webdriver's 1-based indexing vs. Watir's 0-based indexing
    #if(is_webdriver? == true)
    #  aSearchCriteria = [
    #  ["Bonzo", 5, false, "isTextIn_TableIndex_Trial_1"],
    #  ["Parent Row 1 Cell 1", 6, false, "isTextIn_TableIndex_Trial_2"],
    #  ["Nested row_2", 7, false, "isTextIn_TableIndex_Trial_3"],
    #  ["no such text", 5, true, "isTextIn_TableIndex_Trial_5"]
    #  ]
    #else
    aSearchCriteria = [
      ["Bonzo", 6, false, "isTextIn_TableIndex_Trial_1"],
      ["Parent Row 1 Cell 1", 7, false, "isTextIn_TableIndex_Trial_2"],
      ["Nested row_2", 8, false, "isTextIn_TableIndex_Trial_3"],
      ["no such text", 6, true, "isTextIn_TableIndex_Trial_5"]
    ]
    #end

    begin # Test the method

      # Start a browser,
      #browser = Watir::Browser.new
      browser = start_browser($sDefaultBrowser)

      # Load the page
      browser.goto(sURL)

      sleep(iDelay)

      sCurrentURL = browser.url
      puts2("Current URL: " + sCurrentURL)

      # Loop
      aSearchCriteria.each do | aTrial |

        # String to search for
        sExpectedText = aTrial[0].to_s

        # Div Index name to search
        iTableIndex=aTrial[1].to_i

        # Save HTML & Screen capture if no match
        bSaveIssues = aTrial[2]

        # Name to be pre-pended to the file name of any screen capture or HTML saves
        sCaptureFileNamePrefix = aTrial[3].to_s

        puts2("\nSerching Table Index:  \"#{iTableIndex.to_s}\"  for the text \"#{sExpectedText}\"")

        if((browser.isTextIn_TableIndex?(sExpectedText, iTableIndex, bSaveIssues, sCaptureFileNamePrefix)) == true)
          puts2(" Found text: " + sExpectedText)
        else
          puts2("*** WARNING - Text not found: " + sExpectedText, "WARN")
        end

      end # Loop

    rescue => e

      puts2("*** ERROR and Backtrace: " + e.message + "\n" + e.backtrace.join("\n"),"ERROR")

      # Close the browser
      browser.close

      # Raise the error with a custom message after the rest of the rescue actions
      raise("*** TESTCASE - test_HTMLText_009_isTextIn_TableIndex")

    ensure

      # Close the browser
      browser.close

    end # Test the method

  end # END TestCase - test_HTMLText_009_isTextIn_TableIndex

  #===========================================================================#
  # Testcase method: test_HTMLText_010_isTextIn_TableName
  #
  # Description: Test the method: isTextIn_TableName?(...)
  #
  #===========================================================================#
  def test_HTMLText_010_isTextIn_TableName

    puts2("")
    puts2("#######################")
    puts2("Testcase: test_HTMLText_010_isTextIn_TableName")
    puts2("#######################")

    #$VERBOSE = true
    #$DEBUG = true
    iDelay = 2

    # Define components of  the URL
    sProtocol = "file:///"
    sRootURL = Dir.pwd
    sPage = "data/html/html_tags.html"

    # Construct the URL
    sURL = sProtocol  + sRootURL + "/" + sPage

    # Array of trial data with the Expected Text, the Name Name, and the Save file prefix
    aSearchCriteria = [
      ["Bonzo", "zep", false, "isTextIn_TableName_Trial_1"],
      ["Parent Row 1 Cell 1", "nested_blue", false, "isTextIn_TableName_Trial_2"],
      ["Nested row_2", "nested_red", false, "isTextIn_TableName_Trial_3"],
      ["no such text", "zep", true, "isTextIn_TableName_Trial_4"]
    ]

    begin # Test the method

      # Start a browser,
      #browser = Watir::Browser.new
      browser = start_browser($sDefaultBrowser)

      # Load the page
      browser.goto(sURL)

      sleep(iDelay)

      sCurrentURL = browser.url
      puts2("Current URL: " + sCurrentURL)

      # Loop
      aSearchCriteria.each do | aTrial |

        # String to search for
        sExpectedText = aTrial[0].to_s

        # Name name to search
        sName=aTrial[1].to_s

        # Save HTML & Screen capture if no match
        bSaveIssues = aTrial[2]

        # Name to be pre-pended to the file name of any screen capture or HTML saves
        sCaptureFileNamePrefix = aTrial[3].to_s

        puts2("\nSerching Table name:  \"#{sName}\"  for the text \"#{sExpectedText}\"")

        if((browser.isTextIn_TableName?(sExpectedText, sName, bSaveIssues, sCaptureFileNamePrefix)) == true)
          puts2(" Found text: " + sExpectedText)
        else
          puts2("*** WARNING - Text not found: " + sExpectedText, "WARN")
        end

      end # Loop

    rescue => e

      puts2("*** ERROR and Backtrace: " + e.message + "\n" + e.backtrace.join("\n"),"ERROR")

      # Close the browser
      browser.close

      # Raise the error with a custom message after the rest of the rescue actions
      raise("*** TESTCASE - test_HTMLText_010_isTextIn_TableName")

    ensure

      # Close the browser
      browser.close

    end # Test the method

  end # END TestCase - test_HTMLText_010_isTextIn_TableName

  #===========================================================================#
  # Testcase method: test_HTMLText_011_parse_table_by_row
  #
  # Description: Test the method: parse_table_by_row(...)
  #
  #===========================================================================#
  def test_HTMLText_011_parse_table_by_row

    puts2("")
    puts2("#######################")
    puts2("Testcase: test_HTMLText_011_parse_table_by_row")
    puts2("#######################")

    #$VERBOSE = true
    #$DEBUG = true
    iDelay = 2

    # Define components of  the URL
    sProtocol = "file:///"
    sRootURL = Dir.pwd
    sPage = "data/html/html_tags.html"

    # Construct the URL
    sURL = sProtocol  + sRootURL + "/" + sPage

    #if(is_webdriver? == true)
    aTablesIndexesToRead=[5,6,7]
    #else
    #  aTablesIndexesToRead=[6,7,8]
    #end

    begin # Test the method

      # Start a browser,
      #browser = Watir::Browser.new
      browser = start_browser($sDefaultBrowser)

      # Load the page
      browser.goto(sURL)

      sleep(iDelay)

      sCurrentURL = browser.url
      puts2("Current URL: " + sCurrentURL)

      # Loop
      aTablesIndexesToRead.each do | iTableIndexToRead|

        puts2("\nReading Table Index: " + iTableIndexToRead.adjust_index.to_s)

        #if(is_webdriver? == true)
        #  iFirstRow=0
        #  iLastRow=-2
        #else
        iFirstRow=1
        iLastRow=-1
        #end

        bSaveIssues=false

        aTableRowContents = browser.parse_table_by_row(iTableIndexToRead, iFirstRow, iLastRow, bSaveIssues)

        # Display contents
        aTableRowContents.each do | sRowContents |

          puts2(" Row's contents: " + sRowContents.to_s)

        end # Display contents

      end # Loop

    rescue => e

      puts2("*** ERROR and Backtrace: " + e.message + "\n" + e.backtrace.join("\n"),"ERROR")

      # Close the browser
      browser.close

      # Raise the error with a custom message after the rest of the rescue actions
      raise("*** TESTCASE - test_HTMLText_011_parse_table_by_row")

    ensure

      # Close the browser
      browser.close

    end # Test the method

  end # END TestCase - test_HTMLText_011_parse_table_by_row

  #===========================================================================#
  # Testcase method: test_HTMLText_012_IE_find_string_in_div
  #
  # Description: Test methods: find_string_in_div(...)
  #===========================================================================#
  def test_HTMLText_012_IE_find_string_in_div

    puts2("")
    puts2("#######################")
    puts2("Testcase: test_HTMLText_012_IE_find_string_in_div")
    puts2("#######################")

    #$VERBOSE = true
    #$DEBUG = true
    iDelay = 2

    # Define components of  the URL
    sProtocol = "file:///"
    sRootURL = Dir.pwd
    sPage = "data/html/html_tags.html"

    # Construct the URL
    sURL = sProtocol  + sRootURL + "/" + sPage

    aStringsToSerchFor = [
      "in First",
      "in Fourth",
      "in Fifth Div"
    ]

    begin # Start local browsers

      # Start a browser,
      #browser = Watir::Browser.new
      browser = start_browser($sDefaultBrowser)

      # Load the page
      browser.goto(sURL)

      sleep(iDelay)

      sCurrentURL = browser.url
      puts2("Current URL: " + sCurrentURL)

      aStringsToSerchFor.each do | sSearchForString |

        puts2("\nOn the current Web page find the string: " + sSearchForString.strip)
        aSearchResults = browser.find_string_in_div(sSearchForString, false)

        if(aSearchResults[0] > 0)
          puts2("String \"#{sSearchForString}\" found at:")
          puts2(" Div index = " + aSearchResults[0].to_s)
          puts2(" Div text = " +  aSearchResults[1].to_s)
        else
          puts2("*** Warning - Unable to find string \"#{sSearchForString}\"")
        end

      end

    rescue => e

      puts2("Error and Backtrace: " + e.message + "\n" + e.backtrace.join("\n"), "ERROR")

      # Close the browser
      browser.close

      # Raise the error with a custom message after the rest of the rescue actions
      raise("*** TESTCASE - test_HTMLText_012_IE_find_string_in_div")

    ensure

      # Close the browser
      browser.close

    end # Start local browsers

  end # End of test method - test_HTMLText_012_IE_find_string_in_div

  #===========================================================================#
  # Testcase method: test_HTMLText_012_IE_find_string_in_span
  #
  # Description: Test methods: find_string_in_span(...)
  #===========================================================================#
  def test_HTMLText_012_IE_find_string_in_span

    puts2("")
    puts2("#######################")
    puts2("Testcase: test_HTMLText_012_IE_find_string_in_span")
    puts2("#######################")

    #$VERBOSE = true
    #$DEBUG = true
    iDelay = 2

    # Define components of  the URL
    sProtocol = "file:///"
    sRootURL = Dir.pwd
    sPage = "data/html/html_tags.html"

    # Construct the URL
    sURL = sProtocol  + sRootURL + "/" + sPage

    aStringsToSerchFor = [
      "in First",
      "in Fourth",
      "in Fifth Span"
    ]

    begin # Start local browsers

      # Start a browser,
      #browser = Watir::Browser.new
      browser = start_browser($sDefaultBrowser)

      # Load the page
      browser.goto(sURL)

      sleep(iDelay)

      sCurrentURL = browser.url
      puts2("Current URL: " + sCurrentURL)

      aStringsToSerchFor.each do | sSearchForString |

        puts2("\nOn the current Web page find the string: " + sSearchForString.strip)
        aSearchResults = browser.find_string_in_span(sSearchForString, false)

        if(aSearchResults[0] > 0)
          puts2("String \"#{sSearchForString}\" found at:")
          puts2(" Span index = " + aSearchResults[0].to_s)
          puts2(" Span text = " +  aSearchResults[1].to_s)
        else
          puts2("*** Warning - Unable to find string \"#{sSearchForString}\"")
        end

      end

    rescue => e

      puts2("Error and Backtrace: " + e.message + "\n" + e.backtrace.join("\n"), "ERROR")

      # Close the browser
      browser.close

      # Raise the error with a custom message after the rest of the rescue actions
      raise("*** TESTCASE - test_HTMLText_012_IE_find_string_in_span")

    ensure

      # Close the browser
      browser.close

    end # Start local browsers

  end # End of test method - test_HTMLText_012_IE_find_string_in_span

  #===========================================================================#
  # Testcase method: test_HTMLText_014_IE_find_string_in_table
  #
  # Description: Test methods: find_string_in_table(...)
  #===========================================================================#
  def test_HTMLText_014_IE_find_string_in_table

    puts2("")
    puts2("#######################")
    puts2("Testcase: test_HTMLText_014_IE_find_string_in_table")
    puts2("#######################")

    #$VERBOSE = true
    #$DEBUG = true
    iDelay = 2

    # Define components of  the URL
    sProtocol = "file:///"
    sRootURL = Dir.pwd
    sPage = "data/html/html_tags.html"

    # Construct the URL
    sURL = sProtocol  + sRootURL + "/" + sPage

    aStringsToSerchFor = [
      "WatirWorks - Text Tags",
      "WatirWorks - Interactive Tags",
      "WatirWorks - Layout Tags",
      "is equal to the",
      "Checkboxes",
      "Keith Richards",
      "We the People of the United States",
      "Nested row_2 cell_1",
      "Parent Row_4 Cell_3 "
    ]

    begin # Start local browsers

      # Start a browser,
      #browser = Watir::Browser.new
      browser = start_browser($sDefaultBrowser)

      # Load the page
      browser.goto(sURL)

      sleep(iDelay)

      sCurrentURL = browser.url
      puts2("Current URL: " + sCurrentURL)

      aStringsToSerchFor.each do | sSearchForString |

        puts2("\nOn the current Web page find the string: " + sSearchForString.strip)
        aSearchResults = browser.find_string_in_table(sSearchForString, false)

        if(aSearchResults[0] > 0)
          puts2("String \"#{sSearchForString}\" found at:")
          puts2(" Table index = " + aSearchResults[0].to_s)
          puts2(" Row index = " +  aSearchResults[1].to_s)
          #puts2("Text in row = " +  aSearchResults[2].to_s)
        else
          puts2("*** Warning - Unable to find string \"#{sSearchForString}\"")
        end

      end

    rescue => e

      puts2("Error and Backtrace: " + e.message + "\n" + e.backtrace.join("\n"), "ERROR")

      # Close the browser
      browser.close

      # Raise the error with a custom message after the rest of the rescue actions
      raise("*** TESTCASE - test_HTMLText_014_IE_find_string_in_table")

    ensure

      # Close the browser
      browser.close

    end # Start local browsers

  end # End of test method - test_HTMLText_014_IE_find_string_in_table

  #===========================================================================#
  # Testcase method: test_HTMLText_015_IE_find_strings_in_table
  #
  # Description: Test methods: find_strings_in_table(...)
  #===========================================================================#
  def test_HTMLText_015_IE_find_strings_in_table

    puts2("")
    puts2("#######################")
    puts2("Testcase: test_HTMLText_015_IE_find_strings_in_table")
    puts2("#######################")

    #$VERBOSE = true
    #$DEBUG = true
    iDelay = 2

    # Define components of  the URL
    sProtocol = "file:///"
    sRootURL = Dir.pwd
    sPage = "data/html/html_tags.html"

    # Construct the URL
    sURL = sProtocol  + sRootURL + "/" + sPage

    #========================================================#
    begin # Trial 1 -  Text in a table's row contains search string multiple times

      aStringsToSearchFor = [
        "Nested"
      ]

      # Start a browser,
      #browser = Watir::Browser.new
      browser = start_browser($sDefaultBrowser)

      # Load the page
      browser.goto(sURL)

      sleep(iDelay)

      sCurrentURL = browser.url
      puts2("Current URL: " + sCurrentURL)

      puts2("\nOn the current Web page find the strings: ")
      aStringsToSearchFor.each do | sSearchForString|
        puts2(sSearchForString.strip)
      end

      aSearchResults = browser.find_strings_in_table(aStringsToSearchFor, 3, false, false)

      if(aSearchResults[0].to_i > 0)

        aMatchingStrings =  aSearchResults[3]

        puts2("Match found at:")
        #puts2("String \"#{sSearchForString}\" found at:")
        puts2(" Table index = " + aSearchResults[0].to_s)
        puts2(" Row index = " +  aSearchResults[1].to_s)
        puts2(" Number Of Matches Found = " +  aSearchResults[2].to_s)
        aMatchingStrings.each do | sString |
          puts2(" String = " +  sString)
        end

      else
        puts2("*** Warning - Unable to find strings")
      end

    rescue => e

      puts2("Error and Backtrace: " + e.message + "\n" + e.backtrace.join("\n"), "ERROR")

      # Close the browser
      browser.close

      # Raise the error with a custom message after the rest of the rescue actions
      raise("*** TESTCASE - test_HTMLText_015_IE_find_strings_in_table")

    ensure

      # Close the browser
      browser.close

    end # Trial 1
    #========================================================#

    #========================================================#
    begin # Trial 2 - Exact match for all text in a table's row

      aStringsToSearchFor = [
        "John", "Paul", "Jones"
      ]

      # Start a browser,
      #browser = Watir::Browser.new
      browser = start_browser($sDefaultBrowser)

      # Load the page
      browser.goto(sURL)

      sleep(iDelay)

      sCurrentURL = browser.url
      puts2("Current URL: " + sCurrentURL)

      puts2("\nOn the current Web page find the strings: ")
      aStringsToSearchFor.each do | sSearchForString|
        puts2(sSearchForString.strip)
      end

      aSearchResults = browser.find_strings_in_table(aStringsToSearchFor, 0, false, true)

      if(aSearchResults[0].to_i > 0)

        aMatchingStrings =  aSearchResults[3]

        puts2("Match found at:")
        #puts2("String \"#{sSearchForString}\" found at:")
        puts2(" Table index = " + aSearchResults[0].to_s)
        puts2(" Row index = " +  aSearchResults[1].to_s)
        puts2(" Number Of Matches Found = " +  aSearchResults[2].to_s)
        aMatchingStrings.each do | sString |
          puts2(" String = " +  sString)
        end

      else
        puts2("*** Warning - Unable to find strings")
      end

    rescue => e

      puts2("Error and Backtrace: " + e.message + "\n" + e.backtrace.join("\n"), "ERROR")

      # Close the browser
      browser.close

      # Raise the error with a custom message after the rest of the rescue actions
      raise("*** TESTCASE - test_HTMLText_015_IE_find_strings_in_table")

    ensure

      # Close the browser
      browser.close

    end # Trial 2
    #========================================================#

  end # End of test method - test_HTMLText_015_IE_find_strings_in_table

end # END Class - UnitTest_HTMLText
