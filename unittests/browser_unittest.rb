#--
#=============================================================================#
# File: browser_unittest.rb
#
#
#  Copyright (c) 2008-2018, Joe DiMauro
#  All rights reserved.
#
# Description: Unit tests for WatirWorks methods using the Internet Explorer, Firefox & Chrome browser's:
#
#                          display_watir_env()
#                          start_browser(..)
#                          is_chrome?(...)
#                          is_firefox?(...)
#                          is_ie?(...)
#                          is_opera?(...)
#                          kill_browsers()
#                          is_maximized?(...)
#                          is_minimized?(...)
#                          resizeTo()
#                          moveTo()
#                          clear_Cache(...)
#
# When run with a Firefox browser and Firewatir 1.6.5 these test cases may fail as Firewatir
# has known issues with multiple concurrent browsers. Watir and IE are not affected by this issue.
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

#=============================================================================#
# Global Variables section
# Set global variables that will be inherited by each of the test files
#=============================================================================#

# Ruby global variables
#

# Watir global variables
#

# WatirWorks global variables
#
sRun_TestType = "browser"
iRun_TestLevel = 0

# Inherit or set the default browser
if($sDefaultBrowser == nil)
  # Uncomment the browser to be used for this test run
  $sDefaultBrowser = "firefox"
  #$sDefaultBrowser = "ie"
  #$sDefaultBrowser = "chrome"
  #$sDefaultBrowser = "opera"
  #$sDefaultBrowser = "safari"
  #$sDefaultBrowser = "edge"
end

#=============================================================================#

#=============================================================================#
# Class: Unittest_Browser
#
# Test Case Methods: setup, teardown
#
#
#=============================================================================#
class Unittest_Browser < Test::Unit::TestCase
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

    puts2("\nTestcase finished in  " + calc_elapsed_time(@@tTestCase_StartTime) + " seconds.")

    # Restore the Global variable's original settings
    $VERBOSE = @@VERBOSE_ORIG
    $DEBUG = @@DEBUG_ORIG
    $FAST_SPEED = @@FAST_SPEED_ORIG
    $HIDE_IE = @@HIDE_IE_ORIG

    # Flag indicating if a browser was started
    $bBrowserStarted = false

  end # end of teardown

  #===========================================================================#
  # Testcase method: test_Browser_001_DisplayWatirEnv
  #
  # Description: Test the method display_watir_env(...)
  #
  #===========================================================================#
  def test_Browser_001_DisplayWatirEnv

    puts2("")
    puts2("#######################")
    puts2("Testcase: test_Browser_001_DisplayWatirEnv")
    puts2("#######################")

    puts2("\n\nTest - display_watir_env")
    display_watir_env()

  end # END Testcase - test_Browser_001_DisplayWatirEnv

  #===========================================================================#
  # Testcase method: test_Browser_001_is_browser_installed
  #
  # Description: Test the method is_chrome64_installed?()
  #
  #===========================================================================#
  def test_Browser_001_is_browser_installed()

    puts2("")
    puts2("#######################")
    puts2("Testcase: test_Browser_001_is_browser_installed")
    puts2("#######################")

    puts2("\n\nTest - is_chrome64_installed?()")
    puts2("is_chrome64_installed? = " + is_chrome64_installed?().to_s)

    puts2("\n\nTest - is_firefox64_installed?()")
    puts2("is_firefox64_installed? = " + is_firefox64_installed?().to_s)

  end # END Testcase - test_Browser_001_is_browser_installed

  #===========================================================================#
  # Testcase method: test_Browser_003_BrowserTypes
  #
  # Description: Opens multiple browsers and manipulates each one.
  #                   Displays info on the browser, url, etc.
  #
  #  Test methods: start_browser(...)
  #                       is_chrome?(...)
  #                       is_edge?(...)
  #                       is_firefox?(...)
  #                       is_ie?(...)
  #                       is_opera?(...)
  #                       display_Info()
  #                       kill_browsers()
  #===========================================================================#
  def test_Browser_003_BrowserTypes

    puts2("")
    puts2("#######################")
    puts2("Testcase: test_Browser_003_BrowserTypes")
    puts2("#######################")

    #$VERBOSE = true
    #$DEBUG = true

    #sAskURL = "http://ask.com"
    sBingURL = "http://www.bing.com"
    sGoogleURL = "http://google.com"
    #sBlankURL = "about:blank"

    # Define an empty array
    aSupportedBrowsers = []

    # Determine the current OS
    sCurrentOS = ""
    if(is_win?)
      #sCurrentOS = "windows"
      puts2("OS = Windows")
      if(is_win?(10))
        aSupportedBrowsers = ["Firefox", "Chrome", "Internet Explorer", "Edge"]
      else
        aSupportedBrowsers = ["Firefox", "Chrome", "Internet Explorer"]
      end
    elsif(is_osx?)
      #sCurrentOS = "osx"
      puts2("OS = OSX")
      aSupportedBrowsers = ["Firefox", "Chrome", "Safari"]
    elsif(is_linux?)
      #sCurrentOS = "linux"
      puts2("OS = Linux")
      aSupportedBrowsers = ["Firefox", "Chrome"]
    end

    puts2("Supported browsers = " + aSupportedBrowsers.to_s)

    # Loop thru each browser
    aSupportedBrowsers.each { |sBrowserName|

      # Start a browser
      oBrowser = start_browser(sBrowserName)

      #puts2("\nIs a Global browser running: " + is_global_browser_running?.to_s + "\n\n")

      sCurrentURL = oBrowser.url
      puts2("Current URL: " + sCurrentURL)

      puts2("\nBrowser type...")
      puts2("\tis_chrome? = " + oBrowser.is_chrome?.to_s)
      puts2("\tis_edge? = " + oBrowser.is_edge?.to_s)
      puts2("\tis_firefox? = " + oBrowser.is_firefox?.to_s)
      puts2("\tis_ie? = " + oBrowser.is_ie?.to_s)
      puts2("\tis_opera? = " + oBrowser.is_opera?.to_s)
      puts2("\tis_safari? = " + oBrowser.is_safari?.to_s)

      oBrowser.display_info()

      # The #browser.version method is not supported for Edge
      if(oBrowser.is_edge?)
        puts2("SKIPPED - #browser.version method is not supported for Edge")
      else
        sBrowserVersion = oBrowser.version.to_s
        puts2("Browser's full version = " + sBrowserVersion)
        sBrowserMajorVersion = sBrowserVersion.prefix(".")
        puts2("Browser's major version = " + sBrowserMajorVersion)
      end

      if(oBrowser.is_chrome?)
        puts2("Chrome " + (sBrowserMajorVersion.to_i - 1).to_s + ".x browser?: " + oBrowser.is_chrome?((sBrowserMajorVersion.to_i - 1)).to_s)
        puts2("Chrome " + sBrowserMajorVersion + ".x browser?: " + oBrowser.is_chrome?(sBrowserMajorVersion.to_i).to_s)
        puts2("Chrome " + (sBrowserMajorVersion.to_i + 1).to_s + ".x browser?: " + oBrowser.is_chrome?((sBrowserMajorVersion.to_i + 1)).to_s)
      end
      if(oBrowser.is_edge?)
        puts2("SKIPPED - For Edge")
        #puts2("Edge " + (sBrowserMajorVersion.to_i - 1).to_s + ".x browser?: " + oBrowser.is_edge?((sBrowserMajorVersion.to_i - 1)).to_s)
        #puts2("Edge " + sBrowserMajorVersion + ".x browser?: " + oBrowser.is_edge?(sBrowserMajorVersion.to_i).to_s)
        #puts2("Edge " + (sBrowserMajorVersion.to_i + 1).to_s + ".x browser?: " + oBrowser.is_edge?((sBrowserMajorVersion.to_i + 1)).to_s)
      end
      if(oBrowser.is_firefox?)
        puts2("Firefox " + (sBrowserMajorVersion.to_i - 1).to_s + ".x browser?: " + oBrowser.is_firefox?((sBrowserMajorVersion.to_i - 1)).to_s)
        puts2("Firefox " + sBrowserMajorVersion + ".x browser?: " + oBrowser.is_firefox?(sBrowserMajorVersion.to_i).to_s)
        puts2("Firefox " + (sBrowserMajorVersion.to_i + 1).to_s + ".x browser?: " + oBrowser.is_firefox?((sBrowserMajorVersion.to_i + 1)).to_s)
      end
      if(oBrowser.is_ie?)
        puts2("IE " + (sBrowserMajorVersion.to_i - 1).to_s + ".x browser?: " + oBrowser.is_ie?((sBrowserMajorVersion.to_i - 1)).to_s)
        puts2("IE " + sBrowserMajorVersion + ".x browser?: " + oBrowser.is_ie?(sBrowserMajorVersion.to_i).to_s)
        puts2("IE " + (sBrowserMajorVersion.to_i + 1).to_s + ".x browser?: " + oBrowser.is_ie?((sBrowserMajorVersion.to_i + 1)).to_s)
      end
      if(oBrowser.is_opera?)
        puts2("Opera " + (sBrowserMajorVersion.to_i - 1).to_s + ".x browser?: " + oBrowser.is_opera?((sBrowserMajorVersion.to_i - 1)).to_s)
        puts2("Opera " + sBrowserMajorVersion + ".x browser?: " + oBrowser.is_opera?(sBrowserMajorVersion.to_i).to_s)
        puts2("Opera " + (sBrowserMajorVersion.to_i + 1).to_s + ".x browser?: " + oBrowser.is_opera?((sBrowserMajorVersion.to_i + 1)).to_s)
      end
      if(oBrowser.is_safari?)
        puts2("Safari " + (sBrowserMajorVersion.to_i - 1).to_s + ".x browser?: " + oBrowser.is_safari?((sBrowserMajorVersion.to_i - 1)).to_s)
        puts2("Safari " + sBrowserMajorVersion + ".x browser?: " + oBrowser.is_safari?(sBrowserMajorVersion.to_i).to_s)
        puts2("Safari " + (sBrowserMajorVersion.to_i + 1).to_s + ".x browser?: " + oBrowser.is_safari?((sBrowserMajorVersion.to_i + 1)).to_s)
      end

      # Access a URL
      puts2("\nBrowser - Set URL = " + sBingURL)
      oBrowser.goto(sBingURL)
      sleep(10) # Placeholder delay to figure out why a new IE fails at this point, and what can be waited on.
      puts2("\tURL = " + oBrowser.url)
      puts2("\tBrowser name = " + oBrowser.name.to_s)

      puts2("Misc. browser methods...")
      puts2("\tBrowser status = '" + oBrowser.status.to_s + "'")
      puts2("\tBrowser ready_state = " + oBrowser.ready_state.to_s)
      puts2("\tWindow current = " + oBrowser.window.current?.to_s)
      puts2("\tBrowse refresh...")
      oBrowser.refresh

      # Start with browser in it's current size
      puts2("\tBrowser is at it's initial size & position")
      oBrowser.display_info()

      puts2("\nMaximize browser")
      oBrowser.window.maximize
      oBrowser.display_info()

      puts2("Resize the window to 640x480")
      oBrowser.window.resize_to(640,480)
      oBrowser.display_info()

      puts2("Move the window to 100x100")
      oBrowser.window.move_to(100,100)
      oBrowser.display_info()

      iWindowWidth = 1024
      puts2("Resize the window to its max height but specified width (" + iWindowWidth.to_s + ")")
      oBrowser.window.move_to(100,10)  # w,h
      oBrowser.display_info()

      puts2("Maximize window...")
      oBrowser.window.maximize
      oBrowser.display_info()

      puts2("Max height & specified width...")
      iHeight = oBrowser.window.size.height
      oBrowser.window.resize_to(iWindowWidth,iHeight)
      oBrowser.display_info()

      puts2("\nLoad a different URL " + sGoogleURL)
      oBrowser.goto(sGoogleURL)
      puts("\tURL = " + oBrowser.url)
      puts("\tTitle = " + oBrowser.title)

      puts2("Use the browser's 'back' button...")
      if(oBrowser.is_safari?)
        puts2("\tSKIPPED - Safari Browser's back operation not supported.")
        oBrowser.goto(sBingURL)
        sleep(1)
      else
        oBrowser.back
        puts("\tURL = " + oBrowser.url)
        puts("\tTitle = " + oBrowser.title)
      end

      puts2("Use the browser's 'forward' button...")
      if(oBrowser.is_safari?)
        puts2("\tSKIPPED - Safari Browser's forward operation not supported.")
        oBrowser.goto(sGoogleURL)
        sleep(1)
      else
        oBrowser.forward
        puts("\tURL = " + oBrowser.url)
        puts("\tTitle = " + oBrowser.title)
      end

      puts2("Focus the cursor on 1st div...")
      oBrowser.div(:id, "searchform").focus
      sleep(1)

      puts2("Hover the cursor on 1st div...")
      if(oBrowser.is_safari?)
        puts2("\tSKIPPED - Safari Browser does not appear to support hover")
      else
        oBrowser.div(:id, "searchform").hover
        sleep(1)
      end

      puts2("Click the cursor on 1st div...")
      oBrowser.div(:id, "searchform").click
      sleep(1)

      puts2("\nAbout to close the current browser")
      puts2("\tDoes browser exist? = " + oBrowser.exists?.to_s)
      puts2("\tDoes window exist? = " + oBrowser.window.exists?.to_s)
      puts2("Close the browser...")
      oBrowser.close
      puts2("  Does browser exist? = " + oBrowser.exists?.to_s)
      #puts2("  Does window exist? = " + oBrowser.window.exists?.to_s)  # Can't check on window if its closed.

      puts2("\n##### Next browser...")

    }   # END - Loop thru each browser

  rescue => e

    puts2("*** ERROR and Backtrace: " + e.message + "\n" + e.backtrace.join("\n"), "ERROR")

    if(oBrowser.exists? == true)
      oBrowser.display_info()
    else
      puts("No existing browser found")
    end

    # Force any open browsers to exit
    kill_browsers()

    # Raise the error with a custom message after the rest of the rescue actions
    raise("*** TESTCASE - test_Browser_003_LocalBrowsers")

  ensure

    #end # Start browser types

  end # End of test method - test_Browser_003_BrowserTypes

end # end of Class - Unittest_Browser
