#=============================================================================#
# File: watirworks_utilities.rb
#
#  Copyright (c) 2008-2016, Joe DiMauro
#  All rights reserved.
#
# Description: Functions and methods for WatirWorks
#    These functions and methods are application and platform independent, and
#    are NOT specific to Web based applications.
#    Extends some Ruby or Watir classes with additional, hopefully useful, methods.
#
#    Some of these methods and functions have been collected from, or based upon
#    Open Source versions found on various sites in the Internet, and are noted.
#
#--
# Modules:
#    WatirWorks_Utilities
#
# Classes Added or Extended:
#    Array
#    Fixnum
#    Numeric
#    String
#    WatirWorksLogger
#
#++
#=============================================================================#

#=============================================================================#
# Require and Include section
# Entries for additional files or methods needed by these methods
#=============================================================================#
require 'rubygems'
require 'logger'  # The Ruby logger which is the basis for the WatirWorksLogger

# WatirWorks
require 'watirworks'

include WatirWorks_RefLib #  WatirWorks Reference data module

#=============================================================================#
# Module: WatirWorks_Utilities
#=============================================================================#
#
# Description: Functions and methods for WatirWorks
#    These functions and methods are application and platform independent, and
#    are NOT specific to Web based applications.
#    Extends some Ruby or Watir classes with additional, hopefully useful, methods.
#
#    Some of these methods and functions have been collected from, or based upon
#    Open Source versions found on various sites in the Internet, and are noted.
#
#
# Instructions: To use these methods in your scripts add these commands:
#                        require 'watirworks'
#                        include WatirWorks_Utilities
#--
# Table of Contents
#
#  Please manually update this TOC with the alphabetically sorted names of the items in this module,
#  and continue to add new methods alphabetically into their proper location within the module.
#
#  Key:   () = No parameters,  (...) = parameters required
#
# Methods:
#   calc_datestrings()
#   calc_elapsed_time(...)
#   capture_results(...)
#   compare_files(...)
#   compare_strings_in_arrays(...)
#   convert_date(...)
#   create_file_list(...)
#   create_subdirectory(...)
#   display_ruby_env(...)
#   display_ruby_environment()
#   display_watir_env()
#   display_watirworks_env(...)
#   display_OSVersion()
#   filter_file_list(...)
#   find_folder_in_tree(...)
#   find_tmp_dir()
#   format_elapsed_time(...)
#   getenv(...)
#   get_text_from_file(...)
#   get_watirworks_install_path()
#   get_windows()
#   is_java?()
#   is_linux?()
#   is_mac?()
#   is_osx?(...)
#   is_win?(...)
#   is_win32?()
#   is_win64?()
#   is_minimized?(...)
#   is_webdriver()
#   minimize_ruby_console()
#   parse_ascii_file(...)
#   parse_data_array(...)
#   parse_dictionary()
#   parse_csv_file(...)
#   parse_spreadsheet()
#   parse_workbook()
#   printenv(...)
#   puts2(...)
#   random_alphanumeric(...)
#   random_boolean()
#   random_char(...)
#   random_chars(...)
#   random_number(...)
#   random_paragraph(...)
#   random_pseudowords(...)
#   random_sentence(...)
#   random_word(...)
#   send_email_smtp(...)
#   setenv(...)
#   start_logger(...)
#   watchlist(...)
#   which_os()
#
# Pre-requisites:
# ++
#=============================================================================#
module WatirWorks_Utilities

  # Version of this module
  WW_UTILITIES_VERSION =  "1.0.16"

  # Format to use when appending a timestamp to file names
  DATETIME_FILEFORMAT="%Y_%m_%d_%H%M%S"

  # Name of WatirWorks default data directory
  DATA_DIR = "data"

  # Name of WatirWorks default results directory
  RESULTS_DIR = "results"

  #  Define the WatirWorks Global logger variable to suppress messages when $VERBOSE is true
  $logger = nil

  #  Define the WatirWorks Global dictionary variable to suppress messages when $VERBOSE is true
  $Dictionary = nil
  #=============================================================================#
  #--
  # Method: calc_datestrings()
  #++
  #
  # Description: Calculates various date strings (past, present and future)
  #              based on the current date in the format mm/dd/yyyy.
  #              The calculated date strings are put into a hashed array, which is returned.
  #
  # Returns: HASH - Containing STRING representations of the various dates.
  #                 To access a STRING in the HASH use any of the following keys:
  #                     TODAY
  #                     TOMORROW
  #                     YESTERDAY
  #                     7DAYS_FUTURE
  #                     7DAYS_PAST
  #                     30DAYS_FUTURE
  #                     30DAYS_PAST
  #                     60DAYS_FUTURE
  #                     60DAYS_PAST
  #                     ONEYEAR_FUTURE
  #                     ONEYEAR_PAST
  #
  # Usage Examples:
  #                aMyWorkingDates = calc_datestrings
  #                sYESTERDAY = aMyWorkingDates["YESTERDAY"]
  #                s60DAYS_AGO = aMyWorkingDates["60DAYS_PAST"]
  #
  #                 or:
  #
  #                sYESTERDAY = calc_datestrings["YESTERDAY"]
  #                s60DAYS_AGO = calc_datestrings["60DAYS_PAST"]
  #
  #=============================================================================#
  def calc_datestrings()

    # Grab the current date time
    tNow = Time.now

    # Define the time format to be used in file names: e.g. 01/02/2007
    sDateformat="%m/%d/%Y"

    sTODAY = tNow.strftime(sDateformat)
    sTOMORROW = (tNow + (60 * 60 * 24 * 1)).strftime(sDateformat)
    sYESTERDAY = (tNow - (60 * 60 * 24 * 1)).strftime(sDateformat)
    sDAYS_FUTURE_7 = (tNow + (60 * 60 * 24 * 7)).strftime(sDateformat)
    sDAYS_PAST_7 = (tNow - (60 * 60 * 24 * 7)).strftime(sDateformat)
    sDAYS_FUTURE_30 = (tNow + (60 * 60 * 24 * 30)).strftime(sDateformat)
    sDAYS_PAST_30 = (tNow - (60 * 60 * 24 * 30)).strftime(sDateformat)
    sDAYS_FUTURE_60 = (tNow + (60 * 60 * 24 * 60)).strftime(sDateformat)
    sDAYS_PAST_60 = (tNow - (60 * 60 * 24 * 60)).strftime(sDateformat)
    sDAYS_FUTURE_90 = (tNow + (60 * 60 * 24 * 90)).strftime(sDateformat)
    sDAYS_PAST_90 = (tNow - (60 * 60 * 24 * 90)).strftime(sDateformat)
    sDAYS_FUTURE_365 = (tNow + (60 * 60 * 24 * 365)).strftime(sDateformat)
    sDAYS_PAST_365 = (tNow - (60 * 60 * 24 * 365)).strftime(sDateformat)
    sWEEKS_FUTURE_1 = (tNow - (60 * 60 * 24 * 7 * 1)).strftime(sDateformat)
    sWEEKS_FUTURE_2 = (tNow - (60 * 60 * 24 * 7 * 2)).strftime(sDateformat)
    sWEEKS_FUTURE_4 = (tNow - (60 * 60 * 24 * 7 * 4)).strftime(sDateformat)
    sWEEKS_FUTURE_8 = (tNow - (60 * 60 * 24 * 7 * 8)).strftime(sDateformat)
    sWEEKS_FUTURE_12 = (tNow - (60 * 60 * 24 * 7 * 12)).strftime(sDateformat)
    sWEEKS_FUTURE_52 = (tNow - (60 * 60 * 24 * 7 * 52)).strftime(sDateformat)
    sWEEKS_PAST_1 = (tNow - (60 * 60 * 24 * 7 * 1)).strftime(sDateformat)
    sWEEKS_PAST_2 = (tNow - (60 * 60 * 24 * 7 * 2)).strftime(sDateformat)
    sWEEKS_PAST_4 = (tNow - (60 * 60 * 24 * 7 * 4)).strftime(sDateformat)
    sWEEKS_PAST_8 = (tNow - (60 * 60 * 24 * 7 * 8)).strftime(sDateformat)
    sWEEKS_PAST_12 = (tNow - (60 * 60 * 24 * 7 * 12)).strftime(sDateformat)
    sWEEKS_PAST_52 = (tNow - (60 * 60 * 24 * 7 * 52)).strftime(sDateformat)

    hDateStringHash = {
      "TODAY" => sTODAY,
      "TOMORROW" => sTOMORROW,
      "YESTERDAY" => sYESTERDAY,
      "DAYS_FUTURE_7" => sDAYS_FUTURE_7,
      "DAYS_PAST_7" => sDAYS_PAST_7,
      "DAYS_FUTURE_30" => sDAYS_FUTURE_30,
      "DAYS_PAST_30" => sDAYS_PAST_30,
      "DAYS_FUTURE_60" => sDAYS_FUTURE_60,
      "DAYS_PAST_60" => sDAYS_PAST_60,
      "DAYS_FUTURE_90" => sDAYS_FUTURE_90,
      "DAYS_PAST_90" => sDAYS_PAST_90,
      "DAYS_FUTURE_365" => sDAYS_FUTURE_365,
      "DAYS_PAST_365" => sDAYS_PAST_365,
      "WEEKS_FUTURE_1" => sWEEKS_FUTURE_1,
      "WEEKS_FUTURE_2" => sWEEKS_FUTURE_2,
      "WEEKS_FUTURE_4" => sWEEKS_FUTURE_4,
      "WEEKS_FUTURE_8" => sWEEKS_FUTURE_8,
      "WEEKS_FUTURE_12" => sWEEKS_FUTURE_12,
      "WEEKS_FUTURE_52" => sWEEKS_FUTURE_52,
      "WEEKS_PAST_1" => sWEEKS_PAST_1,
      "WEEKS_PAST_2" => sWEEKS_PAST_2,
      "WEEKS_PAST_4" => sWEEKS_PAST_4,
      "WEEKS_PAST_8" => sWEEKS_PAST_8,
      "WEEKS_PAST_12" => sWEEKS_PAST_12,
      "WEEKS_PAST_52" => sWEEKS_PAST_52
    }

    return hDateStringHash

  end # Function - calc_datestrings

  #=============================================================================#
  #--
  # Method: calc_elapsed_time(...)
  #++
  #
  # Description: Calculates the duration of an event based on the specified start time.
  #
  # Returns: STRING - Elapsed time as a string
  #
  # Syntax: tStarttime = TIME object - The starting time of the event to be timed
  #         bFormat = BOOLEAN - true to format like 0 weeks, 0 days, 0 hours, 2 minutes, 4.015612 seconds
  #                             false to leave a total number of seconds
  #
  # Usage Example: tStartTime = Time.new
  #                    puts2("Start time = " + tStartTime.to_s)
  #                    # Do some stuff, run a test,  sleep 4  or whatever
  #                    puts2("Elapsed time = " + calc_elapsed_time(tStartTime))
  #                    #> 4.015612
  #                    puts2("Elapsed time = " + calc_elapsed_time(tStartTime, true))
  #                    #> 0 weeks, 0 days, 0 hours, 0 minutes, 4.015612 seconds
  #
  #=============================================================================#
  def calc_elapsed_time(tStartTime, bFormat=false)

    #$VERBOSE = true

    # Get the end time for this test case
    tEndTime=Time.now

    # Calculate the run time
    fDiff = tEndTime - tStartTime  # Subtraction of two TIME objects results in a FLOAT

    if(bFormat == false)
      return fDiff.to_s
    else
      return format_elapsed_time(fDiff)
    end

  end # Function - calc_elapsed_time(...)

  #=============================================================================#
  #--
  # Method: capture_results(...)
  #
  #++
  #
  # Description: Creates a specified sub-directory in either the Operating systems's
  #              temporary directory or the Current Working Directory in order to
  #              hold the results of this test run, and start a logger,
  #              which in turn opens a timestamped log file within that directory.
  #
  #              Any pre-existing results sub-directory is renamed by appending a time stamp
  #              to the sub-directories name. Thus allowing the current test run's results to always be saved
  #              to the same specified sub-directory name, without overwriting any previous results.
  #
  # Returns: LOGGER object
  #
  # Syntax: bTmpDir = BOOLEAN - true = Create the  directory "watirworks/results/" in the Operating systems's temporary directory
  #                                               false = Create the  directory "results/" in the Current Working Directory
  #
  #         sResultsDirName = STRING - Name of the results directory ( Default value is RESULTS_DIR)
  #
  #         sLogfilePrefix = STRING - Prefix of the name of the log directory.
  #                                   A timestamp (e.g. "%Y_%m_%d_%H%M%S") and a ".log" suffix will be
  #                                   appended to this value to make up the log files name.
  #                                   (default value is "logfile")
  #
  #         iLogsToKeep = INTEGER -  The total number of log files that can be saved.
  #                                  When the current log file reaches the maxLogSize a new file is opened.
  #                                  (e.g. 10 = keep up to 10 log files)
  #                                  (default value is 50)
  #
  #          iMaxLogSize = INTEGER - The file size in bytes for any individual log file. Once this
  #                                  value is reached a new log file is opened.
  #                                  (e.g. 1000000 = 1Mb)
  #                                  (default value is 5000000)
  #
  #          sLogLevel = STRING - The message level. One of the following (Per the Ruby Core API):
  #                                Messages have varying levels (info, error, etc), reflecting their varying importance.
  #                                The levels, and their meanings, are:
  #                                   FATAL: An unhandleable error that results in a program crash
  #                                   ERROR: A handleable error condition
  #                                   WARN: A warning
  #                                   INFO: generic (useful) information about system operation
  #                                   DEBUG: low-level information for developers
  #
  #                                (default value is "INFO")
  #
  # Calls: create_subdirectory()
  #          LoggerFactory.start_default_logger()
  #
  #=============================================================================#
  def capture_results(bTmpDir=true, sResultsDirName=RESULTS_DIR, sLogfilePrefix="logfile", iLogsToKeep=50, iMaxLogSize= 5000000, sLogLevel="INFO")

    if($VERBOSE == true)
      puts2("Parameters - capture_results:")
      puts2("  bTmpDir: " + bTmpDir.to_s)
      puts2("  sResultsDirName: " + sResultsDirName)
      puts2("  sLogfilePrefix: " + sLogfilePrefix)
      puts2("  iLogsToKeep: " + iLogsToKeep.to_s)
      puts2("  iMaxLogSize: " + iMaxLogSize.to_s)
      puts2("  sLogLevel: " + sLogLevel)
    end

    # Don't allow a blank values
    if((sResultsDirName == "") | (sResultsDirName == nil))
      sResultsDirName = "results"
    end

    if((sLogfilePrefix == "") |  (sLogfilePrefix == nil))
      sLogfilePrefix="logfile"
    end

    if((iLogsToKeep < 1) |  (iLogsToKeep > 1000))
      iLogsToKeep=50
    end

    if((iMaxLogSize < 1) |  (iMaxLogSize > 100000000))
      iMaxLogSize=5000000
    end

    if((sLogLevel == "") | (sLogLevel == nil))
      sLogLevel = "INFO"
    end

    # Only one Global logger object can exist
    # If a Global Logger is NOT open proceed
    if(($logger.nil?)  == true)

      # Save the current working directory
      sStartingDir = Dir.getwd

      # Find the proper temporary directory for the current OS
      sTmpDirPath = find_tmp_dir()

      # Define the name of Global WatirWorks directory
      # to be created in the OS's Temporary directory to hold any test results
      $sTmpWatirWorks_Dir = "watir_works"

      # Change directories to the temporary directory for the current OS
      if(bTmpDir)
        Dir.chdir sTmpDirPath

        if(File.exists?($sTmpWatirWorks_Dir) == false)
          # Creates a subdirectory to hold the results
          create_subdirectory($sTmpWatirWorks_Dir)
        end

        # Change directories to the watirworks directory within the temporary directory for the current OS
        Dir.chdir($sTmpWatirWorks_Dir)

      end # Change directories to the temporary directory for the current OS

      puts2("\nCreating results sub-directory: " + sResultsDirName)

      # Creates a subdirectory to hold the results
      create_subdirectory(sResultsDirName)

      # Define variables for the log file
      sTimeStamp = Time.now.strftime(DATETIME_FILEFORMAT)

      sLogfileName = sLogfilePrefix + "_" + sTimeStamp + ".log"

      # Combine the elements of the full pathname to the log file
      sLogfilePartialPathname = File.join(sResultsDirName, sLogfileName)

      sFullPathToFile = File.join(Dir.getwd, sLogfilePartialPathname)

      # Change directories to the watirworks/results directory within the temporary directory for the current OS
      Dir.chdir sResultsDirName
      $sLoggerResultsDir = Dir.getwd

      # Restore the original the working directory
      if(bTmpDir)
        Dir.chdir sStartingDir
      end

      puts2(" Starting new logger object for Log file: " + sFullPathToFile) # Write string to stdout (console)

      # Create the LOGGER object, which in turn creates the log file
      myLogger = start_logger(sFullPathToFile, iMaxLogSize, iMaxLogSize, sLogLevel)

      return myLogger

    else
      if($VERBOSE == true)
        puts2(" Global logger object already started.")
      end
      return $logger
    end # Only one Global logger object can exist

  end # Method - capture_results()

  #=============================================================================#
  #--
  # Method: compare_files(...)
  #++
  #
  # Description: Compares two files to see if they are identical.
  #
  #              If two files differ, their size or other file attributes may
  #              also differ, so compare the file attributes first. If they
  #              pass and both are regular files then compare their contents.
  #
  #              Based on code from the Ruby Cookbook, Section 6.10, page 209
  #                 http://oreilly.com/catalog/9780596523695
  #
  # Returns: BOOLEAN - true if they match, otherwise false
  #
  # Syntax: sFile1 = STRING - Full pathname/filename of the first file to compare
  #         sFile2 = STRING - Full pathname/filename of the second file to compare
  #
  #=============================================================================#
  def compare_files(sFile1, sFile2)

    if($VERBOSE == true)
      puts2("Parameters - compare_files:")
      puts2("  sFile1: " + sFile1)
      puts2("  sFile2: " + sFile2)
    end

    # Start by comparing their file attributes: existence, file size, file type
    return false if(File.exists?(sFile1) != File.exists?(sFile2)) # Fail if either file's existence does not match
    return true if !File.exists?(sFile1)   # Fail since neither exist
    return true if File.expand_path(sFile1) == File.expand_path(sFile2) # Pass if they are the same file in the same location
    return false if File.ftype(sFile1) != File.ftype(sFile2) || File.size(sFile1) != File.size(sFile2) # Fail if they have different file types

    # Their file attributes match so compare their file contents
    open(sFile1) do |f1|
      open(sFile2) do |f2|
        # Determine the blocksize of the first file
        blocksize = f1.lstat.blksize

        bSame=true # Set flag to presume that the files match

        # Compare each file block until you reach the EndOfFile
        while bSame && !f1.eof? && !f2.eof?
          bSame = f1.read(blocksize) == f2.read(blocksize)
        end
        return bSame
      end
    end
  end # Method - compare_files(...)

  #=============================================================================#
  #--
  # Method: compare_strings_in_arrays(...)
  #++
  #
  # Description: Compares the String elements in one array with those in a second array
  #              and returns an array with Fixnum value of the number of exact matches,
  #              along with the matching strings.
  #
  #              If a String in one array matches two or more strings in the other array
  #              both matches will be counted. Any leading or trailing whitespace is ignored.
  #
  # Returns: ARRAY - Two element array,
  #              ARRAY[0] = FIXNUM - Count of the matches found between the two arrays.
  #              ARRAY[1] = ARRAY  - Each matching STRING
  #
  # Syntax:
  #         aArray_1 = First ARRAY of strings to compare
  #         aArray_2 = Second ARRAY of strings to compare
  #         bIgnoreCase = BOOLEAN - true = Ignore case, false = Case sensitive
  #         bExactMatch  = BOOLEAN - true = Row contents are an exact match for string (Compare as strings)
  #                                  false = Row contains the string. (Compare as Regular Expression) (Default)
  #
  # Usage Examples:
  #
  #              aFirstArray = ["the", "end", "the end", "stop"]
  #              aSecondArray = ["The end", "end", "start", "the", "Stop"]
  #
  #              puts2("Compare as strings")
  #              aFound = compare_strings_in_arrays(aFirstArray, aSecondArray)
  #              puts2(aFound.to_s)
  #
  #              puts2("Compare as strings - Ignore case")
  #              aFound = compare_strings_in_arrays(aFirstArray, aSecondArray, true)
  #              puts2(aFound.to_s)
  #
  #              puts2("Compare as Regexp - Ignore case")
  #              aFound = compare_strings_in_arrays(aFirstArray, aSecondArray, true, true)
  #              puts2(aFound.to_s)
  #
  #=============================================================================#
  def compare_strings_in_arrays(aArray_1 = nil, aArray_2 = nil, bIgnoreCase = false, bExactMatch = false)

    # Clear the match counter
    iMatchesFound = 0

    # Clear the matching text
    aMatchingText = []

    # Loop through the Strings in the first array
    aArray_1.each do | aText_1 |

      # Convert element in array to a string and remove an leading or training spaces
      sText_1 = aText_1.to_s.strip

      # Case sensitive or ignore case ?
      if(bIgnoreCase == true)
        sText_1 = sText_1.upcase
      end

      # Loop through the Strings in the second array
      aArray_2.each do | aText_2 |

        # Convert element in array to a string and remove an leading or training spaces
        sText_2 = aText_2.to_s.strip

        # Case sensitive or ignore case ?
        if(bIgnoreCase == true)
          sText_2 = sText_2.upcase
        end

        # Perform a compare between Regular Expressions?
        if(bExactMatch == true)

          # Compare the two strings
          if(sText_1.to_s.strip == sText_2.to_s.strip)

            # Increment the match counter
            iMatchesFound = iMatchesFound + 1

            # Record the matching text
            aMatchingText << sText_1

          end # Compare the two strings
        else# Perform a compare between Regular Expressions?

          # Compare the two strings as Regular Expressions
          if((sText_1 =~ /#{sText_2}/) || (sText_2 =~ /#{sText_1}/))

            # Increment the match counter
            iMatchesFound = iMatchesFound + 1

            # Record the matching text
            aMatchingText << sText_1

          end # Compare the two strings

        end # Perform a compare between Regular Expressions?

      end # Loop through the strings in the second array

    end # Loop through the strings in the first array

    return iMatchesFound, aMatchingText

  end # Method - compare_strings_in_arrays(...)

  #=============================================================================#
  #--
  # Method: convert_date(...)
  #++
  #
  # Description: Converts the specified date to a STRING format based upon the timespan from today.
  #              For a specified DATETIME object, or a STRING representation of a date (e.g. 7/6/05)
  #
  #              Based upon code at:   http://snippets.dzone.com/posts/show/487
  #
  # Returns: STRING - The converted date based on the elapsed time from today, formatted like one of the following:
  #                    'yesterday', 'today', 'tomorrow',	   # If within 1 day of today
  #                    '12 days ago', 'in 4 days',           # If within 60 days of today
  #                    'Monday, January 5'                   # If within 180 days of today
  #                    'Tuesday, December 15, 2004'          # If beyond 1080 days of today
  #
  # Syntax: dMyDate = DATE, DATETIME, or STRING - The date to be converted
  #                   Dates expressed as STRINGs must be format like:   mm/dd/yy    m/d/yyyy   m/d/yy   mm/d/yyyy
  #
  # Usage Examples: Please refer to: convert_datestrings_unittest.rb
  #
  #=============================================================================#
  def convert_date(dMyDate)

    if($VERBOSE == true)
      puts2("Parameters - convert_date:")
      puts2("  dMyDate: " + dMyDate.to_s)
    end

    require 'date'

    begin

      dMyDate = Date.parse(dMyDate, true) unless /Date.*/ =~ dMyDate.class.to_s
      iNumberOfDays = (dMyDate - Date.today).to_i

      return 'today'     if(iNumberOfDays >= 0 and iNumberOfDays < 1)

      return 'tomorrow'  if iNumberOfDays >= 1 and iNumberOfDays < 2

      return 'yesterday' if iNumberOfDays >= -1 and iNumberOfDays < 0

      return "in #{iNumberOfDays} days"      if iNumberOfDays.abs < 60 and iNumberOfDays > 0

      return "#{iNumberOfDays.abs} days ago" if iNumberOfDays.abs < 60 and iNumberOfDays < 0

      return dMyDate.strftime('%A, %B %e') if iNumberOfDays.abs < 182

      #  No match with any of the previous  syntax so return reformatted like - Thursday, April  1, 2010
      return dMyDate.strftime('%A, %B %e, %Y')

    rescue

      return "Invalid date"

    end

  end  # Method - convert_date()

  #=============================================================================#
  #--
  # Method: create_file_list(...)
  #
  #++
  #
  # Description: Creates an array containging list of files that match the specified
  #              file identification string. Can be used by a test suite to
  #              create the list of test files to run.
  #
  #
  # Prerequisite:
  #           The files may reside at the top level of the file system.
  #           The files must reside in the same directory or a sub-directory of the calling file.
  #
  # Returns: ARRAY of STRINGS = Full path the matching files
  #
  # Syntax: sFileIdentifier = STRING -  The partial flie name to add to the list.
  #         bSort = BOOLEAN = true (default) to sort list a-z, false to leave in order files were found
  #
  # Usage Examples: To create a list of test files to run:
  #        require 'watirworks'
  #        require 'find'  # Methods to locate OS files.
  #        include WatirWorks_Utilities    #  WatirWorks General Utilities
  #        aFileList = create_file_list("_test.rb", true)
  #
  #=============================================================================#
  def create_file_list(sFileIdentifier = "_test.rb", bSort = true)

    if($VERBOSE == true)
      puts2("Parameters - create_file_list:")
      puts2("  sFileIdentifier: " + sFileIdentifier.to_s)
      puts2("  bSort: " + bSort.to_s)
    end

    # Define the array to hold the list of files
    aFileList = []

    # Loop through the directory and sub-directories using the find command to collect
    # the list of files. Weeding out the numerous pathnames that don't end with a
    # matchng file name (files ending with sFileIdentifier).
    Find.find('./') do |path|

      # Convert the relative paths to full path names
      path = File.expand_path(path)

      # Convert Enumerable to string
      sPath = File.path(path)
      if($VERBOSE== true)
        puts2("Current Path = " + sPath)
      end

      # Append each valid test file that's found to the array
      if(sPath.include?(sFileIdentifier))
        aFileList << sPath
      end

    end # END - Loop through the directory and sub-directories

    if($VERBOSE == true)
      # Display the unsorted list of test files
      puts2 aFileList
      puts2("")
    end

    if(bSort == true)
      # Sort the list (A-Z)
      aFileList.sort!
    end

    if($VERBOSE == true)
      # Display the alpha sorted list of test files
      puts2 aFileList
      puts2("")
    end

    return aFileList

  end # Method - create_file_list(...)

  #=============================================================================#
  #--
  # Method: create_subdirectory(...)
  #
  #++
  #
  # Description: Creates a specified subdirectory in the Current Working Directory.
  #
  #              If the specified subdirectory pre-exists, that subdirectory is renamed
  #              by appending a timestamp to its name, before the new subdirectory is created.
  #
  #              For example the directory can then be used as a results directory
  #              to hold artifacts of a test run, such as: log files, screen captures, output files, etc.
  #
  # Prerequisite: Since a pre-existing subdirectory will be re-named NO files within it
  #               can be open or in use.
  #
  # Returns: BOOLEAN - true on success, otherwise false
  #
  # Syntax: sSubDir = STRING -  The name of the new subdirectory to be created.
  #
  #=============================================================================#
  def create_subdirectory(sSubDir="new_directory")

    if($VERBOSE == true)
      puts2("Parameters - create_subdirectory:")
      puts2("  sSubDir: " + sSubDir)
    end

    # Don't allow a blank values
    if((sSubDir == "") | (sSubDir == nil))
      sSubDir = "my_new_directory"
    end

    sFullPathToFile = File.join(Dir.getwd, sSubDir)

    if File.exists?(sFullPathToFile)
      puts2(" Pre-existing sub-directory being renamed")

      # Rename the old directory by appending a timestamp to its name
      File.rename(sSubDir, sSubDir + "_" + Time.now.strftime(DATETIME_FILEFORMAT))

    end

    puts2(" Creating sub-directory: #{sFullPathToFile}")

    # Create a new directory
    Dir.mkdir(sFullPathToFile)

    return true

  end # Method - create_subdirectory(...)

  #=============================================================================#
  #--
  # Method: display_ruby_env()
  #
  #++
  #
  # Description: Displays information about the Ruby environment.
  #              Information on the Ruby version, and platform upon which
  #              the tests are being executed is parsed from RUBY_PLATOFRM
  #
  #              Under Windows RUBY_PLATFORM reports "i386-mswin32".
  #              Under linux RUBY_PLATFORM reports "linux"
  #              Under Mac RUBY_PLATFORM reports "Darwin"
  #
  # HINT: Save to a log file along with the results of the test.
  #
  # Returns: N/A
  # Syntax:  N/A
  #
  #=============================================================================#
  def display_ruby_env()

    # Record the settings
    puts2("")
    puts2("Main Test: " + $0)
    puts2(Time.now.strftime("Start time: %a %b %d %H:%M:%S %Y"))
    puts2("\nRUBY_VERSION: " + RUBY_VERSION)
    puts2(" RUBY_PLATFORM: " + RUBY_PLATFORM)
    puts2(" RUBY_RELEASE_DATE: " + RUBY_RELEASE_DATE)

  end # Method display_ruby_env(...)

  #=============================================================================#
  #--
  # Method: display_ruby_environment()
  #
  #++
  #
  # Description: Displays information on the runtime environment:
  #                       Ruby's Version, and Platform
  #                       Ruby's loaded files
  #                       Ruby's collected O/S Variables
  #                       Ruby's Global variables
  #                       Methods that Ruby has loaded
  #
  #               Basically this is a wrapper around Ruby methods that collect info.
  #               with the added ability to print that info out.
  #
  # HINT: Useful for recording that info to a log file, or for assistance in debugging
  #
  # Returns: N/A
  #
  # Syntax: N/A
  #
  # Usage Examples:
  #                 require 'watirworks'
  #                 include WatirWorks_Utilities
  #                 display_ruby_environment()
  #
  #=============================================================================#
  def display_ruby_environment()

    # Ruby
    display_ruby_env()

    # O/S
    display_os_environment()

    # Files
    display_ruby_loaded_files()

    # Ruby Global Variables  #failing
    display_ruby_global_variables()

  end # Method - display_ruby_environment()

  #=============================================================================#
  #--
  # Method: display_ruby_global_variables()
  #
  #++
  # TypeError: can't convert Symbol into String
  #
  # Description: Displays information on the runtime environment:
  #                       Ruby's Global variables
  #
  #               Basically this is a wrapper around Ruby methods that collect info.
  #               with the added ability to print that info out.
  #
  # HINT: Useful for recording that info to a log file, or for assistance in debugging
  #
  # Returns: N/A
  #
  # Syntax: N/A
  #
  # Usage Examples:
  #                 require 'watirworks'
  #                 include WatirWorks_Utilities
  #                 display_ruby_global_variables()
  #
  #=============================================================================#
  def display_ruby_global_variables()

    # Variables
    puts2("\nRuby Global Variables: ")

    aRubyGlobalVars = global_variables()  # Populate array with the Ruby Global variables

    if($VERBOSE == true)
      puts("aRubyGlobalVars.class = " + aRubyGlobalVars.class.to_s) #  array
      puts("aRubyGlobalVars = " + aRubyGlobalVars.to_s)  # array of symbols
    end

    aRubyGlobalVars.each do |key|  # Loop through the Ruby Global variables

      if ($VERBOSE == true)
        puts2("key.class = " + key.class.to_s)
        puts2("key = " + key.to_s)
      end

      # Display the name of the Global variables
      puts2(key.to_s)

      # This does not work to display the name of the Global variables along with the value of each
      #if(eval(key).class.to_s == "String")  # TypeError: can't convert Symbol into String
      #  puts2("  #{key.to_s} = \""  + eval(key).to_s  + "\",\t  Class: "  + eval(key).class.to_s)
      #else
      #  puts2("  #{key.to_s} = "  + eval(key).to_s  + ",\t  Class: "  + eval(key).class.to_s)
      #end
    end # End of Variables loop

  end # Method - display_ruby_global_variables()

  #=============================================================================#
  #--
  # Method: display_ruby_loaded_files()
  #
  #++
  #
  # Description: Displays information on the runtime environment:
  #                       Files listed in require statements that Ruby has loaded
  #
  #               Basically this is a wrapper around Ruby methods that collect info.
  #               with the added ability to print that info out.
  #
  # HINT: Useful for recording that info to a log file, or for assistance in debugging
  #
  # Returns: N/A
  #
  # Syntax: N/A
  #
  # Usage Examples:
  #                 require 'watirworks'
  #                 include WatirWorks_Utilities
  #                 display_ruby_required_files()
  #
  #=============================================================================#
  def display_ruby_loaded_files()

    puts2("\nRuby Loaded files: ")
    $LOADED_FEATURES.each do |value|  # Loop through the files
      puts2("  #{value.to_s}")  # Display each file
    end # End of Files loop

  end # Method - display_ruby_loaded_files()

  #=============================================================================#
  #--
  # Method: display_os_environment()
  #
  #++
  #
  # Description: Displays information on the OS runtime environment vairables:
  #
  #               Basically this is a wrapper around Ruby methods that collect info.
  #               with the added ability to print that info out.
  #
  # HINT: Useful for recording that info to a log file, or for assistance in debugging
  #
  # Returns: N/A
  #
  # Syntax: N/A
  #
  # Usage Examples:
  #                 require 'watirworks'
  #                 include WatirWorks_Utilities
  #                 display_os_environment()
  #
  #=============================================================================#
  def display_os_environment()

    # O/S
    puts2("\nOS ENV Variables: ")
    ENV.each do |key, value|  # Loop through the O/S Env variables
      puts2("  #{key} = #{value}") # Display each variable and its setting
    end # End of O/S loop

  end # Method - display_os_environment()

  #=============================================================================#
  #--
  # Method: display_OSVersion()
  #
  #++
  #
  # Description: Outputs the OS version
  #
  # HINT: Save to a log file along with the results of the test.
  #
  # Returns: N/A
  # Syntax: N/A
  #
  # Usage: display_OSVersion()
  #=============================================================================#
  def display_OSVersion()

    if(is_win? == true)
      sOSVersion = getWindowsVersion()
    end

    if(is_osx? == true)
      sOSVersion = 'OSX ' + getOSXVersion.to_s
    end

    if(is_linux? == true)
      sOSVersion = 'Linux' #+ getLinuxVersion.to_s
    end

    puts2("\nOS = " + sOSVersion.to_s)

  end # Method - display_OSVersion()

  #=============================================================================#
  #--
  # Method: display_watir_env()
  #
  #++
  #
  # Description: Displays information about the Watir environment.
  #              Information on if Watir is loaded, and its version.
  #
  # HINT: Save to a log file along with the results of the test.
  #
  # Returns: N/A
  # Syntax: N/A
  #
  #
  #=============================================================================#
  def display_watir_env()

    begin # If it doesn't error its loaded, if it errors its not loaded.
      puts2(" Watir: " + Watir::VERSION)
    rescue # It erred, thus its NOT loaded
      puts2(" Watir: Not loaded")
    end

    #if(is_win?) # Windows specific
    #  begin # If it doesn't error its loaded, if it errors its not loaded.
    #    puts2(" Watir: " + Watir::IE::VERSION)
    #  rescue # It erred, thus its NOT loaded
    #    puts2(" Watir: Not loaded")
    #  end
    #end # Windows specific

    #begin # If it doesn't error its loaded, if it errors its not loaded.
    #  puts2(" FireWatir: " + FireWatir::Firefox::VERSION)
    #rescue # It erred, thus its NOT loaded
    #  puts2(" FireWatir: Not loaded")
    #end

    #if(is_osx?) # Mac OSx specific
    #      begin # If it doesn't error its loaded, if it errors its not loaded.
    #        puts2(" SafariWatir: " + SafariWatir::VERSION)
    #      rescue # It erred, thus its NOT loaded
    #        puts2(" SafariWatir:: Not loaded")
    #      end
    #   end # Mac OSx specific

  end # Method - display_watir_env(...)

  #=============================================================================#
  #--
  # Method: display_watirworks_env()
  #
  #++
  #
  # Description: Displays information about the WatirWorks environment.
  #              Information on which modules are loaded, and their respective versions.
  #
  # HINT: Save to a log file along with the results of the test.
  #
  # Returns: N/A
  # Syntax: N/A
  #
  #=============================================================================#
  def display_watirworks_env()

    sWW_Install_Path = get_watirworks_install_path
    puts2("\nWatirWorks version: " + sWW_Install_Path.suffix("/"))

    begin # If it doesn't error its loaded, if it errors its not loaded.
      #puts2("WatirWorks Libraries")
      puts2(" WatirWorks_RefLib: " + WW_REFLIB_VERSION)
    rescue # It erred, thus its NOT loaded
      puts2(" WatirWorks_RefLib: Not loaded")
    end

    begin # If it doesn't error its loaded, if it errors its not loaded.
      puts2(" WatirWorks_Utilities: " + WW_UTILITIES_VERSION)
    rescue # It erred, thus its NOT loaded
      puts2(" WatirWorks_Utilities: Not loaded")
    end

    begin # If it doesn't error its loaded, if it errors its not loaded.
      puts2(" WatirWorks_WebUtilities: " + WW_WEB_UTILITIES_VERSION)
    rescue # It erred, thus its NOT loaded
      puts2(" WatirWorks_WebUtilities: Not loaded")
    end

    begin # If it doesn't error its loaded, if it errors its not loaded.
      puts2(" WatirWorks_WinUtilities: " + WW_WIN_UTILITIES_VERSION)
    rescue # It erred, thus its NOT loaded
      puts2(" WatirWorks_WinUtilities: Not loaded")
    end

    begin # If it doesn't error its loaded, if it errors its not loaded.
      puts2(" WatirWorks_LinuxUtilities: " + WW_LINUX_UTILITIES_VERSION)
    rescue # It erred, thus its NOT loaded
      puts2(" WatirWorks_LinuxUtilities: Not loaded")
    end

    begin # If it doesn't error its loaded, if it errors its not loaded.
      puts2(" WatirWorks_MacUtilities: " + WW_MAC_UTILITIES_VERSION)
    rescue # It erred, thus its NOT loaded
      puts2(" WatirWorks_MacUtilities: Not loaded")
    end

  end # Method - display_watirworks_env(...)

  #=============================================================================#
  #--
  # Method: find_folder_in_tree(...)
  #
  # TODO: Perform a case sensitive search. Limitation of Ruby#File.exist?
  #++
  #
  # NoMethodError: undefined method `grep' for "./":String
  #
  # Description: Searches for the specified folder and returns the full pathname of its location in the directory tree.
  #              The Ruby methods called by this method appear to be case insensitive, so the search ignores case.
  #
  #               1) Starts searching in the current working directory.
  #               2) If still not found, searches the directories above the
  #                  current working directory until the top level directory
  #                  is reached (either "/" on Linux, or a syntax like "C:/" on Windows).
  #               3) If still not found, recursively searches in the directories
  #                  beneath the current working directory.
  #
  # Returns: STRING - The full pathname to the matching folder
  #
  # Syntax: sFolderName = STRING - The name of the folder to find (default = DATA_DIR )
  #
  #=============================================================================#
  def find_folder_in_tree(sFolderName = DATA_DIR)

    if($VERBOSE == true)
      puts2("Parameters - find_folder_in_tree:")
      puts2("  sFolderName: " + sFolderName)
    end

    require "find"

    sFullPathToDir = "" # Set a default value

    # Save the current working directory
    sStartingDir = Dir.getwd
    sCurrentDir = sStartingDir

    if($VERBOSE == true)
      puts2("Searching for folder = " + sFolderName)
      puts2("Starting directory: " + sStartingDir)
    end

    # Loop until we've reached the top level of the filesystem.
    #
    # Search for the folder in the PWD or of the parent dir's of the PWD,
    #
    #  Use a regexp to identify if the Top Level Directory is reached
    #   Example on Win32  "C:/"  #  Regexp syntax:  !~ = String not equal regexp, ^=line begin, ..=2 chars (Alpha, Colon), \/=escape /, $=line end)
    #   Example on Linux  "/")   #  Regexp syntax:  !~ = String not equal regexp, ^=line begin, \/=escape /, $=line end)
    while( (sCurrentDir !~ /^..\/$/) &  (sCurrentDir !~ /^\/$/) )   do

      # Is there a match of the folder's name in the current directory?
      # Method appears to be CASE INSENSITIVE
      if (File.exist?(sFolderName))

        if($VERBOSE == true)
          puts2("Checking possible match to verify its a folder")
        end

        # Verify that its a directory, not a file
        # Method appears to be CASE INSENSITIVE
        if (File.directory?(sFolderName))

          if( (sCurrentDir !~ /^..\/$/) |  (sCurrentDir !~ /^\/$/) )  # Found it on top

            # Append folder to PWD to get fullpath
            sFullPathToDir = File.join(sCurrentDir,  sFolderName)

          else
            # The PWD is the full path
            sFullPathToDir = sCurrentDir
          end

          # Restore the original the working directory
          Dir.chdir sStartingDir

          if($VERBOSE == true)
            puts2("Full path to folder: " + sFullPathToDir)
            #puts2("Current directory: " + Dir.getwd)
            #puts2("Starting directory: " + sStartingDir)
          end

          # Return the full path to the sub-directory
          return sFullPathToDir

        end # Verify that its a directory, not a file
      end  # Is there a match of the folder's name in the current directory?

      # Move up one level in the directory tree and repeat.
      Dir.chdir ".."

      # Save the new current directory
      sCurrentDir = Dir.getwd

      if($VERBOSE == true)
        puts2("Searching: " + sCurrentDir)
      end

    end # Loop until we've reached the top level of the filesystem.

    if(sFullPathToDir == "") # Search sub-directories of the original directory

      # Restore the original the working directory
      Dir.chdir sStartingDir

      if($VERBOSE == true)
        puts2("Search for match to the top level of the file system found no match")
        puts2("Recursively searching all sub-directories for match")
      end

      # Restore the original working directory
      Dir.chdir sStartingDir

      if($VERBOSE == true)
        puts2(" Current directory: " + Dir.getwd)
        puts2(" Starting directory: " + sStartingDir)
      end

      # Define an array to hold the results of the search
      aMyDirList = []
      aTemp =""

      # Search the directory and sub-directories using the find command to collect
      # the list of directories. Need to weed out the numerous
      # pathnames that don't end with the subdirectory.
      Find.find('./') do |path|

        # Convert the relative paths to full path names
        path = File.expand_path(path)

        # Convert Enumerable to string
        sPath = File.path(path)
        if ($VERBOSE== true)
          puts2("Found folder = " + sPath)
        end

        # Append each valid file that's found to the array
        # if (sPath.include?(sFolderName))
        ##if (sPath.include?(/#{sFolderName}$/))
        #  aTemp << sPath
        #end

        aTemp = (sPath.include?(sFolderName))
        #aTemp = path.grep(/#{sFolderName}$/) # save the grep'd file path string in the array
        # NoMethodError: undefined method `grep' for "./":String

        if aTemp.to_s != "" # Determine if its a valid folder
          if($VERBOSE == true)
            puts2("Found folder: " + aTemp.to_s)
          end

          # Append each valid directory that's found as a new element in the array
          aMyDirList << aTemp.to_s

          # Assign the first instance found to a local variable
          sTmpString = aMyDirList[0].to_s

          # The Find command returns a relative path so need to remove the dot in the path,
          sTmpString["."]= ""

          if(sTmpString == "")
            sFullPathToDir = sStartingDir
          else
            # Build the full path to the sub-directory by appending the corrected path to the sub-directory
            # to the path of the current working directory.
            sFullPathToDir = Dir.getwd + sTmpString

          end

          # Restore the original working directory
          Dir.chdir sStartingDir

          if($VERBOSE == true)
            puts2("Full path to sub folder: " + sFullPathToDir)
            #puts2("Current directory: " + Dir.getwd)
            #puts2("Starting directory: " + sStartingDir)
          end

          # Return the full path to the sub-directory
          return sFullPathToDir

        end # Determine if its a valid folder
      end  # Search sub-directories of the original directory
    end # Search the directory

    return sFullPathToDir

  end # Method - find_folder_in_tree()

  #=============================================================================#
  #--
  # Method: find_tmp_dir()
  #
  #++
  #
  # Description: Returns the full path of a temporary directory on the current Operating System
  #            That directory should allow write permissions for the user account
  #
  # Returns: STRING = The full path to the temporary directory
  #
  # Syntax: N/A
  #
  # Usage Examples:
  #
  #                           sTempDir = find_tmp_dir()
  #
  #=============================================================================#
  def find_tmp_dir()
    if(is_win?)
      return ENV["TMP"]
    elsif(is_linux?)
      return "/tmp"
    elsif(is_mac?)
      return "/tmp"
    else # Possibly on java. Use the environment variable setting and cross your fingers
      return ENV["TMP"]
    end

  end # Method - find_tmp_dir

  #=============================================================================#
  #--
  # Method: filter_file_list(...)
  #
  #++
  #
  # Description: Filters an array containging list of files that contain a specified
  #              variable within a range of line in the file. Can be used by a test suite to
  #              filter out files from the list of test files to run.
  #
  #
  # Prerequisite:
  #           The files may reside at the top level of the file system.
  #           The files must reside in the same directory or a sub-directory of the calling file.
  #
  # Returns: ARRAY of STRINGS = Full path the matching files
  #
  # Syntax: sFileIdentifier = STRING -  The partial flie name to add to the list.
  #         bSort = BOOLEAN = true (default) to sort list a-z, false to leave in order files were found
  #
  # Usage Examples: To create a list of test files to run:
  #        require 'watirworks'
  #        require 'find'  # Methods to locate OS files.
  #        include WatirWorks_Utilities    #  WatirWorks General Utilities
  #        aFileList = create_file_list("_test.rb", true)
  #        aFileList = filter_file_list(aFileList, sIncludeInTestRun, 0, 100)
  #
  #=============================================================================#
  def filter_file_list(aFileList, sIdentifier, iMinLineNumberToParse = 0, iMaxLineNumberToParse = 100, bSort = true)

    if($VERBOSE == true)
      puts2("Parameters - filter_file_list:")
      puts2("  aFileList: \n" + aFileList.to_s)
      puts2("  sIdentifier: " + sIdentifier.to_s)
      puts2("  iMinLineNumberToParse: " + iMinLineNumberToParse.to_s)
      puts2("  iMaxLineNumberToParse: " + iMaxLineNumberToParse.to_s)
      puts2("  bSort: " + bSort.to_s)
    end

    aFilteredFileList = []

    puts2("Removing all files without sIdentifier '" + sIdentifier.to_s + "'")

    # Loop through the files in the list
    aFileList.each do | sFileToParse |

      if($VERBOSE == true)
        puts2("\nChecking file: " + sFileToParse)
      end

      # Find matches in the current file (only check the range of lines in the file)
      aFileMatches = get_text_from_file(sIdentifier, sFileToParse, iMinLineNumberToParse, iMaxLineNumberToParse)

      if($VERBOSE == true)
        puts2("Parasing search results...")
      end

      # Loop through array of the search results
      aFileMatches.each do | aMatch |

        if($VERBOSE == true)
          puts2("Match found: " + aMatch[0].to_s)
        end

        # Match found
        if(aMatch[0] != true)

          if($VERBOSE == true)
            puts2(" Skipping files w/o matching identifier: " + sFileToParse)
            sLine = "#"
          end

        else

          # Get the 1st match
          sLine = aMatch[2].to_s

          if($VERBOSE == true)
            puts2(" Line: " + sLine)
          end

        end # Loop through array of the search results

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

        # Determine to keep or drop the file
        if(sSetting.to_s.downcase == true)
          if($VERBOSE == true)
            puts2(" Dropping test file: " + sFileToParse)
          end

        else

          if($VERBOSE == true)
            puts2(" Keeping test file: " + sFileToParse)
          end

          # Add file to the list
          aFilteredFileList << sFileToParse

        end # Determine to keep or drop the file

      end # Match found

      # Re-populate the array with the remaining files
      aFileList = aFilteredFileList

    end # Loop through the files in the list

    if($VERBOSE == true)
      # Display the unsorted list of files
      puts2(aFileList)
      puts2("")
    end

    if(bSort == true)
      # Sort the list (A-Z)
      aFileList.sort!
    end

    if($VERBOSE == true)
      # Display the alpha sorted list of files
      puts2(aFileList)
      puts2("")
    end

    return aFileList

  end # Method - filter_file_list(...)

  #=============================================================================#
  #--
  # Method: format_elapsed_time(...)
  #++
  #
  # Description: Formats  a Floating Point number representing an Time into:
  #                    Weeks, Days, Hours, Minutes and Seconds.
  #
  # Returns: STRING - The formated Time (Float) as a string
  #
  # Syntax: fDiff = Float - The time expressed as a FLOAT to be formated
  #
  # Usage Example: tStartTime = Time.now
  #                        sleep(124)  # Do some stuff, run a test,  sleep 2  or whatever
  #                        tEndTime = Time.now
  #                        fDiff = tEndTime - tStartTime  # Subtraction of two TIME objects results in a FLOAT
  #                        puts2("Elapsed time = " + format_elapsed_time(fDiff))
  #                        #>  0 weeks, 0 days, 0 hours, 2 minutes, 4.015612 seconds
  #=============================================================================#
  def format_elapsed_time(fDiff)

    if($VERBOSE == true)
      puts2("Parameters - format_elapsed_time:")
      puts2("  fDiff: " + fDiff.to_s)
    end

    seconds    =  fDiff % 60
    difference = (fDiff - seconds) / 60
    minutes    =  (difference % 60).to_i
    difference = (difference - minutes) / 60
    hours      =  (difference % 24).to_i
    difference = (difference - hours)   / 24
    days       =  (difference % 7).to_i
    weeks      = ((difference - days)    /  7).to_i

    return "#{weeks} weeks, #{days} days, #{hours} hours, #{minutes} minutes, #{seconds} seconds"

  end # Function - format_elapsed_time(...)

  #=============================================================================#
  #--
  # Method: getenv(...)
  #++
  #
  # Description: Collects information of the specified O/S Environment Variables
  #
  #              In effect it reads all or part of Ruby's ENV object into a hash.
  #
  #              Ruby's ENV object is populated with the O/S variables
  #              that were set when the process that launched Ruby started.
  #
  # Note: This method may not be any more useful that accessing the O/S variable values directly
  #       from the ENV object, (i.e. ENV["Path"] will return the setting of that O/S variable).
  #
  #       Since a printenv() method was also coded, this getenv() method is supplied
  #       to complete the set.
  #
  # Returns: HASH - A hash containing STRINGS of:
  #                     key = O/S Environment variable name
  #                     value = O/S Environment variable setting
  #
  # Syntax: sEnvVar = STRING - The case sensitive name of the O/S Environment variable to collect.
  #                            If no variable name is specified all the variables and corresponding values are collected
  #
  # Usage Examples:
  #                 hMyEnvVars = getenv("COMPUTERNAME")
  #                 hMyEnvVars = getenv()
  #=============================================================================#
  def getenv(sEnvVar = nil)

    if(sEnvVar == nil) # Get all the variables if a specific variable was NOT specified
      hEnvVars = ENV

    else # Get only the specified variable

      hEnvVars = {sEnvVar => ENV[sEnvVar]}  # No specific var was specified so get them all
    end

    return hEnvVars

  end # Method - getenv()

  #=============================================================================#
  #--
  # Method: get_os_version()
  #
  # TODO - Get win & linux cases working
  #
  #   INof from http://www.windows-commandline.com/find-windows-os-version-from-command/
  #        On Win option 1 =  use the ver command:
  #           WIN7   = Microsoft Windows [Version 6.1.7601]
  #           WIN8   = Microsoft Windows [Version 6.2.9200]
  #           WIN8.1 = Microsoft Windows [Version 6.3.9600]
  #        On Win option 2 =  use the sysinfo command is too slow (2-3 sec)
  #           c:\>systeminfo | findstr /B /C:"OS Name" /C:"OS Version"
  #             OS Name:   Microsoft Windows 7 Enterprise
  #             OS Version: 6.1.7601 Service Pack 1 Build 7601
  #
  #++
  #
  # Description: Collects the Window's open on the system
  #
  # Returns: STRING - The top-level window objects are returned.
  #
  # Usage Examples: aAllWindows = get_windows()
  #                 aAllWindows.each {|oWindow| puts oWindow.hwnd}
  #
  #=============================================================================#
  def get_os_version()

    case which_os()
    when "windows"

      return "not implimented in WatirWorks"

    when "osx"
      # Get the key & value hash
      hVar = getenv("_system_version")
      return hVar.values().to_s

    when "linux"
      return "not implimented in WatirWorks"

    else
      return "unknown"
    end

  end # Method - get_os_version()

  #=============================================================================#
  #--
  # Method: get_text_from_file(...)
  #
  #++
  #=============================================================================#
  #
  # Description: Checks the specified ASCII text file to see if it contains an exact match for the specified string.
  #              All lines within the specified range are searched
  #
  # Returns: ARRAY - aResults = Three dimensional array containing a record for each match within the specified range:
  #                                   aResults[0,0] = BOOLEAN - true if match found, otherwise false
  #                                   aResults[0,1] = FIXNUM - Line number of the matching line
  #                                   aResults[0,2] = STRING - The line of text containing the matching string
  #
  # Syntax: sSearchString = STRING- The text to find in the ASCII Text file
  #         sFileToSearch = STRING - The  pathname to the ASCII Text file to be searched
  #         iStartLine = FIXNUM -  The line number from the file to start searching at (Default = First line in the file)
  #                                0 = The first line in the file
  #                                Negative number = Last line of file
  #                                Values greater than the actual length of the file default to the last line of the file
  #         iRangeOfLines = FIXNUM -  The number of lines to search (default = 0, All lines in file from the iStartLine)
  #                                   0 = Search the entire length of the file
  #                                   Positive number = Search down from iStartLine toward the BOTTOM of the file for the specified number of lines
  #                                   Negative number = Search up from iStartLine toward the TOP of the file for the specified number of lines
  #                                   Absolute values greater than the length of the file default to the length of the file
  #
  # Usage Example: To find the string "OK" in the file MyTextFile.txt which is in the current directory:
  #                   aMyMatches = get_text_from_file("OK", "./MyFile.txt" ,0 ,0)
  #                   aMyMatches.each do | aMatch|
  #                      if(aMatch[0] == true)
  #                         puts2("Line: " + aMatch[1].to_s)
  #                         puts2("Text: " + aMatch[2].to_s)
  #                      end
  #                   end
  #
  #=============================================================================#
  def get_text_from_file(sSearchString="", sFileToSearch="", iStartLine = 0, iRangeOfLines = 0)

    if($VERBOSE == true)
      puts2("Parameters - get_text_from_file:")
      puts2("  sSearchString: " + sSearchString)
      puts2("  sFileToSearch: " + sFileToSearch)
      puts2("  iStartLine: " + iStartLine.to_s)
      puts2("  iRangeOfLines: " + iRangeOfLines.to_s)
    end

    # Disallow negative numbers for the index
    if(iStartLine < 0)
      iStartLine = 0
    end

    # Disallow negative numbers for the index
    if(iRangeOfLines < 0)
      iRangeOfLines = 0
    end

    # Set default values
    bFoundMatch = false
    iMatchingLineNumber = 0
    sMatchingLineText = ""
    aMatch = [bFoundMatch, iMatchingLineNumber, sMatchingLineText] # Set default search results
    aResults = [aMatch]
    # Set control parameters
    bSearchFromBottomUp = false
    aMatches = []

    # Cut and run if either parameter is blank
    if((sSearchString == "") | (sFileToSearch == ""))
      if($VERBOSE == true)
        puts2("Blank Search String or File")
      end
      return aResults
    end

    begin

      # Perform some basic checks on the file. Any error will return the default value
      #
      # Verify the file exists
      if(File.exist?(sFileToSearch) == false)
        if($VERBOSE == true)
          puts2("File does not exist")
        end
        return aResults  # Default search results

      else  # It exists so perform additional test on the file

        # Verify it is a file and not a directory
        if(File.directory?(sFileToSearch) == true)
          if($VERBOSE == true)
            puts2("Not a file, its a Directory")
          end
          return aResults  # Default search results
        end

        # Verify the file is an ASCII Text file NOT a directory, characterSpecial, blockSpecial, fifo, link, socket, or unknown file type
        if(File.ftype(sFileToSearch) == true)
          if($VERBOSE == true)
            puts2("File is not an ASCII text file")
          end
          return aResults  # Default search results
        end

        # Verify the file is readable
        if(File.readable?(sFileToSearch) == false)
          if($VERBOSE == true)
            puts2("File is not readable")
          end
          return aResults  # Default search results
        end

        # Verify the file is not a zero length file
        if(File.zero?(sFileToSearch) == true)
          if($VERBOSE == true)
            puts2("File is of zero length")
          end
          return aResults  # Default search results
        end

      end # Perform some basic checks on the file

      if($VERBOSE == true)
        puts2("Opening File: " + sFileToSearch)
      end

      # Open the file
      oFileObject = File.open(sFileToSearch)

      # Read the lines of the file into an array
      aFileContents = oFileObject.readlines

      # Determine direction of search
      if(iRangeOfLines < 0)
        bSearchFromBottomUp = true
        if($VERBOSE == true)
          puts2(" Search File from Bottom to Top: " + bSearchFromBottomUp.to_s)
        end
      end

      # Get the number of lines in the file
      iNumberOfLinesInFile = aFileContents.length
      if($VERBOSE == true)
        puts2(" File contains " + iNumberOfLinesInFile.to_s + " lines")
      end

      # Default adjustment for line number (one indexed) to loop counter (zero indexed)
      iStart = iStartLine - 1

      # Adjust the start line  (0, line-1, or last_line-1)
      if (iStartLine < 0)
        iStart = (iNumberOfLinesInFile - 1)
        if($VERBOSE == true)
          puts2("Adjust Negative Start Line")
        end
      end

      if (iStartLine == 0)
        iStart = iStartLine
        if($VERBOSE == true)
          puts2("Adjust Zero Start Line")
        end
      end

      if (iStartLine > iNumberOfLinesInFile)
        iStart = (iNumberOfLinesInFile - 1)
        if($VERBOSE == true)
          puts2("Adjust Out-Of-Range Start Line")
        end
      end

      if($VERBOSE == true)
        puts2("Adjusted Start line: " + iStart.to_s)
      end

      # Adjust the range value is within the actual number of lines in the file
      if((iRangeOfLines.abs > iNumberOfLinesInFile) | (iRangeOfLines == 0))
        iRangeOfLines = iNumberOfLinesInFile

        if($VERBOSE == true)
          puts2("Adjusted range: " + iRangeOfLines.to_s)
        end

      end

      # Determine end line based on search direction
      if(bSearchFromBottomUp == false)

        # Start values (0, line-1, or last_line-1)
        if(iStart + iRangeOfLines >= iNumberOfLinesInFile)
          iEnd = iNumberOfLinesInFile - 1
        else
          iEnd = iStart + iRangeOfLines - 1
        end

        if($VERBOSE == true)
          puts2("Calculated end line: " + iEnd.to_s)
        end

        if($VERBOSE == true)
          puts2(" Search from line " + iStart.to_s + " to line " + iEnd.to_s)
        end

        #=============================================================
      else # Search from the Bottom UP

        iEnd = 0

        if(iStart  - iRangeOfLines.abs <= 0)

          iEnd = 0

          if($VERBOSE == true)
            puts2("Adjusted end line to 0")
          end
        end

        if(iRangeOfLines.abs <= iStart )
          iEnd =  iStart + iRangeOfLines + 1
          if($VERBOSE == true)
            puts2("Adjusted end line  ***")
          end

        end

        if($VERBOSE == true)
          puts2("Calculated end line: " + iEnd.to_s)
        end

        if($VERBOSE == true)
          puts2(" Search from line " + iStart.to_s + " to line " + iEnd.to_s)
        end

      end # Determine end line based on search direction

      # Loop through the file contents array to find a match
      loop do

        if($VERBOSE == true)
          puts2(" Searching Line Number: " + iStart.to_s)
        end

        sCurrentLineContents = aFileContents[iStart].strip

        if($VERBOSE == true)
          puts2("sCurrentLineContents: '" + sCurrentLineContents.strip + "'")
          puts2("sSearchString       : '" + sSearchString + "'")
        end

        # Record info if a match is found
        if(sCurrentLineContents =~ /.*#{sSearchString}.*/)

          if($VERBOSE == true)
            puts2("### Found a Match")
          end

          # Record line number
          #iLineNumberWithMatch = aFileContents.lineno

          # Record text in the  line

          # Add the current line number and line contents to the array
          aMatches << [true, iStart, sCurrentLineContents]
        end

        # Which way to count?
        if(bSearchFromBottomUp == false)

          # increment line
          iStart = iStart + 1

          break if(iStart > iEnd)

        else

          # decrement line
          iStart = iStart - 1

          break if(iStart < iEnd)

        end # Which way to count?

      end # Loop through the file contents array to find a match

      if($VERBOSE == true)
        puts2("Closing File")
      end

      # Close the file
      oFileObject.close

    rescue => e

      puts2("*** WARNING and Backtrace: " + e.message + "\n" + e.backtrace.join("\n"),"WARN")

      # Close the file if it is open
      if(oFileObject != nil)
        oFileObject.close
      end

      return aResults # Default search results

    end

    if($VERBOSE == true)
      puts2(aMatches)
    end

    return aMatches # Completed search results

  end # Method - get_text_from_file()

  #=============================================================================#
  #--
  # Method: get_watirworks_install_path()
  #
  #++
  #
  # Description: Identifies the location of the WatirWorks gem
  #              Uses Ruby's $LOAD_PATH to find the path it used to load WatirWorks
  #
  # HINT:  Use the path returned from this method along with the dictionary file's name
  #        to access that dictionary that is supplied with WatirWorks
  #
  # Returns: STRING - The full path name of the root watirworks folder
  #
  # Syntax: N/A
  #
  # Usage Examples: sPath = get_watirworks_install_path()
  #
  #=============================================================================#
  def get_watirworks_install_path()

    #$VERBOSE = true

    # Set default return value
    sWW_Install_Path = ""

    # Loop through Ruby's Load path array
    $LOAD_PATH.each do | sGemPath |

      if($VERBOSE == true)
        puts2("Checking LOAD_PATH_ENTRY = " + sGemPath.to_s)
      end

      if(sGemPath =~ /watirworks/ && sGemPath =~ /lib/) # && sGemPath =~ /bin/)
        # Save the match
        sWW_Install_Path = sGemPath

        if($VERBOSE == true)
          puts2("Found Match")
        end

      end

    end # Loop through Ruby's Load path array

    # Remove "/bin" from the end of path to get the root WatirWorks folder
    sWW_Install_Path = sWW_Install_Path.remove_suffix("/")

    return sWW_Install_Path

  end # Method - get_watirworks_install_path()

  #=============================================================================#
  #--
  # Method: get_windows(...)
  #
  #++
  #
  # Description: Collects the Window's open on the system
  #
  # Returns: Array of Object - The top-level window objects are returned.
  #
  # Usage Examples: aAllWindows = get_windows()
  #                 aAllWindows.each {|oWindow| puts oWindow.hwnd}
  #
  #=============================================================================#
  def get_windows()

    require 'rautomation'

    # Create an rAutomation object
    return RAutomation::Window.windows

  end # Method - get_windows()

  #=============================================================================#
  #--
  # Method: is_jruby?()
  #
  #++
  #
  # Description: Identifies if running on a JRuby (Java) platform
  #
  # Returns: BOOLEAN - true if platform is JRuby (Java), otherwise false
  #
  # Syntax: N/A
  #
  # Usage Examples:  if(is_jruby?)
  #                      # Execute your Java specific code
  #                  end
  #
  #=============================================================================#
  def is_jruby?()
    RUBY_PLATFORM.downcase.include?("java")
  end # Method - is_java?()

  alias is_java? is_jruby?

  #=============================================================================#
  #--
  # Method: is_linux?()
  #
  #++
  #
  # Description: Identifies if running on a Linux platform
  #
  # Returns: BOOLEAN - true if platform is Linux, otherwise false
  #
  # Syntax: N/A
  #
  # Usage Examples:  if(is_linux?)
  #                      # Execute your Linux specific code
  #                  end
  #
  #=============================================================================#
  def is_linux?()
    if(RUBY_PLATFORM.downcase.include?("linux"))
      return true

      # Is it JRuby on Linux
    elsif(RUBY_PLATFORM.downcase.include?("java"))
      # If its not Windows and not OSX presume its Linux on JRuby
      if((is_osx? !=true) and (is_win? != true))
        return true
      end
    end

    return false
  end # Method - is_linux?()

  #=============================================================================#
  #--
  # Method: is_osx?(...)
  #
  #++
  #
  # Description: Identifies if running on a OS/X platform
  #
  # Returns: BOOLEAN - true if platform is OS/X, otherwise false
  #
  # Syntax: sVersion = STRING - The version of the OS (e.g. 10)
  #
  # Usage Examples:  To check if it is a OSX Operating system
  #                  if(is_osx?)
  #                      # Execute your OS/X specific code
  #                  end
  #
  #                  To check if it is a OSX 10.9 Operating system
  #                  if(is_osx?("10.9")
  #                      # Execute your OS/X 10.9 specific code
  #                  end
  #=============================================================================#
  def is_osx?(sVersion = nil)

    if($VERBOSE == true)
      puts2("Parameters - is_osx?:")
      if(sVersion.class.to_s == 'NilClass')
        puts2("  sVersion: " + sVersion.class.to_s)
      else
        puts2("  sVersion: " + sVersion.to_s)
      end
    end

    # Set default return status
    bReturnStatus = false

    # Get the Ruby platform
    sPlatform = RUBY_PLATFORM.downcase

    # Check the Platform Type
    case sPlatform

    when /.*darwin.*/
      bReturnStatus = true

    when   /.*java.*/

      # Additional check if this is on JRuby
      if(ENV["OSTYPE"].to_s.downcase.include?("darwin"))
        bReturnStatus = true
      end # Additional check if this is on JRuby

    else
      return false

    end  # Check the Platform Type

    # Check the OS Version
    if(sVersion.class.to_s != 'NilClass')

      # Make sure it's a STRING
      sVersion = sVersion.to_s

      # Get the OS Version
      sRawVersion = getOSXVersion()

      # Compare the OS versions
      if(sRawVersion =~ /.*#{sVersion}.*/)
        bReturnStatus = true
      else
        bReturnStatus = false
      end # Compare the OS versions

    end # # Check the OS Version

    return bReturnStatus

=begin
    if(RUBY_PLATFORM.downcase.include?("darwin"))
      return true

      # Is it JRuby on OSX
    elsif(RUBY_PLATFORM.downcase.include?("java"))
      if(ENV["OSTYPE"].to_s.downcase.include?("darwin"))
        return true
      end
    end

    return bReturnStatus
=end

  end # Method - is_osx?(...)

  alias is_mac? is_osx?

  #=============================================================================#
  #--
  # Method: is_win?()
  #
  # TODO - Check out os.gem http://stackoverflow.com/questions/11784109/detecting-operating-systems-in-ruby
  #++
  #
  # Description: Identifies if running on a Windows platform
  #
  # Returns: BOOLEAN - true if platform is Windows, otherwise false
  #
  # Syntax: sVersion = STRING - The version of the OS (e.g. 10)
  #
  # Usage Examples:
  #                 To check if it is a Windows Operating system
  #                  if(is_win?)
  #                      # Execute your Windows specific code
  #                  end
  #
  #                  To check if it is a Windows 10 Operating system
  #                  if(is_win?("10")
  #                      # Execute your Windows 10 specific code
  #                  end
  #
  #=============================================================================#
  def is_win?(sVersion = nil)

    if($VERBOSE == true)
      puts2("Parameters - is_win?:")
      if(sVersion.class.to_s == 'NilClass')
        puts2("  sVersion: " + sVersion.class.to_s)
      else
        puts2("  sVersion: " + sVersion.to_s)
      end
    end

    # Set default return status
    bReturnStatus = false

    # Get the Ruby platform
    sPlatform = RUBY_PLATFORM.downcase

    # Check the Platform Type
    case sPlatform

    when /.*windows.*/
      bReturnStatus = true

    when /.*mswin.*/
      bReturnStatus = true

    when /.*mingw.*/
      bReturnStatus = true

    when   /.*java.*/

      # Additional check if this is on JRuby
      if(ENV["OSTYPE"].to_s.downcase.include?("win"))
        bReturnStatus = true
      end # Additional check if this is on JRuby

    else
      return false

    end  # Check the Platform Type

    # Check the OS Version
    if(sVersion.class.to_s != 'NilClass')

      # Make sure it's a STRING
      sVersion = sVersion.to_s

      # Get the OS Version
      sRawVersion = getWindowsVersion()

      # Compare the OS versions
      if(sRawVersion =~ /.*#{sVersion}.*/)
        bReturnStatus = true
      else
        bReturnStatus = false
      end # Compare the OS versions

    end # # Check the OS Version

    return bReturnStatus

=begin

    if(RUBY_PLATFORM.downcase.include?("mswin") or RUBY_PLATFORM.downcase.include?("windows") or RUBY_PLATFORM.downcase.include?("mingw"))
      return true

      # Is it JRuby on Windows
    elsif(RUBY_PLATFORM.downcase.include?("java"))
      if(ENV["OS"].to_s.downcase.include?("win"))
        return true
      end
    end

    return false
=end

  end # Method - is_win?()

  #=============================================================================#
  #--
  # Method: is_win32?()
  #
  #++
  #
  # Description: Identifies if running on a Windows 32 bit platform
  #
  # Returns: BOOLEAN - true if platform is Windows 32 bit, otherwise false
  #
  # Syntax: N/A
  #
  # Usage Examples:  if(is_win32?)
  #                      # Execute your Windows 32-bit specific code
  #                  end
  #
  #=============================================================================#
  def is_win32?()
    is_win? && RUBY_PLATFORM.downcase.include?("32")
  end # Method - is_win32?

  #=============================================================================#
  #--
  # Method: is_win64?()
  #
  #++
  #
  # Description: Identifies if running on a Windows 64 bit platform
  #
  # Returns: BOOLEAN - true if platform is Windows 64 bit, otherwise false
  #
  # Syntax: N/A
  #
  # Usage Examples:  if(is_win64?)
  #                      # Execute your Windows 64-bit specific code
  #                  end
  #
  #=============================================================================#
  def is_win64?()
    is_win? && RUBY_PLATFORM.downcase.include?("64")
  end # Method - is_win64?

  #=============================================================================#
  #--
  # Method: minimize_ruby_console()
  #
  #++
  #
  # Description: Minimizes the Console window that launched Ruby.
  #              This is a Windwos OS specific function.
  #
  # HINT: Use this method to avoid catching the Console in any screen captures, or to just
  #       get it out of the way so you can see the full browser window.
  #
  # Returns: BOOLEAN - true on success, otherwise false
  #
  # Syntax: N/A
  #
  # Usage Examples: minimize_ruby_console()
  #
  #=============================================================================#
  def minimize_ruby_console()

    # Only works on windows
    if(is_win?() == true)

      require 'rautomation'

      # Set default return value
      bStatus = false

      # Presuming path is similar to:
      #    "c:\ruby\lib\ruby\gems\1.8\gems\watirworks-0.0.3"
      #  or
      #    /opt/ruby/lib/ruby/gems/1.8/gems/watirworks-0.0.3
      sWatirWorksInstallDir = get_watirworks_install_path()

      # Presuming we can cut the path at the first "l" (ell) character
      # and be left with  "c:/ruby/"
      sRubyPath = sWatirWorksInstallDir.prefix("l")

      # Now append the rest of the path to Ruby's executable
      sRubyPath = sRubyPath + "bin/ruby.exe"

      sRubyPath = sRubyPath.gsub("/", "\\")

      if($VERBOSE)
        puts2("Ruby Path = " + sRubyPath)
      end

      # Create an rAutomation object
      oWindow = RAutomation::Window.new(:title => sRubyPath)

      if(oWindow.exists?)
        # Minimize the window
        oWindow.minimize()
      end

    end # Only works on windows

    return bStatus

  end # Method - minimize_ruby_console()

  #=============================================================================#
  #--
  # Method: is_minimized?(...)
  #
  #++
  #
  # Description: Determines if the window (identified by its title or class) is minimized
  #              Specify either the window's title or it's class.
  #
  # Returns: BOOLEAN - true if minimized, otherwise false
  #
  # Syntax: sWinTitle = STRING - The title used to identify the window (e.g. "My WebSite - Home")
  #
  #         sWinClass = STRING - The window's class used to identify the window (e.g. "MozillaUIWindowClass")
  #
  # Usage Examples:  To test if a Firefox browser window is minimized (using it's window class)
  #                  sWindowClass = "MozillaUIWindowClass"
  #                  assert(is_minimized?(nil,sWindowClass))
  #
  #=============================================================================#
  def is_minimized?(sWinTitle=nil, sWinClass=nil)

    if($VERBOSE == true)
      puts2("Parameters - is_minimized:")
      puts2("  sWinTitle: " + sWinTitle.to_s)
      puts2("  sWinClass " + sWinClass.to_s)
    end

    require 'rautomation'

    if(sWinTitle != nil)
      oWindow = RAutomation::Window.new(:title => /#{sWinTitle}/i)
      return oWindow.minimized?
    else
      oWindow = RAutomation::Window.new(:class => sWinClass)
      return oWindow.minimized?
    end

  end # Method - is_minimized?()

  #=============================================================================#
  #--
  # Method: is_selenium_webdriver?(...)
  #
  #++
  #
  # Description: Determines if Selenium WebDriver  is loaded, using Ruby's $LOADED_FEATURES
  #                   variable, and thus safe to presume that code is being executed by
  #                   Selenium WebDriver  and NOT the WatirWebDriver nor by Watir/FireWatir
  #
  # Returns: BOOLEAN - true if Selenium WebDriver is loaded otherwise false
  #
  # Syntax: N/A
  #
  # Usage Examples:  To test if watir-webriver is loaded
  #                           if(is_selenium_webdriver?)
  #                              # execute your Selenium WebDriver code
  #                           else
  #                             # execute your Selenium WebDriver/FireWatir code
  #                           end
  #
  #=============================================================================#
  def is_selenium_webdriver?()

    if($LOADED_FEATURES.to_s =~/selenium-webdriver/)
      return true
    else
      return false
    end

  end # Method - is_selenium_webdriver?()

  #=============================================================================#
  #--
  # Method: is_webdriver?(...)
  #
  #++
  #
  # Description: Determines if watir-webdriver is loaded, by parsing Ruby's
  #                   $LOADED_FEATURES variable, and therefore the code is being executed by
  #                   WatirWebDriver and not by Watir/FireWatir
  #                   Presumes that you would not have loaded watir-webdriver if
  #                   running Watir/FireWatir.
  #
  # Returns: BOOLEAN - true if web-driver is loaded, otherwise false
  #
  # Syntax: N/A
  #
  # Usage Examples:  To test if watir-webriver is loaded
  #                           if(is_webdriver?)
  #                              # execute your WatirWebDriver code
  #                           else
  #                             # execute your Watir/FireWatir code
  #                           end
  #
  #=============================================================================#
  def is_webdriver?()

    if($LOADED_FEATURES.to_s =~/watir-webdriver/)
      return true
    else
      return false
    end

  end # Method - is_webdriver?()

  #=============================================================================#
  #--
  # Method: parse_ascii_file(...)
  #++
  #
  # Description: Returns an array containing the lines of text read from the specified ASCII Text file
  #              Each line in the file becomes a separate item in the array.
  #              Verifies that the file exists and is readable
  #
  # Returns: ARRAY = An array of STRINGS - Each item in the array is a separate line read from the ASCII file
  #
  # Syntax: sFullPathToFile = STRING - The full path to the ASCII text file to be read
  #
  # Pre-requisites:
  #                 The file must:
  #                    a) Exist at the specified location
  #                    b) Be a file NOT a folder
  #                    c) Be a Readable ASCII text file
  #                    d) NOT a zero length file
  #
  # Usage Examples: To read an ASCII text file at C:\MyTextFile.txt into an array:
  #
  #                    aContentsOfFile =  parse_ascii_file("C:\MyTextFile.txt")
  #                    puts2("Number of lines in the file: " + aContentsOfFile.length.to_s)
  #                    puts2("Last line in file: " + ((aContentsOfFile.length) -1).to_s
  #                    aContentsOfFile.each do | sLineOfText |
  #                        puts2(sLineOfText)
  #                    end
  #=============================================================================#
  def parse_ascii_file(sFullPathToFile)

    if($VERBOSE == true)
      puts2("Parameters - parse_ascii_file")
      puts2("  sFullPathToFile =  " + sFullPathToFile.to_s)
    end

    # Define default return value
    aFileContents = []

    # Perform some basic checks on the file. Any error will return the default value
    #
    # Verify the file exists
    if(File.exist?(sFullPathToFile) == false)
      if($VERBOSE == true)
        puts2("File does not exist")
      end
      return aFileContents

    else  # It exists so perform additional test on the file

      # Verify it is a file and not a directory
      if(File.directory?(sFullPathToFile) == true)
        if($VERBOSE == true)
          puts2("Not a file, its a Directory")
        end
        return aFileContents
      end

      # Verify the file is an ASCII Text file NOT a directory, characterSpecial, blockSpecial, fifo, link, socket, or unknown file type
      if(File.ftype(sFullPathToFile) == true)
        if($VERBOSE == true)
          puts2("File is not an ASCII text file")
        end
        return aFileContents
      end

      # Verify the file is readable
      if(File.readable?(sFullPathToFile) == false)
        if($VERBOSE == true)
          puts2("File is not readable")
        end
        return aFileContents
      end

      # Verify the file is not a zero length file
      if(File.zero?(sFullPathToFile) == true)
        if($VERBOSE == true)
          puts2("File is of zero length")
        end
        return aFileContents
      end

    end # Perform some basic checks on the file

    # Access the file (read-only) and populate an array with its contents, line by line
    aFileContents = File.open(sFullPathToFile, "r").readlines

    if ($VERBOSE == true)
      puts2("aFileContents.class = " + aFileContents.class.to_s)
      #puts2("aFileContents = " + aFileContents.to_s)
    end

    return aFileContents

  end # Method - parse_ascii_file()

  #=============================================================================#
  #--
  # Method: parse_data_array(...)
  #
  #++
  #
  # Description: Filters the provided array of strings and returns either a hash or array based upon specified parameters
  #
  # Returns: Hash (or) Array based on query parameters. Returns an empty Hash on error conditions
  #
  #
  # Syntax: aArrayOfStrings = ARRAY - Array of Strings is provided as an input which is output of parse_spreadsheet
  #                                   (Array can be provided with column header or without)
  #
  #   sFilterByRowOn = STRING       - value used to search for a match in the header row or initial column
  #                                   (Conditional: Set to empty when using index)
  #
  #   bFilterByRow = BOOLEAN        - if true uses row (default), else uses column
  #
  #   oFilterByValueOn = STRING (or) INTEGER - Filter value (default=nil) (if nil, returns Hash)
  #                                   STRING - uses specified string for filtering (e.g. Auto, Showcase, Discover)
  #                                           Conditional: if sFilterByValue is filled, oFilterByValueOn cannot be nil
  #                                   INTEGER - specifies the row index when sFilterByValue = 'index'
  #
  #   sFilterByValue = STRING       - Filters by one of the following ('value', 'key', 'index', nil)
  #                                   (default = nil)
  #                                   value - uses right-most column (or) bottom most row
  #                                   key - uses left-most column (or) top most row
  #                                   index - uses index oFilterByValueOn to locate row
  #
  # Example(s):
  #
  # Scenario A: Returns Hash of row header and Showcase row
  #   $aSpreadsheet_RUNCONTROL = [["PageName","PageValidation"],["Showcase","Auto"]] # Array of Strings
  #   hMyHash = parse_data_array($aSpreadsheet_RUNCONTROL,"Showcase")
  #   hMyHash => {"PageValidation"=>"Auto"}
  #
  # Scenario B: Returns Hash of first column and PageValidation column
  #   $aSpreadsheet_RUNCONTROL = [["PageName","PageValidation"],["Showcase","Auto"]] # Array of Strings
  #   hMyHash = parse_data_array($aSpreadsheet_RUNCONTROL,"PageValidation",false)
  #   hMyHash => {"Showcase"=>"Auto"}
  #
  # Scenario C: Returns Hash of row header and row index 1
  #   $aSpreadsheet_RUNCONTROL = [["PageName","PageValidation"],["Showcase","Auto"]] # Array of Strings
  #   hMyHash = parse_data_array($aSpreadsheet_RUNCONTROL,"",true,1,"index")
  #   hMyHash => {"PageValidation"=>"Auto"}
  #
  # Scenario D: Returns array of row headers of row 'Upsale_Guide' whose values equals 'Auto'
  #   $aSpreadsheet_RUNCONTROL = [["PageName","PageValidation","HeaderEnglish_Full","HeaderLatino_Full"],["Upsale_Guide","Auto","Manual","Auto"]] # Array of Strings
  #   aMyArray = parse_data_array($aSpreadsheet_RUNCONTROL,"Upsale_Guide",true,"Auto","value")
  #   aMyArray => ["PageValidation","HeaderLatino_Full"]
  #
  # Scenario E: Returns array of PageName set to 'Auto'
  #   $aSpreadsheet_RUNCONTROL = [["PageName","PageValidation"],["Showcase","Manual"],["Upsale_Guide","Auto"],["KidsProfile","Auto"]] # Array of Strings
  #   aMyArray = parse_data_array($aSpreadsheet_RUNCONTROL,"PageValidation",false,"Auto","value")
  #   aMyArray => ["Upsale_Guide","KidsProfile"]
  #
  # Scenario F: Returns an empty hash for an unavailable row 'You_Can't_See_Me'
  #   $aSpreadsheet_RUNCONTROL = [["PageName","PageValidation"],["Showcase","Auto"]] # Array of Strings
  #   hMyHash = parse_data_array($aSpreadsheet_RUNCONTROL,"You_Can't_See_Me")
  #   hMyHash => {}
  #
  # Scenario G: Returns an empty hash for an unavailable sFilterByValue 'INVALID_CONDITION'
  #   $aSpreadsheet_RUNCONTROL = [["PageName","PageValidation"],["Showcase","Auto"]] # Array of Strings
  #   hMyHash = parse_data_array($aSpreadsheet_ENV,"",true,1,"INVALID_CONDITION")
  #   hMyHash => {}
  #
  #=============================================================================#
  def parse_data_array(aArrayOfStrings, sFilterByRowOn, bFilterByRow=true, oFilterByValueOn="", sFilterByValue="")

    hDataHash = {}
    arDataArray = []
    method_name = "parse_data_array"

    if($VERBOSE == true)
      puts2("Parameters - " + method_name + " :")
      puts2("  aArrayOfStrings: " + aArrayOfStrings.to_s)
      puts2("  sFilterByRowOn: " + sFilterByRowOn.to_s)
      puts2("  bFilterByRow: " + bFilterByRow.to_s)
      puts2("  oFilterByValueOn: " + oFilterByValueOn.to_s)
      puts2("  sFilterByValue: " + sFilterByValue.to_s)
    end

    # Don't allow if input is not an array
    if aArrayOfStrings.class != Array
      puts2(method_name + " - ERROR - aArrayOfStrings is not an array","ERROR")
      return hDataHash
    end

    # Don't allow if input is an empty array
    if aArrayOfStrings.empty?
      puts2(method_name + " - ERROR - aArrayOfStrings is empty","ERROR")
      return hDataHash
    end

    # Shift to lowercase for sFilterByValue
    sFilterByValue = sFilterByValue.to_s.downcase

    # defaults oFilterByValueOn to 1 if not specified when sFilterByValue equals index
    if (sFilterByValue == "index") && (oFilterByValueOn=="")
      if($VERBOSE == true)
        puts2(method_name + " - WARNING - If sFilterByValue is set to 'index', oFilterByValueOn cannot be nil. Defaulted oFilterByValueOn to 1","WARN")
      end
      oFilterByValueOn = 1
    end

    # Conditional: if sFilterByValue is non blank, then oFilterByValueOn cannot be blank
    if (sFilterByValue != "") && (oFilterByValueOn=="")
      puts2(method_name + "  - ERROR - When sFilterByValue is not nil, oFilterByValueOn cannot be nil","ERROR")
      return hDataHash
    end

    # Conditional: if sFilterByValue is index, sFilterByRowOn is defaulted to blank
    if (sFilterByValue == "index") && (sFilterByRowOn!="")
      if($VERBOSE == true)
        puts2(method_name + " - WARNING - When sFilterByValue equals 'index', sFilterByRowOn cannot be nil. Defaulted sFilterByRowOn to nil","WARN")
      end
      sFilterByRowOn = ""
    end

    # Conditional: if sFilterByValue is index, bFilterByRow can only be true
    if (sFilterByValue == "index") && (bFilterByRow==false)
      if($VERBOSE == true)
        puts2(method_name + " - WARNING - sFilterByValue equals 'index' bFilterByRow can only be true. Defaulted bFilterByRow to true","WARN")
      end
      bFilterByRow=true
    end

    # Adding unstructured information into a Hash with its row and column information
    hParsedData = Hash.new
    # set default values
    iOuterCounter = 1
    iInnerCounter = 1

    # Loop through array of strings and add it to a temporary hash
    aArrayOfStrings.each do | aRow_ofData |
      iInnerCounter = 1
      aRow_ofData.each do |sCell_Data|
        # creating hash with traceable conventions <row_column>
        hParsedData[iOuterCounter.to_s + "_" + iInnerCounter.to_s] = sCell_Data.to_s
        iInnerCounter = iInnerCounter + 1
      end
      # reset for next loop
      iOuterCounter = iOuterCounter + 1
    end # Loop through array of strings and add it to a temporary hash

    iInnerCounter = iInnerCounter - 1
    iOuterCounter = iOuterCounter - 1
    if($VERBOSE == true)
      puts2("iInnerCounter = " + iInnerCounter.to_s + " | iOuterCounter = " + iOuterCounter.to_s)
    end

    # Filtering out a hash based on filter parameters
    hParsedData_Specific = Hash.new
    hTempData = Hash.new
    # set defaults
    sRegEx = ""
    sTemp = ""
    sMatchKey = ""

    # Segregating non-index scenarios by checking if filter is non blank
    if sFilterByRowOn != ""
      # Fetching a small hash by filtering for specific row / column value as specified
      hTempData = hParsedData.select { |sKey, sValue| /^#{sFilterByRowOn}$/.match(sValue.to_s) }
      if($VERBOSE == true)
        puts2('Temporary hash for generating regular expression: ' + hTempData.to_s)
      end
      # Fetching the key of first match for preparing a regular expression in later steps
      if hTempData.length >= 1
        sMatchKey = hTempData.keys[0]
        sTemp = sMatchKey.split("_")
        # Preparing a regular expression based on row / column
        if bFilterByRow
          sInfo = sTemp[0]
          sRegEx = "(1_\\d+|" + sInfo + "_\\d+)"
        else
          sInfo = sTemp[1]
          sRegEx = "(\\d+_1|\\d+_" + sInfo + ")"
        end
      else
        # Create an error if unable to find a content with provided information
        puts2(method_name + " - ERROR - Unable to find row / column with content " + sFilterByRowOn,"ERROR")
        return hDataHash
      end
    else
      # Eliminating a negative scenario for a non-blank search without index
      if(sFilterByValue != "index")
        puts2(method_name + " - ERROR - sFilterByRowOn cannot be empty unless sFilterByValue " + sFilterByValue + " equals index","ERROR")
        return hDataHash
      end

      oFilterByValueOn = (oFilterByValueOn.to_i + 1).to_s
      # Fetching specific row based on provided index
      sRegEx = "(1_\\d+|" + oFilterByValueOn + "_\\d+)"
    end # Segregating non-index scenarios by checking if filter is non blank

    if($VERBOSE == true)
      puts2("Regular Expression: " + sRegEx.to_s)
    end

    hParsedData_Specific = hParsedData.select { |sKey, sValue| /^#{sRegEx}$/.match(sKey.to_s) }

    # Delete non-required keys from the temporary hash we created
    if(sFilterByValue != "index")
      hParsedData_Specific.delete("1_1") # deleting the key value pair for 1st row & 1st column
      hParsedData_Specific.delete(sMatchKey)
    end

    # Perform advanced filter if specified
    arParsedData_Specific = hParsedData_Specific.values
    iLengthOfParsedData = hParsedData_Specific.length
    iHalfLength = iLengthOfParsedData / 2

    # set default values
    iCount = 1
    aFirstSplit = []
    aSecondSplit = []

    # Prepare an intermediate hash based on rows or columns
    if(bFilterByRow)
      # Split existing array into equal half in order to prepare return
      arParsedData_Specific.each_slice(iHalfLength) { |arDataSplit|
        if iCount == 1
          aFirstSplit = arDataSplit
        else
          aSecondSplit = arDataSplit
        end
        iCount = iCount + 1
      }
      # Create a hash to forward as return value
      aFirstSplit.each_index { |iIndexValue|
        hDataHash[aFirstSplit[iIndexValue]] = aSecondSplit[iIndexValue]
      }
    else
      # For even's slice the hash into two and equally split the values
      arParsedData_Specific.each_slice(2) { |arDataSplit|
        hDataHash[arDataSplit[0]] = arDataSplit[1]
      }
    end # Prepare an intermediate hash based on rows or columns

    if($VERBOSE==true)
      puts2("Filtered Information: " + hDataHash.to_s)
    end

    # Positive Scenario : If the user didn't request further filtering on data, provide back the created hash
    # Send back data if primary filter is by index
    if(sFilterByValue == "") || (sFilterByValue == "index")
      if($VERBOSE == true)
        puts2("Return the requested hash since requestor didn't request for further data filtering")
      end
      return hDataHash
    end

    # Perform secondary filter when sFilterByValue equals value or key
    if(sFilterByValue == "value")
      hDataHash.keep_if { |sHashKey,sHashValue| sHashValue == oFilterByValueOn }
      arDataArray = hDataHash.keys()
    else
      hDataHash.keep_if { |sHashKey,sHashValue| sHashKey == oFilterByValueOn }
      arDataArray = hDataHash.values()
    end # Perform secondary filter when sFilterByValue equals value or key

    if($VERBOSE==true)
      puts2("Advanced Filtered Information: " + arDataArray.to_s)
    end
    return arDataArray # return data array with advanced filter

  end # Method - parse_data_array(...)

  #=============================================================================#
  #--
  # Method: parse_dictionary(...)
  #++
  #
  # Description: Returns an array containing the lines of text read from the WatirWorks Dictionary file
  #              Each line in the file contains one word, which becomes a separate item in the array.
  #
  # Returns: ARRAY = An array of STRINGS -Each item in the array is a separate word read from Dictionary
  #
  # Syntax: sFilename  - STRING - name of the dictionary file
  #                sDataDirectory - STRING  - Folder name of the data directory
  #
  #
  # Usage Examples: To read the words in the dictionary into an array
  #                      aDictionaryContents =  parse_dictionary()
  #=============================================================================#
  def parse_dictionary(sFilename="english.dictionary", sDataDirectory = "data")

    if($VERBOSE == true)
      puts2("Parameters - parse_dictionary")
      puts2("  sFilename =  " + sFilename.to_s)
      puts2("  sDataDirectory =  " + sDataDirectory.to_s)
    end

    # Define default return value
    aDictionaryContents = []

    # Determine where in the filesystem that WatirWorks is installed
    sGemInstallPath = get_watirworks_install_path()

    # Join the data directory to the gem install path
    sPathToDataDir = File.join(sGemInstallPath, sDataDirectory)

    sFullPathToFile = File.join(sPathToDataDir, sFilename)
    #sFullPathToFile = File.join(sGemInstallPath, sFilename)

    if($VERBOSE == true)
      puts2("sFullPathToFile = " + sFullPathToFile)
    end

    # Populate the array with the contents of the dictionary
    aDictionaryContents = parse_ascii_file(sFullPathToFile)

    return aDictionaryContents

  end # END Method - parse_dictionary()

  #=============================================================================#
  #--
  # Method: parse_csv_file(...)
  #++
  #
  # Description: Returns a hashed array containing data read from the
  #              specified Comma Separated Value (CSV)  file read from
  #              the file in the specified sub-directory (e.g. my_data).
  #              In the CSV file the data needs to be arranged by record=row, NOT record=column
  #
  #
  # Returns: ARRAY = Data read from CSV file (aCSVData)
  #
  # Syntax: sCSVFilename = STRING - Excel workbook's filename
  #         sSubDirName = STRING - name of the sub-directory that holds the CSV file
  #
  # Pre-requisites:
  #                 The CSV data file must:
  #                    a) Exist within the specified sub-directory
  #                    b) Be readable from the specified sub-directory
  #                 In the CSV file the data must be:
  #                    a) Arranged by record=row, NOT record=column
  #                    b) Contained in a contiguous block
  #=============================================================================#
  def parse_csv_file(sCSVFilename="", sSubDirName=DATA_DIR)

    if($VERBOSE == true)
      puts2("Parameters - parse_csv_file:")
      puts2("  sCSVFilename: " + sCSVFilename)
      puts2("  Containting folder: " + sSubDirName)
    end

    # Require the roo library in the script
    require 'roo' # Gem for reading Workbooks/spreadsheets for Excel (.xlsx), OpenOffice (.ods), and Google
    #include Roo::CSV

    # The CSV library
    require 'csv'

    # Find the location of the directory holding the testsuite data
    sDataDir = find_folder_in_tree(sSubDirName)

    if($VERBOSE == true)
      puts2(" Found containting folder:" + sDataDir)
    end

    # Verify that the files exist in the proper location
    begin

      sFullPathToFile = File.join(sDataDir, sCSVFilename)

      # Check that the files exist
      assert(File.exist?(sFullPathToFile))

      if($VERBOSE == true)
        puts2(" Found CSV file: " + sFullPathToFile)
      end

      if($VERBOSE == true)
        puts2("Open the CSV file and read each record")
      end

      # Define a null array to hold the data
      aCSVData = nil

      # Open the CSV file and read each record (record=row) into a HASH
      # where each element in the parent array is a record from the CSV,
      # the child array holds the individual
      # fields from the CSV record.
      #
      #aCSVData = CSV.open(sFullPathToFile , "r").collect { |row| row.to_a}
      aCSVData = CSV.open(sFullPathToFile , "r").collect { |column| column.to_a}

      if($VERBOSE == true)
        puts2("RAW Contents of CSV file: " + aCSVData.to_s )

      end

      return aCSVData

    rescue => e

      # Record an  error message
      puts2("*** WARNING - Unable to read CSV file: " + sCSVFilename, "WARN")
      # Error and backtrace
      puts2("*** WARNING and Backtrace: " + e.message + "\n" + e.backtrace.join("\n"),"WARN")

    ensure

    end

  end # Method - parse_csv_file()

  #=============================================================================#
  #--
  # Method: parse_spreadsheet(...)
  #
  # TODO: Reading to end of contents (not just to first row starting with a blank cell) is not working
  #++
  #
  # Description: Returns an array containing data read from the specified spreadsheet,
  #              in the specified workbook file, in the specified sub-directory.
  #              Can read data from Workbooks/spreadsheets for Excel (.xls and .xlsx), or OpenOffice (.ods)
  #
  # Syntax:
  #         sWorkbookFile =  STRING - File name of the Workbook (including the file extension (.xls .xlsx .ods)
  #
  #         sSpreadsheet = STRING - Name of the Spreadsheet (tabsheet) in the workbook to read data from.
  #                                     The name must be exact match of the name on the sheet tab, and can NOT contain spaces!
  #
  #         bStopAtEmptyRow = BOOLEAN - true = Read data from first cell in row up to the first row starting with an empty cell
  #                                                        false = Read data from first cell in row up to the last populated cell in the last populated row
  #
  #         sDataDirectory = STRING - name of the sub-directory that holds the workbook file
  #                                                  defaults to "data"
  #
  # Returns: ARRAY - An array of STRINGS - aSpreadsheetContents_byRow
  #
  # Pre-requisites: The  Workbook file must exist in the sub-directory.
  #                 Data must be contained in a contiguous block on one spreadsheet.
  #                 Spreadsheet must holds records as rows:
  #                     Data columns must have headings in first row.
  #
  # Usage example: To Read data from a sheets in a workbook:
  #
  #                    sWorkbookFile = "TestData.xls"
  #                    sSpreadsheet = "Credentials"
  #                    sDataDirectory = "data"
  #                    bStopAtEmptyRow = true
  #
  #                     aMy_Array = sSpreadsheet_Name => parse_spreadsheet(sWorkbookFile, sSpreadsheet, sDataDirectory,  bStopAtEmptyRow)
  #
  #=============================================================================#
  def parse_spreadsheet(sWorkbookFile=nil, sSpreadsheet=nil,  sDataDirectory="data", bStopAtEmptyRow=true)

    if($VERBOSE == true)
      puts2("Parameters - parse_spreadsheet:")
      puts2("  sWorkbookFile: " + sWorkbookFile)
      puts2("  sSpreadsheet: " + sSpreadsheet.to_s)
      puts2("  sDataDirectory: " + sDataDirectory)
      puts2("  bStopAtEmptyRow: " + bStopAtEmptyRow.to_s)
    end

    # Require the roo library in the script
    require 'roo' # Gem for reading Workbooks/spreadsheets for Excel (.xlsx), OpenOffice (.ods), and Google
    require 'roo-xls' # Gem for reading Workbooks/spreadsheets for Excel (.xls)

    # Find the location of the directory holding the testsuite data
    sDataDir = find_folder_in_tree(sDataDirectory)

    # Define the expected full path to the file
    sFullPathToWorkbookFile = File.join(sDataDir, sWorkbookFile)

    # Verify that the file exists in the specified location
    if(File.exist?(sFullPathToWorkbookFile))
      puts2("Reading spreadsheet #{sSpreadsheet} from Workbook file found at: #{sFullPathToWorkbookFile}")

    else
      puts2("*** WARNING - Workbook file not found: #{sFullPathToWorkbookFile}", "WARN")

    end # Verify that the file exists in the specified location

    begin

      if($VERBOSE == true)
        puts2("Opening workbook: " + sFullPathToWorkbookFile)
        puts2("sSpreadsheet: " + sSpreadsheet.to_s )
        puts2("bStopAtEmptyRow: " + bStopAtEmptyRow.to_s )
      end

      # Define a null array to hold the data
      #aSpreadsheetData = nil

      # determine File format based on file's extension
      sFormat = sWorkbookFile.suffix()

      # Create a workbook object for the proper file format
      case sFormat.downcase
      when "xls"
        # Create an instance of Excel XLS workbook
        oWorkbook = Roo::Excel.new(sFullPathToWorkbookFile)
        if($VERBOSE == true)
          puts2("Excel XLS Workbook")
        end
      when "xlsx"
        # Create an instance of Excel XLSX workbook
        oWorkbook = Roo::Excelx.new(sFullPathToWorkbookFile)
        if($VERBOSE == true)
          puts2("Excel XLSX Workbook")
        end
      when "ods"
        # Create an instance of OpenOffice ODS  workbook
        oWorkbook = Roo::OpenOffice.new(sFullPathToWorkbookFile)
        if($VERBOSE == true)
          puts2("OpenOffice ODS Workbook")
        end
      end # Create a workbook object for the proper file format

      aSheetsInWorkbook = oWorkbook.sheets

      #if($VERBOSE == true)
      puts2("\t Workbook contains spreadsheets: " )

      # Loop through sheets in workbook
      aSheetsInWorkbook.each do | sSheetLabel |
        puts2("\t\t" + sSheetLabel)
      end # Loop through sheets in workbook
      #end

      # Set the specified Spreadsheet as the default (active) sheet
      if(sSpreadsheet == nil)
        puts2("\t Using first spreadsheet")
        oWorkbook.default_sheet = oWorkbook.sheets.first
      else
        oWorkbook.default_sheet =  sSpreadsheet.to_s
      end

      puts2("\t Reading sheet: " + oWorkbook.default_sheet)

      # Gather info on the range of the data in the sheet
      iFirstRow = oWorkbook.first_row
      iLastRow = oWorkbook.last_row
      iFirstColumn = oWorkbook.first_column
      iLastColumn = oWorkbook.last_column
      sFirstColumnLetter = oWorkbook.first_column_as_letter
      sLastColumnLetter = oWorkbook.last_column_as_letter

      if($VERBOSE == true)
        puts2("First row: " + iFirstRow.to_s)
        puts2("Last row: " + iLastRow.to_s)
        puts2("First column: " + iFirstColumn.to_s)
        puts2("First column (letter): " + sFirstColumnLetter)
        puts2("Last column: " + iLastColumn.to_s)
        puts2("Last column (letter): " + sLastColumnLetter)
      end

      iCurrentRow = iFirstRow
      aSpreadsheetContents_byRow = []
      aRowData = []

      # Loop through rows
      while (iCurrentRow <= iLastRow)

        aRowData = oWorkbook.row(iCurrentRow, oWorkbook.default_sheet.to_s)

        iCurrentRow = iCurrentRow + 1

        if($VERBOSE == true)
          puts2(aRowData.to_s)
        end

        if(bStopAtEmptyRow == true)
          if($VERBOSE == true)
            puts2(aRowData[0].to_s)
          end

          if(aRowData[0] == nil)
            puts2("Skip from the row starting with an empty first column to the last row")
            # Force skipping the remaining rows
            iCurrentRow = iLastRow + 1
          else
            aSpreadsheetContents_byRow << aRowData
          end
        end

      end # Loop through rows

      # Have roo cleanup after itself and recursively remove any tmp folders (oo_xxxx)
      #oWorkbook.remove_tmp()

      return aSpreadsheetContents_byRow

    rescue => e

      # log the error message
      puts2("*** WARNING - Reading data from Workbook failed", "WARN")
      # Log the backtrace
      puts2("*** WARNING and Backtrace: " + e.message + "\n" + e.backtrace.join("\n"))

    ensure

    end
  end # Method - parse_spreadsheet()

  #=============================================================================#
  #--
  # Method: parse_workbook(...)
  #++
  #
  # Description: Returns a HASH of ARRAYS containing data read from the
  #              the specified spreadsheets within the specified workbook file
  #               in the specified sub-directory.
  #
  #              Data must be assigned to records as rows on the sheets,
  #              all sheets must follow the same scheme .
  #              Each spreadsheet name is used as the hash key for accessing that sheet's data.
  #              Within that sheet's data HASH each spreadhseet's column headings  are the first row in the ARRAY data.
  #
  # Syntax:
  #         sWorkbookFile =  STRING - File name of the Workbook (including the file extension (.xls .xlsx .ods)
  #
  #         aSpreadsheet_List = ARRAY - Containing the Spreadsheets (tabsheet) in the workbook to read data from.
  #                                     These names must be exact matches of the names on the sheet tabs, and can NOT contain spaces!
  #
  #
  #         bStopAtEmptyRow = BOOLEAN - true = Read data from first cell in row up to the first row starting with an empty cell
  #                                                        false = Read data from first cell in row up to the last populated cell in the last populated row
  #
  #         sDataDirectory = STRING - name of the sub-directory that holds the workbook file
  #                                                  defaults to "data"
  #
  # Returns: HASH - A HASH of ARRAYS containing all the data from all of the sheets.
  #                 Use the sheet name as the key for accessing an individual sheet's data hash
  #                 Within that sheet's data HASH each spreadhseet's column headings  are the first row in the ARRAY data
  #
  # Pre-requisites: The Workbook file must exist in the specified data directory
  #                 Data must be contained in a contiguous block within each spreadsheet
  #
  #                 Neither the directory name, the workbook, the spreadsheet, nor the headings may contain spaces.
  #
  #                 Data sets on every sheet must be by rows (not by column)
  #                    Data columns must have headings in first row.
  #
  # Usage example: To Read data from multiple sheets in the workbook:
  #
  #                    sWorkbookFile = "TestData.xls"
  #                    aSpreadsheet_List = ["Credentials",
  #                                         "Workflow_Data",
  #                                         "Access_Data"
  #                                         ]
  #                    sDataDirectory = "data"
  #                    bStopAtEmptyRow = true
  #
  #                     hMy_Hash = sSpreadsheet_Name => parse_workbook(sWorkbookFile, aSpreadsheet_List,  sDataDirectory, bStopAtEmptyRow)
  #
  #=============================================================================#
  def parse_workbook(sWorkbookFile=nil, aSpreadsheet_List=nil, sDataDirectory="data", bStopAtEmptyRow=true)

    if($VERBOSE == true)
      puts2("Parameters - parse_workbook:")
      puts2("  sWorkbookFile: " + sWorkbookFile)
      puts2("  aSpreadsheet_List: " + aSpreadsheet_List.to_s)
      puts2("  sDataDirectory: " + sDataDirectory)
      puts2("  bStopAtEmptyRow: " + bStopAtEmptyRow.to_s)
    end

    begin # BEGIN - Read each spreadsheet's data into a separate hash ###

      # Define top level hash
      hWorkbookHash = {}

      # Loop through the list of spreadsheets, assigning the data from each to a separate array.
      aSpreadsheet_List.each do |sSpreadsheet_Name|  # BEGIN - Loop to read data from spreadsheets

        if($VERBOSE == true)
          puts2("###################################")
          puts2("Reading data from:")
          puts2(" Workbook: " + sDataDirectory + "/" + sWorkbookFile)
          puts2(" Spreadsheet: " + sSpreadsheet_Name)
          puts2(" Stop at Empty Row: " + bStopAtEmptyRow.to_s)
        end

        # Define unique name for each hash
        hSpreadsheetHash = sSpreadsheet_Name

        # Read in the data file
        hSpreadsheetHash = {sSpreadsheet_Name => parse_spreadsheet(sWorkbookFile, sSpreadsheet_Name, sDataDirectory, bStopAtEmptyRow)}

        if($VERBOSE == true)
          puts2("")
          puts2(" Data read from spreadsheet:")
          puts2("  Sheet = " + sSpreadsheet_Name)
          puts2("  Data read= " + hSpreadsheetHash[sSpreadsheet_Name].to_s)
        end

        # Add the current spreadsheet data hash to the workbook hash
        hWorkbookHash [sSpreadsheet_Name] = hSpreadsheetHash[sSpreadsheet_Name]

        if($VERBOSE == true)
          puts2("")
          puts2(" Current key = " + sSpreadsheet_Name)
          puts2(" Current data = " + hWorkbookHash[sSpreadsheet_Name].to_s)

          puts2("")
          puts2(" Complete contents of top level hash")
          hWorkbookHash.each {|hKey,hData| puts2("    Spreadsheet Key: = #{hKey} \n    Spreadsheet DataHash: #{hData} \n")}
        end

      end # END - Loop to read data from spreadsheets

    rescue => e

      puts2("*** WARNING - Reading Data", "WARN")
      puts2("*** WARNING and Backtrace: " + e.message + "\n" + e.backtrace.join("\n"))

      # Raise the error with a custom message after the rest of the rescue actions
      raise("*** METHOD - parse_workbook(...)")

    ensure

      return hWorkbookHash

      # Have roo cleanup after itself and recursively remove any tmp folders (oo_xxxx)
      #oWorkbook.remove_tmp()

    end # END - Read each spreadsheet's data into a separate hash
  end # Method - parse_workbook()

  #=============================================================================#
  #--
  #  Method: printenv(...)
  #++
  #
  # Description: Display the specified Environment variables and their corresponding values
  #              to STDOUT. Similar to the UNIX/Linux command "printenv".
  #
  #              In effect this methods displays all or part of Ruby's ENV object to STDOUT.
  #
  #              Ruby's ENV object is populated with the O/S variables
  #              that were set when the process that launched Ruby started.
  #
  # Syntax: sEnvVar = STRING - The case sensitive string of the Environment variable to display.
  #                             If no variable is specified then all the variables are displayed
  # Usage examples:
  #              To display the variable "COMPUTERNAME" and its setting:
  #                  printenv("COMPUTERNAME")
  #
  #              To display all the variables and their settings:
  #                 printenv()
  #=============================================================================#
  def printenv(sEnvVar = nil)

    if($bRunLocal == true)

      # Loop through the O/S Env variables
      ENV.each do |key, value|

        if(sEnvVar == nil)  # Display all the variables if a specific variable was NOT specified
          puts2("#{key} = #{value}")

        else # Display only the specified variable if one was specified
          if(key == sEnvVar)
            puts2("#{key} = #{value}")
          end

        end

      end # End of loop

    else
      puts2("Remote Execution not supported for this method")
    end

  end # Method - printenv()

  #=============================================================================#
  #--
  # Method: puts2(...)
  #++
  #
  # Description: Wrapper around the methods puts() and log()
  #
  #              Allows messages to be sent to STDOUT via puts(), or to the log file
  #              (if one was started) via $logger.log, or to both. Defaults to both.
  #
  #              Presumes that when a log file exists, messages should be output
  #              to both STDOUT and the log file. So the default parameters are set
  #              to make this the one needing the least parameters.
  #
  #              If Global logger was NOT started no writes to the log file occur.
  #              Determines if a Global $logger was started and skips any writes to the log file it it was not.
  #
  #              The majority of the methods in WatirWorks use this method to alleviate the need
  #              for separate puts() and $logger.log() statements, as well as the need for an if()
  #              conditional statement around each  $logger.log() statement. For example using
  #              this method one line "puts2("Hello") will output to STDOUT, and if the logger
  #              is running, will also output to the log file.
  #
  #
  # Returns: BOOLEAN - true on success, otherwise false
  #
  # Syntax: sMessage = STRING - The text to write to STDOUT and/or the log file
  #
  #         sLogLevel = STRING - The message level. One of the following (Per the Ruby Core API):
  #                             Messages have varying levels (info, error, etc), reflecting their varying importance.
  #                             The levels, and their meanings, are:
  #                                   FATAL: an unhandleable error that results in a program crash
  #                                   ERROR: a handleable error condition
  #                                   WARN: a warning
  #                                   INFO: generic (useful) information about system operation
  #                                   DEBUG: low-level information for developers
  #                              Defaults to level 1 (INFO) of no sLogLevel is specified.
  #
  #         iChoice = INTEGER - Values of 0 write only to STDOUT via puts()
  #                                Values > 0 write to STDOUT via puts() and to log file via log()  (default setting)
  #                                Values < 0 write only to log()
  #
  # Usage Examples: 1) To output an informational message to both STDOUT
  #                    and the log file (presuming that a Global logger object
  #                    $logger has been started:
  #                       puts2("Message")
  #                 2) To output a message to STDOUT and as a DEBUG message
  #                    to the log file (presuming that a Global logger object
  #                    $logger has been started:
  #                       puts2("Message", "DEBUG")
  #                 3) To output a message as a DEBUG message ONLY
  #                    to the log file (presuming that a Global logger object
  #                    $logger has been started:
  #                       puts2("Message", "DEBUG", -1)
  #                 4) To output a message ONLY to STDOUT even though a logger
  #                    object $logger has been started:
  #                       puts2("Message", "", -1)
  #
  #=============================================================================#
  def puts2(sMessage, sLogLevel="INFO", iChoice = 1)

    #      if($VERBOSE == true)
    #        puts("Parameters - puts2:")
    #        puts("  sMessage: " + sMessage)
    #        puts("  sLogLevel: " + sLogLevel)
    #        puts("  iChoice: " + iChoice.to_s)
    #      end

    begin

      bReturnStatus = false # Set default return value

      # Define the valid log level settings
      aValidLogLevels = ["FATAL", "ERROR", "WARN", "INFO", "DEBUG"]

      # Validate the Log Level value
      if(aValidLogLevels.include?(sLogLevel.upcase) == false)
        sLogLevel = "ERROR"
      end

      # Validate the iChoice setting
      if(iChoice > 0)
        iChoice =1
      end
      if(iChoice < 0)
        iChoice = -1
      end

      # If a Global Logger is NOT open for writing only write to STDOUT
      #if(is_global_var_set?("$logger") == false)
      # Presume that the global logger does not exist if the Global variable $logger is nil
      if($logger.nil?)
        iChoice = 0
      end

      # Now that iChoice is properly set we can attempt to write
      case iChoice

      when 0  #  Write only to STDOUT via puts()
        puts(sMessage)  # Echo message to stdout

      when 1  # Write to STDOUT via puts() and to log file via log()

        puts(sMessage)  # Echo message to stdout

        # Write to the log file if one was started
        $logger.log(sMessage, sLogLevel)

      when -1  # Write only to log file via log()

        # Write to the log file if one was started
        $logger.log(sMessage, sLogLevel)

      end

      bReturnStatus = true

    rescue

      bReturnStatus = false

    end

    return bReturnStatus

  end # Method - puts2()

  #=============================================================================#
  #--
  # Method: random_alphanumeric(...)
  #
  #++
  #
  # Description: Generates a String of the specified length that's populated with random alpha-numeric characters
  #              Characters used are:  a-z  A-Z  0-9
  #
  #              From: http://snippets.dzone.com/tag/ruby/
  #
  # Returns: STRING = The generated string of the specified character length
  #
  # Syntax: iLength = FIXNUM -  The length of the string to generate
  #
  # Usage Examples:
  #                 puts2(random_alphanumeric(10)) #=> ab8he2shjz
  #
  #=============================================================================#
  def random_alphanumeric(iLength = 10)

    if($VERBOSE == true)
      puts2("Parameters - random_alphanumeric:")
      puts2("  iLength: " + iLength.to_s)
    end

    # Disallow values less than 1
    if(iLength < 1)
      iLength = 1
    end

    sString = ""

    #  Generate string using random numbers for the ASCII character codes of the characters: 0-9, a-z, A-Z
    iLength.times { sString << (i = Kernel.rand(62); i += ((i < 10) ? 48 : ((i < 36) ? 55 : 61 ))).chr }
    return sString
  end # Method - random_alphanumeric()

  #=============================================================================#
  #--
  # Method: random_boolean()
  #
  #++
  #
  # Description: Generates a random BOOLEAN value of true or false
  #
  # Returns: BOOLEAN = A random value of true or false
  #
  # Syntax: N/A
  #
  # Usage Examples:  puts2(random_boolean().to_s) #=> true
  #
  #=============================================================================#
  def random_boolean()

    if((random_number(0, 1)) == 1)
      return true
    else
      return false
    end

  end # Method - random_boolean()

  #=============================================================================#
  #--
  # Method: random_char()
  #
  #++
  #
  # Description: Generates a random STRING value of a single ASCII character
  #
  # Returns: STRING = A random value of a single upper case or lower case ASCII character
  #
  # Syntax: bLowercase = BOOLEAN - true for UPPER CASE or false for lower case,
  #
  # Usage Examples:  puts2(random_char()) #=> w
  #                  puts2(random_char(true)) #=> G
  #
  #
  #=============================================================================#
  def random_char(bUpcase = false)

    if($VERBOSE == true)
      puts2("Parameters - random_char:")
      puts2("  bUpcase: " + bUpcase.to_s)
    end

    # Generate the ASCII Character
    sChar = sprintf("%c", random_number(97, 122))

    # Need to Upcase the character or not
    if(bUpcase == false)
      return sChar
    else
      return sChar.upcase
    end

  end # Method - random_char()

  #=============================================================================#
  #--
  # Method: random_chars(...)
  #
  #++
  #
  # Description: Generates a random STRING value of a specified number of ASCII characters
  #
  # Returns: STRING = A random set of a lower case or Capitalized ASCII characters
  #
  # Syntax: iLength = INTEGER - The length of the characters in string to generate
  #         bCapitalize = BOOLEAN - true to Capitalize 1st character in string or false for all lower case,
  #
  # Usage Examples:  puts2(random_chars()) #=> wshjeochtybisuaqlxyh
  #                  puts2(random_chars(10, true)) #=> Gslknmeruh
  #
  #
  #=============================================================================#
  def random_chars(iLength = 10, bCapitalize = false)

    if($VERBOSE == true)
      puts2("Parameters - random_chars:")
      puts2("  iLength: " + iLength.to_s)
      puts2("  bCapitalize: " + bCapitalize.to_s)
    end

    # Disallow values less than 1
    if(iLength < 1)
      iLength = 1
    end

    # Start with an empty character set
    sChars = ""

    # Populate the set of ASCII Characters
    iLength.times do
      sChars << random_char()
    end

    # Capitalize the character set?
    if(bCapitalize == false)
      return sChars
    else
      return sChars.capitalize
    end

  end # Method - random_chars()

  #=============================================================================#
  #--
  # Method: random_number(...)
  #
  #++
  #
  # Description: Generates a random Integer value between the specified Min and Max values (inclusive)
  #
  # Returns: INTEGER = A random number >= iMin, but <= iMax
  #
  # Syntax: iMin = INTEGER -  The minimum value
  #         iMax = INTEGER -  The maximum value
  #
  # Usage Examples: puts2(random_number(5, 10).to_s) #=> 6
  #
  #
  #=============================================================================#
  def random_number(iMin = 0, iMax = 1)

    if($VERBOSE == true)
      puts2("Parameters - random_number:")
      puts2("  iMin: " + iMin.to_s)
      puts2("  iMax: " + iMax.to_s)
    end

    # Generate the random number
    rand(iMax-iMin+1)+iMin

  end # Method - random_number()

  #=============================================================================#
  #--
  # Method: random_paragraph(...)
  #
  #++
  #
  # Description: Generates a random STRING value of a specified number of sentences that are
  #              comprised of pseudo words which in turn are comprised of random ASCII characters.
  #
  # Returns: STRING = A random set of sentences comprised of pseudo words  of ASCII characters
  #
  # Syntax: iNumberOfSentences = INTEGER - The number of sentences in the paragraph to generate
  #         iMaxWordsPerSentence = INTEGER - The maximum number of pseudo words per sentence to generate
  #         iMaxCharsPerWord = INTEGER - The max number of characters in each pseudo words to generate
  #
  # Usage Examples:  Generate as set of 4 sentences with a max of 6 pseudo words of 10 characters each:
  #                     puts2(random_paragraph(4, 6, 10))
  #
  #                  Generate a random paragraph of sentences from a random set of pseudo words of random length
  #                     puts2(random_paragraph(random_number(3,5), random_number(4,6), random_number(5,7)))
  #
  #
  #=============================================================================#
  def random_paragraph(iNumberOfSentences = 2, iMaxWordsPerSentence = 10, iMaxCharsPerWord = 10)

    if($VERBOSE == true)
      puts2("Parameters - random_paragraph:")
      puts2("  iNumberOfSentences: " + iNumberOfSentences.to_s)
      puts2("  iMaxSentenceLength: " + iMaxSentenceLength.to_s)
      puts2("  iMaxWordLength: " + iMaxWordLength.to_s)
    end

    # Start with an empty paragraph
    sParagraph = ""

    # Disallow values less than 1
    if(iNumberOfSentences < 1)
      iNumberOfSentences = 1
    end

    # Disallow values less than 1
    if(iMaxWordsPerSentence < 1)
      iMaxWordsPerSentence = 1
    end

    # Disallow values less than 1
    if(iMaxCharsPerWord < 1)
      iMaxCharsPerWord = 1
    end

    # Loop for each sentence
    iNumberOfSentences.times {

      sString = random_pseudowords(random_number(2, iMaxWordsPerSentence), iMaxCharsPerWord)
      sParagraph << sString.to_sentence + " "

    } # Loop for each sentence

    return sParagraph + "\n\n"

  end # Method - random_paragraph()

  #=============================================================================#
  #--
  # Method: random_pseudowords(...)
  #
  #++
  #
  # Description:  Generates a random STRING value of a specified number of pseudo words comprised
  #               of random ASCII characters.
  #
  #               If you need a set of dictionary words please use the method random_words() .
  #
  # Returns: STRING = A random set of a lower case or Capitalized pseudo words comprised  of ASCII characters
  #
  # Syntax: iSetLength = INTEGER -  The length of the number of pseudo words to generate
  #         iMaxWordLength = INTEGER - The max length of the number of characters in each pseudo words to generate
  #         bCapitalize = BOOLEAN - true to Capitalize 1st character in string or false for all lower case,
  #
  # Usage Examples:  Generate as set of 3 pseudo words of 10 characters each:
  #                     puts2(random_pseudowords(3, 10, false)) #=> wshjeochty mjuhygtrfd mkliygcdwk
  #
  #                 Generate a random set of pseudo words of random length and Capitalize the set.
  #                     puts2(random_pseudowords(random_number(2,5), random_number(2,10), true)) #=> Go lkdknmeruh jsdhf fie om
  #
  #
  #=============================================================================#
  def random_pseudowords(iSetLength = 10, iMaxWordLength = 10, bCapitalize = false)

    if($VERBOSE == true)
      puts2("Parameters - random_pseudowords:")
      puts2("  iSetLength: " + iSetLength.to_s)
      puts2("  iMaxWordLength: " + iMaxWordLength.to_s)
      puts2("  bCapitalize: " + bCapitalize.to_s)
    end

    # Disallow values less than 1
    if(iSetLength < 1)
      iSetLength = 1
    end

    # Disallow values less than 1
    if(iMaxWordLength < 1)
      iMaxWordLength = 1
    end

    # Start with an empty word set
    sPsuedoWords = ""

    # Populate the set of pseudo words with a set of random length character sets, with each word separated by a space
    iSetLength.times do
      sPsuedoWords << random_chars(random_number(1, iMaxWordLength)) + " "
    end

    # Remove the trailing white space
    sPsuedoWords.strip!

    # Capitalize the pseudo word set?
    if(bCapitalize == false)
      return sPsuedoWords
    else
      return sPsuedoWords.capitalize
    end

  end # Method - random_pseudowords()

  #=============================================================================#
  #--
  # Method: random_sentence(...)
  #
  #++
  #
  # Description: Makes a sentence of a specified number of words randomly selected from the WatirWorks Dictionary
  #
  # Returns: STRING = A random sentence
  #
  # Syntax:  iNumberOfWords = INTEGER - The number of words to include in the sentence,
  #
  # Usage Examples: puts2(random_sentence(5)) #=> Cabinetmaker ungraded cub's minimalist irene?
  #                 puts2(random_sentence(3)) #=> Lifestyles popper radish's!
  #
  #
  #=============================================================================#
  def random_sentence(iNumberOfWords = 2)

    if($VERBOSE == true)
      puts2("Parameters - random_sentence:")
      puts2("  iNumberOfWords: " + iNumberOfWords.to_s)
    end

    # Define default return value
    sSentence = ""

    # Disallow values less than 1
    if(iNumberOfWords < 1)
      iNumberOfWords = 1
    end

    iNumberOfWords.times {
      sSentence << (random_word().to_s + " ")
    }

    return sSentence.to_sentence()

  end # Method - random_sentence()

  #=============================================================================#
  #--
  # Method: random_word(...)
  #
  #++
  #
  # Description: Retrieves a random word read from the WatirWorks Dictionary
  #
  # Returns: STRING = A random lower case or Capitalized word
  #
  # Syntax:  bCapitalize = BOOLEAN - true to Capitalize 1st character in word or false for all lower case,
  #
  # Usage Examples: puts2(random_word()) #=> word
  #                 puts2(random_word(true)) #=> Random
  #
  #
  #=============================================================================#
  def random_word(bCapitalize = false)

    if($VERBOSE == true)
      puts2("Parameters - random_word:")
      puts2("  bCapitalize: " + bCapitalize.to_s)
    end

    # To save time only read the dictionary into a global array if that array wasn't populated already
    if($Dictionary.nil?)

      # Populate the global array of words from the dictionary
      $Dictionary = parse_dictionary()
    end # # To save time ...

    iNumberOfWords = $Dictionary.length

    # Pick a random word from the dictionary
    sWord = $Dictionary[random_number(0,iNumberOfWords)]

    #Remove and leading or trailing spaces
    sWord = sWord.strip!

    # Capitalize the word?
    if(bCapitalize == false)
      return sWord.downcase   # Words in the dictionary may be UPPER, lower or Capitalized so standardize on lower case
    else
      return sWord.capitalize
    end # Capitalize the word?

  end # Method - random_word()

  #=============================================================================#
  #--
  # Method: send_email_smtp(...)
  #++
  #
  # Description: Uses Ruby to sends email via a SMTP server (Simple Mail Transfer Protocol)
  #              to the specified user account's email address.
  #
  #              For further details see Ruby's Rdoc class NET::SMTP
  #
  # Syntax: sSMTP_Server = STRING - Full domain name or I.P. Address of the SMTP server
  #         sFromAddress = STRING - sender@mail.address
  #         sFromAlias = STRING - Sender's Name
  #         sToAddress = STRING - recipient@mail.address
  #         sToAlias = STRING - Reciepient's Name
  #         sSubjectLine = STRING - Text to use as the email's subject line
  #         sMessageBody = STRING - Text to use as the email's message body
  #         iSMTP_Port = INTEGER - Port number of the SMTP server (Default is 25)
  #         sMailFromdomain = STRING - The domain name of the host the mail is sent from
  #                                    (Default = Use domain of sFromAddress)
  #         sSMTPAuthType = STRING - plain, login, or cram_md5
  #         sAccountName = STRING - User account the SMTP server accepts email from
  #         sAccountPassword = STRING - Password for the User account
  #
  # Requires:  net/smtp - Ruby's means for sending email
  #
  # Usage examples:  send_email_smtp("smtp.yahoo.com", "me@yahoo.com", "you@yahoo.com",
  #                  "What's new?", "Hi, /n What's new with you?")
  #=============================================================================#
  def send_email_smtp(sSMTP_Server, sFromAddress, sToAddress, sSubjectLine, sMessageBody,
    sFromAlias = nil, sToAlias = nil, iSMTP_Port = 25, sMailFromdomain= nil,
    sSMTPAuthType = nil, sAccountName = nil, sAccountPassword= nil)

    if($VERBOSE == true)
      puts2("Parameters (some omitted)- send_email_smtp:")
      puts2("  sSMTP_Server: " + sSMTP_Server)
      puts2("  sFromAddress: " + sFromAddress)
      puts2("  sToAddress: " + sToAddress)
      puts2("  sSubjectLine: " + sSubjectLine)
      puts2("  sMessageBody: " + sMessageBody)
      puts2("  iSMTP_Port: " + iSMTP_Port.to_s)
    end

    require "net/smtp" # Ruby's means for sending email

    # Define the mail from domain from the sender's address
    if(sMailFromdomain == nil)
      aMailFromdomain = sFromAddress.split("@")
      sMailFromdomain = aMailFromdomain[1].to_s
    end

    # Disallow negative port numbers
    if(iSMTP_Port < 0)
      iSMTP_Port = 25
    end

    # Create the email to be sent
    sEmail = "From: #{sFromAlias} <#{sFromAddress}>\n"
    sEmail << "To: #{sToAlias} <#{sToAddress}>\n"
    sEmail << "Subject: #{sSubjectLine}\n"
    sEmail << "#{sMessageBody}\n\n"

    # Send the email (based on the SMTP Auth Type)
    case sSMTPAuthType

    when /pl/  # (sSMTPAuthType == plain)
      Net::SMTP.start(sSMTP_Server, iSMTP_Port, sMailFromdomain,
      sAccountName, sAccountPassword, :plain) do |smtp_server|
        smtp_server.send_message sEmail, sFromAddress, sToAddress
      end # Send the email (sSMTPAuthType == plain)

    when /lo/ #(sSMTPAuthType == login)
      Net::SMTP.start(sSMTP_Server, iSMTP_Port, sMailFromdomain,
      sAccountName, sAccountPassword, :login) do |smtp_server|
        smtp_server.send_message sEmail, sFromAddress, sToAddress
      end # Send the email (sSMTPAuthType == login)

    when /cr/  # (sSMTPAuthType == cram_md5)
      Net::SMTP.start(sSMTP_Server, iSMTP_Port, sMailFromdomain,
      sAccountName, sAccountPassword, :cram_md5) do |smtp_server|
        smtp_server.send_message sEmail, sFromAddress, sToAddress
      end # Send the email (sSMTPAuthType == cram_md5)

    else
      Net::SMTP.start(sSMTP_Server, iSMTP_Port, sMailFromdomain) do |smtp_server|
        smtp_server.send_message sEmail, sFromAddress, sToAddress
      end # Send the email (sSMTPAuthType == nil)

    end # Send the email (based on the SMTP Auth Type)

  end # Method - send_email_smtp()

  #=============================================================================#
  #--
  # Method: setenv(...)
  #++
  #
  # Description: Sets the specified environment variable to the specified value,
  #              Similar to the UNIX/Linux command "setenv".
  #
  #              In effect this method modifies Ruby's ENV object.
  #
  #              Ruby's ENV object is populated with the O/S environment variables
  #              that were set when the process that launched Ruby started.
  #
  # Note: This method is not any more useful that accessing the O/S variable values directly
  #       from the ENV object, (i.e. ENV["Path"] = "NewValue" will set  that O/S variable),
  #       Since a printenv() and a getenv() method were also coded, this setenv() method is
  #       supplied to complete the set.
  #
  # Returns: HASH = hEnvVars - A hash of the environment variables (key) and setting (value)
  #
  # Syntax: sEnvVar = STRING - The case sensitive string of the O/S Environment variable to set.
  #         sValue = STRING - The case sensitive string of the value to set the O/S Environment variable to
  #
  # Usage examples:
  #                setenv("COMPUTERNAME", "MyPC")
  #=============================================================================#
  def setenv(sEnvVar = nil, sValue = nil)

    # Set the specified variable to the specified value
    ENV[sEnvVar] = sValue

  end # Method - setenv()

  #=============================================================================#
  #--
  # Method: start_logger(...)
  #
  #++
  #
  # Description: Creates a new LOGGER object to write to a log file.
  #
  # Calls: WatirWorksLogger() to open a log file and sets parameters to use and maintain the log file.
  #
  # Returns: LOGGER object
  #
  # Syntax: sFullPathToFile = STRING - The full pathname and filename of the log file (Case sensitive)
  #
  #         iLogsToKeep = INTEGER - Number of log file to keep. Default value is 50
  #
  #         iMaxLogSize = INTEGER - Max size in bytes of the current log file. Once reached it
  #                                 will roll to a new log file and rename the old file(s)
  #                                 Default value is 50000000     5Mb
  #
  #         sLogLevel = STRING - The message level. One of the following (Per the Ruby Core API):
  #                              Messages have varying levels (info, error, etc), reflecting their varying importance.
  #                                 The levels, and their meanings, are:
  #                                     FATAL: an unhandleable error that results in a program crash
  #                                     ERROR: a handleable error condition
  #                                     WARN: a warning
  #                                     INFO: generic (useful) information about system operation
  #                                     DEBUG: low-level information for developers
  #
  #                                (default value is "INFO")
  #
  #=============================================================================#
  def start_logger(sFullPathToFile="Logfile.log", iLogsToKeep=50, iMaxLogSize= 5000000, sLogLevel="DEBUG")

    if($VERBOSE == true)
      puts2("Parameters - start_logger:")
      puts2("  sFullPathToFile: " + sFullPathToFile)
      puts2("  iLogsToKeep: " + iLogsToKeep.to_s)
      puts2("  iMaxLogSize: " + iMaxLogSize.to_s)
      puts2("  sLogLevel: " + sLogLevel)
    end

    # Don't allow a blank values
    if((sFullPathToFile == "") | (sFullPathToFile == nil))
      sFullPathToFile = "Logfile.log"
    end

    if((iLogsToKeep < 1) |  (iLogsToKeep > 1000))
      iLogsToKeep=50
    end

    if((iMaxLogSize < 1) |  (iMaxLogSize > 100000000))
      iMaxLogSize=5000000
    end

    if((sLogLevel == "") | (sLogLevel == nil))
      sLogLevel = "INFO"
    end

    myLogger = WatirWorksLogger.new(sFullPathToFile, iLogsToKeep, iMaxLogSize, sLogLevel)

    return myLogger

  end  # Method - start_logger()

  #=============================================================================#
  #--
  # Method: watchlist(...)
  #
  # TODO: Trap Errors with Begin/Rescue/End
  # TODO: Stripping of Class Variables (@@) from passed parameters.
  #
  #++
  #
  # Description: Displays an alpha sorted list of the specified Constants,  Global or Local variables
  #              along with their current settings and class type to stdout. Class variables (e.g. @@myClassVar)  are NOT supported.
  #
  #              If no specific Constants/Variables are passed in, only the Global variables along with their
  #              settings and Class type are displayed.
  #
  #              To display all the Constants defined within a Module the Module must be passed in,
  #              and was previously required/included.
  #
  # Restrictions: Local variables (e.g. @myLocalVar) are only supported if they were defined
  #               within the same Local scope as watchlist() was called from.
  #
  #                   Class variables (e.g. @@myClassVar)  are NOT supported.
  #                   While Ruby has methods for: constants(), global_variables(), and local_variabes(), it lacks a corresponding
  #                   class_variables() method. As Class variables only exist within the class they were
  #                   defined, and as watchlist() is NOT defined in that same Class, they don't exist to watchlist().
  #                   Class variables can't be supported by this method unless:
  #                                   1) A Ruby method,  e.g. class_variables()  exists
  #                                   2) The Class variable was initiated within the same class as the watchlist() method itself
  #
  # Syntax:
  #         aVariableWatchList = ARRAY of strings for the Constants and Variables to watch.
  #                              If nil only the Global variables are displayed
  #                              Note: Constants may be included without
  #                                    needing to specify the Module.
  #
  #          mModule = MODULE - from which to get the Constant definitions
  #                             Note - Pass the Module object, not a String (don't quote it)
  #
  # Usage Examples:
  #                     To display info on all Global variables:
  #                           watchlist()
  #
  #                     To display info on all Global variables,
  #                         and all Constants in the Module:  WatirWorks_Reflib
  #                             watchlist(nil, WatirWorks_Reflib)
  #
  #                     To display info on all Global variables,
  #                          and all Constants in the Module: WatirWorks_Reflib
  #                             watchlist(nil, WatirWorks_Reflib)
  #
  #                     To display info on on only a specific set of Constants and Variables:
  #                           aMyArrayOflocalVarsToWatch = ["$FAST_SPEED", "$VERBOSE", "THIS_YEAR"]
  #                             watchlist(aMyArrayOflocalVarsToWatch)
  #
  #                     To Display only the Global variable ($VERBOSE),
  #                          and the Constant (THIS_YEAR),
  #                             watchlist(["$VERBOSE", "THIS_YEAR"])
  #
  #=============================================================================#
  def watchlist(aVariableWatchList = nil, mModule = nil)

    # Only collect Constants if a Method was passed in
    if((mModule != nil) && (mModule.class.to_s == "Module" ))
      # Populate array with the names of all Constants
      aCurrentConstants = mModule.constants()
    else
      aCurrentConstants = []
    end

    # Populate array with the names of all Global variables
    aCurrentGlobalVars = global_variables()

    # Populate array with the names of all local variables
    aCurrentLocalVars = local_variables()

    # Get the number of each type of variables
    iNumberOfConstants = aCurrentConstants.length
    iNumberOfGlobalVars = aCurrentGlobalVars.length

    # Sort the arrays if they have more than one element
    if(iNumberOfConstants >1)
      aCurrentConstants.sort!
    end
    if(iNumberOfGlobalVars >1)
      aCurrentGlobalVars.sort!
    end
    if(iNumberOfConstants >1)
      aCurrentConstants.sort!
    end

    # Display a specific set of variables or all variables
    if((aVariableWatchList != nil))
      #if((aVariableWatchList != nil) && (aVariableWatchList != []))

      iNumberOfVariables = aVariableWatchList.length

      if(iNumberOfVariables >1)
        aVariableWatchList.sort!
      end

      # Loop to strip Class variables if char 1 & 2 are @'s
      #
      # Put Code Here
      #puts2("Class Variables NOT supported")

      # Loop to display specified variables
      aVariableWatchList.each do | sLocalVar2watch |

        if(eval(sLocalVar2watch).class.to_s == "String")
          puts2("  #{sLocalVar2watch.to_s} = \""  + eval(sLocalVar2watch).to_s  + "\",\t  Class: "  + eval(sLocalVar2watch).class.to_s)
        else
          puts2("  #{sLocalVar2watch.to_s} = "  + eval(sLocalVar2watch).to_s  + ",\t  Class: "  + eval(sLocalVar2watch).class.to_s)
        end

      end # Loop to display specified variables

    else # Display all the variables

      #########################
      # Verify that the Constants array is not empty
      if((mModule != nil) && !(aCurrentLocalVars.empty?))

        puts2("")
        puts2("Constants defined: #{iNumberOfConstants.to_s}")

        # Loop through the Constants
        aCurrentConstants.each do | sCurentVar |

          if(eval(sCurentVar).class.to_s == "String")
            puts2("  #{sCurentVar.to_s} = \""  + eval(sCurentVar).to_s  + "\",\t  Class: " + eval(sCurentVar).class.to_s)
          else
            puts2("  #{sCurentVar.to_s} = "  + eval(sCurentVar).to_s  + ",\t  Class: "  + eval(sCurentVar).class.to_s)
          end

        end # Loop through the Constants

      end # Verify that the Constants array is not empty

      #########################
      # Verify that the Global Var array is not empty
      if !(aCurrentGlobalVars.empty?)

        puts2("")
        puts2("Global variables defined: #{iNumberOfGlobalVars.to_s}")

        # Loop through the Global Variables
        aCurrentGlobalVars.each do | sCurentVar |

          if(eval(sCurentVar).class.to_s == "String")
            puts2("  #{sCurentVar.to_s} = \""  + eval(sCurentVar).to_s  + "\",\t  Class: "  + eval(sCurentVar).class.to_s)
          else
            puts2("  #{sCurentVar.to_s} = "  + eval(sCurentVar).to_s  + ",\t  Class: "  + eval(sCurentVar).class.to_s)
          end

        end # Loop through the Global Variables

      end # Verify that the Global Var array is not empty

    end # Display all the variables

  end # Method - watchlist()

  #=============================================================================#
  #--
  # Method: which_os()
  #
  #++
  #
  # Description: Identifies the OS platform
  #
  # Returns: STRING - OS type: Windows, osx, or linux
  #
  # Syntax: N/A
  #
  # Usage Examples:  if(which_os == 'windows')
  #                      # Execute your Windows specific code
  #                  end
  #
  #=============================================================================#
  def which_os()

    if(is_win? == true)
      return "windows"
    elsif(is_osx? == true)
      return "osx"
    elsif(is_linux? == true)
      return "linux"
    else
      return "unknownOS"
    end

  end # Method - which_os()

end # end of module WatirWorks_Utilities

#=============================================================================#
#======================= END of MODULE ====================================#
#=============================================================================#

#=============================================================================#
# Class: Fixnum
#
# Description: Extends the Ruby Fixnum class with additional methods
#
#--
# Methods: ordinal
#++
#=============================================================================#
class Fixnum
  #=============================================================================#
  #--
  # Method: ordinal
  #++
  #
  # Description: Converts Fixnum to String with the appropriate English ordinal appended.
  #              i.e. 1st, 2nd, 3rd, 4th, 125th etc.
  #
  #              From: http://snippets.dzone.com/tag/ruby/
  #
  # Usage Examples:
  #                 1) 21.ordinal #=> "21st"
  #
  #                 2) [1, 22, 123, 10, -3.1415].collect { |i| i.ordinal }
  #                     => ["1st", "22nd", "123rd", "10th", "3rd"]
  #
  #                      # Print each Ordinal from iMin to iMax
  #                      iMin = 1
  #                      iMax = 120
  #                      iMin.upto(iMax) { | iInteger |  puts2("#{iInteger.to_s} " + iInteger.ordinal) }
  #
  #=============================================================================#
  def ordinal()

    iCardinal = self.to_i.abs

    if(10...20).include?(iCardinal) then
      iCardinal.to_s << 'th'  # 11th thru 19th

    else
      iCardinal.to_s << %w{th st nd rd th th th th th th}[iCardinal % 10]
    end

  end # Method - ordinal

end # Class - Fixnum

#=============================================================================#
# Class: Numeric
#
# Description: Extends the Ruby Numeric class with additional methods
#
#--
# Methods: comma_delimit(...)
#++
#=============================================================================#
class Numeric
  #=============================================================================#
  #--
  # Method: comma_delimit(...)
  #++
  #
  # Description:  Converts FIXNUM to STRING with the thousands separators inserted.
  #               User can specify the separator character. Typically a comma for US or period for European numbers.
  #               Any decimal places in the original number are truncated at two places, at the penny/cent.
  #
  # Returns: STRING = The string representation of the number with the thousands separator inserted.
  #
  # Syntax: sDelimiter =  STRING - Character to use as the thousand's delimiter,
  #
  # Usage Examples:
  #                 To delimit with a comma:
  #                    1234567890.0123.comma_delimit  #=>  "1,234,567,890.01"
  #                 To delimit with a period
  #                    1234567890.0123.comma_delimit(".")  # =>  "1.234.567.890.01"
  #
  #=============================================================================#
  def comma_delimit(sDelimiter =',')

    #$VERBOSE = true

    if($VERBOSE == true)
      puts2("Parameters - comma_delimit:")
      puts2("  sDelimiter: " + sDelimiter)
    end

    sDecimalPoint ='.'

    # Escape pre-existing decimal point
    fNumber = to_s.sub(/\./, sDecimalPoint)

    # Convert to string while retaining the escaped decimal point
    sDecimalPoint = Regexp.escape sDecimalPoint

    # Insert the delimiter character every third digit
    fNumber.reverse.gsub(/(\d\d\d)(?=\d)(?!\d*#{sDecimalPoint})/, "\\1#{sDelimiter}").reverse

  end # Method - comma_delimit()

end  # Class - Numeric

#=============================================================================#
# Class: String
#
# Description: Extends the Ruby String class with additional methods
#
#--
# Methods:
#                word_count()     # alias  wc()
#                format_dateString_mdyy(...)
#                format_dateString_mmddyyyy(...)
#                isValid_EmailAddress?()
#                isValid_Password?()
#                isValid_TopLevelDomain?()
#                isValid_ZipCode?()
#                prefix(...)
#                remove_prefix(...)
#                remove_suffix(...)
#                suffix(...)
#++
#=============================================================================#
class String
  #=============================================================================#
  #--
  # Method: format_dateString_mdyy(...)
  #
  #++
  #
  # Description: Converts a string representation of a date (i.e. "01/02/2007", or "12/22/2007")
  #              into the form m/d/yy, (e.g. 1/2/07).
  #
  # Returns: sConvertedDateString = STRING
  #
  # Syntax: sDelimiter = STRING - The delimiter character (defaults to "/")
  #
  # Usage Examples: To convert the date string "08/04/2007" to "8/4/07"
  #                    sMyDateString = "08/04/2007"
  #                    sAdjustedDate = sMyDateString.format_dateString_mdyy("/")
  #
  # Pre-requisites: Month and day must be one or two characters long
  #                 Year must be two or four characters long
  #
  #=============================================================================#
  def format_dateString_mdyy(sDelimiter="/")

    if($VERBOSE == true)
      puts2("Parameters - format_dateString_mdyy:")
      puts2("  sDelimiter: " + sDelimiter)
    end

    begin ### BEGIN - Convert the date string ###

      # Define empty string to return
      sConvertedDateString = ""

      if($VERBOSE == true)
        puts2("Origional Date string: " + self.to_s)
      end

      # BEGIN - SETP 1 - Value is not a string
      if(self.class.to_s == "String")

        # BEGIN - STEP 2 - Split the string into separate month, day and year strings
        #
        # Split the date into Month, Day and Year strings  based on the delimiter character
        iMySeperator = self.index(sDelimiter)
        iMyEndOfLine = self.index(/$/)

        sMonthToConvert = self[0,iMySeperator].to_s.strip
        sDayYearToConvert = self[iMySeperator + 1 ,iMyEndOfLine].to_s.strip

        if($VERBOSE == true)
          puts2(" Origional Month: " + sMonthToConvert)
          puts2(" sDayYearToConvert: " + sDayYearToConvert)
        end

        iMySeperator = sDayYearToConvert.index(sDelimiter)
        iMyEndOfLine = sDayYearToConvert.index(/$/)
        sDayToConvert = sDayYearToConvert[0,iMySeperator].to_s.strip
        sYearToConvert = sDayYearToConvert[iMySeperator + 1 ,iMyEndOfLine].to_s.strip

        if($VERBOSE == true)
          puts2(" Origional Day: " + sDayToConvert)
          puts2(" Origional Year: " + sYearToConvert)
        end
        # END - STEP 2 - Split the string into separate month, day and year strings

        # BEGIN - STEP 3 - Remove leading zeros from the month
        #
        if($VERBOSE == true)
          puts2(" sMonthToConvert[0].chr: " + sMonthToConvert[0].chr)
        end

        if(sMonthToConvert[0].chr == "0")
          # Starting with the first character, keep one characters
          sConvertedMonth = sMonthToConvert[1,1].to_s
        else
          sConvertedMonth = sMonthToConvert
        end

        if($VERBOSE == true)
          puts2(" sConvertedMonth: " + sConvertedMonth)
        end
        # END - STEP 3 - Remove leading zeros from the month

        # BEGIN - STEP 4 - Remove leading zeros from the day
        #
        if($VERBOSE == true)
          puts2(" sDayToConvert[0].chr: " + sDayToConvert[0].chr)
        end

        if(sDayToConvert[0].chr == "0")
          # Starting with the first character, keep one characters
          sConvertedDay = sDayToConvert[1,1].to_s
        else
          sConvertedDay = sDayToConvert
        end

        if($VERBOSE == true)
          puts2(" sConvertedDay: " + sConvertedDay)
        end
        # END - STEP 4 - Remove leading zeros from the day

        # BEGIN - STEP 5 - Remove first two characters from a 4-character year
        #
        if($VERBOSE == true)
          puts2(" sYearToConvert.length: " + sYearToConvert.length.to_s)
        end
        if(sYearToConvert.length == 4)
          # Starting with the second character, keep two characters
          sConvertedYear = sYearToConvert[2,2].to_s.strip
        else
          sConvertedYear = sYearToConvert
        end

        if($VERBOSE == true)
          puts2(" sConvertedYear: " + sConvertedYear)
        end
        # END - STEP 5 - Remove first two characters from a 4-character year

        # BEGIN - STEP 6 - Assemble the corrected date string
        #
        sConvertedDateString = sConvertedMonth + "/" + sConvertedDay + "/" + sConvertedYear

        if($VERBOSE == true)
          puts2("New Date string: " + sConvertedDateString)
        end
        # END - STEP 6 - Assemble the corrected date string

      else # SETP 1 - Value is not string

        if($VERBOSE == true)
          puts2("   ## sDateToConvert not a string, its a " + self.class.to_s)
        end

      end # END - SETP 1 - Value is not a string

    rescue => e

      puts2("*** WARNING - Converting the date string", "WARN")
      puts2("*** WARNING and Backtrace: " + e.message + "\n" + e.backtrace.join("\n"),"WARN")

      # Raise the error with a custom message after the rest of the rescue actions
      raise("*** METHOD - format_dateString_mdyy(...)")

    ensure

      return sConvertedDateString

    end # Convert the date string
  end # Method - format_dateString_mdyy

  #=============================================================================#
  #--
  # Method: format_dateString_mmddyyyy(...)
  #
  #++
  #
  # Description: Convert a string representation of a date (i.e. "1/2/07", or "12/22/55")
  #              into the form mm/dd/yyyy, (e.g. 01/02/2007).
  #
  # Returns: sConvertedDateString = STRING
  #
  # Syntax: sDelimiter = STRING - The delimiter character (defaults to "/")
  #
  #         sMSB = STRING - The two Most Significant Bits of the year (e.g. "19" for 1900-1999)
  #
  # Usage Examples: To convert the date string "8/4/55" to "08/04/1955"
  #                    sMyDateString = "8/4/55"
  #                    sAdjustedDateString = sMyDateString.format_dateString_mmddyyyy("/", "19")
  #
  # Pre-requisites: Month and day may only be one or two characters long
  #                 Year may only be two or four characters long
  #=============================================================================#
  def format_dateString_mmddyyyy(sDelimiter="/", sMSB="20")

    if($VERBOSE == true)
      puts2("Parameters - format_dateString_mmddyyyy:")
      puts2("  sDelimiter: " + sDelimiter)
      puts2("  sMSB: " + sMSB)
    end

    begin ### BEGIN - Convert the date string ###

      # Define empty string to return
      sConvertedDateString=""

      if($VERBOSE == true)
        puts2("Original Date string: " + self.to_s)
      end

      # BEGIN - SETP 1 - Value is not a string
      if(self.class.to_s == "String")

        # BEGIN - STEP 2 - Split the string into separate month, day and year strings
        #
        # Split the date into Month, Day and Year strings  based on the Delimiter character
        iMySeperator = self.index(sDelimiter)
        iMyEndOfLine = self.index(/$/)

        sMonthToConvert = self[0,iMySeperator].to_s.strip
        sDayYearToConvert = self[iMySeperator + 1 ,iMyEndOfLine].to_s.strip

        if($VERBOSE == true)
          puts2(" Origional Month: " + sMonthToConvert)
          puts2(" sDayYearToConvert: " + sDayYearToConvert)
        end

        iMySeperator = sDayYearToConvert.index(sDelimiter)
        iMyEndOfLine = sDayYearToConvert.index(/$/)
        sDayToConvert = sDayYearToConvert[0,iMySeperator].to_s.strip
        sYearToConvert = sDayYearToConvert[iMySeperator + 1 ,iMyEndOfLine].to_s.strip

        if($VERBOSE == true)
          puts2(" Origional Day: " + sDayToConvert)
          puts2(" Origional Year: " + sYearToConvert)
        end
        # END - STEP 2 - Split the string into separate month, day and year strings

        # BEGIN - STEP 3 - Add leading zeros from the month
        #
        if($VERBOSE == true)
          puts2(" sMonthToConvert.length: " + sMonthToConvert.length.to_s)
        end

        if(sMonthToConvert.length == 1)
          # Pre-pend a zero to the day
          sConvertedMonth = "0" + sMonthToConvert
        else
          sConvertedMonth = sMonthToConvert
        end

        if($VERBOSE == true)
          puts2(" sConvertedMonth: " + sConvertedMonth)
        end
        # END - STEP 3 - Add leading zeros from the month

        # BEGIN - STEP 4 - Add leading zeros from the day
        #
        if($VERBOSE == true)
          puts2(" sDayToConvert.length: " + sDayToConvert.length.to_s)
        end

        if(sDayToConvert.length == 1)
          # Pre-pend a zero to the day
          sConvertedDay = "0" + sDayToConvert
        else
          sConvertedDay = sDayToConvert
        end

        if($VERBOSE == true)
          puts2(" sConvertedDay: " + sConvertedDay)
        end
        # END - STEP 4 - Add leading zeros from the day

        # BEGIN - STEP 5 - Add first two characters to a 2-character year
        #
        if($VERBOSE == true)
          puts2(" sYearToConvert.length: " + sYearToConvert.length.to_s)
        end
        if(sYearToConvert.length == 2)
          # Pre-pend two characters to the year
          sConvertedYear = sMSB + sYearToConvert
        else
          sConvertedYear = sYearToConvert
        end

        if($VERBOSE == true)
          puts2(" sConvertedYear: " + sConvertedYear)
        end
        # END - STEP 5 - Add first two characters to a 2-character year

        # BEGIN - STEP 6 - Assemble the corrected date string
        #
        sConvertedDateString = sConvertedMonth + "/" + sConvertedDay + "/" + sConvertedYear

        if($VERBOSE == true)
          puts2("New Date string: " + sConvertedDateString)
        end
        # END - STEP 6 - Assemble the corrected date string

      else # SETP 1 - Value is not string

        if($VERBOSE == true)
          puts2("   ## sDateToConvert not a string, its a " + self.class.to_s)
        end

      end # END - SETP 1 - Value is not a string

    rescue => e

      puts2("*** WARNING - Converting the date string", "WARN")
      puts2("*** WARNING and Backtrace: " + e.message + "\n" + e.backtrace.join("\n"),"WARN")

      # Raise the error with a custom message after the rest of the rescue actions
      raise("*** METHOD - format_dateString_mmddyyyy(...)")

    ensure

      return sConvertedDateString

    end # Convert the date string

  end # Method - format_dateString_mmddyyyy

  #=============================================================================#
  #--
  # Method: format_from_currency(...)
  #
  #++
  #
  # Description: Converts a string representation of a currency formatted number
  #              into a string representation of a number.
  #              Such as converting the string "$1,000.52"  into the string "1000.52"
  #              Note that strings with more than 2 decimal places are rounded off.
  #
  # Returns: sStringRepresentationOfNumber = STRING
  #
  # Syntax:
  #         bStripDecimalPlaces = BOOLEAN - true = Strip string of decimal places (assumes 2 decimal places)
  #                                         false = Do NOT strip
  #         sDelimiter = STRING - Character used to separate the converted amount every 3 places to
  #                               left of the decimal's location
  #         sSymbol = STRING - Character used to identify the amount which will be truncated by the conversion process.
  #                            For example: Dollars ($), Euros (�), Pounds Sterling (�), Yen (�),
  #                            or other non-multi-byte currency symbols.
  #                            If set to "" no symbol is truncated
  #
  # Usage Examples:
  #                To convert the string "�1.000.00" to "1000"
  #                       "�1.000.00".format_from_currency("�", ".", true)
  #
  #                To convert the string "$1,000.50" to "1000"
  #                       "$1,000.50".format_from_currency("$", ",", true)
  #
  #                To convert the string "$1.000.50" to "$1000.50"
  #                       "$1.000.50".format_from_currency("", ".", false)
  #
  #=============================================================================#
  def format_from_currency(sSymbol = "$", sDelimiter = ",", bStripDecimalPlaces = false)

    if($VERBOSE == true)
      puts2("Parameters - format_from_currency:")
      puts2("  bStripDecimalPlaces: " + bStripDecimalPlaces.to_s)
      puts2("  sDelimiter: " + sDelimiter)
      puts2("  sSymbol: " + sSymbol)
    end

    if($VERBOSE == true)
      puts2(" Amount To Convert \"#{self.to_s}\" ")
      puts2(" Strip Decimal Places \"#{bStripDecimalPlaces.to_s}\" ")
      puts2(" Delimiter \"#{sDelimiter.to_s}\" ")
      puts2(" Symbol \"#{sSymbol.to_s}\" ")
    end

    # Define decimal point character
    sDecimalPoint = "."

    # Remove any leading or trailing spaces
    self.strip!

    # Determine the length of the string
    iEndOfString = self.index(/$/) # Length of the string (count from 0)

    if($VERBOSE == true)
      puts2(" String length: #{iEndOfString.to_s}")
    end

    # Determine if the Numeric String has a decimal and where's its located
    # Count backward from the end of the string through only the last 4 character
    # which will catch formats ( *, *., *.0, *.00)
    case
    when self[iEndOfString - 1].chr == sDecimalPoint
      iSplit = iEndOfString - 1
    when self[iEndOfString - 2].chr == sDecimalPoint
      iSplit = iEndOfString - 2
    when self[iEndOfString - 3].chr == sDecimalPoint
      iSplit = iEndOfString - 3
    when self[iEndOfString - 4].chr == sDecimalPoint
      iSplit = iEndOfString - 4
    else
      iSplit = iEndOfString
    end # Determine if the Numeric String has a decimal and where's its located

    # Split string at the decimal place's location
    sPrefix = self[0, iSplit].to_s.strip
    sSuffix = self[(iSplit) ,iEndOfString].to_s.strip

    if($VERBOSE == true)
      puts2(" Prefix string: #{sPrefix.to_s}")
      puts2(" Suffix string: #{sSuffix.to_s}")
    end

    # Remove the delimiter character from the prefix
    sPrefix = sPrefix.gsub(sDelimiter, "")

    if($VERBOSE == true)
      puts2(" Delimted prefix string: #{sPrefix.to_s}")
    end

    # Does the first character in the string match the symbol that is to be removed?
    if(sSymbol.to_s != "")
      # Strip off the symbol character
      sPrefix = sPrefix.sub(sSymbol, "")
    end

    # Pad the prefix as necessary
    if(sPrefix == "")
      sPrefix = "0" + sPrefix

      if($VERBOSE == true)
        puts2(" Padded prefix string: #{sPrefix.to_s}")
      end

    end # Pad the prefix as necessary

    # Pad the suffix to 2-decimal places as necessary
    case
    when sSuffix == ""
      sSuffix = sSuffix + ".00"
    when sSuffix =~ /\.$/
      sSuffix = sSuffix + "00"
    when sSuffix =~ /\.\d$/
      sSuffix = sSuffix + "0"
    end # Pad the suffix to 2-decimal places as necessary

    if($VERBOSE == true)
      puts2(" Padded suffix string: #{sSuffix.to_s}")
    end

    # Re-attach the suffix
    if(bStripDecimalPlaces == false)
      # Create string by adding the prefix and the suffix
      sStringRepresentationOfNumber = sPrefix + sSuffix
    else
      # Create string by adding only the prefix
      sStringRepresentationOfNumber = sPrefix
    end # Re-attach the suffix

    return sStringRepresentationOfNumber

  end # Method - format_from_currency()

  #=============================================================================#
  #--
  # Method: format_to_currency(...)
  #++
  #
  # Description: Converts a string representation of a number into a string representation
  #              of a currency formatted amount, with a thousands separator, and 2-decimal places.
  #              Such as converting "1000000"  to "$1,000,000.00".
  #              Values are padded to two decimal places as necessary.
  #
  # Returns: sStringRepresentationOfAmount = STRING
  #
  # Syntax:
  #          sDelimiter = STRING - Character used to separate the converted amount every 3 places to
  #                                  left of the decimal's location (the thousands separator)
  #          sSymbol = STRING - Monetary symbol prepended onto the converted amount,
  #                              For example: Dollars ($), Euros (�), Pounds Sterling (�), Yen (�),
  #                              or other non-multi-byte currency symbols.
  #                              If set to "" no symbol is prepended.
  #
  # Usage Examples:
  #                To convert the string "1000" to Pounds Sterling, using a period as a delimiter,
  #                     "1000".format_to_currency("�", ".")  #=>  "�1.000.00"
  #
  #                To convert the string "1000.50" to Dollars, using a comma as a delimiter,
  #                     "1000.50".format_to_currency()   #=>  "$1,000.50"
  #
  #                To convert the string "1000.5" without a $, using a comma as a delimiter,
  #                     "1000000.50".format_to_currency("", ",")   #=> "1,000,000.50"
  #
  #                To convert the string "1" to Euros, using a period as a delimiter,
  #                     "1".format_to_currency("�", ".")  #=>  "�1.00"
  #
  #                To convert the string ".5" to Dollars, using a comma as a delimiter,
  #                    ".5".format_to_currency("$", ",") #=> "$0.50"
  #=============================================================================#
  def format_to_currency(sSymbol = "$", sDelimiter = ",")

    if($VERBOSE == true)
      puts2("Parameters - format_to_currency:")
      puts2("  sDelimiter: " + sDelimiter)
      puts2("  sSymbol: " + sSymbol)
    end

    # Remove any leading or trailing spaces
    sString = self.strip

    # Determine the last character of the string
    iStringLength = sString.length
    sLastCharacter =  sString[iStringLength - 1].chr  # Adjust for 0 vs 1 indexed

    # If string ends in a decimal, pad it with zeros
    if(sLastCharacter == ".")
      sString = sString + "00"
    end

    # Format the String with 2 decimal places ## and prepend the Monetary symbol character
    sStringRepresentationOfAmount = sprintf("%.2f", sString)

    if($VERBOSE == true)
      puts2(" Partly converted string \"#{sStringRepresentationOfAmount.to_s}\" ")
    end

    # Convert String into a float
    fAmount = sStringRepresentationOfAmount.to_f

    # Add the separator character to the Float before every third digit to the left of the decimal place
    fAmount = fAmount.comma_delimit(sDelimiter)

    if($VERBOSE == true)
      puts2(" Partly converted number \"#{fAmount.to_s}\" ")
    end

    # Convert the Float back into a String and prepend the Monetary symbol character
    sStringRepresentationOfAmount =  sSymbol + fAmount.to_s

    # Determine the length of the string
    iEndOfString = sStringRepresentationOfAmount.index(/$/) # Length of the string (count from 0)

    if($VERBOSE == true)
      puts2("Length of string: #{iEndOfString.to_s}")
    end

    # Pad to 2-decimal places if necessary
    if(sStringRepresentationOfAmount[iEndOfString - 3].chr != ".")

      sStringRepresentationOfAmount = sStringRepresentationOfAmount + "0"

    end

    return sStringRepresentationOfAmount

  end # Method - format_to_currency()

  #=============================================================================#
  #--
  # Method: is_blank?()
  #++
  #
  # Description: Determines if the specified string contains only whitespace
  #
  # Returns: BOOLEAN - true if string is all white space., otherwise false
  #
  # Syntax: N/A
  #
  # Usage Examples:
  #                 puts2("    ".is_blank?)  #=>  true
  #                 puts2("".is_blank?)      #=>  false
  #                 puts2("A".is_blank?)     #=>  false
  #
  #=============================================================================#
  def is_blank?()
    !(self =~ /\S/)
  end # Method - is_blank?

  #=============================================================================#
  #--
  # Method: isValid_EmailAddress?()
  #++
  #
  # Description: Checks the specified string against Email Address rules defined herein.
  #
  #              If the string is nil the validation is skipped. Please check this condition outside
  #              of this function, as your application may not require an email address, but needs
  #              to validate it only if one exists.
  #
  #              Email Address rules are:
  #                 1. It is a STRING
  #                 2. String's syntax is valid  (e.g. <account>@<local-domain>.<top-level-domain>)
  #                 3. String is at least 6 characters long
  #                 4. String contains a valid Top Level Domain
  #                 5. String contains only valid characters:  A-Z  a-z  0-9  .  +  -  _
  #
  # Returns: BOOLEAN - true if all verifications pass, otherwise false
  #
  # Syntax: N/A
  #
  # Usage Examples: sMyString = "qa@test.com"
  #                 assert(sMyString.isValid_EmailAddress?)
  #
  # Limitations: Does not check the following:
  #                     1. IP Address instead of <local-domain>.<top-level-domain> :
  #                             me@[192.168.1.1]
  #
  #                     2. Account is specified by an Alias which is between double quotes " thus allowing otherwise invalid characters:
  #                            "J. P.'s-Big Boy, The Best Burger in Town!"@server.com
  #
  #                     3. Local domain name may not begin with a number:
  #                           elvis.presley@123.com            # Sorry but Elvis has left the building
  #
  #                     4. Email account, or local-domain exist and is currently active:
  #                           queen-of-england@whitehouse.gov
  #
  #                    5. The validation is skipped if email address is nil
  #=============================================================================#
  def isValid_EmailAddress?()

    begin ### BEGIN - Check the Email Address  ###

      #Set flag to true by default, if any check fails it will be set to false
      # Innocent until proven guilty
      bValidEmailAddress = true

      # BEGIN - SETP 1 - Value is not a string
      if(self.class.to_s == "String")

        if($VERBOSE == true)
          puts2("  Checking Email Address: " + self.to_s)
        end

        # BEGIN - STEP 2 - String length

        # The account, and local-domain could conceivable be only 1 character
        # The global-domain must be at least 2 characters
        #  Add the @ and a period and it all adds up to 6 characters
        #  For example:  a@b.de
        #
        if self.length < 6

          bValidEmailAddress=false

          if($VERBOSE == true)
            puts2("   ## Email Address must be at least 6 characters, only counted " + self.length.to_s)
          end

        end  # END - STEP 2 - String length

        # BEGIN - STEP 3 - Syntax is valid  (e.g. <account>@<local-domain>.<top-level-domain>)

        #
        # Note that x@localhost will fail as its missing a period separating the <local-domain> and <top-level-domain>
        #

        # Define set of valid characters. The + after the square bracket means multiples occurrences are OK
        # Need to check if other characters are valid (e.g. double quote "  bang !  etc.)
        sValidCharacters = '[A-Za-z0-9.+-_]+'

        if self !~ /#{sValidCharacters}@#{sValidCharacters}\.#{sValidCharacters}/

          bValidEmailAddress=false

          if($VERBOSE == true)
            puts2("   ## Invalid Email Address syntax " + self.to_s)
          end

        end  # END - STEP 3 - Syntax is valid

        # BEGIN - STEP 4 - Top Level domain  (e.g. com, org, gov, etc.)

        # Separate the TLD from the address.
        #  The TLD is always the characters following the last period to the end of the string
        #
        # Flip the string so that the TLD is at the beginning of the strings
        sTLD2Check = self.suffix(".")

        # Check the validity of the TLD
        bValidEmailAddress = sTLD2Check.isValid_TopLevelDomain?

        if((bValidEmailAddress == false) & ($VERBOSE == true))
          puts2("   ## Invalid Email Address Top Level domain " + self.to_s)
        end

        #end # Check validity

        # END OF - STEP 4 - Top Level domain is valid

      else # SETP 1 - Value is not string

        bValidEmailAddress=false

        if($VERBOSE == true)
          puts2("   ## Email Address not a string, its a " + self.class.to_s)
        end

      end # END - SETP 1 - Value is not a string

    rescue => e

      puts2("*** WARNING - Checking Email Address Top Level domain", "WARNING")
      puts2("*** WARNING and Backtrace: " + e.message + "\n" + e.backtrace.join("\n"),"WARN")

    ensure

      return bValidEmailAddress

    end ### END - Check the Email Address  ###

  end # Method - isValid_EmailAddress?

  #=============================================================================#
  #--
  # Method: isValid_Password?()
  #
  #++
  #
  # Description: Checks the specified STRING against the Password rules as defined herein.
  #
  #              If the string is nil the validation is skipped. Please check this condition outside
  #              of this function, as your application may not require a password, but needs
  #              to validate it only if one exists.
  #
  #              Password rules are:
  #                 1. It is a STRING
  #                 2. String is at least 8 characters long
  #                 3. String contains at least 1 alpha character
  #                 4. String contains at least 1 uppercase alpha character
  #                 5. String contains at least 1 lowercase alpha character
  #                 6. String contains at least 1 non-alpha character
  #                 7. String DOES NOT contain a whitespace character
  #                 8. String DOES NOT contain an invalid character (? @ &)
  #
  # Returns: BOOLEAN - true if all verifications pass, otherwise false
  #
  # Syntax: N/A
  #
  # Usage examples: sMyString = "MyPa55w0rd"
  #                 assert(sMyString.isValid_Password?)
  #
  #=============================================================================#
  def isValid_Password?()

    begin ### BEGIN - Check the password  ###

      #$VERBOSE = true

      #Set flag to true by default, if any check fails it will be set to false
      # Innocent until proven guilty
      bValidPassword = true

      # BEGIN - SETP 1 - Value is not a string
      if(self.class.to_s == "String")

        # BEGIN - STEP 2 - String is at least 8 characters long
        if(self.length < 8)

          bValidPassword = false

          if($VERBOSE == true)
            puts2("   ## Password has less than 8 characters, only counted " + self.length.to_s)
          end

        end  # END - STEP 2 - String is at least 8 characters long

        # BEGIN - STEP 3 - String contains at least 1 alpha character
        if (self !~ /[a-z]|[A-Z].?/)

          bValidPassword = false

          if($VERBOSE == true)
            puts2("   ## Password has less than 1 alpha character")
          end

        end # END - STEP 3 - String contains at least 1 alpha character

        # BEGIN - STEP 4 - String contains at least 1 uppercase alpha character
        if (self !~ /[A-Z].?/)

          bValidPassword = false

          if($VERBOSE == true)
            puts2("   ## Password has less than 1 uppercase alpha character")
          end

        end  # END - STEP 4 - String contains at least 1 uppercase alpha character

        # BEGIN - STEP 5 - String contains at least 1 lowercase alpha character
        if (self !~ /[a-z].?/)

          bValidPassword = false

          if($VERBOSE == true)
            puts2("   ## Password has less than 1 lowercase alpha character")
          end

        end  # END - STEP 5 - String contains at least 1 lowercase alpha character

        # BEGIN - STEP 6 - String contains at least 1 non-alpha character
        if (self !~ /[0-9]|[\!\$\#\%].?/)

          bValidPassword = false

          if($VERBOSE == true)
            puts2("   ## Password has less than 1 non-alpha character")
          end

        end  # END - STEP 6 - String contains at least 1 non-alpha character

        # BEGIN - STEP 7 - String contains a whitespace character
        if (self =~ /\s.?/)

          bValidPassword = false

          if($VERBOSE == true)
            puts2("   ## Password contains a whitespace character")
          end

        end  # END - STEP 7 - String contains a whitespace character

        # BEGIN - STEP 8 - String contains at least invalid character
        # NEED to find a complete list of what are considered invalid characters
        if (self =~ /[\?\@\&].?/)

          bValidPassword = false

          if($VERBOSE == true)
            puts2("   ## Password contains an invalid character @ & ?")
          end

        end  # END - STEP 8 - String contains at least 1 invalid character

      else # SETP 1 - Value is not string

        bValidPassword = false

        if($VERBOSE == true)
          puts2("   ## Password not a string, its a " + self.class.to_s)
        end

      end # END - SETP 1 - Value is not a string

    rescue => e

      puts2("*** WARNING - Checking Password", "WARN")
      puts2("*** WARNING and Backtrace: " + e.message + "\n" + e.backtrace.join("\n"),"WARN")

    ensure

      return bValidPassword

    end ### END - Check the password  ###

  end # Method - isValid_Password?

  #=============================================================================#
  #--
  # Method: isValid_TopLevelDomain?()
  #++
  #
  # Description: Checks the specified string against the list of valid Top Level Domain abbreviations.
  #
  #
  # Returns: BOOLEAN - true if all verifications pass, otherwise false
  #
  # Syntax: N/A
  #
  # Usage Examples:  sMyString = "com"
  #                  assert(sMyString.isValid_TopLevelDomain?)
  #
  #=============================================================================#
  def isValid_TopLevelDomain?()

    begin ### BEGIN - Check the TLD  ###

      #Set flag to false by default, if a match is found it will be set to true
      # Innocent until proven guilty
      bValidDomain = false

      # BEGIN - SETP 1 - Value is not a string
      if(self.class.to_s == "String")

        # BEGIN - STEP 2 - Top Level domain  (e.g. com, org, gov, etc.)

        #
        # Set of Top Level domain names was found at: http://www.icann.org/registries/top-level-domains.htm
        #
        aTopLevelDomains = TOP_LEVEL_DOMAINS # Constant array defined in WatirWorks_Reflib

        # Loop
        aTopLevelDomains.each do |  sTLD |
          if(self == sTLD)

            bValidDomain=true
          end
        end # Loop

        if((bValidDomain == false) & ($VERBOSE == true))
          puts2("   ## Invalid Top Level domain: " + self.to_s)
        end

        #end  # END - STEP 2 - Top Level domain is valid

      else # SETP 1 - Value is not string

        bValidDomain=false

        if($VERBOSE == true)
          puts2("   ## Value is not a string, its a " + self.class.to_s)
        end

      end # END - SETP 1 - Value is not a string

    rescue => e

      puts2("*** WARNING -  Top Level domain: ", "WARN")
      puts2("*** WARNING and Backtrace: " + e.message + "\n" + e.backtrace.join("\n"),"WARN")

    ensure

      return bValidDomain

    end ### END - Check the TLD  ###

  end # Method - isValid_TopLevelDomain?

  #=============================================================================#
  #--
  # Method: isValid_ZipCode?()
  #
  #++
  #
  # Description: Checks the specified STRING against Zip Code rules defined herein
  #              Covers both Zip and Zip+4 syntax.
  #
  #              If the string is nil the validation is skipped. Please check this condition outside
  #              of this function, as your application may not require a Zip Code, but needs
  #              to validate it only if one exists.
  #
  #              Zip Code rules are:
  #                 1. It is a STRING
  #                 2. String's syntax is:  <5 digits>  or  <5-digits>-<4-digits>
  #
  # Returns: BOOLEAN - true if all verifications pass, otherwise false
  #
  # Syntax: N/A
  #
  # Usage examples: sMyString = "80303-4000"
  #                 assert(sMyString.isValid_ZipCode?)
  #
  # Limitations: Does not check the following:
  #                 1. The Zip Code is listed by the US Postal Service as currently supported
  #                 2. Does not lie outside of the range of valid numbers
  #
  #=============================================================================#
  def isValid_ZipCode?()

    begin ### BEGIN - Check the Zip Code  ###

      #Set flag to true by default, if any check fails it will be set to false
      # Innocent until proven guilty
      bValidZipCode = true

      # Skip check if value is nil
      if ((self !=nil) && (self !="nil"))

        # BEGIN - SETP 1 - Value is not a string
        if(self.class.to_s == "String")

          # BEGIN - STEP 2 - Syntax of <5 digits> or <5-digits>-<4-digits>
          if self !~ /(^\d{5}$)|(^\d{5}-\d{4}$)/

            bValidZipCode = false

            if($VERBOSE == true)
              puts2("   ## Invalid Zip Code syntax " + self.to_s)
            end

          end  # END - STEP 2 - Syntax is valid

        else # SETP 1 - Value is not string

          bValidZipCode = false

          if($VERBOSE == true)
            puts2("   ## Zip Code not a string, its a " + self.class.to_s)
          end

        end # END - SETP 1 - Value is not a string
      end # Skip check if value is nil

    rescue => e

      puts2("*** WARNING - Checking Zip Code", "WARN")
      puts2("*** WARNING and Backtrace: " + e.message + "\n" + e.backtrace.join("\n"),"WARN")

    ensure

      return bValidZipCode

    end ### END - Check the Zip Code  ###

  end # Method - isValid_ZipCode?

  #=============================================================================#
  #--
  # Method: prefix(...)
  #
  #++
  #
  # Description: Returns only the prefix of the string.
  #
  #              The prefix is the characters proceeding the first Delimiter
  #              of the string.
  #
  # HINT: Use to separate file extensions from file names, or to separate
  #       strings like email addresses, or domain names into their sub components.
  #
  # Returns: STRING = The prefix of the string
  #
  # Syntax: sDelimiter = STRING - The character to use as the delimiter
  #
  # Usage Examples:
  #               1) To verify a file name (without extension) is "some_file"
  #                    sMyFile = "some_long_filename.log"
  #                    sMyFilePrefix = sMyFile.prefix(".")
  #                    assert(sMyFilePrefix == "some_file")
  #
  #               2) To verify the user account of a Email address is "joe"
  #                    sMyEmailAddress = "joe@gmail.net"
  #                    sMyUserAccount = sMyEmailAddress.prefix("@")
  #                    assert(sMyUserAccount == "joe")
  #
  #               3) To verify the protocol of a URL is "http"
  #                    browser.goto("google.com")
  #                    sMyURL = browser.url
  #                    sMyPrefix = sMyURL.prefix(":")
  #                    assert(sMyPrefix.downcase == "http")
  #
  #               4) To return the first word in a string
  #                    sMyString = "This is a test"
  #                    sMyFirstWord = sMyString.prefix(" ")
  #                    assert(sMyFirstWord == "This")
  #
  #=======================================================================#
  def prefix(sDelimiter = ".")

    if($VERBOSE == true)
      puts2("Parameters - prefix:")
      puts2("  sDelimiter: " + sDelimiter)
    end

    # Set default return value
    sPrefix = self

    begin

      # Only allow single character delimiter's, Use 1st char if multiple chars were specified
      sDelimiter = sDelimiter[0]

      # Remove any training whitespace
      sString = self.strip

      # Find index of the Delimiter
      iIndex = sString.index(sDelimiter)

      # Save character 0, up to the Delimiter's index, leaving off the Delimiter
      sPrefix = sString[0,iIndex]

    rescue

      return self  # If something went wrong, return the original string. No harm no foul

    end

    return sPrefix # Return the modified string

  end # Method -prefix()

  #=============================================================================#
  #--
  # Method: suffix(...)
  #
  #++
  #
  # Description: Returns only the suffix of the string.
  #
  #              The suffix is the characters following the last Delimiter
  #              to the end of the string.
  #
  # HINT: Use to separate file extensions from file names, or to separate
  #       strings like email addresses, or domain names into their sub components.
  #
  # Returns: STRING = The suffix of the string
  #
  # Syntax: sDelimiter = STRING - The character to use as the delimiter
  #
  # Usage Examples:
  #               1) To verify a file name extension is "log"
  #                    sMyFile = "some_long_filename.log"
  #                    sMyFileExtension = sMyFile.suffix(".")
  #                    assert(sMyFileExtension == "log")
  #
  #               2) To verify the Domain of a Email address is "gmail.net"
  #                    sMyURL = "me@gmail.net"
  #                    sMySuffix = sMyURL.suffix("@")
  #                    assert(sMySuffix == "gmail.net")
  #
  #               3) To verify the Top Level Domain of a URL is "net"
  #                    sMyDomain = "gmail.net"
  #                    sMySuffix = sMyDomain.suffix(".")
  #                    assert(sMySuffix == "net")
  #
  #               4) To return the last word in a string
  #                    sMyString = "This is a test"
  #                    sMyLastWord = sMyString.suffix(" ")
  #                    assert(sMyLastWord == "test")
  #
  #=======================================================================#
  def suffix(sDelimiter = ".")

    if($VERBOSE == true)
      puts2("Parameters - suffix:")
      puts2("  sDelimiter: " + sDelimiter)
    end

    # Set default return value
    sSuffix = self

    begin

      # Only allow single character delimiter's, Use 1st char if multiple chars were specified
      sDelimiter = sDelimiter[0]

      # Remove any training whitespace
      sString = self.strip

      # Flip the string so that the suffix is at the beginning
      sReversedString = sString.reverse

      # Find index of the Delimiter
      iIndex = sReversedString.index(sDelimiter)

      # Save character from 0, up to the Delimiter's index, leaving off the Delimiter
      sReversedString = sReversedString[0,iIndex]

      #Flip the remaining string which now has the suffix by itself
      sSuffix = sReversedString.reverse

    rescue

      return self  # If something went wrong, return the original string. No harm no foul

    end

    return sSuffix # Return the modified string

  end # Method - suffix()

  #=============================================================================#
  #--
  # Method: remove_prefix(...)
  #
  #++
  #
  # Description: Returns the string with the prefix removed.
  #
  #              The prefix is the characters proceeding the first Delimiter
  #              of the string.
  #
  # HINT: Use to separate file extensions from file names, or to separate
  #       strings like email addresses, or domain names into their sub components.
  #
  # Returns: STRING = The string with the prefix removed.
  #
  # Syntax: sDelimiter = STRING - The character to use as the delimiter
  #
  # Usage Examples:
  #               1) To verify a file name extension is "log"
  #                    sMyFile = "some_long_filename.log"
  #                    sMyFileExt = sMyFile.remove_prefix(".")
  #                    assert(sMyFileExt == "log")
  #
  #               2) To verify the domain of a Email address is "gmail.net"
  #                    sMyEmailAddress = "joe@gmail.net"
  #                    sMyDomain = sMyEmailAddress.remove_prefix("@")
  #                    assert(sMyDomain == "gmail.net")
  #
  #               3) To return the string with the first word removed
  #                    sMyString = "This is a test"
  #                    sMyStringLessFirstWord = sMyString.remove_prefix(" ")
  #                    assert(sMyStringLessFirstWord == "is a test")
  #
  #=======================================================================#
  def remove_prefix(sDelimiter = ".")

    if($VERBOSE == true)
      puts2("Parameters - remove_prefix:")
      puts2("  sDelimiter: " + sDelimiter)
    end

    # Set default return value
    sString = self

    begin

      # Only allow single character delimiter's, Use 1st char if multiple chars were specified
      sDelimiter = sDelimiter[0]

      # Remove any training whitespace
      sString = self.strip

      # Find index of the Delimiter
      iIndex = sString.index(sDelimiter)

      # Find the length of the string
      iStringLength = sString.length

      # Save characters from one after the Delimiter's index, leaving off the Delimiter, to the end of the string
      sString = sString[iIndex + 1, iStringLength]

    rescue

      return self  # If something went wrong, return the original string. No harm no foul

    end

    return sString # Return the modified string

  end # Method - remove_prefix()

  #=============================================================================#
  #--
  # Method: remove_suffix(...)
  #
  #++
  #
  # Description: Returns the string with the suffix removed.
  #
  #              The suffix is the characters following the last Delimiter
  #              to the end of the string.
  #
  # HINT: Use to separate file extensions from file names, or to separate
  #       strings like email addresses, or domain names into their sub components.
  #
  # Returns: STRING = The string with the suffix removed
  #
  # Syntax: sDelimiter = STRING - The character to use as the delimiter
  #
  # Usage Examples:
  #               1) To verify a file name without the extension is "some_long_filename"
  #                    sMyFile = "some_long_filename.log"
  #                    sMyFileLessExtension = sMyFile.remove_suffix(".")
  #                    assert(sMyFileLessExtension == "some_long_filename")
  #
  #               2) To verify the User Account of a Email address is "me"
  #                    sMyURL = "me@gmail.net"
  #                    sMyStringLessSuffix = sMyURL.remove_suffix("@")
  #                    assert(sMyStringLessSuffix == "me")
  #
  #               3) To verify the To Level Domain of a URL is "net"
  #                    sMyDomain = "gmail.net"
  #                    sMySuffix = sMyDomain.remove_suffix(".")
  #                    assert(sMySuffix == "net")
  #
  #               3) To return the last word in a string
  #                    sMyString = "This is a test"
  #                    sMyLastWord = sMyString.remove_suffix(" ")
  #                    assert(sMyLastWord == "test")
  #
  #=======================================================================#
  def remove_suffix(sDelimiter = ".")

    if($VERBOSE == true)
      puts2("Parameters - remove_suffix:")
      puts2("  sDelimiter: " + sDelimiter)
    end

    # Set default return value
    sString = self

    begin

      # Only allow single character delimiter's, Use 1st char if multiple chars were specified
      sDelimiter = sDelimiter[0]

      # Remove any training whitespace
      sString = self.strip

      # Flip the string so that the suffix is at the beginning
      sReversedString = sString.reverse

      # Find the length of the string
      iStringLength = sReversedString.length

      # Find index of the Delimiter
      iIndex = sReversedString.index(sDelimiter)

      # Save character from 0, up to the Delimiter's index, leaving off the Delimiter
      sReversedString = sReversedString[iIndex + 1, iStringLength]

      #Flip the remaining string which now has the suffix by itself
      sString = sReversedString.reverse

    rescue

      return self  # If something went wrong, return the original string. No harm no foul

    end

    return sString # Return the modified string

  end # Method - remove_suffix()

  #=============================================================================#
  #--
  # Method: to_sentence(...)
  #
  #++
  #
  # Description: Converts a string, of one or more words, into a sentence by
  #              Capitalizing it and appending a randomly selected punctuation mark (. ? !)
  #
  # Returns: STRING = The Capitalized string with the punctuation mark appended.
  #
  # Syntax: N/A
  #
  # Usage Examples:
  #                 To change the string "this is a string" into a sentence
  #                    sMyString = "this is a string"
  #                    sSentence = sMyString.to_sentence
  #                    puts2(sSentence)   #=> This is a string?
  #
  #
  #=======================================================================#
  def to_sentence()

    # Skip if nil or blank
    if(self.nil? || self == "")
      return self
    end

    # Define the punctuation marks
    aPunctuationMarks = [".", "?", "!"]

    # Randomly select a punctuation mark to append
    sRandomPunctuationMark = aPunctuationMarks[random_number(0,2)]

    if($VERBOSE == true)
      puts2("sRandomPunctuationMark: " + sRandomPunctuationMark)
    end

    begin

      sString = self

      # Remove any training whitespace and apply the capitalization to the 1st char in the string
      sString.strip!
      sString.capitalize!

      # Determine if the string ends with a period, question mark or exclamation point.
      if(sString =~ /.*[\.\?\!]$/ )

        # No need to append punctuation so apply the capitalization to the 1st char in the string
        return sString
      else
        # Append punctuation to the string
        sString << sRandomPunctuationMark
        return sString
      end

    rescue

      return self  # If something went wrong, return the original string. No harm no foul

    end

    return sSuffix # Return the modified string

  end # Method - to_sentence()

  #=============================================================================#
  #--
  # Method: word_count()
  #++
  #
  # Description:  Counts the words in a String like UNIX's word count command.
  #               Words are counted as contiguous characters separated by whitespace.
  #               Does not count whitespace.
  #
  # Returns: FIXNUM = The number of words that were counted in the strings
  #
  # Usage Examples:
  #
  #     1.  puts2("hello world").word_count #=> 2
  #
  #     2.  sStringVariable = "Don't count contractions or hyphens as two-words"
  #
  #            aArrayOfStrings = [
  #              "Two words",
  #              "  Multiple   Whitespace including tabs\t are ignored. Doesn't count new line\n or 123-456 \n a+b i:2  1/2    ",
  #              "#{sStringVariable}",
  #              "THE END"
  #              ]
  #
  #           aArrayOfStrings.each do |  sString |
  #           puts2("String: #{sString}")
  #           puts2("  Word count: #{sString.word_count.to_s}")
  #
  #         #> String:   Multiple   Whitespace is 	ignored. New line
  #          also.
  #          123-456
  #          a+b i:2  1/2
  #           Word count: 11
  #         String: Doesn't count contractions or hyphens as two-words
  #           Word count: 7
  #         String: THE END
  #           Word count: 2
  #
  #=============================================================================#
  def word_count()
    self.split(" ").length
  end # Method - word_count

  alias wc word_count

end # Class - String

#=============================================================================#
#--
# Class: WatirWorksLogger
#++
#
# Description: Based on the Ruby Logger class, but adds the ability to set the default log level.
#              And adds ability to pass log level of any message as a parameter.
#
#--
# Methods:
#          initialize(fileName, logsToKeep, maxLogSize)
#          log(sMessage, sLogLevel="info")
#++
#=============================================================================#
class  WatirWorksLogger < Logger
  #=============================================================================#
  #--
  # Method: initialize(...)
  #
  # TODO: Create a logger which ages logfile daily/weekly/monthly
  # Per Ruby Logger class:
  #   myLogger = Logger.new('foo.log', 'daily')
  #   myLogger = Logger.new('foo.log', 'weekly')
  #   myLogger = Logger.new('foo.log', 'monthly')
  #
  #++
  #
  # Description: Defines parameters to open a new log file.
  #
  #              Clone of Watir::WatirLogger.new but adds ability to specify a self.level
  #              Changed from WatirLogger's hard coded value of: Logger::DEBUG
  #              to a user specified version that is default to INFO, but
  #              can be changed to Logger::DEBUG or other supported log levels.
  #
  # Syntax: sFullPathToFile = STRING - name of the file create for use as the log file
  #                                    Default value is "Logfile.log"
  #
  #         iLogsToKeep = INTEGER -  The total number of log files that can be saved.
  #                                  When the current log file reaches the maxLogSize a new file is opened.
  #                                     (e.g. 10 = keep up to 10 log files)
  #                                  Default value is 50
  #
  #         iMaxLogSize = INTEGER - The file size in bytes for any individual log file. Once this
  #                                 value is reached a new log file is opened.
  #                                    (e.g. 1000000 = 1Mb)
  #                                 Default value is 5000000    5Mb
  #
  #         sLogLevel = STRING - The message level. One of the following (Per the Ruby Core API):
  #                              Messages have varying levels (info, error, etc), reflecting their varying importance.
  #                              The levels, and their meanings, are:
  #                                   FATAL: an unhandleable error that results in a program crash
  #                                   ERROR: a handleable error condition
  #                                   WARN: a warning
  #                                   INFO: generic (useful) information about system operation
  #                                   DEBUG: low-level information for developers
  #                              Default value is  "INFO"
  #
  #=============================================================================#
  def initialize(sFullPathToFile="Logfile.log", iLogsToKeep=50, iMaxLogSize= 5000000, sLogLevel="INFO")

    super(sFullPathToFile , iLogsToKeep, iMaxLogSize)

    if((iLogsToKeep < 1) |  (iLogsToKeep > 1000))
      iLogsToKeep=50
    end

    if((iMaxLogSize < 1) |  (iMaxLogSize > 100000000))
      iMaxLogSize=5000000
    end

    case sLogLevel
    when "UNKNOWN"
      self.level = Logger::UNKNOWN  # Define the default logging level to be the Unknown level

    when "FATAL"
      self.level = Logger::FATAL  # Define the default logging level to be the Fatal level

    when "ERROR"
      self.level = Logger::ERROR  # Define the default logging level to be the Error level

    when "WARN"
      self.level = Logger::WARN  # Define the default logging level to be the Warning level

    when "INFO"
      self.level = Logger::INFO  # Define the default logging level to be the Informational level

    else
      self.level = Logger::DEBUG  # Define the default logging level to be the Debug level
    end

    # Define the format of the time stamps (e.g. 19-Oct-2007 14:39:15)
    self.datetime_format = "%d-%b-%Y %H:%M:%S"

    # Enter initial informational message into the log file
    self.info(" Starting WatirWorks Logger...")

  end # Method - initialize

  #=============================================================================#
  #--
  # Method: log(...)
  #++
  #
  # Description:  Modified version of the Ruby "log" method so that the log level can be
  #               specified as a parameter. This allows a single log method to be used.
  #                  For example:
  #                     MyLogger.log("Program started", "INFO")
  #                     MyLogger.log("Program failed", "ERROR")
  #
  #               Instead of the original method where log levels were individual log methods, such as:
  #                  MyLogger.log.info("Program started")
  #                  MyLogger.log.error("Program failed")
  #
  #
  #               Appends the <message> to the log file with the specified
  #               message level (FATAL, ERROR, WARN, INFO, DEBUG),
  #               and echos to STDOUT anything that is written to the log file.
  #
  #                  Example of the syntax of an INFO message in the log:
  #                     I, [<datetime>]  INFO -- : <message>
  #
  #                  Example of the syntax of an ERROR message in the log:
  #                     E, [<datetime>] ERROR -- : <message>
  #
  #
  # Syntax:
  #         sMessage = STRING - The text of the message to be logged
  #         sLogLevel = STRING - The message level. One of the following (Per the Ruby Core API):
  #                              Messages have varying levels (info, error, etc), reflecting their varying importance.
  #                              The levels, and their meanings, are:
  #                                   FATAL: an unhandleable error that results in a program crash
  #                                   ERROR: a handleable error condition
  #                                   WARN: a warning
  #                                   INFO: generic (useful) information about system operation
  #                                   DEBUG: low-level information for developers
  #                              Defaults to level 1 (INFO) of no sLogLevel is specified.
  #
  # Usage Examples:
  #          myLogger.log("My Informational message")            # Log an info message
  #          myLogger.log("My Informational message", "INFO")    # Log an info message
  #          myLogger.log("My Warning message", "WARN")
  #          myLogger.log("My Debug message", "DEBUG")
  #          myLogger.log("My Error message", "ERROR")
  #          myLogger.log("My Fatal message", "FATAL")
  #=============================================================================#
  def log(sMessage, sLogLevel="INFO")

    #if($VERBOSE == true)
    #  puts2("Parameters - log:")
    #  puts2("  sMessage: " + sMessage)
    #  puts2("  sLogLevel: " + sLogLevel)
    #end

    # Define the valid log level settings
    aValidLogLevels = ["FATAL", "ERROR", "WARN", "INFO", "DEBUG"]

    # Validate the Log Level value
    if(aValidLogLevels.include?(sLogLevel.upcase) == false)
      sLogLevel = "FATAL"
    end

    # puts2("#{sMessage}\n")  # Echo all messages to stdout

    case sLogLevel.upcase
    when  "DEBUG"
      debug(sMessage)           # Calls level 0 error in logger.rb
    when  "INFO"
      info(sMessage)             # Calls  level 1 info  in logger.rb
    when "WARN"
      warn(sMessage)           # Calls  level 2 warn in logger.rb
    when "ERROR"
      error(sMessage)           # Calls  level 3 error in logger.rb
    when "FATAL"
      fatal(sMessage)           # Calls  level 5 fatal in logger.rb
    else
      info(sMessage)           # If no level is specified, Calls level 1 info in logger.rb
    end
  end # method - log

end # Class - TestLogger

# END File - watirworks_utilities.rb
