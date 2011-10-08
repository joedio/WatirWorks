#--
#=============================================================================#
# File: watirworks_browser_unittest.rb
#
#
#  Copyright (c) 2008-2010, Joe DiMauro
#  All rights reserved.
#
# Description: Unit tests for WatirWorks methods using the Internet Explorer, Firefox & Chrome browser's:
#
#                          display_watir_env()
#                          start_browser(..)
#                          is_ie?
#                          is_ie6?
#                          is_ie7?
#                          is_ie8?
#                          is_ie9?
#                          is_firefox?
#                          is_ff2?
#                          is_ff3?
#                          is_ff4?
#                          is_ff5?
#                          wait_until_status(..)
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
  #$sDefaultBrowser = "android"
  #$sDefaultBrowser = "iphone"
  #$sDefaultBrowser = "remote"
end


#if(is_webdriver? != true)
#  Watir.options[:browser => $sDefaultBrowser]
#end

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


    #puts2("END")

  end # END Testcase - test_Browser_001_DisplayWatirEnv

  #===========================================================================#
  # Testcase method: test_Browser_003_LocalBrowsers
  #
  # Description: Opens multiple local browsers and manipulates each one.
  #                   Displays info on the browser, url, and the HTML document each is displaying.
  #
  #  Test methods: start_browser(...)
  #                       is_ie?()
  #                       is_ie6?()
  #                       is_ie7?()
  #                       is_ie8?()
  #                       is_ie9?()
  #                       is_firefox?()
  #                       is_ff2?()
  #                       is_ff3?()
  #                       is_ff4?()
  #                       is_ff5?
  #                       wait_until_status(...)
  #                       kill_browsers()
  #===========================================================================#
  def test_Browser_003_LocalBrowsers

    puts2("")
    puts2("#######################")
    puts2("Testcase: test_Browser_003_LocalBrowsers")
    puts2("#######################")

    #$VERBOSE = true
    #$DEBUG = true

    sAskURL = "http://ask.com"
    sBingURL = "http://www.bing.com"
    sGoogleURL = "http://google.com"
    sBlankURL = "about:blank"

    #    if(is_webdriver? != true)  # watir-webdriver - missing method - options
    #       # Determine which type of browser is set as the current default
    #      sBrowserType = Watir.options[:browser]
    #  else
    sBrowserType = $sDefaultBrowser
    #   end

    puts2("\nBrowser Type: " + sBrowserType)

    begin # Start local browsers

      puts2("\nIs a Global browser running: " + is_global_browser_running?.to_s + "\n\n")

      puts2("Create a new local Browser Object with no URL specified")
      oLocalBrowser_1 = start_browser(sBrowserType)

      puts2("\nIs a Global browser running: " + is_global_browser_running?.to_s + "\n\n")

      sCurrentURL = oLocalBrowser_1.url
      puts2("Current URL: " + sCurrentURL)

      puts2("\nIs it a Android browser?: " + oLocalBrowser_1.is_android?.to_s)
      puts2("\nIs it a Chrome browser?: " + oLocalBrowser_1.is_chrome?.to_s)
      puts2("Is it a Opera browser?: " + oLocalBrowser_1.is_opera?.to_s)
      puts2("Is it a Safari browser?: " + oLocalBrowser_1.is_safari?.to_s)

      puts2("\nIs it an IE browser?: " + oLocalBrowser_1.is_ie?.to_s)
      puts2("Is it an IE 6.x browser?: " + oLocalBrowser_1.is_ie6?.to_s)
      puts2("Is it an IE 7.x browser?: " + oLocalBrowser_1.is_ie7?.to_s)
      puts2("Is it an IE 8.x browser?: " + oLocalBrowser_1.is_ie8?.to_s)
      puts2("Is it an IE 9.x browser?: " + oLocalBrowser_1.is_ie9?.to_s)

      puts2("\nIs it a Firefox browser?: " + oLocalBrowser_1.is_firefox?.to_s)
      puts2("Is it a Firefox 2.x browser?: " + oLocalBrowser_1.is_firefox2?.to_s)
      puts2("Is it a Firefox 3.x browser?: " + oLocalBrowser_1.is_firefox3?.to_s)
      puts2("Is it a Firefox 4.x browser?: " + oLocalBrowser_1.is_firefox4?.to_s)
      puts2("Is it a Firefox 5.x browser?: " + oLocalBrowser_1.is_firefox5?.to_s)
      puts2("Is it a Firefox 6.x browser?: " + oLocalBrowser_1.is_firefox6?.to_s)
      puts2("Is it a Firefox 7.x browser?: " + oLocalBrowser_1.is_firefox7?.to_s)


      puts2("\nBrowser's status text = " + oLocalBrowser_1.status)

      # Verify that the browser is ready
      if(oLocalBrowser_1.wait_until_status("Done", 10, 1) == true)
        puts2("Found expected Browser's status text = " + oLocalBrowser_1.status)
      else
        puts2("Found unexpected Browser's status text = " + oLocalBrowser_1.status)
      end

      # Can't run this until a browser exists.
      # Once a URL is loaded an IE 8 browser may down-rev to emulate an IE 6 or IE 7 browser.
      # Thus a browser may report IE 8 before a page is loaded and IE 6 or IE 7 after a page loads.

      # Access a URL
      puts2("\nBrowser 1 - Set URL = " + sAskURL)
      oLocalBrowser_1.goto(sAskURL)
      puts2("Current URL: " + oLocalBrowser_1.url)

      puts2("\nCreate a 2nd local Browser Object, and load the URL " + sBingURL)
      oLocalBrowser_2 = start_browser(sBrowserType, sBingURL)
      puts2("Current URL: " + oLocalBrowser_2.url)

      sleep(2)

      puts2("\nCreate a 3rd local Browser Object,and load the URL " + sBlankURL)
      oLocalBrowser_3 = start_browser(sBrowserType, sBlankURL)
      puts2("Current URL: " + oLocalBrowser_3.url)

      puts2("\nAccess a different URL with 2nd browser: " + sBlankURL)
      oLocalBrowser_2.goto(sBlankURL)
      puts2("Current URL: " + oLocalBrowser_2.url)

      puts2("\nAccess a different URL with the 1st browser: " + sGoogleURL)
      oLocalBrowser_1.goto(sGoogleURL)
      puts2("Current URL: " + oLocalBrowser_1.url)

      # Close the browsers
      puts2("\nClose the 3rd browser...")
      oLocalBrowser_3.close
      puts2("3rd browser CLOSED")

      puts2("Close 1st browser...")
      oLocalBrowser_1.close
      puts2("1st local browser CLOSED")

      puts2("Close 2nd browser using - kill_browsers()...")
      #oLocalBrowser_2.close
      kill_browsers()
      puts2("2nd local browser CLOSED")

    rescue => e

      puts2("*** ERROR and Backtrace: " + e.message + "\n" + e.backtrace.join("\n"), "ERROR")

      # Force any open browsers to exit
      kill_browsers()

      # Raise the error with a custom message after the rest of the rescue actions
      raise("*** TESTCASE - test_Browser_003_LocalBrowsers")

    ensure



    end # Start local browsers

    #puts2("END")

  end # End of test method - test_Browser_002_LocalBrowsers

  #===========================================================================#
  # Testcase method: test_Browser_004_GlobalAndLocalBrowsers
  #
  # Description: Starts local and global browser objects which run concurrently
  #
  # Tests methods:  start_browser()
  #                        watchlist(...)
  #                        kill_browsers()
  #===========================================================================#
  def test_Browser_004_GlobalAndLocalBrowsers

    puts2("")
    puts2("#######################")
    puts2("Testcase: test_Browser_004_GlobalAndLocalBrowsers")
    puts2("#######################")

=begin  watir-webdriver - missing method - options
    # Determine which type of browser is set as the current default
    sBrowserType = Watir.options[:browser]
=end
    sBrowserType = $sDefaultBrowser

    puts2("\nBrowser Type = " + sBrowserType)

    watchlist(["$browser"])

    sAskURL = "http://ask.com"
    sBingURL = "http://www.bing.com"
    sGoogleURL = "http://google.com"
    #sBlankURL = "about:blank"

    begin # Global browsers

      puts2("\nIs a Global browser running: " + is_global_browser_running?.to_s + "\n\n")

      puts2("Create a local browser object and load the URL: " + sGoogleURL)
      myLocalBrowser = start_browser(sBrowserType, sGoogleURL)
      puts2("Current URL: " + myLocalBrowser.url)

      puts2("\nCreate a Global browser object and load the URL " + sAskURL)
      $browser = start_browser(sBrowserType, sAskURL)

      puts2("Is a Global browser running: " + is_global_browser_running?.to_s)

      sCurrentURL = $browser.url
      puts2("Current URL: " + sCurrentURL)

      puts2("\nAccess a different URL with the Global browser: " + sBingURL)
      $browser.goto(sBingURL)
      puts2("Current URL: " + $browser.url)

      puts2("Close the local browser")
      myLocalBrowser.close
      puts2("Local browser CLOSED")

      puts2("Is a Global browser running: " + is_global_browser_running?.to_s)

      # Close the Global browsers
      puts2("\nClose the Global browser")
      $browser.close
      puts2("Global browser CLOSED")
      puts2("Is a Global browser running: " + is_global_browser_running?.to_s + "\n\n")

      puts2("Remove the global browser's Global varaible, closing the browser does not remove its Global varaible")
      $browser=nil
      puts2("Is a Global browser running: " + is_global_browser_running?.to_s + "\n\n")

      # Force any open browsers to exit
      kill_browsers()

    rescue => e

      puts2("Error and Backtrace: " + e.message + "\n" + e.backtrace.join("\n"), "ERROR")

      # Force any open browsers to exit
      kill_browsers()

      # Raise the error with a custom message after the rest of the rescue actions
      raise("*** TESTCASE - test_Browser_003_GlobalAndLocalBrowsers")

    ensure

    end # Global browsers

    #puts2("END")

  end # Testcase -  test_Browser_004_GlobalAndLocalBrowsers


  #===========================================================================#
  # Testcase method: test_Browser_005_BrowserStatus
  #
  # Description: Starts local browser an determines their status.
  #
  # Tests methods: is_maximized?(...)
  #                is_minimized?(...)
  #===========================================================================#
  def test_Browser_005_BrowserStatus

    puts2("")
    puts2("#######################")
    puts2("Testcase: test_Browser_005_BrowserStatus")
    puts2("#######################")

    sGoogleURL = "http://google.com"
    #sBlankURL = "about:blank"
    sURL = sGoogleURL

    sBrowserType = $sDefaultBrowser

    begin # MinMax browsers

      if(is_win?) # Only run on windows

        browser = start_browser(sBrowserType)
        browser.goto(sURL)
        puts2("Current URL: " + browser.url)

=begin  watir-webdriver - missing method - minimize
        puts2("\nNormal sized browser")
        puts2("Minimized? = " + (browser.is_minimized?).to_s)
        puts2("Maximized? = " + (browser.is_maximized?).to_s)

        puts2("\nMimimized browser")
        browser.minimize
        puts2("Minimized? = " + (browser.is_minimized?).to_s)
        puts2("Maximized? = " + (browser.is_maximized?).to_s)


        puts2("\nMaximized browser")
        browser.maximize
        puts2("Minimized? = " + (browser.is_minimized?).to_s)
        puts2("Maximized? = " + (browser.is_maximized?).to_s)
=end

        if(browser.is_ie?) # Firewatir 1.6.5 lacks a restore method

=begin  watir-webdriver - missing method - minimize
          puts2("\nRestored normal sized browser")
          browser.restore
          puts2("Minimized? = " + (browser.is_minimized?).to_s)
          puts2("Maximized? = " + (browser.is_maximized?).to_s)
=end
        end

        # Force any open browsers to exit
        kill_browsers()

      else # Not running on windows
        puts2("Skipping test - incompatible OS")
      end # Only run on windows

    rescue => e

      puts2("Error and Backtrace: " + e.message + "\n" + e.backtrace.join("\n"), "ERROR")

      # Force any open browsers to exit
      kill_browsers()

      # Raise the error with a custom message after the rest of the rescue actions
      raise("*** TESTCASE - test_Browser_005_BrowserStatus")

    ensure

    end # MinMax browsers

    #puts2("END")

  end # Testcase -  test_Browser_005_BrowserStatus



  #===========================================================================#
  # Testcase method: test_Browser_006_SizeAndPosition
  #
  # Description: Starts local browser an determines their status.
  #
  # Tests methods: is_maximized?(...)
  #                is_minimized?(...)
  #===========================================================================#
  def test_Browser_006_SizeAndPosition

    $VERBOSE = true

    puts2("")
    puts2("#######################")
    puts2("Testcase: test_Browser_006_SizeAndPosition")
    puts2("#######################")

    #sGoogleURL = "http://google.com"
    sBlankURL = "about:blank"
    sURL = sBlankURL

    sBrowserType = $sDefaultBrowser

    begin # Resize browser

      #$browser = Watir::Browser.new
      $browser = start_browser(sBrowserType)

      $browser.goto(sURL)
      puts2("Current URL: " + $browser.url)

      # These tests hang with Watir::IE,
      # They run OK with WebDriver with any of the browser types.
      if(($browser.is_ie? == true) and (is_webdriver? == false))
        puts2("Skipping test incompatible browser")
      else
        puts2("\n ReSize browser to 640 x 680")
        $browser.resizeTo(640,480)
        #sleep 3 # Delay so you can see the new sized browser window

        puts2("\n ReSize browser to 1024 x 756")
        $browser.resizeTo(1024,756)
        #sleep 3 # Delay so you can see the new sized browser window

        puts2("\n ReSize browser to 100 x 200")
        $browser.resizeTo(100,200)
        #sleep 3 # Delay so you can see the new sized browser window

        puts2("\n Move browser to x = 100, y = 200")
        $browser.moveTo(100,200)
        #sleep 3 # Delay so you can see the repositioned browser window

        puts2("\n Move browser to x = 10, y = 20")
        $browser.moveTo(10,20)
        #sleep 3 # Delay so you can see the repositioned browser window

      end # Only run these tests on firefox, hands on IE

      # Force any open browsers to exit
      kill_browsers()


    rescue => e

      puts2("Error and Backtrace: " + e.message + "\n" + e.backtrace.join("\n"), "ERROR")

      # Force any open browsers to exit
      kill_browsers()

      # Raise the error with a custom message after the rest of the rescue actions
      raise("*** TESTCASE - test_Browser_006_SizeAndPosition")

    ensure

    end # Resize browsers

  end # END Testcase - test_Browser_006_SizeAndPosition

  #===========================================================================#
  # Testcase method: test_Browser_999_ClearCacheAndCookies
  #
  # Description: Test the method clear_Cache(...) which in turns
  #                calls one of the following platform specific methods:
  #                                clear_Win_Cache(...)
  #                                clear_Linux_Cache(...)
  #                                clear_Mac_Cache(...)
  #
  #===========================================================================#
  def test_Browser_999_ClearCacheAndCookies

    puts2("")
    puts2("#######################")
    puts2("Testcase: test_Browser_999_ClearCacheAndCookies")
    puts2("#######################")

    begin

      puts2("Clear the Cache and Cookies")
      clear_cache()

    rescue => e

      puts2("*** ERROR and Backtrace: " + e.message + "\n" + e.backtrace.join("\n"), "ERROR")

    ensure

    end

  end # END Testcase - test_Browser_999_ClearCacheAndCookies

end # end of Class - Unittest_Browser
