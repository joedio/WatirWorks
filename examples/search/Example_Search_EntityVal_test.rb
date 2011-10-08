
#--
#=============================================================================#
# File: Example_Search_EntityVal_test.rb
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
  # Testcase: test_Search_002_ENTVAL_1_Google
  #
  # Description:
  #
  #===========================================================================#
  def test_Search_002_ENTVAL_1_Google
    
    sTestCase_Name = "test_Search_002_ENTVAL_1_Google"
    puts2("\nStarting Testcase: #{sTestCase_Name}")
    
    begin
      
      # Start browser
      browser = Watir::Browser.new
      
      # Display a blank page
      browser.goto("about:blank")
      
      
      # Access the Web site URL for the environment that was set on the workbook's Environment sheet
      browser.goto($sAccessURL)
      
      # Google specific validation
      if($sExecution_Env =~ /Google/)
        
        ### BEGIN - HOME PAGE ##############################
        
        puts2("\nAccessing page - Web...")
        
        # Load web page
        browser.goto($sAccessURL)
        sleep(@@iDelay)  # Allow time for page to complete loading
        
        # Record info on the web page
        puts2(" Current URL: " + browser.url)
        puts2(" Emulating Web Browser version: " + browser.get_doc_app_version)
        
        
        # Perform a check of the HTML tags on the page to see if the page has changed
        # The HTML tag counts vary based upon the browser type (IE vs. FF)
        #
        # Determine if this test run should generate new testcode counts
        # that can be manually added and used as a regression for subsequent runs
        # or run with the current code.
        if(@@bGenerateTestcode)
          browser.generate_testcode_html_tag_counts()
        else
          puts2("\nBegin verifying HTML tag counts on page...")
          @@bPassed = false # Clear flag
          
          if(browser.is_ie?)
            # Counts were generated on 05/27/2010 with IE 8.0
            assert_equal(0, browser.areas.length) # Number of areas
            assert_equal(2, browser.buttons.length) # Number of buttons
            assert_equal(0, browser.checkboxes.length) # Number of checkboxes
            assert_equal(0, browser.dds.length) # Number of dds
            assert((22..27) === browser.divs.length) # Number of divs	# Varies from 22 and 27
            assert_equal(0, browser.dls.length) # Number of dls
            assert_equal(0, browser.dts.length) # Number of dts
            assert_equal(0, browser.ems.length) # Number of ems
            assert_equal(0, browser.file_fields.length) # Number of file_fields
            assert_equal(1, browser.forms.length) # Number of forms
            assert_equal(7, browser.hiddens.length) # Number of hiddens
            assert((1..3) === browser.images.length) # Number of images	# Varies from 1 to 3
            assert_equal(0, browser.labels.length) # Number of labels
            assert_equal(0, browser.lis.length) # Number of lis
            assert((31..32) === browser.links.length) # Number of links	# Varies from 31 to 32
            assert_equal(0, browser.maps.length) # Number of maps
            assert_equal(2, browser.ps.length) # Number of ps
            assert_equal(0, browser.pres.length) # Number of pres
            assert_equal(0, browser.radios.length) # Number of radios
            assert_equal(0, browser.select_lists.length) # Number of select_lists
            assert((11..12) === browser.spans.length) # Number of spans	# Varies from 11 to 12
            assert_equal(0, browser.strongs.length) # Number of strongs
            assert((2..3) === browser.tables.length) # Number of tables	# Varies from 2 to 3
            assert_equal(5, browser.text_fields.length) # Number of text_fields
            
            @@bPassed = true # Set flag
          end # IE counts
          
          if(browser.is_firefox?)
            # Counts were generated on 05/27/2010 with Firefox 3.6
            assert_equal(0, browser.areas.length) # Number of areas
            assert_equal(2, browser.buttons.length) # Number of buttons
            assert_equal(0, browser.checkboxes.length) # Number of checkboxes
            assert_equal(0, browser.dds.length) # Number of dds
            assert((21..22) === browser.divs.length) # Number of divs	# Varies from 21 and 22
            assert_equal(0, browser.dls.length) # Number of dls
            assert_equal(0, browser.dts.length) # Number of dts
            assert_equal(0, browser.ems.length) # Number of ems
            assert_equal(0, browser.file_fields.length) # Number of file_fields
            assert_equal(7, browser.hiddens.length) # Number of hiddens
            assert_equal(1, browser.images.length) # Number of images
            assert_equal(0, browser.labels.length) # Number of labels
            assert_equal(0, browser.lis.length) # Number of lis
            assert((30..31) === browser.links.length) # Number of links	# Varies from 30 and 31
            assert_equal(0, browser.maps.length) # Number of maps
            assert_equal(1, browser.ps.length) # Number of ps
            assert_equal(0, browser.pres.length) # Number of pres
            assert_equal(0, browser.radios.length) # Number of radios
            assert_equal(0, browser.select_lists.length) # Number of select_lists
            assert_equal(10, browser.spans.length) # Number of spans
            assert_equal(0, browser.strongs.length) # Number of strongs
            assert_equal(2, browser.tables.length) # Number of tables
            assert_equal(5, browser.text_fields.length) # Number of text_fields
            
            @@bPassed = true # Set flag
          end # Firefox counts
          
          puts2(" Done verifying HTML tag counts on page.")
        end # Perform a check ...
        
        ### BEGIN - IMAGES PAGE ##############################
        
        puts2("\nAccessing page - Images...")
        browser.link(:text, "Images").click
        sleep(@@iDelay)  # Allow time for page to complete loading
        
        # Record URL on the web page
        puts2(" Current URL: " + browser.url)
        puts2(" Emulating Web Browser version: " + browser.get_doc_app_version)
        
        
        # Perform a check of the HTML tags on the page to see if the page has changed
        # The HTML tag counts vary based upon the browser type (IE vs. FF)
        #
        # Determine if this test run should generate new testcode counts
        # that can be manually added and used as a regression for subsequent runs
        # or run with the current code.
        if(@@bGenerateTestcode)
          browser.generate_testcode_html_tag_counts()
        else
          puts2("\nBegin verifying HTML tag counts on page...")
          @@bPassed = false # Clear flag
          
          if(browser.is_ie?)
            # Counts were generated on 05/27/2010 with IE 8.0
            assert_equal(0, browser.areas.length) # Number of areas
            assert_equal(1, browser.buttons.length) # Number of buttons
            assert_equal(0, browser.checkboxes.length) # Number of checkboxes
            assert_equal(0, browser.dds.length) # Number of dds
            assert((17..18) === browser.divs.length) # Number of divs # Varies by date
            assert_equal(0, browser.dls.length) # Number of dls
            assert_equal(0, browser.dts.length) # Number of dts
            assert_equal(0, browser.ems.length) # Number of ems
            assert_equal(0, browser.file_fields.length) # Number of file_fields
            assert_equal(1, browser.forms.length) # Number of forms
            assert_equal(8, browser.hiddens.length) # Number of hiddens
            assert_equal(4, browser.images.length) # Number of images
            assert_equal(0, browser.labels.length) # Number of labels
            assert_equal(0, browser.lis.length) # Number of lis
            assert_equal(36, browser.links.length) # Number of links
            assert_equal(0, browser.maps.length) # Number of maps
            assert_equal(1, browser.ps.length) # Number of ps
            assert_equal(0, browser.pres.length) # Number of pres
            assert_equal(0, browser.radios.length) # Number of radios
            assert_equal(0, browser.select_lists.length) # Number of select_lists
            assert_equal(4, browser.spans.length) # Number of spans
            assert_equal(0, browser.strongs.length) # Number of strongs
            assert_equal(3, browser.tables.length) # Number of tables
            assert_equal(2, browser.text_fields.length) # Number of text_fields
            
            @@bPassed = true # Set flag
          end # IE counts
          
          if(browser.is_firefox?)
            # Counts were generated on 05/27/2010 with Firefox 3.6
            assert_equal(0, browser.areas.length) # Number of areas
            assert((1..2) === browser.buttons.length) # Number of buttons	# Varies from 1 to 2
            assert_equal(0, browser.checkboxes.length) # Number of checkboxes
            assert_equal(0, browser.dds.length) # Number of dds
            assert((17..22) === browser.divs.length) # Number of divs	# Varies from 17 to 22
            assert_equal(0, browser.dls.length) # Number of dls
            assert_equal(0, browser.dts.length) # Number of dts
            assert_equal(0, browser.ems.length) # Number of ems
            assert_equal(0, browser.file_fields.length) # Number of file_fields
            assert((7..8) === browser.hiddens.length) # Number of hiddens	# Varies from 7 to 8
            assert((1..4) === browser.images.length) # Number of images	# Varies from 1 to 4
            assert_equal(0, browser.labels.length) # Number of labels
            assert_equal(0, browser.lis.length) # Number of lis
            assert((31..36) === browser.links.length) # Number of links	# Varies from 31 to 36
            assert_equal(0, browser.maps.length) # Number of maps
            assert_equal(1, browser.ps.length) # Number of ps
            assert_equal(0, browser.pres.length) # Number of pres
            assert_equal(0, browser.radios.length) # Number of radios
            assert_equal(0, browser.select_lists.length) # Number of select_lists
            assert((4..10) === browser.spans.length) # Number of spans	# Varies from 4 to 10
            assert_equal(0, browser.strongs.length) # Number of strongs
            assert((2..3) === browser.tables.length) # Number of tables	# Varies from 2 to 3
            assert((2..5) === browser.text_fields.length) # Number of text_fields	# Varies from 2 to 5
            
            @@bPassed = true # Set flag
          end # Firefox counts
          
          puts2(" Done verifying HTML tag counts on page.")
        end # Perform a check ...
        
        
        # Return to the Home page
        puts2("Return to the home page...")
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
        puts2(" Emulating Web Browser version: " + browser.get_doc_app_version)
        
        
        # Perform a check of the HTML tags on the page to see if the page has changed
        # The HTML tag counts vary based upon the browser type (IE vs. FF)
        #
        # Determine if this test run should generate new testcode counts
        # that can be manually added and used as a regression for subsequent runs
        # or run with the current code.
        if(@@bGenerateTestcode)
          browser.generate_testcode_html_tag_counts()
        else
          puts2("\nBegin verifying HTML tag counts on page...")
          @@bPassed = false # Clear flag
          
          if(browser.is_ie?)
            # Counts were generated on 05/27/2010 with IE 8.0
            assert_equal(0, browser.areas.length) # Number of areas
            assert_equal(1, browser.buttons.length) # Number of buttons
            assert_equal(0, browser.checkboxes.length) # Number of checkboxes
            assert_equal(0, browser.dds.length) # Number of dds
            assert((54..75) === browser.divs.length) # Number of divs  # Varies by date
            assert_equal(0, browser.dls.length) # Number of dls
            assert_equal(0, browser.dts.length) # Number of dts
            assert_equal(0, browser.ems.length) # Number of ems
            assert_equal(0, browser.file_fields.length) # Number of file_fields
            assert_equal(1, browser.forms.length) # Number of forms
            assert_equal(6, browser.hiddens.length) # Number of hiddens
            assert((9..15) === browser.images.length) # Number of images # Varies by date
            assert_equal(0, browser.labels.length) # Number of labels
            assert_equal(0, browser.lis.length) # Number of lis
            assert((47..55) === browser.links.length) # Number of links # Varies by date
            assert_equal(0, browser.maps.length) # Number of maps
            assert_equal(1, browser.ps.length) # Number of ps
            assert_equal(0, browser.pres.length) # Number of pres
            assert_equal(0, browser.radios.length) # Number of radios
            assert_equal(0, browser.select_lists.length) # Number of select_lists
            assert((58..90) === browser.spans.length) # Number of spans	# Varies by server (between 58 to 60)
            assert(58 <= browser.spans.length) # Number of spans
            assert(90 >= browser.spans.length) # Number of spans
            assert_equal(0, browser.strongs.length) # Number of strongs
            assert_equal(2, browser.tables.length) # Number of tables
            assert_equal(1, browser.text_fields.length) # Number of text_fields
            
            @@bPassed = true # Set flag
          end # IE counts
          
          if(browser.is_firefox?)
            # Counts were generated on 05/27/2010 with Firefox 3.6
            assert_equal(0, browser.areas.length) # Number of areas
            assert((1..2) === browser.buttons.length) # Number of buttons	# Varies from 1 to 2
            assert_equal(0, browser.checkboxes.length) # Number of checkboxes
            assert_equal(0, browser.dds.length) # Number of dds
            assert((22..54) === browser.divs.length) # Number of divs	# Varies from 22 to 54
            assert_equal(0, browser.dls.length) # Number of dls
            assert_equal(0, browser.dts.length) # Number of dts
            assert_equal(0, browser.ems.length) # Number of ems
            assert_equal(0, browser.file_fields.length) # Number of file_fields
            assert((4..7) === browser.hiddens.length) # Number of hiddens	# Varies from 4 to 7
            assert((1..9) === browser.images.length) # Number of images		# Varies from 1 to 9
            assert_equal(0, browser.labels.length) # Number of labels
            assert_equal(0, browser.lis.length) # Number of lis
            assert((31..47) === browser.links.length) # Number of links	# Varies from 31 to 47
            assert_equal(0, browser.maps.length) # Number of maps
            assert_equal(1, browser.ps.length) # Number of ps
            assert_equal(0, browser.pres.length) # Number of pres
            assert_equal(0, browser.radios.length) # Number of radios
            assert_equal(0, browser.select_lists.length) # Number of select_lists
            assert((8..60) === browser.spans.length) # Number of spans	# Varies from 8 to 60
            assert_equal(0, browser.strongs.length) # Number of strongs
            assert((1..2) === browser.tables.length) # Number of tables	# Varies from 1 to 2
            assert((1..5) === browser.text_fields.length) # Number of text_fields	# Varies from 1 to 5
            
            @@bPassed = true # Set flag
          end # Firefox counts
          
          puts2(" Done verifying HTML tag counts on page.")
        end # Perform a check ...
        
        
        # Return to the Home page
        puts2("Return to the home page...")
        browser.goto($sAccessURL)
        sleep(@@iDelay)  # Allow time for page to complete loading
        
        # Record URL on the web page
        puts2(" Current URL: " + browser.url)
        
        ### BEGIN - MAPS PAGE ##############################
        
        puts2("\nAccessing page - Maps...")
        browser.link(:text, "Maps").click
        sleep(@@iDelay)  # Allow time for page to complete loading
        
        # Record info on the web page
        puts2(" Current URL: " + browser.url)
        puts2(" Emulating Web Browser version: " + browser.get_doc_app_version)
        
        
        # Perform a check of the HTML tags on the page to see if the page has changed
        # The HTML tag counts vary based upon the browser type (IE vs. FF)
        #
        # Determine if this test run should generate new testcode counts
        # that can be manually added and used as a regression for subsequent runs
        # or run with the current code.
        if(@@bGenerateTestcode)
          browser.generate_testcode_html_tag_counts()
        else
          puts2("\nBegin verifying HTML tag counts on page...")
          @@bPassed = false # Clear flag
          
          if(browser.is_ie?)
            # Counts were generated on 05/27/2010 with IE 8.0
            assert_equal(0, browser.areas.length) # Number of areas
            assert_equal(4, browser.buttons.length) # Number of buttons
            assert_equal(15, browser.checkboxes.length) # Number of checkboxes
            assert_equal(0, browser.dds.length) # Number of dds
            assert((198..360) === browser.divs.length) # Number of divs	# Varies from 198 and 360
            assert_equal(0, browser.dls.length) # Number of dls
            assert_equal(0, browser.dts.length) # Number of dts
            assert_equal(0, browser.ems.length) # Number of ems
            assert_equal(0, browser.file_fields.length) # Number of file_fields
            assert_equal(4, browser.forms.length) # Number of forms
            assert_equal(23, browser.hiddens.length) # Number of hiddens
            assert(63 <= browser.images.length) # Number of images
            assert_equal(10, browser.labels.length) # Number of labels
            assert_equal(0, browser.lis.length) # Number of lis
            assert(60 <= browser.links.length) # Number of links
            assert_equal(0, browser.maps.length) # Number of maps
            assert_equal(0, browser.ps.length) # Number of ps
            assert_equal(0, browser.pres.length) # Number of pres
            assert_equal(0, browser.radios.length) # Number of radios
            assert_equal(1, browser.select_lists.length) # Number of select_lists
            assert((45..52) === browser.spans.length) # Number of spans		# Varies from 49 and 52
            assert_equal(0, browser.strongs.length) # Number of strongs
            assert_equal(8, browser.tables.length) # Number of tables
            assert_equal(6, browser.text_fields.length) # Number of text_fields
            
            @@bPassed = true # Set flag
          end # IE counts
          
          if(browser.is_firefox?)
            # Counts were generated on 05/27/2010 with Firefox 3.6
            assert_equal(0, browser.areas.length) # Number of areas
            assert((2..6) === browser.buttons.length) # Number of buttons	# Varies from 2 to 6
            assert((0..15) === browser.checkboxes.length) # Number of checkboxes	# Varies from 0 to 15
            assert_equal(0, browser.dds.length) # Number of dds
            assert((22..374) === browser.divs.length) # Number of divs	# Varies from 22 to 374
            assert_equal(0, browser.dls.length) # Number of dls
            assert_equal(0, browser.dts.length) # Number of dts
            assert_equal(0, browser.ems.length) # Number of ems
            assert_equal(0, browser.file_fields.length) # Number of file_fields
            assert((7..23) === browser.hiddens.length) # Number of hiddens	# Varies from 7 to 23
            assert((1..100) === browser.images.length) # Number of images	# Varies from 1 to 77
            assert((0..10) === browser.labels.length) # Number of labels	# Varies from 0 to 10
            assert_equal(0, browser.lis.length) # Number of lis
            assert((31..62) === browser.links.length) # Number of links	# Varies from 31 to 62
            assert_equal(0, browser.maps.length) # Number of maps
            assert((0..1) === browser.ps.length) # Number of ps	# Varies from 0 to 1
            assert_equal(0, browser.pres.length) # Number of pres
            assert_equal(0, browser.radios.length) # Number of radios
            assert((0..1) === browser.select_lists.length) # Number of select_lists	# Varies from 0 to 1
            assert((10..52) === browser.spans.length) # Number of spans	# Varies from 10 to 52
            assert_equal(0, browser.strongs.length) # Number of strongs
            assert((2..8) === browser.tables.length) # Number of tables	# Varies from 2 to 8
            assert((5..6) === browser.text_fields.length) # Number of text_fields	# Varies from 5 to 6
            
            @@bPassed = true # Set flag
          end # Firefox counts
          
          puts2(" Done verifying HTML tag counts on page.")
        end # Perform a check ...
        
        
        # Return to the Home page
        puts2("Return to the home page...")
        browser.goto($sAccessURL)
        sleep(@@iDelay)  # Allow time for page to complete loading
        
        # Record URL on the web page
        puts2(" Current URL: " + browser.url)
        
        
        ### BEGIN - NEWS PAGE ##############################
        
        puts2("\nAccessing page -  News...")
        browser.link(:text, "News").click
        sleep(@@iDelay)  # Allow time for page to complete loading
        
        # Record info on the web page
        puts2(" Current URL: " + browser.url)
        puts2(" Emulating Web Browser version: " + browser.get_doc_app_version)
        
        
        # Perform a check of the HTML tags on the page to see if the page has changed
        # The HTML tag counts vary based upon the browser type (IE vs. FF)
        #
        # Determine if this test run should generate new testcode counts
        # that can be manually added and used as a regression for subsequent runs
        # or run with the current code.
        if(@@bGenerateTestcode)
          browser.generate_testcode_html_tag_counts()
        else
          puts2("\nBegin verifying HTML tag counts on page...")
          @@bPassed = false # Clear flag
          
          if(browser.is_ie?)
            # Counts were generated on 05/27/2010 with IE 8.0
            # Varies by content over time
            assert_equal(0, browser.areas.length) # Number of areas
            assert((5..13) === browser.buttons.length) # Number of buttons		# Varies from 5 and 13
            assert((0..2) === browser.checkboxes.length) # Number of checkboxes		# Varies from 0 and 2
            assert_equal(0, browser.dds.length) # Number of dds
            assert((746..1000) === browser.divs.length) # Number of divs	# Varies from 746 to 933
            assert_equal(0, browser.dls.length) # Number of dls
            assert_equal(0, browser.dts.length) # Number of dts
            assert_equal(0, browser.ems.length) # Number of ems
            assert_equal(0, browser.file_fields.length) # Number of file_fields
            assert((6..7) === browser.forms.length) # Number of forms
            assert((220..230) === browser.hiddens.length) # Number of hiddens	# Varies from 226 to 230
            assert((59..68) === browser.images.length) # Number of images		# Varies from 66 to 68
            assert_equal(0, browser.labels.length) # Number of labels
            assert((5..15) === browser.lis.length) # Number of lis
            assert((461..487) === browser.links.length) # Number of links		# Varies from 461 to 474
            assert_equal(0, browser.maps.length) # Number of maps
            assert_equal(0, browser.ps.length) # Number of ps
            assert_equal(0, browser.pres.length) # Number of pres
            assert((0..21) === browser.radios.length) # Number of radios
            assert((0..147) === browser.select_lists.length) # Number of select_lists
            assert((373..725) === browser.spans.length) # Number of spans		# Varies from 373 to 720
            assert_equal(0, browser.strongs.length) # Number of strongs
            assert((5..6) === browser.tables.length) # Number of tables
            assert((4..9) === browser.text_fields.length) # Number of text_fields
            
            @@bPassed = true # Set flag
          end # IE counts
          
          if(browser.is_firefox?)
            # Counts were generated on 05/27/2010 with Firefox 3.6
            # Varies by content over time
            assert_equal(0, browser.areas.length) # Number of areas
            assert((2..13) === browser.buttons.length) # Number of buttons	# Varies from 2 to 13
            assert((0..2) === browser.checkboxes.length) # Number of checkboxes	# Varies from 0 to 2
            assert_equal(0, browser.dds.length) # Number of dds
            assert((22..1000) === browser.divs.length) # Number of divs	# Varies from 22 to 757
            assert_equal(0, browser.dls.length) # Number of dls
            assert_equal(0, browser.dts.length) # Number of dts
            assert_equal(0, browser.ems.length) # Number of ems
            assert_equal(0, browser.file_fields.length) # Number of file_fields
            assert((7..230) === browser.hiddens.length) # Number of hiddens	# Varies from 7 to 230
            assert((1..68) === browser.images.length) # Number of images	# Varies from 1 to 68
            assert_equal(0, browser.labels.length) # Number of labels
            assert((0..15) === browser.lis.length) # Number of lis	# Varies from 0 to 5
            assert((31..500) === browser.links.length) # Number of links	# Varies from 31 to 469
            assert_equal(0, browser.maps.length) # Number of maps
            assert((0..1) === browser.ps.length) # Number of ps	# Varies from 0 to 1
            assert_equal(0, browser.pres.length) # Number of pres
            assert((0..21) === browser.radios.length) # Number of radios
            assert((0..147) === browser.select_lists.length) # Number of select_lists	# Varies from 0 to 147
            assert((10..730) === browser.spans.length) # Number of spans	# Varies from 10 to 378
            assert_equal(0, browser.strongs.length) # Number of strongs
            assert((2..6) === browser.tables.length) # Number of tables	# Varies from 2 to 6
            assert((3..9) === browser.text_fields.length) # Number of text_fields	# Varies from 3 to 9
            
            @@bPassed = true # Set flag
          end # Firefox counts
          
          puts2(" Done verifying HTML tag counts on page.")
        end # Perform a check ...
        
        
        # Return to the Home page
        puts2("Return to the home page...")
        browser.goto($sAccessURL)
        sleep(@@iDelay)  # Allow time for page to complete loading
        
        # Record URL on the web page
        puts2(" Current URL: " + browser.url)
        
        
        ### BEGIN - SHOPING PAGE ##############################
        
        puts2("\nAccessing page - Shopping...")
        browser.link(:text, "Shopping").click
        sleep(@@iDelay)  # Allow time for page to complete loading
        
        # Record info on the web page
        puts2(" Current URL: " + browser.url)
        puts2(" Emulating Web Browser version: " + browser.get_doc_app_version)
        
        
        # Perform a check of the HTML tags on the page to see if the page has changed
        # The HTML tag counts vary based upon the browser type (IE vs. FF)
        #
        # Determine if this test run should generate new testcode counts
        # that can be manually added and used as a regression for subsequent runs
        # or run with the current code.
        if(@@bGenerateTestcode)
          browser.generate_testcode_html_tag_counts()
        else
          puts2("\nBegin verifying HTML tag counts on page...")
          @@bPassed = false # Clear flag
          
          if(browser.is_ie?)
            # Counts were generated on 05/27/2010 with IE 8.0
            assert_equal(0, browser.areas.length) # Number of areas
            assert_equal(1, browser.buttons.length) # Number of buttons
            assert_equal(0, browser.checkboxes.length) # Number of checkboxes
            assert_equal(0, browser.dds.length) # Number of dds
            assert_equal(12, browser.divs.length) # Number of divs
            assert_equal(0, browser.dls.length) # Number of dls
            assert_equal(0, browser.dts.length) # Number of dts
            assert_equal(0, browser.ems.length) # Number of ems
            assert_equal(0, browser.file_fields.length) # Number of file_fields
            assert_equal(1, browser.forms.length) # Number of forms
            assert_equal(3, browser.hiddens.length) # Number of hiddens
            assert_equal(1, browser.images.length) # Number of images
            assert_equal(0, browser.labels.length) # Number of labels
            assert_equal(0, browser.lis.length) # Number of lis
            assert_equal(51, browser.links.length) # Number of links
            assert_equal(0, browser.maps.length) # Number of maps
            assert_equal(2, browser.ps.length) # Number of ps
            assert_equal(0, browser.pres.length) # Number of pres
            assert_equal(0, browser.radios.length) # Number of radios
            assert_equal(0, browser.select_lists.length) # Number of select_lists
            assert_equal(0, browser.spans.length) # Number of spans
            assert_equal(0, browser.strongs.length) # Number of strongs
            assert_equal(3, browser.tables.length) # Number of tables
            assert_equal(1, browser.text_fields.length) # Number of text_fields
            
            @@bPassed = true # Set flag
          end # IE counts
          
          if(browser.is_firefox?)
            # Counts were generated on 05/27/2010 with Firefox 3.6
            # Varies by content over time
            assert_equal(0, browser.areas.length) # Number of areas
            assert((1..2) === browser.buttons.length) # Number of buttons	# Varies from 1 to 2
            assert_equal(0, browser.checkboxes.length) # Number of checkboxes
            assert_equal(0, browser.dds.length) # Number of dds
            assert((12..22) === browser.divs.length) # Number of divs	# Varies from 12 to 22
            assert_equal(0, browser.dls.length) # Number of dls
            assert_equal(0, browser.dts.length) # Number of dts
            assert_equal(0, browser.ems.length) # Number of ems
            assert_equal(0, browser.file_fields.length) # Number of file_fields
            assert((3..7) === browser.hiddens.length) # Number of hiddens	# Varies from 3 to 7
            assert_equal(1, browser.images.length) # Number of images
            assert_equal(0, browser.labels.length) # Number of labels
            assert_equal(0, browser.lis.length) # Number of lis
            assert((31..55) === browser.links.length) # Number of links	# Varies from 31 to 51
            assert_equal(0, browser.maps.length) # Number of maps
            assert_equal(2, browser.ps.length) # Number of ps
            assert_equal(0, browser.pres.length) # Number of pres
            assert_equal(0, browser.radios.length) # Number of radios
            assert_equal(0, browser.select_lists.length) # Number of select_lists
            assert((0..10) === browser.spans.length) # Number of spans	# Varies from 0 to 10
            assert_equal(0, browser.strongs.length) # Number of strongs
            assert_equal(3, browser.tables.length) # Number of tables
            assert((1..5) === browser.text_fields.length) # Number of text_fields	# Varies from 1 to 5
            
            @@bPassed = true # Set flag
          end # Firefox counts
          
          puts2(" Done verifying HTML tag counts on page.")
        end # Perform a check ...
        
        
        # Return to the Home page
        puts2("Return to the home page...")
        browser.goto($sAccessURL)
        sleep(@@iDelay)  # Allow time for page to complete loading
        
        # Record URL on the web page
        puts2(" Current URL: " + browser.url)
        
        #######################################
      else
        puts("Skipping this test case since this is NOT Google's web site.")
        
      end # Google specific validation
      
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
  end # END TestCase - test_Search_002_ENTVAL_1_Google
  
  
  #===========================================================================#
  # Testcase: test_Search_002_ENTVAL_2_GenerateCode
  #
  # Description: When run against the Google web site's home page it
  #              will demonstrate the collection of entity attribute settings.
  #
  #              In a real wold situation you would run the test code generator once
  #              to display the code, which you would then cut 'n paste into your
  #              test. The code would then be available to be used for validation
  #              on future test runs.
  #
  #              Here is is only performing the generation aspect on a few of the
  #              many HTML elements on the page, (images, links, text_fields, and buttons),
  #              so you can see it in action.  Be patient as it may take awhile to complete.
  #
  #  NOTE: The HTML tag attributes may vary based upon the browser type (IE vs. FF),
  #        so you may want to run the capture one with IE, cut 'n'paste the results into
  #        the test, bounded by an    if(browser.is_ie?)      statement and then
  #        re-run the test with Firefox  and save that code into an   if(browser.is_ff?)
  #        code block.
  #
  #===========================================================================#
  def test_Search_002_ENTVAL_2_GenerateCode
    
    sTestCase_Name = "test_Search_002_ENTVAL_GenerateCode"
    puts2("\nStarting Testcase: #{sTestCase_Name}")
    
    begin
      
      # Start browser
      browser = Watir::Browser.new
      
      # Display a blank page
      browser.goto("about:blank")
      
      
      # Access the Web site URL for the environment that was set on the workbook's Environment sheet
      browser.goto($sAccessURL)
      
      # Google specific validation
      #if($sExecution_Env =~ /Google/)
      
      ### BEGIN - HOME PAGE ##############################
      
      puts2("\nAccessing page - Web...")
      
      # Load web page
      browser.goto($sAccessURL)
      sleep(@@iDelay)  # Allow time for page to complete loading
      
      # Record info on the web page
      puts2(" Current URL: " + browser.url)
      puts2(" Emulating Web Browser version: " + browser.get_doc_app_version)
      
      
      # Define a list of the HTML Elements type to generate test code for
      aHTMLElementListToCapture = ["link", "image", "button", "text_field"]
      
      # Force the generation so you can see it in  action
      bGenerateTestcode = true
      
      puts2("##################################################")
      puts2("####### Beginging the test code generation #######")
      puts2("##################################################")
      
      if(bGenerateTestcode)
        browser.generate_testcode_html_tag_attributes(aHTMLElementListToCapture)
      else
        
      end # Perform a check ...
      
      # Return to the Home page
      puts2("Return to the home page...")
      browser.goto($sAccessURL)
      sleep(@@iDelay)  # Allow time for page to complete loading
      
      # Record URL on the web page
      puts2(" Current URL: " + browser.url)
      
      #######################################
      
      #end # Google specific validation
      
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
  end # END TestCase - test_Search_002_ENTVAL_2_GenerateCode
  
end # END Class - Example_Search_TestClass
