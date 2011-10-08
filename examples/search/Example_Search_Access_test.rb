
#--
#=============================================================================#
# File: Example_Search_Access_test.rb
#
#
#  Copyright (c) 2008-2010, Joe DiMauro
#  All rights reserved.
#
# Description: WatirWorks example test file demonstrating:
#
#               Use of logger to save test results
#               Saving of the HTML file and a screen capture file to the results
#               A very basic Access, Entity Validation, and Workflow test.
#
#               A data driven test using an Excel Workbook
#               Changing settings in the Workbook controls the test flow
#               as well as the search engine to be used for the search.
#
#              The Entity Validation test cases validate the creation/execution
#              of a basic high level regression test on the Google home page, and some
#              of its adjoining pages. It accesses each page and validates that each page
#              contains the same count of HTML tags as was previously collected.
#              If the HTML tag count changed, a new set of counts is collected which
#              can be used to manually update the test prior to the next test run.
#
#              As the Web servers construct page differently by browser type (e.g. IE FF)
#              a different set of counts are used based upon the type of browser executing the test.
#
#              Some HTML tag counts will vary due to either content changes, or
#              due to differences in the servers, those counts without a fixed number
#              of tags are validated to within a specified range. That range was determined
#              by repetitive iterations of the test over a period of several days.
#
#
# NOTES:
#   Some web pages on the Google site have widely varying content over time.
#   Thus some HTML tag counts for those pages also vary from day to day, minute to minute.
#   For example the number of links, images and button on the News page.
#
#   The Google web site consists of several servers, the exactly identical
#   Web page code is surprisingly NOT served from each server.  This can be
#    observer the tag counts collected by running multiple iterations of the test back-to-back.
#   The HTML tag counts will thus vary based upon which server was accessed during any particular test run.
#   For example the <div> counts on the Web (Home) page.
#
#  This test exposes both of those conditions on Google's web site, and takes that into account.
#
#  It accounts for these variances by either:
#       a) Ignore the verification of those affected HTML tag counts by commenting them out
#           This could be done for some of the HTML tag counts, but is not the preferred way
#       b) Change the assert_equals() to an assert()  statement
#           and add a range for the count (iMin..iMax).
#           This was done for some of the HTML tag counts.
#      Refer to the code to see examples.
#
#=============================================================================#

#=============================================================================#
# Require and Include section
# Entries for additional files or methods needed by this test
#=============================================================================#
require 'rubygems'

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
sRun_TestType = "access"
iRun_TestLevel = 0

@@iDelay =2

@@bGenerateTestcode = false  # Set to true to generate code during this test run

#=============================================================================#

#=============================================================================#
# Class: Example_Search_TestClass
#
# Test Case Methods: setup, teardown
#
#
#=============================================================================#
class Example_Search_TestClass < Test::Unit::TestCase
  
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
  # Testcase: test_0000_Search_Prep
  #
  # Description: Starts the global logger
  #                    Displays information on the test tool versions
  #                    Displays information on the browser executing the tests
  #                    Reads Test Control data from Workbooks
  #                    Reads data specific for this test from Workbooks
  #
  #===========================================================================#
  def test_0000_Search_Prep
    
    sTestCase_Name = "test_0000_Search_Prep"
    puts2("\nStarting Testcase: #{sTestCase_Name}")
    
    
    begin
      
      # Minimize the Ruby Console window
      minimize_ruby_console()
      
      # Only run this if no other logger has been started
      if($logger.class == NilClass)
        # Create a Global logger object for use by all tests launched from this testsuite
        $logger = capture_results()
      end
      
      # Only run this if no other test has previously displayed the Test environment information
      if($bDisplayTestEnv.class == NilClass)
        
        # Set the global flag so other tests won't display this info
        $bDisplayTestEnv = true
        
        # Display information on the test tools
        display_ruby_env()
        display_watir_env()
        display_watirworks_env()
        
        # Display information on the browser executing the test
        display_browser_env()
        
        if(is_win?)
          puts2("Registered IE version: " + get_registered_ie_version)
          puts2("Registered Firefox version: " + get_registered_firefox_version)
        end
        
      end
      
      # Only run this if no other test has read in the Common data from the workbooks
      if($hWorkbook_Data.class == NilClass)
        
        sWorkbook_Name = "RunControl_Data.xls"
        aSpreadsheet_List = ["Environment", "Urls", "SearchTerms", "RunControl"]
        
        # Read the Test control workbook into a  Hash of -Sheet Arrays of - Column data Hashes of - STRING of data
        $hWorkbook_Data = parse_workbook_xls(sWorkbook_Name, aSpreadsheet_List)
        
        # Split the Workbook Hash of - Sheet Arrays of-  Column data Hashes - into separate Arrays by Sheet
        $aSpreadsheet_ENV = $hWorkbook_Data["Environment"]
        $aSpreadsheet_URL = $hWorkbook_Data["Urls"]
        $aSpreadsheet_TERMS = $hWorkbook_Data["SearchTerms"]
        $aSpreadsheet_CONTROL = $hWorkbook_Data["RunControl"]
        
        # Find the setting of the Environment to run the test within
        #
        # Pull the Hashed Column data from the Sheet Array
        $aSpreadsheet_ENV.each do | hRow_ofData |
          # Parse the Environment setting from the "ENV" column within the first row of data on the spreadsheet
          $sExecution_Env = hRow_ofData["ENV"]
          puts2("Running from the environment - #{$sExecution_Env}")
        end # Find the setting of the Environment to run the test within
        
        # Find the Row of data matching the Execution Environment (The Row data is in a HASH)
        $aSpreadsheet_URL.each do | hRow_ofData |
          # Find the row by looking under the "ENV" Column for a setting matches the execution environment setting
          if(hRow_ofData["ENV"] == $sExecution_Env)
            # Get the Url setting in the matching row from the Column ACCESS_URL
            $sAccessURL = hRow_ofData["ACCESS_URL"]
          end
        end # Find the Row of data matching the Execution Environment
        
      end # Only run this if no other test has read in the Common data from the workbooks
      
    rescue => e
      
      puts2("*** ERROR Backtrace: " + e.message + "\n" + e.backtrace.join("\n"), "ERROR")
      
      raise("*** TESTCASE - #{sTestCase_Name}")
      
    ensure
      
    end
  end # END TestCase - test_0000_Search_Prep
  
  
  #===========================================================================#
  # Testcase: test_Search_001_ACCESS
  #
  # Description:
  #
  #===========================================================================#
  def test_Search_001_ACCESS
    
    sTestCase_Name = "test_Search_001_ACCESS"
    puts2("\nStarting Testcase: #{sTestCase_Name}")
    
    @@bPassed = false # Clear flag since test has NOT passed yet
    
    begin
      
      # Start browser
      browser = Watir::Browser.new
      
      # Display a blank page
      browser.goto("about:blank")
      
      # Access the Web site URL for the environment that was set on the workbook's Environment sheet
      browser.goto($sAccessURL)
      puts2("Current URL: " + browser.url )
      puts2(" Emulating Web Browser version: " + browser.get_doc_app_version)
      
      
      ### BEGIN - IMAGES PAGE ##############################
      
      puts2("\nAccessing page - Images...")
      browser.link(:text, "Images").click
      sleep(@@iDelay)  # Allow time for page to complete loading
      
      # Record URL on the web page
      puts2(" Current URL: " + browser.url)
      
      puts2("Return to the Home page...")
      # Return to the Home page
      browser.goto($sAccessURL)
      sleep(@@iDelay)  # Allow time for page to complete loading
      
      # Record URL on the web page
      puts2(" Current URL: " + browser.url)
      
      ### BEGIN - VIDEOS PAGE ##############################
      
      puts2("\nAccessing page - Videos...")
      browser.link(:text, "Videos").click
      sleep(@@iDelay)  # Allow time for page to complete loading
      
      # Record info on the web page
      puts2(" Current URL: " + browser.url)
      
      puts2("Return to the Home page...")
      # Return to the Home page
      browser.goto($sAccessURL)
      sleep(@@iDelay)  # Allow time for page to complete loading
      
      # Record URL on the web page
      puts2(" Current URL: " + browser.url)
      
      ### BEGIN - MAPS PAGE ##############################
      
      
      puts2("\nAccessing page - Maps...")
      if(browser.link(:text, "Maps").exists?)
        browser.link(:text, "Maps").click
        sleep(@@iDelay)  # Allow time for page to complete loading
        
        # Record info on the web page
        puts2(" Current URL: " + browser.url)
        
        puts2("Return to the Home page...")
        # Return to the Home page
        browser.goto($sAccessURL)
        sleep(@@iDelay)  # Allow time for page to complete loading
        
        # Record URL on the web page
        puts2(" Current URL: " + browser.url)
      else
        puts2("#{$sExecution_Env} does not have a Maps page")
      end
      
      ### BEGIN - NEWS PAGE ##############################
      
      puts2("\nAccessing page -  News...")
      browser.link(:text, "News").click
      sleep(@@iDelay)  # Allow time for page to complete loading
      
      # Record info on the web page
      puts2(" Current URL: " + browser.url)
      
      puts2("Return to the Home page...")
      # Return to the Home page
      browser.goto($sAccessURL)
      sleep(@@iDelay)  # Allow time for page to complete loading
      
      # Record URL on the web page
      puts2(" Current URL: " + browser.url)
      
      
      ### BEGIN - SHOPING PAGE ##############################
      
      puts2("\nAccessing page - Shopping...")
      if(browser.link(:text, "Maps").exists?)
        browser.link(:text, "Shopping").click
        sleep(@@iDelay)  # Allow time for page to complete loading
        
        # Record info on the web page
        puts2(" Current URL: " + browser.url)
        
        puts2("Return to the Home page...")
        # Return to the Home page
        browser.goto($sAccessURL)
        sleep(@@iDelay)  # Allow time for page to complete loading
        
        # Record URL on the web page
        puts2(" Current URL: " + browser.url)
        
      else
        puts2("#{$sExecution_Env} does not have a Shopping page")
      end
      
      #######################################
      
      puts2(" Close the browser...")
      if(browser.is_firefox?)
        # Force any open browsers to exit
        kill_browsers()
      else
        # Close the browser
        browser.close
      end
      
    rescue => e
      
      puts2("*** ERROR Backtrace: " + e.message + "\n" + e.backtrace.join("\n"), "ERROR")
      
      # Re-collect HTML tag counts on the current page
      if(@@bPassed == false)
        puts2("\nCollecting current HTML tag counts...")
        browser.generate_testcode_html_tag_counts()
      end
      
      
      # Force any open browsers to exit
      kill_browsers()
      
      raise("*** TESTCASE - #{sTestCase_Name}")
      
    ensure
      
    end
  end # END TestCase - test_Search_001_ACCESS
  
end # END Class - Example_Search_TestClass
