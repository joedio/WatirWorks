#=============================================================================#
# File: watirworks_linux-utilities.rb
#
#  Copyright (c) 2008-2015, Joe DiMauro
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
#   is_chrome64_installed_linux?()
#   is_firefox64_installed_linux?()
#   save_screencapture_linux(...)
#
# Pre-requisites:
# ++
#=============================================================================#
module WatirWorks_LinuxUtilities

  # Version of this module
  WW_LINUX_UTILITIES_VERSION =  "0.0.5"
  #=============================================================================#
  #--
  # Method: is_chrome64_installed_linux?()
  #
  # TODO - Determine how it tell if Chrome is 32 or 64 bit.
  #++
  #
  # Description: Determines if the 64 bit Chrome browser is installed
  #
  #              This method currently presumes that it is installed
  #              and is hard coded to return true.
  #
  # Returns: BOOLEAN - true if installed, otherwise false
  #
  # Syntax: N/A
  #
  # Usage Examples:      if(is_chrome64_installed_linux? == true)
  #                         # Put your code here
  #                      end
  #
  #=============================================================================#
  def is_chrome64_installed_linux?()

    if($VERBOSE == true)
      puts2("Parameters - is_chrome64_installed_linux?:")
      #puts2("  sX: " + sX.to_s)
    end

    bReturnStatus = false

    bChrome32PathExists = false # File.exist?(sChrome32Path)
    bChrome64PathExists = true # File.exist?(sChrome64Path)

    if(bChrome32PathExists == false && bChrome64PathExists == true)
      bReturnStatus = true
    end

    return bReturnStatus

  end # Method - is_chrome64_installed_linux?()

  #=============================================================================#
  #--
  # Method: is_firefox64_installed_linux?()
  #
  # TODO - Determine how it tell if Firefox is 32 or 64 bit.
  #++
  #
  # Description: Determines if the 64 bit Firefox browser is installed
  #
  #              This method currently presumes that its is installed
  #              and is hard coded to return true.
  #
  # Returns: BOOLEAN - true if installed, otherwise false
  #
  # Syntax: N/A
  #
  # Usage Examples:      if(is_firefox64_installed_linux? == true)
  #                         # Put your code here
  #                      end
  #
  #=============================================================================#
  def is_firefox64_installed_linux?()

    if($VERBOSE == true)
      puts2("Parameters - is_firefox64_installed_linux?:")
      #puts2("  sX: " + sX.to_s)
    end

    bReturnStatus = false

    bFirefox32PathExists = false # File.exist?(sFirefox32Path)
    bFirefox64PathExists = true  # File.exist?(sFirefox64Path)

    if(bFirefox32PathExists == false && bFirefox64PathExists == true)
      bReturnStatus = true
    end

    return bReturnStatus

  end # Method - is_firefox64_installed_linux?()

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
