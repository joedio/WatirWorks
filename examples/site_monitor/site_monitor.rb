#--
#=============================================================================#
# File:  site_monitor.rb
#
#  Copyright (c) 2008-2010, Joe DiMauro
#  All rights reserved.
#
# Description:  This script attempts to access a set of user specified web sites.
#
#               It uses WatirWorks to determine if each site is accessible, and logs results to a
#               file in the current working directory.
#
#               If the site is not accessible an email is generated and
#               sent to the specified email accounts associated with
#               that site via the user specified SMTP server.
#
#               Data for the script is read from an Excel workbook
#               which should be in the same directory as this file.
#
#               The workbook needs to be updated with information
#               on the web sites to monitor, and the email server's
#               information, and the email accounts to contact.
#
#               Please refer to information in the workbook for details.
#
#               Aside from the email messages that are sent if a site is inaccessible, two additional files
#               are auto-generated when this script runs. They are created in the same directory
#               as the site_monitor.rb script resides:
#                   stdout.txt - Contains the text normally sent to STDOUT and STDERR
#                   site_monitor.log - Contains information recorded by the script
#
#
#
# NOTE: This script is partly based on code by Alister Scott
#               http://watirmelon.wordpress.com/
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
# Global Variables section
# Set global variables that control the test execution
#=============================================================================#

# Ruby - Global variables
#
$VERBOSE=false      # Set to true for help in debugging
$DEBUG=false

# Watir - Global variables
#
# IE - Global variables
$FAST_SPEED=true  # Set to true to type fast, or false to type at normal speed
$HIDE_IE = false # Set to true to hide the browser window, or false to keep it visible
#
# Firefox - Global Variables
#

# WatirWorks - Global variables
#

# Application Under Test - Global variables
#


#===================================================
# Main
#===================================================
class Monitor_WebSites
  
  # Clear the error flag
  @bErrorReadingDataFlag = false
  
  require "socket" # For getting host name
  @sHostname = Socket.gethostname
  
  # Name of the log file
  sLogFileName = "site_monitor.log"
  
  # Define placeholder values that will be populated from
  # the data read in from the Excel workbook
  @sSMTP_SERVER = "localhost"
  @iSMTP_PORT = 25
  @sFromAddress = ""
  @sFromAlias = "Site Monitor"
  @sToAddress = ""
  @sURL = ""
  
  @hSMTP_Data = Hash.new
  @SITE_Data = Hash.new
  
  @sPWD = Dir.getwd
  @sBasename = File.basename(@sPWD)
  @sLogFile = @sPWD + "/" + sLogFileName
  
  begin # Read the data from the Excel workbook
    
    # Define values needed to read workbook
    sDataDirectory = @sBasename
    sWorkbook = "site_monitor_data.xls"
    bDataInRows = true
    sCellRange = ""
    sLabel = ""
    aSpreadsheet_List = ["SMTP" , "SITES"]
    
    if($VERBOSE == true)
      puts2("sDataDirectory: "+ sDataDirectory)
      puts2("sWorkbook: "+ sWorkbook)
      puts2("bDataInRows: "+ bDataInRows.to_s)
      puts2("sCellRange: "+ sCellRange)
      puts2("sLabel: "+ sLabel)
      puts2("aSpreadsheet_List: "+ aSpreadsheet_List[0].to_s + ", " + aSpreadsheet_List[1].to_s)
    end
    
    hWorkbookHash = Hash.new
    
    puts2("Time: #{Time.now.strftime( "%A %m/%d/%y %I:%M %p" ).to_s}")

      # Verify that the data file exists
      if(FileTest.exist?("#{@sPWD}/#{sWorkbook}"))
         puts2("Reading data from Excel Workbook: #{@sPWD}/#{sWorkbook}")
         else
         puts2("*** ERROR - Reading data from Excel Workbook: #{sDataDirectory}/#{sWorkbook}")
      end

      # Read the data from each sheet in the workbook into a hash of hashes
      # Top-level hash contains a hash of each sheet (secondary hash), keyed by sheet name
      # Secondary hashes (keyed by sheet name), contain data for each heading (keyed by heading) on that sheet,
      hWorkbookHash = parse_workbook_xls(sWorkbook, aSpreadsheet_List, sCellRange, bDataInRows, sDataDirectory, sLabel)

      if ($VERBOSE == true)
          puts2("Was a Hash or array returned?  #{hWorkbookHash.class.to_s}")
      end

      # Split the Workbook hash
      @SITE_Data = hWorkbookHash["SITES"]
      @aSMTP_Data = hWorkbookHash["SMTP"]
      @hSMTP_Data = @aSMTP_Data[0]

      if($VERBOSE == true)
          puts2("Was a Hash or array returned?  #{@hSMTP_Data.class.to_s}")
          puts2 @hSMTP_Data
          puts2("@SITE_Data =  #{@SITE_Data.class.to_s}")
          puts2 @SITE_Data
      end

      # Now that the individual spreadsheet hashes exist
      # Clear the workbook hash to free up memory
      hWorkbookHash = nil

      # Replace the placeholder values with the data read from the Workbooks SMTP spreadsheet
      @sSMTP_SERVER = @hSMTP_Data["SMTP_SERVER"]
      @iSMTP_PORT = @hSMTP_Data["SMTP_PORT"].to_i
      @sFromAddress = @hSMTP_Data["FromAddress"]
    @sFromAlias = @hSMTP_Data["FromAlias"]
    
  rescue => e
    
    puts2("*** ERROR - Reading Excel workbook")
    puts2("Error and Backtrace: " + e.message + "\n" + e.backtrace.join("\n"))
    
    @bErrorReadingDataFlag = true
    
  ensure
    
  end  # Read the data from the Excel workbook
  
  begin # Monitor the web sites
    
    if(@bErrorReadingDataFlag == false) # Data was read
      
      # Record loop
      @SITE_Data.each do | record |
        
        sIncludeSite = record["INCLUDE"]
        sWebSiteName = record["WEB_SITE"]
        sURL = record["URL"]
        sToAddress = record["NOTIFY"]
        aNotifyList = sToAddress.split()
        
        if(sIncludeSite.upcase != "YES") #  Included if flag is set
          puts2("\n Excluded site: #{sWebSiteName}")
          
        else
          puts2("\nMontioring site: #{sWebSiteName}")
          puts2(" URL: #{sURL}")
          puts2(" Notify: #{sToAddress}")
          
          # Reset the flag to the default for each pass through the record loop.
          # Innocent until ...
          sStatus = "Passed"
          
          # Current time
          sDate_time = Time.now.strftime( "%A %m/%d/%Y %I:%M %p" )
          
          # Start a new web browser
          @browser = Watir::Browser.start("about:blank")
          
          sleep 1  # allow time for the browser to open
          
          # Check if the current URL is accessible
          bURL_accessible = @browser.is_url_accessible?(sURL)
          
          if($VERBOSE == true)
            puts2("bURL_accessible = " + bURL_accessible.to_s)
          end
          
          # Close the browse
          puts2(" Closing the browser")
          @browser.close
          
          if !(bURL_accessible)
            sStatus = "FAILED"
          end
          
          # Record the download time of the last IE page loaded
          sAccessTime = @browser.down_load_time.to_s
          
          # Delete the current browser object
          @browser = nil
          
          puts2(" #{sStatus} URL: #{sURL}")
          
          # Record the results in the log file
          File.open(@sLogFile, File::WRONLY|File::APPEND|File::CREAT, 0666) do |log_file|
            log_file.puts2 "#{sDate_time}, #{sStatus}, Host: #{@sHostname}, Access time: #{sAccessTime}, Site: #{sWebSiteName},  URL: #{sURL}"
          end # File closes automatically
          
          if !(bURL_accessible) # Send the email
            sSubjectLine = "Failed to access URL: <#{sURL}>"
            sMessageBody = "#{sDate_time}\n\n#{sSubjectLine} \n\nPossible problem with the Web Site: #{sWebSiteName}.\n\nThis email is auto-generated by the WatirWorks Site Monitor. Please do not reply to the email"
            
            aNotifyList.each do |sToAddress |
              # Send individual email to the account listed  in the spreadsheet for the failing site
              send_email_smtp(@sSMTP_SERVER, @sFromAddress, sToAddress,
                              sSubjectLine, sMessageBody, @sFromAlias)
            end
            
          end # Send the email
          
        end # END - Included if flag is set
      end # Record loop
      
    end # Data was read
    
  rescue => e
    
    puts2("*** ERROR Backtrace: " + e.message + "\n" + e.backtrace.join("\n"), "ERROR")
    
  ensure
    
    if(@browser)
      @browser.close
    end
    
    
  end # Monitor the web sites
  
end # END - Class - Monitor_WebSites

# End of file
