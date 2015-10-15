#--
#=============================================================================#
# File: watirworks_unittest_testsuite.rb
#
#  Copyright (c) 2008-2015, Joe DiMauro
#  All rights reserved.
#
#
# Description:  This script performs the following:
#                    a) Defines global variables that are shared among the tests in this testsuite.
#                    b) Starts a log file that's shared among the tests in this testsuite.
#                    c) Starting at the directory where this file resides it transverses the directory 
#                       tree collecting an alpha sorted list (a-z) of test files
#                       (files ending in *_unittest.rb) and executes each test file.
#
#=============================================================================#

#=============================================================================#
# Require and Include section
# Entries for additional files or methods needed by this testsuite
#=============================================================================#

# Ruby
require 'rubygems' # Precaution if the O/S Env Variable RUBYOPT = -rubygems was NOT set
require 'find'  # Methods to locate OS files.

$bUseWebDriver = true
$sDefaultBrowser = "firefox"
#$sDefaultBrowser = "ie"
#$sDefaultBrowser = "chrome"
#$sDefaultBrowser = "opera"
#$sDefaultBrowser = "android"

# WatirWorks
require 'watirworks'  # The WatirWorks library loader
include WatirWorks_Utilities      #  WatirWorks General Utilities

#=============================================================================#
# Global Variables section
# Set global variables that will be inherited by each of the test files
#=============================================================================#

# Ruby global variables
#======================
# Set the Ruby variable $VERBOSE to true for help in debugging scripts
$VERBOSE = false
#
# Set the Ruby variable $DEBUG to true for help in debugging scripts
$DEBUG = false


# Watir-Webdriver global variables
#=======================
# Set the Watir variable $FAST_SPEED to true to type fast, or false to type at normal speed
$FAST_SPEED = true
#
# Set the Watir variable $HIDE_IE to true to run the IE Browser process
# without a visible GUI, or to false to run IE visible
$HIDE_IE = false

# WatirWorks global variables
#============================
# Clear the WatirWorks flag since no logger has been started yet
$bLoggerStarted = false

# Set the WatirWorks variable to filter out tests to exclude in this test run.
# Set the same variable in each individual test.
# Only tests matching this setting will be included in this run.
bIncludeInSuite = true

# Set the WatirWorks sRun_TestType variable to your choice of tests to launch
# for this test run . Define any types you like and add a local variable
# (sRun_TestType = "sMyType") in your individual tests.
# Only tests matching this setting will be run.
# ("" = ignore setting)
sRun_TestType = "nobrowser"
#sRun_TestType = "browser"
#sRun_TestType = ""

# Set the WatirWorks iRun_TestLevel variable to your choice of test level to launch
# for this test run. Set the level (1-5) as a local variable (iRun_TestLevel = iMyLevel)
# setting in your individual tests.
# Only tests with a level <= this setting will be run.
# (0 = ignore setting)(1=highest level, 5 = lowest level)
iRun_TestLevel = 0

# Application Under Test global variables
#
#=============================================================================#

#=============================================================================#
# Main code section
#=============================================================================#

# Create a Global logger object for use by all tests launched from this testsuite
#$logger = capture_results()  # Not running a logger for the unit test

# Minimize the Ruby Console window
minimize_ruby_console()

# Collect list of possible files to run
aMyTestList = create_file_list("_unittest.rb")

# Display the number of test files
puts2("\nNumber of Test files found: " + aMyTestList.length.to_s)

# Display the list of test files
puts2 aMyTestList
puts2("")

# Filter the file list
aMyTestList = filter_file_list(aMyTestList, bIncludeInSuite, 0, 100, true)
aMyTestList = filter_file_list(aMyTestList, sRun_TestType, 0, 100, true)
aMyTestList = filter_file_list(aMyTestList, iRun_TestLevel, 0, 100, true)

# Display the number of remaining test files
puts2("\nNumber of Test files to run: " + aMyTestList.length.to_s)

# Display the list of test files that will be run
puts2 aMyTestList
puts2("")

# Execute each test file in the list (A-Z)
aMyTestList.each {|sTestfile| require sTestfile}