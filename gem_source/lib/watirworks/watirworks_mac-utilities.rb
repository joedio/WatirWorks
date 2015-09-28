#=============================================================================#
# File: watirworks_mac-utilities.rb
#
#  Copyright (c) 2008-2015, Joe DiMauro
#  All rights reserved.
#
# Description:
#    Functions and methods for WatirWorks that are specific to the Mac/OSx platform.
#    but not specific to any particular Application Under Test, or Browser.
#
#    Extends some Ruby or Watir classes with additional, hopefully useful, methods.
#
#    Some of these methods and functions have been collected from, or based upon
#    Open Source versions found on various sites in the Internet, and are noted.
#
#--
# Modules:
#    WatirWorks_MacUtilities
#
#++
#=============================================================================#

#=============================================================================#
# Require and Include section
# Entries for additional files or methods needed by these methods
#=============================================================================#
require 'rubygems'

#============================================================================#
# Module: WatirWorks_MacUtilities
#============================================================================#
#
# Description:
#    Functions and methods for WatirWorks that are specific to the Mac/OSx platform.
#    but not specific to any particular Application Under Test, or Browser.
#
#    Extends some Ruby or Watir classes with additional, hopefully useful, methods.
#
#    Some of these methods and functions have been collected from, or based upon
#    Open Source versions found on various sites in the Internet, and are noted.
#
# Instructions: To use these methods in your scripts add these commands:
#                        require 'watirworks'
#                        include WatirWorks_MacUtilities
#
#--
# Table of Contents
#
#  Please manually update this TOC with the alphabetically sorted names of the items in this module,
#  and continue to add new new methods alphabetically into their proper location within the module.
#
#  Key:   () = No parameters,  (...) = parameters required
#
# Methods:
#
#    save_screencapture_mac(...)
#
# Pre-requisites:
# ++
#=============================================================================#
module WatirWorks_MacUtilities

  # Version of this module
  WW_MAC_UTILITIES_VERSION =  "0.0.3"


  #=============================================================================#
  #--
  # Method: save_screencapture_mac()
  #
  #++
  #
  # Description: Save a screen capture of the current web page or desktop to a file using ImageMagick.
  #
  #              For details on ImageMagick see:
  #                 http://www.imagemagick.org
  #              or
  #                 man imagemagick
  #                 man import
  #              If ImageMagick is not already installed perform the following:
  #                 sudo port install ImageMagick
  #
  # Returns: BOOLEAN = true on success, otherwise false
  #
  # Syntax: sFileNamePrefix = STRING - The left most part of the filename (Defaults to "ScreenShot")
  #
  #         bActiveWindowOnly = BOOLEAN - true  = save current window (default)
  #                                       false = save entire desktop
  #
  #         bSaveAsJpg = BOOLEAN - true  = save a JPEG file (default)
  #                                false = save a PNG file
  #
  #         sOutputDir = STRING -  Directory that the file is saved under (Defaults to /tmp )
  #
  #
  # Prerequisites: ImageMagick must be installed on the local filesystem
  #
  # Usage Examples:
  #
  #=============================================================================#
  def save_screencapture_mac(sFileNamePrefix="", bActiveWindowOnly=false, bSaveAsJpg=true, sOutputDir="/tmp")

    if($VERBOSE == true)
      puts2("Parameters - save_screencapture_mac:")
      puts2("  sFileNamePrefix: " + sFileNamePrefix)
      puts2("  bActiveWindowOnly: " + bActiveWindowOnly.to_s)
      puts2("  bSaveAsJpg: " + bSaveAsJpg.to_s)
      puts2("  sOutputDir: " + sOutputDir)
    end

    if(is_mac?) # Only run on mac

      # Default to the tmp folder on local filesystem, as it allows write permissions
      if(sOutputDir == "")
        sOutputDir = "/tmp"
      end

      # Define file format parameters
      if bSaveAsJpg
        sFileExt = ".jpg"
        sFormat = " -format JPEG "
        sOptions = " -type TrueColor "
      else
        sFileExt = ".png"
        sFormat = " -format PNG "
        sOptions = " -type TrueColor "
      end

      # Define the region of the capture
      if bActiveWindowOnly
        sScreen_Region = "_window_"
        sWindowID = (self.title + " - Mozilla Firefox")
      else
        sScreen_Region = "_desktop_"
        sWindowID = " root "
      end

      # Combine the elements to make a unique file name prefix
      sFilename = sFileNamePrefix + sScreen_Region + Time.now.strftime(DATETIME_FILEFORMAT).to_s + sFileExt

      sFullPathToImageFile = File.join(sOutputDir, sFilename)

      if($VERBOSE)
        puts2("Capturing window: #{sWindowID}")
      end

      # Minimize the Ruby Console window so it doesn't block the browser window
      #minimize_ruby_console()

      # Perform the screen capture
      system("import #{sFormat} -window #{sWindowID} #{sFullPathToImageFile} #{sOptions}")

      puts2("Saved image to: #{sFullPathToImageFile}")


    end # Only run on mac


  end # Method - save_screencapture_mac()

end # Module - WatirWorks_MacUtilities

  #=============================================================================#
  # Class: Watir::Safari
  #
  # Description: Extends the Watir::Safari class with additional methods
  #              This class is is NOT supported if using Watir, FireWatir or Watir_WebDriver
  #
  #--
  # Methods:
  #
  #          restart()
  #          scrollBy(...)
  #          title()
  #          title_from_url
  #++
  #=============================================================================#
  class Watir::Safari


    #=============================================================================#
    #--
    # Method: restart(...)
    #
    #++
    #
    # Description: Close the current browser object, pause,
    #              then create and return a new browser object.
    #              Any URL that the current browser is displaying is lost.
    #
    # Returns: BROWSER object
    #
    # Syntax: sURL = STRING - The URL to load in the new browser, defaults to the currently loaded URL
    #
    #         bClearCache = BOOLEAN - true - clear the cache and cookies after the old browser closes, but before the new browser starts
    #                                 false - don't clear the cache & cookies
    #
    # Usage Examples:
    #            To restart Global Browser Object with the same URL loaded:
    #                $browser = $browser.restart()
    #
    #            To restart local browser object (e.g. myCurrentBrowser) with a different url:
    #                myRestartedBrowser = myCurrentBrowser.restart("www.myNewURL.com")
    #
    #=============================================================================#
    def restart(sURL ="", bClearCache = false)

      if($VERBOSE == true)
        puts2("Parameters - restart:")
        puts2("  sURL: " + sURL)
      end

      puts2("Closing the browser...")

      if(sURL=="")
        sURL = self.url
      end

      self.close

      if($browser == self) # If a Global Browser Object exists remove it
        $browser = nil
      end

      # Allow time to mourn the passing of the old browser.
      sleep 3  # That's long enough to mourn

      if(bClearCache == true)
        clear_cache()
      end

      puts2("Starting a new browser object...")

      # Create a new browser object using Watir's method directly
      # Can't use start_Browser() as both local and Global Browser's may coexist
      oBrowser = Watir::Safari.new
      oBrowser.goto(sURL)

      # Allow time to celebrate the birth of the new browser.
      sleep 2  # That's long enough to celebrate

      return oBrowser  # Return the new browser.

    end # Method - restart()


    #=============================================================================#
    #--
    # Method: scrollBy(...)
    #
    #++
    #
    # Description: Scroll the current Browser window (in pixels)
    #              Per: http://www.w3schools.com/jsref/obj_window.asp
    #                    The ScrollBy() method is supported in all major browsers.
    #
    # Returns: BOOLEAN - true if successful, otherwise false
    #
    # Syntax: iHorizontal = INTEGER - How many pixels to scroll by, along the x-axis (horizontal)
    #                                 Positive values move scroll left, Negative values move scroll right
    #                                 Default value = 0
    #
    #         iVertical = INTEGER - How many pixels to scroll by, along the y-axis (vertical)
    #                               Positive values move scroll down, Negative values move scroll up
    #                               Default value = 0
    #
    # Usage Examples:
    #                To scroll the browser vertically by 100 pixels
    #                     browser.scrollBy(0, 100)
    #
    #=============================================================================#
    def scrollBy(iHorizontal=0, iVertical=0)

    # Return hard coded value until watir-webdriver supports JavaScript
    bReturnStatus = true
=begin
      self.goto("javascript:window.scrollBy(#{iHorizontal},#{iVertical})")
=end
    return bReturnStatus

    end # Method - scrollBy()

    #=============================================================================#
    #--
    # Method: status()
    #
    #++
    #
    # Description: SafariWatir does not support browser.status().
    #              This method is hard coded to delay and always return "Done"
    #
    # Returns: STRING - Hard coded to delay and always return "Done"
    #
    # Syntax: N/A
    #
    # Usage Examples:
    #
    #                     browser.status()
    #
    #=============================================================================#
    def status()
      sleep 2
      return "Done"

    end # Method - status()

    #=============================================================================#
    #--
    # Method: title_from_url()
    #
    #++
    #
    # Description:  When a file is loaded in browser served by file system in location "c:\data\file.html"
    #               And the title tag is empty ""
    #               Then url method returns file:/// format "file:///c:/data/file.html"
    #               But the window title displays "c:\data\file.html"
    #               this method massages the locationUrl and returns its representation in title bar
    #
    #  From: http://gist.github.com/141738
    #
    #=============================================================================#
    def title_from_url()

      loc = url # relies on browser.url to return @browser.locationUrl and not @browser.document.url
       (loc[0,8] == "file:///") ? loc.split("file:///")[1].gsub("/", '\\') : loc

    end #  Method - title_from_url()

  end # Class - Safari

# END File - watirworks_mac-utilities.rb
