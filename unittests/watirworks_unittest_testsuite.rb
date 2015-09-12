#--
#=============================================================================#
# File: watirworks_unittest_testsuite.rb
#
#  Copyright (c) 2008-2015, Joe DiMauro
#  All rights reserved.
#
#
# Description:  This script performs the following:
#                    a) Defines global variables shared among the tests in this testsuite.
#                    b) Starts a log file that's shared among the tests in this testsuite.
#                    c) Starting at the directory where this file resides it transverses the directory and
#                       its sub-directory tree collecting an alpha sorted list (a-z) of test files
#                       (files ending in *_unittest.rb) and then executes each test file.
#
# Instructions: 1. Copy this file into the parent directory containing your test files
#               2. Edit the global variable definitions in this file as needed for the test run
#               3. Execute this file (see details below).
#
# Execution:   To run your Testsuite (e.g. Testsuite.rb):
#                 a) From ScITE:
#                      1. Open your Testsuite.rb in ScITE (Right click on the .rb file & select Edit)
#                      2. From the ScITE tool select Tools > Go  or press F5
#                 b) From a DOS Command Console window:
#                      1. Change directory (cd) to the location of your Testsuite.rb
#                      2. To run and re-direct stdout (1) & stderr (2) to a text file:
#                              ruby Testsuite.rb >> stdout.txt 2>&1
#                 c) From an Cygwin window:
#                      1. Change directory (cd) to the location of your Testsuite.rb
#                      2. To run in the background and re-direct stdout ($1) & stderr ($2) to a text file:
#                               ruby Testsuite.rb $1$2 >> stdout.txt &
#
# Analysis:       View the contents of the time-stamped logfile (that will be created in
#                 the ./results sub-directory), and the stdout for any failures.
#
#                 Note: If the Testsuite or individual Test files re-run the previous results directory will
#                       be renamed with an appended time-stamped.
#
#
# Restrictions:
#                Neither this file, the *_test.rb nor  the *_lib.rb files may reside at the top
#                level of the file system.
#
#                Only Testsuite files should end with _testuite.rb
#                Only Test files should end with _test.rb
#
#                Test files must reside in the same directory or a sub-directory of their testsuite file.
#                Test files must end with _test.rb in order to be included for execution in the testsuite.
#
#                Individual test files should NOT open their Browser of Log file directly, but
#                should use the methods startBrowser() or startLogger(). This will ensure that the tests
#                can be run either collectively as a part of a testsuite, or individually apart of a testsuite,
#                and still have access to a log file, and a single results sub-directory.
#
#                Individual test files should NOT CLOSE the log file!
#
#                Individual test files should inherit the settings of any global variables
#                from the testsuite that launched them.
#
#=============================================================================#

#=============================================================================#
# Require and Include section
# Entries for additional files or methods needed by this testsuite
#=============================================================================#

# Ruby
require 'rubygems' # Precaution if the O/S Env Variable RUBYOPT = -rubygems was NOT set
require 'find'  # Require the Ruby's Find method
include Enumerable
include Find

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


# Watir global variables
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

# Not running a logger for the unit test

# Minimize the Ruby Console window
#minimize_ruby_console()

#=======================================
# Collect list of possible files to run
#=======================================

# Define the array to hold the list of test files
aMyTestList = []

# Loop through the directory and sub-directories using the find command to collect
# the list of files. Weeding out the numerous pathnames that don't end with a valid
# test file name (files ending  with _test.rb).
Find.find('./') do |path|

  # Convert the relative paths to full path names
  path = File.expand_path(path)


  # Convert Enumerable to string
  sPath = File.path(path)
  if ($VERBOSE== true)
     puts2("Current Path = " + sPath)
  end

  # Append each valid test file that's found to the array
   if (sPath.include?("_test.rb"))
      aMyTestList << sPath
   end

end # END - Loop through the directory and sub-directories

# Sort the list (A-Z)
aMyTestList.sort!

#=======================================================#
# Determine if file list needs to be pruned
#=======================================================#
if((sRun_TestType != "") | (iRun_TestLevel != 0))

  # Display the number of test files
  puts2("\nNumber of Test files found: " + aMyTestList.length.to_s)

  # Display the alpha sorted list of all test files
  puts2 aMyTestList
  puts2("")

else
  puts2("Ignoring settings for: sRun_TestType and iRun_TestLevel")
end


#=============================================================#
# Prune the test file list based on the sRun_TestType setting
#=============================================================#
if(sRun_TestType != "")

  # Define the array to hold the list of files to run
  aTestTypeListToRun =[]

  puts2("Removing all tests without sRun_TestType = " + sRun_TestType)

  # Loop through the files in the list
  aMyTestList.each do | sTestFile |

    if($VERBOSE == true)
      puts2("\nChecking file: " + sTestFile)
    end

    # Find matches in the current file (only check the 1st 100 lines in the file)
    aMyMatches = get_text_from_file("sRun_TestType", sTestFile, 0, 100)

    if($VERBOSE == true)
      puts2("Parasing file search results")
    end

    # Loop through results array of the search
    aMyMatches.each do | aMatch |

      if($VERBOSE == true)
        puts2("Match found: " + aMatch[0].to_s)
      end

      # Match found
      if(aMatch[0] != true)

        if($VERBOSE == true)
          puts2(" Skipping tests w/o matching variable string: " + sTestFile)
          sLine = "#"
        end

      else

        # Get the 1st match
        sLine = aMatch[2].to_s

        if($VERBOSE == true)
          puts2(" Line: " + sLine)
        end


      end # Loop through results of search

      # Remove any commented out lines
      sLine = sLine.prefix("#")

      # Cleanup the line
      sLine = sLine.delete"\"" # Remove double quotes
      sLine = sLine.delete"\'" # Remove single quotes
      sLine = sLine.delete" "  # Remove whitespace

      # Save the setting portion of the line
      sSetting = sLine.suffix("=")

      if($VERBOSE == true)
        puts2(" Setting: " + sSetting)
      end

      # Determine to keep or drop the test file
      if(sSetting.downcase != sRun_TestType)
        if($VERBOSE == true)
          puts2(" Dropping test file: " + sTestFile)
        end


      else

        if($VERBOSE == true)
          puts2(" Keeping test file: " + sTestFile)
        end

        # Add it to the list
        aTestTypeListToRun << sTestFile

      end # Determine to keep or drop the test file

    end # Match found

    # Re-populate the array with the remaining files to run
    aMyTestList = aTestTypeListToRun

  end # Loop through the files in the list

end # Prune the test file list based on the sRun_TestType settings

#=============================================================#
# Prune the test file list based on the iRun_TestLevel setting
#=============================================================#
if(iRun_TestLevel != 0)

  # Define the array to hold the list of files to run
  aTestLevelListToRun =[]

  puts2("Removing all tests with iRun_TestLevel < " + iRun_TestLevel.to_s)

  # Loop through the files in the list
  aMyTestList.each do | sTestFile |

    if($VERBOSE == true)
      puts2("\nChecking file: " + sTestFile)
    end

    # Find matches in the current file (only check the 1st 50 lines in the file)
    aMyMatches = get_text_from_file("iRun_TestLevel", sTestFile, 0, 50)

    if($VERBOSE == true)
      puts2("Parasing file search results")
    end

    # Loop through results array of the search
    aMyMatches.each do | aMatch |

      if($VERBOSE == true)
        puts2("Match found: " + aMatch[0].to_s)
      end

      # Match found
      if(aMatch[0] != true)

        if($VERBOSE == true)
          puts2(" Skipping tests w/o matching variable string: " + sTestFile)
          sLine = "#"
        end

      else

        # Get the 1st match
        sLine = aMatch[2].to_s

        if($VERBOSE == true)
          puts2(" Line: " + sLine)
        end


      end # Loop through results of search

      # Remove any commented out lines
      sLine = sLine.prefix("#")

      # Cleanup the line
      sLine = sLine.delete"\"" # Remove double quotes
      sLine = sLine.delete"\'" # Remove single quotes
      sLine = sLine.delete" "  # Remove whitespace

      # Save the setting portion of the line
      sSetting = sLine.suffix("=")

      if($VERBOSE == true)
        puts2(" Setting: " + sSetting)
      end

      # Convert the string to an integer
      iSetting = sSetting.to_i

      # Determine to keep or drop the test file
      if(iSetting > iRun_TestLevel)

        if($VERBOSE == true)
          puts2(" Dropping test file: " + sTestFile)
        end

      else

        if($VERBOSE == true)
          puts2(" Keeping test file: " + sTestFile)
        end

        # Add it to the list
        aTestLevelListToRun << sTestFile

      end # Determine to keep or drop the test file

    end # Match found

    # Re-populate the array with the remaining files to run
    aMyTestList = aTestLevelListToRun

  end # Loop through the files in the list

end # Prune the test file list based on the sRun_TestLevel settings

#=============================================================#

# Display the number of test files
puts2("\nNumber of Test files to run: " + aMyTestList.length.to_s)

# Display the alpha sorted list of test files that will be run
puts2 aMyTestList
puts2("")

# Execute each test file in the list (A-Z)
aMyTestList.each {|sTestfile| require sTestfile}
