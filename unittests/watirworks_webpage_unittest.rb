#--
#=============================================================================#
# File: watirworks_webpage_unittest.rb
#
#
#  Copyright (c) 2008-2015, Joe DiMauro
#  All rights reserved.
#
# Description: Unit tests for the Web pages using WatirWorks methods:
#                          count_html_tags()
#                          generate_testcode_html_tag_counts(...)
#                          set_select_list_by_name(...)
#                          set_multiselect_list_by_name(...)
#                          set_select_list_by_id(...)
#                          set_multiselect_list_by_id(...)
#                          set_select_list_by_index(...)
#                          set_multiselect_list_by_index(...)
#                          wait_until_status(...)
#                          wait_until_count(...)
#                          wait_until_text(...)
#                          scroll_element_intoview(...)
#                          show_html_tag_attributes(...)
#                          generate_testcode_html_tag_attributes(...)
#=============================================================================#

#=============================================================================#
# Require and Include section
# Entries for additional files or methods needed by this test
#=============================================================================#
require 'rubygems'

$bUseWebDriver = true

if($bUseWebDriver == nil)
  $bUseWebDriver = false
end

#
# Watir

# WatirWorks
require 'watirworks'  # The WatirWorks library loader

include WatirWorks_Utilities    # WatirWorks General Utilities
include WatirWorks_WebUtilities # WatirWorks Web Utilities
include WatirWorks_RefLib # WatirWorks Web Utilities

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
bIncludeInSuite = false
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
# Class: Unittest_WebPage
#
# Test Case Methods: setup, teardown
#                    test_WebPage_nnn_xxx
#
#=============================================================================#
class Unittest_WebPage < Test::Unit::TestCase
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

    puts2("\nTestcase finished in " + calc_elapsed_time(@@tTestCase_StartTime) + " seconds.")

    # Restore the Global variable's original settings
    $VERBOSE = @@VERBOSE_ORIG
    $DEBUG = @@DEBUG_ORIG
    $FAST_SPEED =@@FAST_SPEED_ORIG
    $HIDE_IE = @@HIDE_IE_ORIG

  end # end of teardown

  #===========================================================================#
  # Testcase method: test_WebPage_001_count_html_tags
  #
  # Description: Test methods: count_html_tags()
  #===========================================================================#
  def test_WebPage_001_count_html_tags

    puts2("")
    puts2("#######################")
    puts2("Testcase: test_WebPage_001_count_html_tags")
    puts2("#######################")

    sGoogleURL = "http://google.com"

    #$VERBOSE = true
    #$DEBUG = true
    iDelay = 2

    # Define components of  the URL for the WatirWorks HTML Tags web page
    sProtocol = "file:///"
    sRootURL =Dir.pwd
    sPage = "data/html/html_tags.html"

    # Construct the URL
    sURL = sProtocol  + sRootURL + "/" + sPage

    begin # Start local browsers

      puts2("Create a new local Browser Object")
      browser = start_browser($sDefaultBrowser)
      sleep iDelay

      puts2("\nLoad a blank page")
      browser.goto("about:blank")
      sleep iDelay

      sCurrentURL = browser.url
      puts2("Current URL: " + sCurrentURL)

      puts2("Count all Watir supported HTML tags on the current Web page")
      hMyPageObjects =browser.count_html_tags()

      puts2("Counts of the objects on the page:")
      hMyPageObjects.sort.each do | key, value|
        puts2(" #{key} =  #{value.to_s}")
      end

      puts2("\nLoad Google")
      browser.goto(sGoogleURL)
      sleep iDelay

      sCurrentURL = browser.url
      puts2("Current URL: " + sCurrentURL)

      puts2("Count only link and image objects on the current Web page")
      oObjects= ["link", "image"]
      hMyPageObjects = browser.count_html_tags(oObjects)

      puts2("Counts of the objects on the page:")
      hMyPageObjects.sort.each do | key, value|
        puts2(" #{key} =  #{value.to_s}")
      end

      puts2("\nLoad the WatirWorks HTML tags page")
      browser.goto(sURL)
      sleep 2

      sCurrentURL = browser.url
      puts2("Current URL: " + sCurrentURL)

      puts2("Count all Watir supported HTML tags on the current Web page")
      hMyPageObjects =browser.count_html_tags("all")

      puts2("Count of the supported objects on the page:")
      hMyPageObjects.sort.each do | key, value|
        puts2(" #{key} =  #{value.to_s}")
      end

    rescue => e

      puts2("*** ERROR and Backtrace: " + e.message + "\n" + e.backtrace.join("\n"), "ERROR")

      # Close the browser
      browser.close

      # Raise the error with a custom message after the rest of the rescue actions
      raise("*** TESTCASE - test_WebPage_001_count_html_tags")

    ensure

      # Close the browser
      browser.close

    end # Start local browsers

  end # End of test method - test_WebPage_001_count_html_tags

  #===========================================================================#
  # Testcase method: test_WebPage_002_generate_testcode_html_tag_counts
  #
  # Description: Test methods: generate_testcode_html_tag_counts()
  #===========================================================================#
  def test_WebPage_002_generate_testcode_html_tag_counts

    puts2("")
    puts2("#######################")
    puts2("Testcase: test_WebPage_002_generate_testcode_html_tag_counts")
    puts2("#######################")

    sGoogleURL = "http://google.com"

    #$VERBOSE = true
    #$DEBUG = true
    iDelay = 2

    # Define components of  the URL for the WatirWorks HTML Tags web page
    sProtocol = "file:///"
    sRootURL =Dir.pwd
    sPage = "data/html/html_tags.html"

    # Construct the URL
    sURL = sProtocol  + sRootURL + "/" + sPage

    begin # Start local browsers

      puts2("Create a new local Browser Object")
      browser = start_browser($sDefaultBrowser)
      sleep iDelay

      puts2("\nLoad a blank page")
      browser.goto("about:blank")
      sleep iDelay

      sCurrentURL = browser.url
      puts2("Current URL: " + sCurrentURL)

      puts2("Count all Watir supported HTML tags on the current Web page")
      browser.generate_testcode_html_tag_counts()

      puts2("\nLoad Google")
      browser.goto(sGoogleURL)
      sleep iDelay

      sCurrentURL = browser.url
      puts2("Current URL: " + sCurrentURL)

      puts2("Count only area, link and image objects on the current Web page")
      oObjects= ["link", "image", "area"]
      browser.generate_testcode_html_tag_counts(oObjects)

      puts2("\nLoad the WatirWorks HTML tags page")
      browser.goto(sURL)
      sleep 2

      sCurrentURL = browser.url
      puts2("Current URL: " + sCurrentURL)

      puts2("Count all Watir supported HTML tags on the current Web page")
      browser.generate_testcode_html_tag_counts("all")

    rescue => e

      puts2("*** ERROR and Backtrace: " + e.message + "\n" + e.backtrace.join("\n"), "ERROR")

      # Close the browser
      browser.close

      # Raise the error with a custom message after the rest of the rescue actions
      raise("*** TESTCASE - test_WebPage_002_generate_testcode_html_tag_counts")

    ensure

      # Close the browser
      browser.close

    end # Start local browsers

  end # End of test method - test_WebPage_002_generate_testcode_html_tag_counts

  #===========================================================================#
  # Testcase method: test_WebPage_003_set_select_list_by_name
  #
  # Description: Test methods: set_select_list_by_name()
  #===========================================================================#
  def test_WebPage_003_set_select_list_by_name

    puts2("")
    puts2("#######################")
    puts2("Testcase: test_WebPage_003_set_select_list_by_name")
    puts2("#######################")

    #$VERBOSE = true
    #$DEBUG = true
    iDelay = 2

    # Define components of  the URL for the WatirWorks HTML Tags web page
    sProtocol = "file:///"
    sRootURL =Dir.pwd
    sPage = "data/html/html_tags.html"

    # Construct the URL
    sURL = sProtocol  + sRootURL + "/" + sPage

    begin # Start local browsers

      puts2("Create a new local Browser Object")
      #browser = Watir::Browser.new
      browser = start_browser($sDefaultBrowser)
      sleep 2

      puts2("\nLoad the WatirWorks HTML tags page")
      browser.goto(sURL)
      sleep iDelay
      puts2("Current URL: " + browser.url)

      aChoices = [
        ["choice", "Choice One"],
        ["choice", "Choice Two"],
        ["choice", ""],
        ["RC", "Agile"],
        ["RC", ""],
      ]

      # Loop
      aChoices.each do | sListName, sChoice |

        # Display the contents of the select list
        if(browser.select_list(:name, sListName).exists?)

          aSelections = browser.select_list(:name, sListName).options.map

          # Display options
          puts2("\n Number of options in select list: " + aSelections.count.to_s)
          puts2("\t Options in select list:")
          aSelections.each do | sSelection |
            if(is_webdriver? == false)
              puts2("\t " + sSelection.to_s)
            else
              puts2("\t " + sSelection.text)
            end

          end # Display options
        end # Display the contents of the select list

        bStatus = browser.set_select_list_by_name?(sListName, sChoice)

        if(bStatus == true)
          puts("Selected option in list: #{sChoice}")
        else
          puts("Failed selecting option in list: #{sChoice}")
        end

        if(browser.select_list(:name, sListName).exists?)

          puts2("* Current selection: " + browser.select_list(:name, sListName).selected_options.to_s)
        end

      end # Loop

    rescue => e

      puts2("*** ERROR and Backtrace: " + e.message + "\n" + e.backtrace.join("\n"), "ERROR")

      # Close the browser
      browser.close

      # Raise the error with a custom message after the rest of the rescue actions
      raise("*** TESTCASE - test_WebPage_003_set_select_list_by_name")

    ensure

      # Close the browser
      browser.close

    end # Start local browsers

  end # End of test method - test_WebPage_003_set_select_list_by_name

  #===========================================================================#
  # Testcase method: test_WebPage_004_set_multiselect_list_by_name
  #
  # Description: Test methods: set_multiselect_list_by_name()
  #===========================================================================#
  def test_WebPage_004_set_multiselect_list_by_name

    puts2("")
    puts2("#######################")
    puts2("Testcase: test_WebPage_004_set_multiselect_list_by_name")
    puts2("#######################")

    #$VERBOSE = true
    #$DEBUG = true
    iDelay = 2

    # Define components of  the URL for the WatirWorks HTML Tags web page
    sProtocol = "file:///"
    sRootURL =Dir.pwd
    sPage = "data/html/html_tags.html"

    # Construct the URL
    sURL = sProtocol  + sRootURL + "/" + sPage

    begin # Start local browsers

      puts2("Create a new local Browser Object")
      #browser = Watir::Browser.new
      browser = start_browser($sDefaultBrowser)
      sleep 2

      puts2("\nLoad the WatirWorks HTML tags page")
      browser.goto(sURL)
      sleep iDelay
      puts2("Current URL: " + browser.url)

      aSelectListChoices = ["Choice One", "", "Choice Two", "Choice Four"]
      sListName = "MultiSelect_1"

      # Display the contents of the select list
      if(browser.select_list(:name, sListName).exists?)

        aSelections = browser.select_list(:name, sListName).options

        # Display options
        puts2("\n Number of options in select list: " + aSelections.count.to_s)
        puts2("\t Options in select list:")
        aSelections.each do | sSelection |
          if(is_webdriver? == false)
            puts2("\t " + sSelection.to_s)
          else
            puts2("\t " + sSelection.text)
          end

        end # Display options
      end # Display the contents of the select list

      bStatus = browser.set_multiselect_list_by_name?(sListName, aSelectListChoices)
      if(bStatus == true)
        puts("Selected multiple options in list")
      else
        puts("Failed selecting multiple options in list")
      end

      if(browser.select_list(:name, sListName).exists?)
        puts2("* Current option: ")

        puts(browser.select_list(:name, sListName).selected_options)
      end

    rescue => e

      puts2("*** ERROR and Backtrace: " + e.message + "\n" + e.backtrace.join("\n"), "ERROR")

      # Close the browser
      browser.close

      # Raise the error with a custom message after the rest of the rescue actions
      raise("*** TESTCASE - test_WebPage_004_set_multiselect_list_by_name")

    ensure

      # Close the browser
      browser.close

    end # Start local browsers

  end # End of test method - test_WebPage_004_set_multiselect_list_by_name

  #===========================================================================#
  # Testcase method: test_WebPage_005_set_select_list_by_id
  #
  # Description: Test methods: set_select_list_by_id()
  #===========================================================================#
  def test_WebPage_005_set_select_list_by_id

    puts2("")
    puts2("#######################")
    puts2("Testcase: test_WebPage_005_set_select_list_by_id")
    puts2("#######################")

    #$VERBOSE = true
    #$DEBUG = true
    iDelay = 2

    # Define components of  the URL for the WatirWorks HTML Tags web page
    sProtocol = "file:///"
    sRootURL =Dir.pwd
    sPage = "data/html/html_tags.html"

    # Construct the URL
    sURL = sProtocol  + sRootURL + "/" + sPage

    begin # Start local browsers

      puts2("Create a new local Browser Object")
      #browser = Watir::Browser.new
      browser = start_browser($sDefaultBrowser)
      sleep 2

      puts2("\nLoad the WatirWorks HTML tags page")
      browser.goto(sURL)
      sleep iDelay
      puts2("Current URL: " + browser.url)

      aChoices = [
        ["sl_2", "Agile"],
        ["sl_2", ""],
        ["sl_2", "Waterfall"],
        ["sl_1", "Choice One"],
        ["sl_1", ""]
      ]

      # Loop
      aChoices.each do | sListName, sChoice |

        # Display the contents of the select list
        if(browser.select_list(:id, sListName).exists?)

          aSelections = browser.select_list(:id, sListName).options

          # Display options
          puts2("\n Number of options in select list: " + aSelections.count.to_s)
          puts2("\t Options in select list:")
          aSelections.each do | sSelection |
            if(is_webdriver? == false)
              puts2("\t " + sSelection.to_s)
            else
              puts2("\t " + sSelection.text)
            end

          end # Display options
        end # Display the contents of the select list

        bStatus = browser.set_select_list_by_id?(sListName, sChoice)

        if(bStatus == true)
          puts("Selected value in list: #{sChoice}")
        else
          puts("Failed selecting value in list: #{sChoice}")
        end

        if(browser.select_list(:id, sListName).exists?)

          puts2("* Current selection: " + browser.select_list(:id, sListName).selected_options.to_s)

        end

      end # Loop

    rescue => e

      puts2("*** ERROR and Backtrace: " + e.message + "\n" + e.backtrace.join("\n"), "ERROR")

      # Close the browser
      browser.close

      # Raise the error with a custom message after the rest of the rescue actions
      raise("*** TESTCASE - test_WebPage_005_set_select_list_by_id")

    ensure

      # Close the browser
      browser.close

    end # Start local browsers

  end # End of test method - test_WebPage_005_set_select_list_by_id

  #===========================================================================#
  # Testcase method: test_WebPage_006_set_multiselect_list_by_id
  #
  # Description: Test methods: set_multiselect_list_by_id()
  #===========================================================================#
  def test_WebPage_006_set_multiselect_list_by_id

    puts2("")
    puts2("#######################")
    puts2("Testcase: test_WebPage_006_set_multiselect_list_by_id")
    puts2("#######################")

    #$VERBOSE = true
    #$DEBUG = true
    iDelay = 2

    # Define components of  the URL for the WatirWorks HTML Tags web page
    sProtocol = "file:///"
    sRootURL =Dir.pwd
    sPage = "data/html/html_tags.html"

    # Construct the URL
    sURL = sProtocol  + sRootURL + "/" + sPage

    aSelectListChoices = [
    ]

    begin # Start local browsers

      puts2("Create a new local Browser Object")
      #browser = Watir::Browser.new
      browser = start_browser($sDefaultBrowser)
      sleep 2

      puts2("\nLoad the WatirWorks HTML tags page")
      browser.goto(sURL)
      sleep iDelay
      puts2("Current URL: " + browser.url)

      aSelectListChoices = ["Choice A", "", "Choice B", "Choice D"]
      sListName = "ms_2"

      # Display the contents of the select list
      if(browser.select_list(:id, sListName).exists?)

        aSelections = browser.select_list(:id, sListName).options

        # Display options
        puts2("\n Number of options in select list: " + aSelections.count.to_s)
        puts2("\t Options in select list:")
        aSelections.each do | sSelection |
          if(is_webdriver? == false)
            puts2("\t " + sSelection.to_s)
          else
            puts2("\t " + sSelection.text)
          end

        end # Display options
      end # Display the contents of the select list

      bStatus = browser.set_multiselect_list_by_id?(sListName, aSelectListChoices)
      if(bStatus == true)
        puts("Selected multiple values in list")
      else
        puts("Failed first")
      end

      if(browser.select_list(:id, sListName).exists?)
        puts2("* Current selection: ")

        puts(browser.select_list(:id, sListName).selected_options)

      end

    rescue => e

      puts2("*** ERROR and Backtrace: " + e.message + "\n" + e.backtrace.join("\n"), "ERROR")

      # Close the browser
      browser.close

      # Raise the error with a custom message after the rest of the rescue actions
      raise("*** TESTCASE - test_WebPage_006_set_multiselect_list_by_id")

    ensure

      # Close the browser
      browser.close

    end # Start local browsers

  end # End of test method - test_WebPage_006_set_multiselect_list_by_id

  #===========================================================================#
  # Testcase method: test_WebPage_007_set_select_list_by_index
  #
  # Description: Test methods: set_select_list_by_index()
  #===========================================================================#
  def test_WebPage_007_set_select_list_by_index

    puts2("")
    puts2("#######################")
    puts2("Testcase: test_WebPage_007_set_select_list_by_index")
    puts2("#######################")

    #$VERBOSE = true
    #$DEBUG = true
    iDelay = 2

    # Define components of  the URL for the WatirWorks HTML Tags web page
    sProtocol = "file:///"
    sRootURL =Dir.pwd
    sPage = "data/html/html_tags.html"

    # Construct the URL
    sURL = sProtocol  + sRootURL + "/" + sPage

    begin # Start local browsers

      puts2("Create a new local Browser Object")
      #browser = Watir::Browser.new
      browser = start_browser($sDefaultBrowser)
      sleep 2

      puts2("\nLoad the WatirWorks HTML tags page")
      browser.goto(sURL)
      sleep iDelay
      puts2("Current URL: " + browser.url)

      aChoices = [
        [2, "Agile"],
        [2, ""],
        [2, "Waterfall"]
      ]

      # Loop
      aChoices.each do | iSelectList_Index, sChoice |

        # Display the contents of the select list
        if(browser.select_list(:index, iSelectList_Index.adjust_index).exists?)

          aSelections = browser.select_list(:index, iSelectList_Index.adjust_index).options

          # Display options
          puts2("\n Number of options in select list: " + aSelections.count.to_s)
          puts2("\t Options in select list:")
          aSelections.each do | sSelection |
            if(is_webdriver? == false)
              puts2("\t " + sSelection.to_s)
            else
              puts2("\t " + sSelection.text)
            end

          end # Display options
        end # Display the contents of the select list

        bStatus = browser.set_select_list_by_index?(iSelectList_Index, sChoice)

        if(bStatus == true)
          puts("Selected value in list: #{sChoice}")
        else
          puts("Failed selecting value in list: #{sChoice}")
        end

        if(browser.select_list(:index, iSelectList_Index.adjust_index).exists?)

          puts2("* Current selection: " + browser.select_list(:index, iSelectList_Index.adjust_index).selected_options.to_s)

        end

      end # Loop

    rescue => e

      puts2("*** ERROR and Backtrace: " + e.message + "\n" + e.backtrace.join("\n"), "ERROR")

      # Close the browser
      browser.close

      # Raise the error with a custom message after the rest of the rescue actions
      raise("*** TESTCASE - test_WebPage_007_set_select_list_by_index")

    ensure

      # Close the browser
      browser.close

    end # Start local browsers

  end # End of test method - test_WebPage_007_set_select_list_by_index

  #===========================================================================#
  # Testcase method: test_WebPage_008_set_multiselect_list_by_index
  #
  # Description: Test methods: set_multiselect_list_by_index()
  #===========================================================================#
  def test_WebPage_008_set_multiselect_list_by_index

    puts2("")
    puts2("#######################")
    puts2("Testcase: test_WebPage_008_set_multiselect_list_by_index")
    puts2("#######################")

    #$VERBOSE = true
    #$DEBUG = true
    iDelay = 2

    # Define components of  the URL for the WatirWorks HTML Tags web page
    sProtocol = "file:///"
    sRootURL =Dir.pwd
    sPage = "data/html/html_tags.html"

    # Construct the URL
    sURL = sProtocol  + sRootURL + "/" + sPage

    aSelectListChoices = [
    ]

    begin # Start local browsers

      puts2("Create a new local Browser Object")
      #browser = Watir::Browser.new
      browser = start_browser($sDefaultBrowser)
      sleep 2

      puts2("\nLoad the WatirWorks HTML tags page")
      browser.goto(sURL)
      sleep iDelay
      puts2("Current URL: " + browser.url)

      aSelectListChoices = ["Choice One", "", "Choice Two", "Choice Four"]
      iSelectList_Index = 3

      # Display the contents of the select list
      if(browser.select_list(:index, iSelectList_Index.adjust_index).exists?)

        aSelections = browser.select_list(:index, iSelectList_Index.adjust_index).options

        # Display options
        puts2("\n Number of options in select list: " + aSelections.count.to_s)
        puts2("\t Options in select list:")
        aSelections.each do | sSelection |
          if(is_webdriver? == false)
            puts2("\t " + sSelection.to_s)
          else
            puts2("\t " + sSelection.text)
          end

        end # Display options
      end # Display the contents of the select list

      bStatus = browser.set_multiselect_list_by_index?(iSelectList_Index, aSelectListChoices)
      if(bStatus == true)
        puts("Selected multiple values in list")
      else
        puts("Failed first")
      end

      if(browser.select_list(:index, iSelectList_Index.adjust_index).exists?)
        puts2("* Current selection: ")

        puts(browser.select_list(:index, iSelectList_Index.adjust_index).selected_options)

      end

    rescue => e

      puts2("*** ERROR and Backtrace: " + e.message + "\n" + e.backtrace.join("\n"), "ERROR")

      # Close the browser
      browser.close

      # Raise the error with a custom message after the rest of the rescue actions
      raise("*** TESTCASE - test_WebPage_008_set_multiselect_list_by_index")

    ensure

      # Close the browser
      browser.close

    end # Start local browsers

  end # End of test method - test_WebPage_008_set_multiselect_list_by_index

  #===========================================================================#
  # Testcase method: test_WebPage_009_wait_until_status
  #
  # Description: Test methods: wait_until_status()
  #
  #                    The web page being validated by this test should have Status bar
  #                     text of "Done", unless you manually hover over an input element
  #===========================================================================#
  def test_WebPage_009_wait_until_status

    puts2("")
    puts2("#######################")
    puts2("Testcase: test_WebPage_009_wait_until_status")
    puts2("#######################")

    #$VERBOSE = true
    #$DEBUG = true
    iDelay = 2

    # Define components of  the URL for the WatirWorks HTML Tags web page
    sProtocol = "file:///"
    sRootURL =Dir.pwd
    sPage = "data/html/html_tags.html"

    # Construct the URL
    sURL = sProtocol  + sRootURL + "/" + sPage

    begin # Start local browsers

      puts2("Create a new local Browser Object")
      #browser = Watir::Browser.new
      browser = start_browser($sDefaultBrowser)
      sleep 2

      puts2("\nLoad the WatirWorks HTML tags page")
      browser.goto(sURL)
      sleep iDelay
      puts2("Current URL: " + browser.url)

      # Set initial values
      aStatusTextToCheck = [ "Done", "Bogus Text"]
      tStartTime = Time.now

      # Loop
      aStatusTextToCheck.each do | sString |

        puts2("\nChecking Browser's status text = " + sString)

        # Validate the browser's status text
        if(browser.wait_until_status(sString, 3, 0.1))
          puts2("Found expected Browser's status text = " + browser.status)
        else
          puts2("Found unexpected Browser's status text = " + browser.status)
        end

      end # Loop

      puts2("Elapsed time = " + calc_elapsed_time(tStartTime))

    rescue => e

      puts2("*** ERROR and Backtrace: " + e.message + "\n" + e.backtrace.join("\n"), "ERROR")

      # Close the browser
      browser.close

      # Raise the error with a custom message after the rest of the rescue actions
      raise("*** TESTCASE - test_WebPage_009_wait_until_status")

    ensure

      # Close the browser
      browser.close

    end # Start local browsers

  end # End of test method - test_WebPage_009_wait_until_status

  #===========================================================================#
  # Testcase method: test_WebPage_010_wait_until_count
  #
  # Description: Test methods: wait_until_count()
  #                    The web page being validated by this test should have a select list
  #                    that contains 5 selections.
  #===========================================================================#
  def test_WebPage_010_wait_until_count

    puts2("")
    puts2("#######################")
    puts2("Testcase: test_WebPage_010_wait_until_count")
    puts2("#######################")

    #$VERBOSE = true
    #$DEBUG = true
    iDelay = 2

    # Define components of  the URL for the WatirWorks HTML Tags web page
    sProtocol = "file:///"
    sRootURL =Dir.pwd
    sPage = "data/html/html_tags.html"

    # Construct the URL
    sURL = sProtocol  + sRootURL + "/" + sPage

    begin # Start local browsers

      puts2("Create a new local Browser Object")
      #browser = Watir::Browser.new
      browser = start_browser($sDefaultBrowser)
      sleep 2

      puts2("\nLoad the WatirWorks HTML tags page")
      browser.goto(sURL)
      sleep iDelay
      puts2("Current URL: " + browser.url)

      # Set initial values
      iItemCountInList = 0
      tStartTime = Time.now

      # Loop
      7.times do

        puts2("\nChecking select list for at least #{iItemCountInList} items in the list")

        if(browser.select_list(:id, "ms_1").wait_until_count(iItemCountInList, 3, 0.1))
          puts2("Found at least #{iItemCountInList} items in the list")
        else
          puts2("Did NOT find at least #{iItemCountInList} items in the list")
        end

        iItemCountInList = iItemCountInList + 1

      end # Loop

      puts2("Elapsed time = " + calc_elapsed_time(tStartTime))

    rescue => e

      puts2("*** ERROR and Backtrace: " + e.message + "\n" + e.backtrace.join("\n"), "ERROR")

      # Close the browser
      browser.close

      # Raise the error with a custom message after the rest of the rescue actions
      raise("*** TESTCASE - test_WebPage_010_wait_until_count")

    ensure

      # Close the browser
      browser.close

    end # Start local browsers

  end # End of test method - test_WebPage_010_wait_until_count

  #===========================================================================#
  # Testcase method: test_WebPage_011_wait_until_text
  #
  # Description: Test methods: wait_until_text()
  #                    The web page being validated by this test should have a select list
  #                    that contains 5 selections.
  #===========================================================================#
  def test_WebPage_011_wait_until_text

    puts2("")
    puts2("#######################")
    puts2("Testcase: test_WebPage_011_wait_until_text")
    puts2("#######################")

    #$VERBOSE = true
    #$DEBUG = true
    iDelay = 2

    # Define components of  the URL for the WatirWorks HTML Tags web page
    sProtocol = "file:///"
    sRootURL =Dir.pwd
    sPage = "data/html/html_tags.html"

    # Construct the URL
    sURL = sProtocol  + sRootURL + "/" + sPage

    begin # Start local browsers

      puts2("Create a new local Browser Object")
      #browser = Watir::Browser.new
      browser = start_browser($sDefaultBrowser)
      sleep 2

      puts2("\nLoad the WatirWorks HTML tags page")
      browser.goto(sURL)
      sleep iDelay
      puts2("Current URL: " + browser.url)

      # Set initial values
      aExpectedSelectListText = [
        "Make Multiple selections",
        "Choice One", "Choice Two", "Choice Three", "Choice Four",
        "Choice Bogus" ]
      tStartTime = Time.now

      # Loop
      aExpectedSelectListText.each do | sStringInList |

        puts2("\nChecking select list for:  #{sStringInList}")

        if(browser.select_list(:id, "ms_1").wait_until_text(sStringInList, 3, 0.1))
          puts2("Found #{sStringInList} in the list")
        else
          puts2("Did NOT find #{sStringInList} in the list")
        end

      end # Loop

      puts2("Elapsed time = " + calc_elapsed_time(tStartTime))

    rescue => e

      puts2("*** ERROR and Backtrace: " + e.message + "\n" + e.backtrace.join("\n"), "ERROR")

      # Close the browser
      browser.close

      # Raise the error with a custom message after the rest of the rescue actions
      raise("*** TESTCASE - test_WebPage_011_wait_until_text")

    ensure

      # Close the browser
      browser.close

    end # Start local browsers

  end # End of test method - test_WebPage_011_wait_until_text

  #===========================================================================#
  # Testcase method: test_WebPage_012_scroll_element_intoview
  #
  # Description: Test methods: scroll_element_intoview()
  #===========================================================================#
  def test_WebPage_012_scroll_element_intoview

    puts2("")
    puts2("#######################")
    puts2("Testcase: test_WebPage_012_scroll_element_intoview")
    puts2("#######################")

    #$VERBOSE = true
    #$DEBUG = true
    iDelay = 2

    # Define components of  the URL for the WatirWorks HTML Tags web page
    sProtocol = "file:///"
    sRootURL =Dir.pwd
    sPage = "data/html/html_tags.html"

    # Construct the URL
    sURL = sProtocol  + sRootURL + "/" + sPage

    begin # Start local browsers

      puts2("Create a new local Browser Object")
      #browser = Watir::Browser.new
      browser = start_browser($sDefaultBrowser)
      sleep 2

      puts2("\nLoad the WatirWorks HTML tags page")
      browser.goto(sURL)
      sleep iDelay
      puts2("Current URL: " + browser.url)

      # Set initial values
      aView = ["button", "checkbox", "image", "link", "map", "radio", "select_list", "text_field"]

      # Loop
      aView.each do | sElement |

        # Scroll the last element into view
        puts2("\nScrolling the last #{sElement} into view")
        bStatus = browser.scroll_element_intoview(sElement)
        if(bStatus)
          puts2("...Passed")
        else
          puts2("...Failed")
        end

        # Scroll the first element into view
        puts2("Scrolling the first #{sElement} into view")
        bStatus = browser.scroll_element_intoview(sElement, false)

        if(bStatus)
          puts2("...Passed")
        else
          puts2("...Failed")
        end

      end # Loop

    rescue => e

      puts2("*** ERROR and Backtrace: " + e.message + "\n" + e.backtrace.join("\n"), "ERROR")

      # Close the browser
      browser.close

      # Raise the error with a custom message after the rest of the rescue actions
      raise("*** TESTCASE - test_WebPage_012_scroll_element_intoview")

    ensure

      # Close the browser
      browser.close

    end # Start local browsers

  end # End of test method - test_WebPage_012_scroll_element_intoview

  #===========================================================================#
  # Testcase method: test_WebPage_019_show_html_tag_attributes
  #
  # Description: Test methods: show_html_tag_attributes()
  #
  # TODO - browser.show_html_tag_attributes(["image", "button"]) # : NotImplementedError: not currently supported by WebDriver
  #===========================================================================#
  def test_WebPage_019_show_html_tag_attributes

    puts2("")
    puts2("#######################")
    puts2("Testcase: test_WebPage_019_show_html_tag_attributes")
    puts2("#######################")

    #$VERBOSE = true
    #$DEBUG = true
    iDelay = 2

    # Define components of  the URL for the WatirWorks HTML Tags web page
    sProtocol = "file:///"
    sRootURL =Dir.pwd
    sPage = "data/html/html_tags.html"

    # Construct the URL
    sURL = sProtocol  + sRootURL + "/" + sPage

    begin # Start local browsers

      puts2("Create a new local Browser Object")
      #browser = Watir::Browser.new
      browser = start_browser($sDefaultBrowser)
      sleep 2

      puts2("\nLoad the WatirWorks HTML tags page")
      browser.goto(sURL)
      sleep iDelay
      puts2("Current URL: " + browser.url)

      puts2("\n######################################")
      puts2("### Test with single string")
      puts2("######################################")
      # Show attributes for only image HTML tags
      #browser.show_html_tag_attributes("image") # : NotImplementedError: not currently supported by WebDriver # : NotImplementedError: not currently supported by WebDriver
      browser.show_html_tag_attributes("button")
      puts2("\n######################################")
      puts2("### Test with array of two strings")
      puts2("######################################")
      # Show attributes for only two types of HTML tags
      browser.show_html_tag_attributes(["checkbox", "button"]) # : NotImplementedError: not currently supported by WebDriver

      puts2("\n######################################")
      puts2("### Skipping Test with string of - ALL")
      puts2("######################################")
      # Show attributes for all HTML tags
      #browser.show_html_tag_attributes("ALL")

      puts2("\n######################################")
      puts2("### Skipping Test with array of one string of- alL")
      puts2("######################################")
      # Show attributes for all HTML tags
      #browser.show_html_tag_attributes(["alL"])

      puts2("\n######################################")
      puts2("### Test with no passed parameter")
      puts2("######################################")
      # Show attributes for all HTML tags
      browser.show_html_tag_attributes()

    rescue => e

      puts2("*** ERROR and Backtrace: " + e.message + "\n" + e.backtrace.join("\n"), "ERROR")

      # Close the browser
      browser.close

      # Raise the error with a custom message after the rest of the rescue actions
      raise("*** TESTCASE - test_WebPage_019_show_html_tag_attributes")

    ensure

      # Close the browser
      browser.close

    end # Start local browsers

  end # End of test method - test_WebPage_019_show_html_tag_attributes

  #===========================================================================#
  # Testcase method: test_WebPage_020_generate_testcode_html_tag_attributes
  #
  # Description: Test methods: generate_testcode_html_tag_attributes()
  #===========================================================================#
  def test_WebPage_020_generate_testcode_html_tag_attributes

    puts2("")
    puts2("#######################")
    puts2("Testcase: test_WebPage_020_generate_testcode_html_tag_attributes")
    puts2("#######################")

    #$VERBOSE = true
    #$DEBUG = true
    iDelay = 2

    # Define components of  the URL for the WatirWorks HTML Tags web page
    sProtocol = "file:///"
    sRootURL =Dir.pwd
    sPage = "data/html/html_tags.html"

    # Construct the URL
    sURL = sProtocol  + sRootURL + "/" + sPage

    begin # Start local browsers

      puts2("Create a new local Browser Object")
      #browser = Watir::Browser.new
      browser = start_browser($sDefaultBrowser)
      sleep 2

      puts2("\nLoad the WatirWorks HTML tags page")
      browser.goto(sURL)
      sleep iDelay
      puts2("Current URL: " + browser.url)

      browser.generate_testcode_html_tag_attributes("all", "myBrowser")
      browser.generate_testcode_html_tag_attributes(["text_field", "select_list"], "myBrowser")

    rescue => e

      puts2("*** ERROR and Backtrace: " + e.message + "\n" + e.backtrace.join("\n"), "ERROR")

      # Close the browser
      browser.close

      # Raise the error with a custom message after the rest of the rescue actions
      raise("*** TESTCASE - test_WebPage_020_generate_testcode_html_tag_attributes")

    ensure

      # Close the browser
      browser.close

    end # Start local browsers

  end # End of test method - test_WebPage_020_generate_testcode_html_tag_attributes

end # end of Class - Unittest_WebPage
