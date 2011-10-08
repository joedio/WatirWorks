#=============================================================================#
# File: watirworks_mac-utilities.rb
#
#  Copyright (c) 2008-2010, Joe DiMauro
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
#    clear_cache_mac()
#    get_firefox_version_mac()
#    is_firefox2_installed_mac()
#    is_firefox3_installed_mac()
#    is_firefox4_installed_mac()
#    is_firefox5_installed_mac()
#    is_firefox6_installed_mac()
#    is_firefox7_installed_mac()
#    save_screencapture_mac(...)
#
# Pre-requisites:
# ++
#=============================================================================#
module WatirWorks_MacUtilities
  
  # Version of this module
  WW_MAC_UTILITIES_VERSION =  "1.0.0"
  
  #=============================================================================#
  #--
  # Method: clear_cache_mac()
  #
  # TODO: Determine if Onyx will work and update accordingly.
  #       Heard Onyx needs Admin rights to run, which may be an issue.
  #       Another possibility is: http://creativebe.com/mainmenu/
  #++
  #
  # Description: On Mac, run Onyx, (an application) to clear the browser's Cache and cookies.
  #              You can download Onyx for free at: http://www.titanium.free.fr/index_us.html
  #                                                 http://www.apple.com/downloads/macosx/system_disk_utilities/onyx.html
  #
  #              Onyx only clears cookies if the browser is closed, so close the browser prior to invoking this method.
  #              Onyx only clears the cache if the browser is closed, so close the browser prior to invoking this method.
  #
  #  Per Watir: The method "Watir::CookieManager::WatirHelper" has been deprecated, thus leaving no other means to do this from Watir.
  #
  #             By installing and using a 3rd party tool like Onyx, the cache and cookies for IE, Firefox, and other Web browsers
  #             on the Mac/OSx platform can be cleared.  All cookies will be cleared unless you configure Onyx to exclude specific cookies.
  #
  #
  # Usage Examples: To clear the cache and cookies on a Mac/OSx system:
  #                    browser.close
  #                    clear_cache_mac()
  #
  # Pre-requisites:
  #              Onyx must be installed in the default location.
  #              Onyx must be configured to clear the various browser's cookies and cache.
  #              Configure Onyx to exclude any cookies you do NOT wish removed.
  #=============================================================================#
  def clear_cache_mac()
    
    if(is_osx?) # Only run on Mac
      
      # Default install location of the tool
      sToolInstallPath = "\\Path\\To\\Tool\\Tool.exe"
      
      sToolCommandLineOptions = ""
      
      # Determine if Tool is installed in the default location
      if(File.exists?(sToolInstallPath))
        
        puts2(" ")
        puts2("Clearing Cookies and Cache by running: " + sToolInstallPath + sToolCommandLineOptions)
        
        # Run the tool
        system(sToolInstallPath + sToolCommandLineOptions)
        sleep 3 # Allow time for the cleaner to complete
        
      else # Tool is NOT installed so skip the command and log a WARNING
        
        puts2(" ")
        puts2("WARNING - Clearing Cookies and Cache: Not performed", "WARN") # Log as a warning message
        
      end # Use Tool if its installed
      
    end # Only run on Mac
    
  end # Method - clear_cache_mac()
  
  
  #=============================================================================#
  #--
  # Method: get_firefox_version_mac()
  #
  #++
  #
  # Description: Determines if Firefox version installed in the filesystem.
  #
  # Returns: BOOLEAN = true if installed, otherwise false
  #
  # Usage Examples:
  #                 puts2("Firefox version: " + get_firefox_version_mac())
  #
  #=============================================================================#
  def get_firefox_version_mac()
    
    # Define values
    sPathToFile = "/Applications/Firefox.app/Contents/Info.plist"
    
    if(is_firefox2_installed_mac?() == true)
      sStringtoMatch = "Firefox 2"
    elsif(is_firefox3_installed_mac?() == true)
      sStringtoMatch = "Firefox 3"
    elsif(is_firefox4_installed_mac?() == true)
      sStringtoMatch = "Firefox 4"
    elsif(is_firefox5_installed_mac?() == true)
      sStringtoMatch = "Firefox 5"
    elsif(is_firefox6_installed_mac?() == true)
      sStringtoMatch = "Firefox 6"
    elsif(is_firefox7_installed_mac?() == true)
      sStringtoMatch = "Firefox 7"
    end
    
    aMatch = get_text_from_file(sStringtoMatch, sPathToFile, 0, 0)
    
    # Parse version
    aMatch.each do | aIndex |
      return (getXMLTagValue(aIndex[2].to_s, "string").prefix(",").suffix(" "))
    end # Parse version
    
  end # Method - get_firefox_version_mac()
  
  #=============================================================================#
  #--
  # Method: is_firefox2_installed_mac?()
  #
  #++
  #
  # Description: Determines if Firefox 2.x is installed in the filesystem.
  #
  #              On OSX the the Firefox version is noted in the file:
  #                 /Applications/Firefox.app/Contents/Info.plist
  #              For example Firefox v2.1.2 contains this entry:
  #                 <string>Firefox 2.1.2</string>
  #
  # Returns: BOOLEAN = true if installed, otherwise false
  #
  # Usage Examples:
  #                 if(is_firefox2_installed_mac?())
  #                      # Execute FF2 specific code
  #                 end
  #
  #=============================================================================#
  def is_firefox2_installed_mac?()
    
    # Define values
    sPathToFile = "/Applications/Firefox.app/Contents/Info.plist"
    sStringtoMatch = "Firefox 2"
    
    aMatch = get_text_from_file(sStringtoMatch, sPathToFile, 0, 0)
    
    # Check for a match
    aMatch.each do | aIndex |
      if(aIndex[0] == true)
        return true
      else
        return false
      end
    end # Check for a match
    
  end # Method - is_firefox2_installed_mac?()
  
  
  #=============================================================================#
  #--
  # Method: is_firefox3_installed_mac?()
  #
  #++
  #
  # Description: Determines if Firefox 3.x is installed in the filesystem.
  #
  #              On OSX the the Firefox version is noted in the file:
  #                 /Applications/Firefox.app/Contents/Info.plist
  #              For example Firefox v3.6.3 contains this entry:
  #                 <string>Firefox 3.6.19, 1998-2011 Contributors</string>
  #
  # Returns: BOOLEAN = true if installed, otherwise false
  #
  # Usage Examples:
  #                 if(is_firefox3_installed_mac?())
  #                      # Execute FF3 specific code
  #                 end
  #
  #=============================================================================#
  def is_firefox3_installed_mac?()
    
    # Define values
    sPathToFile = "/Applications/Firefox.app/Contents/Info.plist"
    sStringtoMatch = "Firefox 3"
    
    aMatch = get_text_from_file(sStringtoMatch, sPathToFile, 0, 0)
    
    # Check for a match
    aMatch.each do | aIndex |
      if(aIndex[0] == true)
        return true
      else
        return false
      end
    end # Check for a match
    
    
  end # Method - is_firefox3_installed_mac?()
  
  
  #=============================================================================#
  #--
  # Method: is_firefox4_installed_mac?()
  #
  #++
  #
  # Description: Determines if Firefox 4.x is installed in the filesystem.
  #
  #              On OSX the the Firefox version is noted in the file:
  #                 /Applications/Firefox.app/Contents/Info.plist
  #              For example Firefox v4.0.1 contains this entry:
  #                 <string>Firefox 4.0.1</string>
  #
  # Returns: BOOLEAN = true if installed, otherwise false
  #
  # Usage Examples:
  #                 if(is_firefox4_installed_mac?())
  #                      # Execute FF4 specific code
  #                 end
  #
  #=============================================================================#
  def is_firefox4_installed_mac?()
    
    # Define values
    sPathToFile = "/Applications/Firefox.app/Contents/Info.plist"
    sStringtoMatch = "Firefox 4"
    
    aMatch = get_text_from_file(sStringtoMatch, sPathToFile, 0, 0)
    
    # Check for a match
    aMatch.each do | aIndex |
      if(aIndex[0] == true)
        return true
      else
        return false
      end
    end # Check for a match
    
    
  end # Method - is_firefox4_installed_mac?()
  
  
  #=============================================================================#
  #--
  # Method: is_firefox5_installed_mac?()
  #
  #++
  #
  # Description: Determines if Firefox 5.x is installed in the filesystem.
  #
  #              On OSX the the Firefox version is noted in the file:
  #                 /Applications/Firefox.app/Contents/Info.plist
  #              For example Firefox v5.0.1 contains this entry:
  #                 <string>Firefox 5.0.1</string>
  #
  # Returns: BOOLEAN = true if installed, otherwise false
  #
  # Usage Examples:
  #                 if(is_firefox5_installed_mac?())
  #                      # Execute FF5 specific code
  #                 end
  #
  #=============================================================================#
  def is_firefox5_installed_mac?()
    
    # Define values
    sPathToFile = "/Applications/Firefox.app/Contents/Info.plist"
    sStringtoMatch = "Firefox 5"
    
    aMatch = get_text_from_file(sStringtoMatch, sPathToFile, 0, 0)
    
    # Check for a match
    aMatch.each do | aIndex |
      if(aIndex[0] == true)
        return true
      else
        return false
      end
    end # Check for a match
    
    
  end # Method - is_firefox5_installed_mac?()
  
  
  #=============================================================================#
  #--
  # Method: is_firefox6_installed_mac?()
  #
  #++
  #
  # Description: Determines if Firefox 6.x is installed in the filesystem.
  #
  #              On OSX the the Firefox version is noted in the file:
  #                 /Applications/Firefox.app/Contents/Info.plist
  #              For example Firefox v6.0.1 contains this entry:
  #                 <string>Firefox 6.0.1</string>
  #
  # Returns: BOOLEAN = true if installed, otherwise false
  #
  # Usage Examples:
  #                 if(is_firefox6_installed_mac?())
  #                      # Execute FF6 specific code
  #                 end
  #
  #=============================================================================#
  def is_firefox6_installed_mac?()
    
    # Define values
    sPathToFile = "/Applications/Firefox.app/Contents/Info.plist"
    sStringtoMatch = "Firefox 6"
    
    aMatch = get_text_from_file(sStringtoMatch, sPathToFile, 0, 0)
    
    # Check for a match
    aMatch.each do | aIndex |
      if(aIndex[0] == true)
        return true
      else
        return false
      end
    end # Check for a match
    
    
  end # Method - is_firefox6_installed_mac?()
  
  
  #=============================================================================#
  #--
  # Method: is_firefox7_installed_mac?()
  #
  #++
  #
  # Description: Determines if Firefox 7.x is installed in the filesystem.
  #
  #              On OSX the the Firefox version is noted in the file:
  #                 /Applications/Firefox.app/Contents/Info.plist
  #              For example Firefox v7.0.1 contains this entry:
  #                 <string>Firefox 7.0.1</string>
  #
  # Returns: BOOLEAN = true if installed, otherwise false
  #
  # Usage Examples:
  #                 if(is_firefox7_installed_mac?())
  #                      # Execute FF7 specific code
  #                 end
  #
  #=============================================================================#
  def is_firefox7_installed_mac?()
    
    # Define values
    sPathToFile = "/Applications/Firefox.app/Contents/Info.plist"
    sStringtoMatch = "Firefox 7"
    
    aMatch = get_text_from_file(sStringtoMatch, sPathToFile, 0, 0)
    
    # Check for a match
    aMatch.each do | aIndex |
      if(aIndex[0] == true)
        return true
      else
        return false
      end
    end # Check for a match
    
    
  end # Method - is_firefox7_installed_mac?()
  
  
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

# Include if not using webdriver
if(is_webdriver? != true)
  
  #=============================================================================#
  # Class: Watir::Safari
  #
  # Description: Extends the Watir::Safari class with additional methods
  #              This class is is NOT supported if using Watir, FireWatir or Watir_WebDriver
  #
  #--
  # Methods:
  #
  #          moveBy(...)
  #          moveTo(...)
  #          resizeBy(...)
  #          resizeTo(...)
  #          restart()
  #          scrollBy(...)
  #          title()
  #          title_from_url
  #++
  #=============================================================================#
  class Watir::Safari
    
    #=============================================================================#
    #--
    # Method: moveBy(...)
    #
    #++
    #
    # Description: Move the Browser window relative to its current location
    #              Per: http://www.w3schools.com/jsref/obj_window.asp
    #                   The moveBy() method is supported in all major browsers,
    #
    # Returns: BOOLEAN - true if successful, otherwise false
    #
    # Syntax: iXPos = INTEGER - The X-coordinate in pixels to re-position the top left
    #                           corner of the browser window
    #                           Default value = 0
    #
    #         iYPos = INTEGER - The Y-coordinate  in pixels to re-position the top left
    #                           corner of the browser window
    #                           Default value = 0
    #
    # Usage Examples:
    #                To reposition the browser relative to its current location by 10, -20
    #                     browser.moveBY(10, -20)
    #
    #=============================================================================#
    def moveBy(iXPos=0, iYPos=0)
      
      self.goto("javascript:window.moveBy(#{iXPos},#{iYPos})")
    end # moveBy()
    
    
    #=============================================================================#
    #--
    # Method: moveTo(...)
    #
    #++
    #
    # Description: Move the current Browser window to the specified location
    #              Per: http://www.w3schools.com/jsref/obj_window.asp
    #                   The moveTo() method is supported in all major browsers.
    #
    # Returns: BOOLEAN - true if successful, otherwise false
    #
    # Syntax: iXPos = INTEGER - The X-coordinate in pixels to position the top left
    #                           corner of the browser window
    #                           Default value = 0
    #
    #         iYPos = INTEGER - The Y-coordinate in pixels to position the top left
    #                           corner of the browser window
    #                           Default value = 0
    #
    # Usage Examples:
    #                To move the browser to 100, 200
    #                     browser.moveTo(100,200)
    #
    #=============================================================================#
    def moveTo(iXPos=0, iYPos=0)
      
      if(iXPos <0)
        iXPos = 0
      end
      if(iYPos <0)
        iYPos = 0
      end
      
      self.goto("javascript:window.moveTo(#{iXPos},#{iYPos})")
    end # moveTo()
    
    
    #=============================================================================#
    #--
    # Method: resizeBy(...)
    #
    #++
    #
    # Description: Resize the current Browser window relative to its current size (in pixels)
    #              Per: http://www.w3schools.com/jsref/obj_window.asp
    #                   The resizeBy() method is supported in all major browsers, except Opera and Chrome.
    #
    # Returns: BOOLEAN - true if successful, otherwise false
    #
    # Syntax: iHeight = INTEGER - The width in pixels to resize the browser window
    #                             Default value = 0
    #
    #         iWidth = INTEGER - The height in pixels to resize the browser window
    #                            Default value = 0
    #
    # Usage Examples:
    #                To size the browser by an additional 100, 200
    #                     browser.resizeTo(100, 200)
    #
    #=============================================================================#
    def resizeBy(iHeight=0, iWidth=0)
      
      self.goto("javascript:window.resizeBy(#{iHeight},#{iWidth})")
    end # resizeTo()
    
    
    #=============================================================================#
    #--
    # Method: resizeTo(...)
    #
    #++
    #
    # Description: Move the current Browser window to the specified location (in pixels)
    #              Per: http://www.w3schools.com/jsref/obj_window.asp
    #                   The resizeTo() method is supported in all major browsers, except Opera and Chrome
    #
    # Returns: BOOLEAN - true if successful, otherwise false
    #
    # Syntax: iHeight = INTEGER - The width in pixels to resize the browser window
    #                             Default value = 640
    #
    #         iWidth = INTEGER - The height in pixels to resize the browser window
    #                            Default value = 480
    #
    # Usage Examples:
    #                To size the browser to 1024 by 756
    #                     browser.resizeTo(1024,756)
    #
    #=============================================================================#
    def resizeTo(iHeight=640, iWidth=480)
      
      if(iHeight <1)
        iHeight = 1
      end
      if(iWidth <1)
        iWidth = 1
      end
      
      self.goto("javascript:window.resizeTo(#{iHeight},#{iWidth})")
    end # resizeTo()
    
    
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
      
    end # END Method - restart()
    
    
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
      
      self.goto("javascript:window.scrollBy(#{iHorizontal},#{iVertical})")
    end # scrollBy()
    
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
      
    end # moveBy()
    
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
    def title_from_url
      loc = url # relies on browser.url to return @browser.locationUrl and not @browser.document.url
       (loc[0,8] == "file:///") ? loc.split("file:///")[1].gsub("/", '\\') : loc
    end
    
  end # Class - Safari
  
end # Include if not using webdriver

# END File - watirworks_mac-utilities.rb
