#=============================================================================#
# File: watirworks_mac-utilities.rb
#
#  Copyright (c) 2008-2012, Joe DiMauro
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
#    is_firefox_installed_mac(...)
#    is_firefox2_installed_mac() # Deprecated use is_firefox2_installed_mac(2)
#    is_firefox3_installed_mac() # Deprecated use is_firefox2_installed_mac(3)
#    is_firefox4_installed_mac() # Deprecated use is_firefox2_installed_mac(4)
#    is_firefox5_installed_mac() # Deprecated use is_firefox2_installed_mac(5)
#    is_firefox6_installed_mac() # Deprecated use is_firefox2_installed_mac(6)
#    is_firefox7_installed_mac() # Deprecated use is_firefox2_installed_mac(7)
#    save_screencapture_mac(...)
#
# Pre-requisites:
# ++
#=============================================================================#
module WatirWorks_MacUtilities
  
  # Version of this module
  WW_MAC_UTILITIES_VERSION =  "2.0.0"
  
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
  # Method: get_chrome_version_mac()
  #
  #++
  #
  # Description: Determines if Chrome version installed in the filesystem.
  #
  # Returns: STRING = Version of the browser that is installed in the system's
  #                   default location
  #
  # Usage Examples:
  #                 puts2("Chrome version: " + get_chrome_version_mac())
  #
  #=============================================================================#
  def get_chrome_version_mac()
    
    # Define values
    sPathToFile = "/Applications/Chrome.app/Contents/Info.plist"
    
    sStringtoMatch = nil
    
    for iVersion in 10..20
      if(is_chrome_installed_mac?(iVersion) == true)
        sStringtoMatch = "Chrome " + iVersion.to_s
      end
    end
    
    if(sStringtoMatch == nil)
      return "Unknown"
    else
      aMatch = get_text_from_file(sStringtoMatch, sPathToFile, 0, 0)
      
      # Parse version
      aMatch.each do | aIndex |
        return (getXMLTagValue(aIndex[2].to_s, "string").prefix(",").suffix(" "))
      end # Parse version
    end
    
  end # Method - get_chrome_version_mac()
  
  
  #=============================================================================#
  #--
  # Method: get_firefox_version_mac()
  #
  #++
  #
  # Description: Determines if Firefox version installed in the filesystem.
  #
  # Returns: STRING = Version of the browser that is installed in the system's
  #                   default location
  #
  # Usage Examples:
  #                 puts2("Firefox version: " + get_firefox_version_mac())
  #
  #=============================================================================#
  def get_firefox_version_mac()
    
    # Define values
    sPathToFile = "/Applications/Firefox.app/Contents/Info.plist"
    
    sStringtoMatch = nil
    
    for iVersion in 2..12
      if(is_firefox_installed_mac?(iVersion) == true)
        sStringtoMatch = "Firefox " + iVersion.to_s
      end
    end
    
    if(sStringtoMatch == nil)
      return "Unknown"
    else
      aMatch = get_text_from_file(sStringtoMatch, sPathToFile, 0, 0)
      
      # Parse version
      aMatch.each do | aIndex |
        return (getXMLTagValue(aIndex[2].to_s, "string").prefix(",").suffix(" "))
      end # Parse version
    end
    
  end # Method - get_firefox_version_mac()
  
  
  #=============================================================================#
  #--
  # Method: get_opera_version_mac()
  #
  #++
  #
  # Description: Determines if Opera version installed in the filesystem.
  #
  # Returns: STRING = Version of the browser that is installed in the system's
  #                   default location
  #
  # Usage Examples:
  #                 puts2("Opera version: " + get_opera_version_mac())
  #
  #=============================================================================#
  def get_opera_version_mac()
    
    # Define values
    sPathToFile = "/Applications/Opera.app/Contents/Info.plist"
    
    sStringtoMatch = nil
    
    for iVersion in 10..20
      if(is_chrome_installed_mac?(iVersion) == true)
        sStringtoMatch = "Opera " + iVersion.to_s
      end
    end
    
    if(sStringtoMatch == nil)
      return "Unknown"
    else
      aMatch = get_text_from_file(sStringtoMatch, sPathToFile, 0, 0)
      
      # Parse version
      aMatch.each do | aIndex |
        return (getXMLTagValue(aIndex[2].to_s, "string").prefix(",").suffix(" "))
      end # Parse version
    end
    
  end # Method - get_opera_version_mac()
  
  
  #=============================================================================#
  #--
  # Method: get_safari_version_mac()
  #
  #++
  #
  # Description: Determines if Safari version installed in the filesystem.
  #
  # Returns: STRING = Version of the browser that is installed in the system's
  #                   default location
  #
  # Usage Examples:
  #                 puts2("Safari version: " + get_safari_version_mac())
  #
  #=============================================================================#
  def get_safari_version_mac()
    
    # Define values
    sPathToFile = "/Applications/Safari.app/Contents/Info.plist"
    
    sStringtoMatch = nil
    
    for iVersion in 10..20
      if(is_safari_installed_mac?(iVersion) == true)
        sStringtoMatch = "Opera " + iVersion.to_s
      end
    end
    
    if(sStringtoMatch == nil)
      return "Unknown"
    else
      aMatch = get_text_from_file(sStringtoMatch, sPathToFile, 0, 0)
      
      # Parse version
      aMatch.each do | aIndex |
        return (getXMLTagValue(aIndex[2].to_s, "string").prefix(",").suffix(" "))
      end # Parse version
    end
    
  end # Method - get_safari_version_mac()
  
  #=============================================================================#
  #--
  # Method: is_chrome_installed_mac?(...)
  #
  #++
  #
  # Description: Determines the specified version of Chrome is installed in the filesystem.
  #
  #              On OSX the default installed browesr's version is noted in the file:
  #                 /Applications/Chrome.app/Contents/Info.plist
  #              For example Chrome v17.1.2 contains this entry:
  #                 <string>Chrome 2.1.2</string>
  #
  # Returns: BOOLEAN = true if installed, otherwise false
  #
  # Usage Examples:
  #                 if(is_chrome_installed_mac?(17))
  #                      # Execute Chrome 17 specific code
  #                 end
  #
  #=============================================================================#
  def is_chrome_installed_mac?(iVersion = 7)
    
    if($VERBOSE == true)
      puts2("Parameters - is_chrome_installed_mac?")
      puts2("  iVersion " + iVersion.to_s)
    end
    
    # Define values
    sVersion = iVersion.to_s
    sPathToFile = "/Applications/Chrome.app/Contents/Info.plist"
    sStringtoMatch = "Chrome #{sVersion}"
    
    aMatch = get_text_from_file(sStringtoMatch, sPathToFile, 0, 0)
    
    # Check for a match
    aMatch.each do | aIndex |
      if(aIndex[0] == true)
        return true
      else
        return false
      end
    end # Check for a match
    
  end # Method - is_chrome_installed_mac?(...)
  
  
  #=============================================================================#
  #--
  # Method: is_firefox_installed_mac?(...)
  #
  #++
  #
  # Description: Determines the specified version of Firefox is installed in the filesystem.
  #
  #              On OSX the default installed browesr's version is noted in the file:
  #                 /Applications/Firefox.app/Contents/Info.plist
  #              For example Firefox v2.1.2 contains this entry:
  #                 <string>Firefox 2.1.2</string>
  #
  # Returns: BOOLEAN = true if installed, otherwise false
  #
  # Usage Examples:
  #                 if(is_firefox_installed_mac?(7))
  #                      # Execute FF7 specific code
  #                 end
  #
  #=============================================================================#
  def is_firefox_installed_mac?(iVersion = 7)
    
    if($VERBOSE == true)
      puts2("Parameters - is_firefox_installed_mac?")
      puts2("  iVersion " + iVersion.to_s)
    end
    
    # Define values
    sVersion = iVersion.to_s
    sPathToFile = "/Applications/Firefox.app/Contents/Info.plist"
    sStringtoMatch = "Firefox #{sVersion}"
    
    aMatch = get_text_from_file(sStringtoMatch, sPathToFile, 0, 0)
    
    # Check for a match
    aMatch.each do | aIndex |
      if(aIndex[0] == true)
        return true
      else
        return false
      end
    end # Check for a match
    
  end # Method - is_firefox_installed_mac?(...)
  
  
  #=============================================================================#
  #--
  # Method: is_opera_installed_mac?(...)
  #
  #++
  #
  # Description: Determines the specified version of Opera is installed in the filesystem.
  #
  #              On OSX the default installed browesr's version is noted in the file:
  #                 /Applications/Opera.app/Contents/Info.plist
  #              For example Opera v2.1.2 contains this entry:
  #                 <string>Opera 2.1.2</string>
  #
  # Returns: BOOLEAN = true if installed, otherwise false
  #
  # Usage Examples:
  #                 if(is_opera_installed_mac?(7))
  #                      # Execute Opera 7 specific code
  #                 end
  #
  #=============================================================================#
  def is_opera_installed_mac?(iVersion = 7)
    
    if($VERBOSE == true)
      puts2("Parameters - is_opera_installed_mac?")
      puts2("  iVersion " + iVersion.to_s)
    end
    
    # Define values
    sVersion = iVersion.to_s
    sPathToFile = "/Applications/Opera.app/Contents/Info.plist"
    sStringtoMatch = "Opera #{sVersion}"
    
    aMatch = get_text_from_file(sStringtoMatch, sPathToFile, 0, 0)
    
    # Check for a match
    aMatch.each do | aIndex |
      if(aIndex[0] == true)
        return true
      else
        return false
      end
    end # Check for a match
    
  end # Method - is_opera_installed_mac?(...)
  
  
  #=============================================================================#
  #--
  # Method: is_safari_installed_mac?(...)
  #
  #++
  #
  # Description: Determines the specified version of Safari is installed in the filesystem.
  #
  #              On OSX the default installed browesr's version is noted in the file:
  #                 /Applications/Safari.app/Contents/Info.plist
  #              For example Safari v2.1.2 contains this entry:
  #                 <string>Safari 2.1.2</string>
  #
  # Returns: BOOLEAN = true if installed, otherwise false
  #
  # Usage Examples:
  #                 if(is_safari_installed_mac?(7))
  #                      # Execute Safari 7 specific code
  #                 end
  #
  #=============================================================================#
  def is_safari_installed_mac?(iVersion = 7)
    
    if($VERBOSE == true)
      puts2("Parameters - is_safari_installed_mac?")
      puts2("  iVersion " + iVersion.to_s)
    end
    
    # Define values
    sVersion = iVersion.to_s
    sPathToFile = "/Applications/Safari.app/Contents/Info.plist"
    sStringtoMatch = "Safari #{sVersion}"
    
    aMatch = get_text_from_file(sStringtoMatch, sPathToFile, 0, 0)
    
    # Check for a match
    aMatch.each do | aIndex |
      if(aIndex[0] == true)
        return true
      else
        return false
      end
    end # Check for a match
    
  end # Method - is_safari_installed_mac?(...)
  
  
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



#=begin 
# Dropping support if SafariWatir, will support Safari via watir-webdriver 

# Include if using webdriver
#if(is_webdriver? == true)
#if(is_webdriver? != true)

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
  # Method: brand()
  #
  #++
  #
  # Description: Returns the brand of the current browser (IE, Firefox, Chrome, Safari)
  #              Uses a JavaScript object method that is recognized by most browsers.
  #              Based on info at: http://www.w3schools.com/js/js_browser.asp
  #              To debug browse this URL: javascript:alert(window.navigator.userAgent);
  #
  # Usage Examples: To verify that the current browser is a Firefox browser:
  #                    sBrand = browser.brand()
  #                    assert(sBrand == "Firefox")
  #
  #=============================================================================#
  def brand()
    
    # Return hard coded value until watir-webdriver supports JavaScript
    sBrand = "Safari"
    
=begin      
      if($bUseWebDriver == false)
        sRawType = self.execute_script("window.navigator.userAgent")
      else
        sRawType = self.execute_script("return window.navigator.userAgent")
      end
      
      if($VERBOSE == true)
        puts2(sRawType)
      end
      
      if(sRawType =~ /MSIE \d/)
        sBrand = "IE"
      elsif(sRawType =~ /Firefox\//)
        sBrand = "Firefox"
      elsif(sRawType =~ /Chrome\//)
        sBrand = "Chrome"
      elsif(sRawType =~ /Safari\/\d\.\d/)
        sBrand = "Safari"
      elsif(sRawType =~ /Opera\//)
        sBrand = "Opera"
      else
        sBrand = "Unknown"
      end
      
      # puts2(sBrand)
=end      
    return sBrand
    
  end # Method - brand()
  
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
    
    # Return hard coded value until watir-webdriver supports JavaScript
    bReturnStatus = true
    
=begin      
      self.goto("javascript:window.moveBy(#{iXPos},#{iYPos})")
=end
    
    return bReturnStatus
    
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
    
    # Return hard coded value until watir-webdriver supports JavaScript
    bReturnStatus = true
    
=begin      
      if(iXPos <0)
        iXPos = 0
      end
      if(iYPos <0)
        iYPos = 0
      end
      
      self.goto("javascript:window.moveTo(#{iXPos},#{iYPos})")
=end
    
    return bReturnStatus
    
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
    
    # Return hard coded value until watir-webdriver supports JavaScript
    bReturnStatus = true
    
=begin      
      self.goto("javascript:window.resizeBy(#{iHeight},#{iWidth})")
=end
    return bReturnStatus
    
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
    
    # Return hard coded value until watir-webdriver supports JavaScript
    bReturnStatus = true
=begin      
      if(iHeight <1)
        iHeight = 1
      end
      if(iWidth <1)
        iWidth = 1
      end
      
      self.goto("javascript:window.resizeTo(#{iHeight},#{iWidth})")
=end
    return bReturnStatus
    
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
    
    # Return hard coded value until watir-webdriver supports JavaScript
    bReturnStatus = true
=begin      
      self.goto("javascript:window.scrollBy(#{iHorizontal},#{iVertical})")
=end
    return bReturnStatus
    
  end # scrollBy()
  
    
    #=============================================================================#
    #--
    # Method: status()
    #
    #++
    #
    # Description: Watir-webdriver for Safari does not support browser.status().
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
      
    end # status()

  
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
  
  
  #=============================================================================#
  #--
  # Method: version()
  #
  #++
  #
  # Description: Returns the version of the current browser.
  #              Uses a JavaScript object method that is recognized by most browsers.
  #              Based on info at: http://www.w3schools.com/js/js_browser.asp
  #              To debug browse this URL: javascript:alert(window.navigator.userAgent);
  #
  # Usage Examples: To verify that the current Firefox browser's version is > 9:
  #                    sVersion = browser.version()
  #                    assert(sVersion >= "9")
  #
  #=============================================================================#
  def version()
    
    # Return hard coded value until watir-webdriver supports JavaScript
    sVersion = "5"
    
=begin      
      if($bUseWebDriver == false)
        sRawType = self.execute_script("window.navigator.userAgent")
      else
        sRawType = self.execute_script("return window.navigator.userAgent")
      end
      
      if($VERBOSE == true)
        puts2(sRawType)
      end
      
      if(sRawType =~ /MSIE \d/)
        # IE 8.0 returns this:
        #   Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 6.0; WOW64; Trident/4.0; SLCC1; .NET CLR 2.0.50727; Media Center PC 5.0; .NET CLR 3.5.30729; .NET CLR 3.0.30729; .NET4.0C; MS-RTC LM 8)
        sVersion = sRawType.remove_prefix(";").prefix(";").remove_prefix(" ")
      elsif(sRawType =~ /Firefox\//)
        # Firefox 3.6.28 returns this:
        #   Mozilla/5.0 (Windows; U; Windows NT 6.0; en-US; rv:1.9.2.28) Gecko/20120306 Firefox/3.6.28
        sVersion = sRawType.suffix("/").prefix(" ")
      elsif(sRawType =~ /Chrome\//)
        # Chrome 17.0.963.79 returns this:
        #   Mozilla/5.0 (Windows NT 6.0; WOW64) AppleWebKit/535.11 (KHTML, like Gecko) Chrome/17.0.963.79 Safari/535.11
        sVersion = sRawType.suffix(")").remove_prefix("/").prefix(" ")
      elsif(sRawType =~ /Safari\/\d\.\d/)
        # Safari 5.1.4 returns this:
        #   Mozilla/5.0 (Windows NT 6.0; WOW64) AppleWebKit/534.54.16 (KHTML, like Gecko) Version/5.1.4 Safari/5.3.4.54.16
        sVersion = sRawType.suffix(")").remove_prefix("/").prefix(" ")
      elsif(sRawType =~ /Opera\//)
        # Opera 11.61 returns this:
        #   Opera/9.80 (Windows NT 6.0; U; en) Presto/2.10.229 Version/11.61
        sVersion = sRawType.suffix("/")
      else
        sVersion = "-1"
      end
      
      # puts2(sVersion)
=end      
    return sVersion
    
  end # Method - version()
  
end # Class - Safari

#  end # Include if using webdriver

#=end

# END File - watirworks_mac-utilities.rb
