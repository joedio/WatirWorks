#=============================================================================#
# File: watirworks_linux-utilities.rb
#
#  Copyright (c) 2008-2012, Joe DiMauro
#  All rights reserved.
#
# Description:
#    Functions and methods for WatirWorks that are specific to the Linux platform.
#    but not specific to any particular Application Under Test, or Browser.
#
#    Extends some Ruby or Watir classes with additional, hopefully useful, methods.
#
#    Some of these methods and functions have been collected from, or based upon
#    Open Source versions found on various sites in the Internet, and are noted.
#
#--
# Modules:
#    WatirWorks_LinuxUtilities
#
#++
#=============================================================================#

#=============================================================================#
# Require and Include section
# Entries for additional files or methods needed by these methods
#=============================================================================#
require 'rubygems'

#============================================================================#
# Module: WatirWorks_LinuxUtilities
#============================================================================#
#
# Description:
#    Functions and methods for WatirWorks that are specific to the Linux platform.
#    but not specific to any particular Application Under Test, or Browser.
#
#    Extends some Ruby or Watir classes with additional, hopefully useful, methods.
#
#    Some of these methods and functions have been collected from, or based upon
#    Open Source versions found on various sites in the Internet, and are noted.
#
# Instructions: To use these methods in your scripts add these commands:
#                        require 'watirworks'
#                        include WatirWorks_LinuxUtilities
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
#    clear_cache_linux()
#    get_firefox_version_linux()
#    is_firefox_installed_linux?(...)
#    is_firefox2_installed_linux? # Deprecated use is_firefox_installed_linux?(2)
#    is_firefox3_installed_linux? # Deprecated use is_firefox_installed_linux?(3)
#    is_firefox4_installed_linux? # Deprecated use is_firefox_installed_linux?(4)
#    is_firefox5_installed_linux? # Deprecated use is_firefox_installed_linux?(5)
#    is_firefox6_installed_linux? # Deprecated use is_firefox_installed_linux?(6)
#    is_firefox7_installed_linux? # Deprecated use is_firefox_installed_linux?(7)
#    save_screencapture_linux(...)
#
# Pre-requisites:
# ++
#=============================================================================#
module WatirWorks_LinuxUtilities
  
  # Version of this module
  WW_LINUX_UTILITIES_VERSION =  "1.0.0"
  
  #=============================================================================#
  #--
  # Method: clear_cache_linux()
  #
  # TODO: Determining if BleachBit will work and update accordingly.
  #++
  #
  # Description:  On Linux, run BleachBit, (an application) to clear the browser's Cache and cookies.
  #                          You can download BleachBit for free at : http://bleachbit.sourceforge.net/
  #
  #                          BleachBit only clears cookies if the browser is closed, so close the browser prior to invoking this method.
  #                          BleachBit only clears the cache if the browser is closed, so close the browser prior to invoking this method.
  #
  #  Per Watir: The method "Watir::CookieManager::WatirHelper" has been deprecated, thus leaving no other means to do this from Watir.
  #
  #                    By installing and using a 3rd party tool like BleachBit, the cache and cookies for IE, Firefox, and other Web browsers
  #                       on the Linux platform can be cleared.  All cookies will be cleared unless you configure BleachBit to exclude specific cookies.
  #
  #
  # Usage Examples: To clear the cache and cookies on a Linux system:
  #                browser.close
  #                clear_cache_linux()
  #
  # Pre-requisites:
  #              BleachBit must be installed in the default location.
  #              BleachBit must be configured to clear the various browser's cookies and cache.
  #              Configure BleachBit to exclude any cookies you do NOT wish removed.
  #=============================================================================#
  def clear_cache_linux()
    
    if(is_linux?) # Only run on Linux
      
      # Default install location of the tool
      sToolInstallPath = "\\Path\\To\\Tool\\Tool.exe"
      
      sToolCommandLineOptions = ""
      
      # Determine if Tool is installed in the default location
      if(File.exists?(sToolInstallPath))
        
        puts2("")
        puts2("Clearing Cookies and Cache by running: " + sToolInstallPath + sToolCommandLineOptions)
        
        # Run the tool
        system(sToolInstallPath + sToolCommandLineOptions)
        sleep 3 # Allow time for the cleaner to complete
        
      else # Tool is NOT installed so skip the command and log a WARNING
        
        puts2(" ")
        puts2("WARNING - Clearing Cookies and Cache: Not performed", "WARN") # Log as a warning message
        
      end # Use Tool if its installed
      
    end # Only run on Linux
    
  end # Method - clear_cache_linux()
  
  
  #=============================================================================#
  #--
  # Method: get_chrome_version_linux()
  #
  #++
  #
  # Description: Determines if Chrome version installed in the filesystem.
  #
  # Returns: BOOLEAN = true if installed, otherwise false
  #
  # Usage Examples:
  #                 puts2("Chrome version: " + get_chrome_version_linux())
  #
  #=============================================================================#
  def get_chrome_version_linux()
    
    for iVersion in 10..20
        if(self.is_chrome?(iVersion) == true)
           return iVersion.to_s + ".x"
         end
    end # Check for a match
    
  end # Method - get_chrome_version_linux()
  
  
  #=============================================================================#
  #--
  # Method: get_firefox_version_linux()
  #
  #++
  #
  # Description: Determines if Firefox version installed in the filesystem.
  #
  # Returns: BOOLEAN = true if installed, otherwise false
  #
  # Usage Examples:
  #                 puts2("Firefox version: " + get_firefox_version_linux())
  #
  #=============================================================================#
  def get_firefox_version_linux()
    
    for iVersion in 2..12
        if(self.is_ff?(iVersion) == true)
           return iVersion.to_s + ".x"
         end
    end # Check for a match
    
  end # Method - get_firefox_version_linux()
  
  
  #=============================================================================#
  #--
  # Method: get_opera_version_linux()
  #
  #++
  #
  # Description: Determines if Opera version installed in the filesystem.
  #
  # Returns: BOOLEAN = true if installed, otherwise false
  #
  # Usage Examples:
  #                 puts2("Opera version: " + get_opera_version_linux())
  #
  #=============================================================================#
  def get_opera_version_linux()
    
    for iVersion in 8..12
        if(self.is_ff?(iVersion) == true)
           return iVersion.to_s + ".x"
         end
    end # Check for a match
    
  end # Method - get_opera_version_linux()
  
  #=============================================================================#
  #--
  # Method: is_chrome_installed_linux?(...)
  #
  #++
  #
  # Description: Determines if the specified Chrome version is installed in the filesystem
  #              by checking for the existence of its installation directory.
  #
  #              On Ubuntu 10.04 the link to the Chrome executable at: /usr/bin/chrome
  #              and the Chrome v2.0.0.20 install dir is: /usr/lib/chrome2.0.0.20/
  #
  #  NOTE: This is a slow way to do it as it recursively checks the contents
  #        of /usr/lib which contains the install folders for many applications.
  #
  # Returns: BOOLEAN = true if installed, otherwise false
  #
  # Usage Examples:
  #                 if(is_chrome_installed_linux?(17))
  #                      # Execute Chrome 17 specific code
  #                 end
  #
  #=============================================================================#
  def is_chrome_installed_linux?(iVersion = 7)
    
    if($VERBOSE == true)
      puts2("Parameters - is_chrome_installed_linux?")
      puts2("  iVersion " + iVersion.to_s)
    end
    
    require 'find'
    
    sVersion = iVersion.to_s
    
    # Recursively search the directory
    Find.find("/usr/lib/") do | path |
      
      if($VERBOSE)
        puts2("Searching: " + path)
      end
      
      # Check current path for a match
      if(path =~ /chrome-#{sVersion}/)
        if($VERBOSE)
          puts2("Found: " + path)
        end
        
        return true
        
      end # Check current path for a match
    end # Recursively search the directory
    
  end # Method - is_chrome_installed_linux?(...)
  
  #=============================================================================#
  #--
  # Method: is_firefox_installed_linux?(...)
  #
  #++
  #
  # Description: Determines if the specified Firefox version is installed in the filesystem
  #              by checking for the existence of its installation directory.
  #
  #              On Ubuntu 10.04 the link to the Firefox executable at: /usr/bin/firefox
  #              and the Firefox v2.0.0.20 install dir is: /usr/lib/firefox2.0.0.20/
  #
  #  NOTE: This is a slow way to do it as it recursively checks the contents
  #        of /usr/lib which contains the install folders for many applications.
  #
  # Returns: BOOLEAN = true if installed, otherwise false
  #
  # Usage Examples:
  #                 if(is_firefox_installed_linux?(7))
  #                      # Execute FF7 specific code
  #                 end
  #
  #=============================================================================#
  def is_firefox_installed_linux?(iVersion = 3)
    
    if($VERBOSE == true)
      puts2("Parameters - is_firefox_installed_linux?")
      puts2("  iVersion " + iVersion.to_s)
    end
    
    require 'find'
    
    sVersion = iVersion.to_s
    
    # Recursively search the directory
    Find.find("/usr/lib/") do | path |
      
      if($VERBOSE)
        puts2("Searching: " + path)
      end
      
      # Check current path for a match
      if(path =~ /firefox-#{sVersion}/)
        if($VERBOSE)
          puts2("Found: " + path)
        end
        
        return true
        
      end # Check current path for a match
    end # Recursively search the directory
    
  end # Method - is_firefox_installed_linux?(...)
  
  
  #=============================================================================#
  #--
  # Method: is_opera_installed_linux?(...)
  #
  #++
  #
  # Description: Determines if the specified Opera version is installed in the filesystem
  #              by checking for the existence of its installation directory.
  #
  #              On Ubuntu 10.04 the link to the Opera executable at: /usr/bin/opera
  #              and the Opera v2.0.0.20 install dir is: /usr/lib/firefox2.0.0.20/
  #
  #  NOTE: This is a slow way to do it as it recursively checks the contents
  #        of /usr/lib which contains the install folders for many applications.
  #
  # Returns: BOOLEAN = true if installed, otherwise false
  #
  # Usage Examples:
  #                 if(is_opera_installed_linux?(10))
  #                      # Execute Opera 10 specific code
  #                 end
  #
  #=============================================================================#
  def is_opera_installed_linux?(iVersion = 10)
    
    if($VERBOSE == true)
      puts2("Parameters - is_opera_installed_linux?")
      puts2("  iVersion " + iVersion.to_s)
    end
    
    require 'find'
    
    sVersion = iVersion.to_s
    
    # Recursively search the directory
    Find.find("/usr/lib/") do | path |
      
      if($VERBOSE)
        puts2("Searching: " + path)
      end
      
      # Check current path for a match
      if(path =~ /opera-#{sVersion}/)
        if($VERBOSE)
          puts2("Found: " + path)
        end
        
        return true
        
      end # Check current path for a match
    end # Recursively search the directory
    
  end # Method - is_opera_installed_linux?(...)
  
  #=============================================================================#
  #--
  # Method: save_screencapture_linux()
  #
  #++
  #
  # Description: Save a screen capture of the current web page or desktop to a file using ImageMagick.
  #
  #              For details on ImageMagick see:
  #                 http://www.imagemagick.org
  #              or
  #                man imagemagick
  #                man import
  #              If ImageMagick is not already installed perform the following:
  #                 sudo apt-get install imagemagick
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
  #         sOutputDir = STRING - Directory that the file is saved to (Defaults to /tmp )
  #
  #
  # Prerequisites: ImageMagick must be installed on the local filesystem
  #
  # Usage Examples:
  #
  #=============================================================================#
  def save_screencapture_linux(sFileNamePrefix="", bActiveWindowOnly=false, bSaveAsJpg=true, sOutputDir="/tmp")
    
    if($VERBOSE == true)
      puts2("Parameters - save_screencapture_linux:")
      puts2("  sFileNamePrefix: " + sFileNamePrefix)
      puts2("  bActiveWindowOnly: " + bActiveWindowOnly.to_s)
      puts2("  bSaveAsJpg: " + bSaveAsJpg.to_s)
      puts2("  sOutputDir: " + sOutputDir)
    end
    
    if(is_linux?) # Only run on Linux
      
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
      system("import #{sFormat} -window \"#{sWindowID}\" #{sFullPathToImageFile} #{sOptions}")
      
      puts2("Saved image to: #{sFullPathToImageFile}")
      
      
    end # Only run on Linux
    
    
  end # Method - save_screencapture_linux()
  
end # Module - WatirWorks_LinuxUtilities

# END File - watirworks_linux-utilities.rb
