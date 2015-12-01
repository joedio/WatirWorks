#--
#=============================================================================#
# File: watirworks_windows_unittest.rb
#
#  Copyright (c) 2008-2010, Joe DiMauro
#  All rights reserved.
#
# Description: Unit tests for WatirWorks Windowsmethods:
#                          xxx_win(...)
#
#=============================================================================#

#=============================================================================#
# Require and Include section
# Entries for additional files or methods needed by this test
#=============================================================================#
require 'rubygems'

$bUseWebDriver = true

# WatirWorks
require 'watirworks'               # The WatirWorks library loader

include WatirWorks_Utilities       #  WatirWorks General Utilities
include WatirWorks_WebUtilities    #  WatirWorks Web Utilities

# Include the platform specific modules
if(is_win?)
  require 'win32/registry'
  include WatirWorks_WinUtilities # WatirWorks Windows Utilities
else
  puts2("*** ERROR - These tests are not supported on this platform")
end

#=============================================================================#
# Global Variables section
# Set global variables that will be inherited by each of the test files
#=============================================================================#

# Ruby global variables
#

# Watir global variables
#

# WatirWorks global variables
bIncludeInSuite = false
sRun_TestType = "nobrowser"
iRun_TestLevel = 0

#=============================================================================#
#=============================================================================#
# Class: UnitTest_Windows
#
#
# Test Case Methods: setup, teardown
#                    test_Windows_001_WinMessageBox
#                    test_Windows_002_Pause
#                    test_Windows_003_popup_watchpoint
#
#=============================================================================#
class UnitTest_Windows < Test::Unit::TestCase
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

  end # end of teardown

  #===========================================================================#
  # Testcase method: test_Windows_001_ReadRegistryKey
  #
  # Description: Read single value's from the Window's Registry
  #
  #===========================================================================#
  def test_Windows_001_ReadRegistryKey

    puts2("")
    puts2("#######################")
    puts2("Testcase: test_Windows_001_ReadRegistryKey")
    puts2("#######################")

    $VERBOSE = true

    if(is_win? == false)
      puts2("WARNING - Test is only supported in Windows", 'WARN')
      return
    end

    puts2("Read value's from the Window's Registry...")

    # Define a Windows Registry key to be read
    sRegHive = 'HKEY_LOCAL_MACHINE'
    sRegPath = 'SOFTWARE\Microsoft\Windows NT\CurrentVersion'

    # Read the key's value
    sRegKeyName = 'ProductName'
    puts2("\tReading " + sRegHive + "\\" + sRegPath + "\\" + sRegKeyName)
    Win32::Registry::HKEY_LOCAL_MACHINE.open(sRegPath) do |reg|

      sKeyValue = reg[sRegKeyName, Win32::Registry::REG_SZ]

      sRegFullpath = sRegHive + "\\" + sRegPath + "\\" + sRegKeyName

      # Display the key's value
      puts2("\tFound:  " + sRegFullpath.to_s + " = " + sKeyValue.to_s)

    end #  Read the key's value

    # Define a Windows Registry key to be read

    # Read the key's value
    sRegKeyName = 'CurrentVersion'
    puts2("\tReading " + sRegHive + "\\" + sRegPath + "\\" + sRegKeyName)
    Win32::Registry::HKEY_LOCAL_MACHINE.open(sRegPath) do |reg|

      sKeyValue = reg[sRegKeyName, Win32::Registry::REG_SZ]

      sRegFullpath = sRegHive + "\\" + sRegPath + "\\" + sRegKeyName

      # Display the key's value
      puts2("\tFound:  " + sRegFullpath.to_s + " = " + sKeyValue.to_s)

    end # Read the key's value

  end # end Testcase - test_Windows_001_ReadRegistryKey

  #===========================================================================#
  # Testcase method: test_Windows_002_parseWinRegistryKey
  #
  # Description: Test methods:
  #                 parseWinRegistryKey(...)
  #
  #===========================================================================#
  def test_Windows_002_parseWinRegistryKey

    puts2("")
    puts2("#######################")
    puts2("Testcase: test_Windows_002_parseWinRegistryKey")
    puts2("#######################")

    #$VERBOSE = true

    if(is_win? == false)
      puts2("WARNING - Test is only supported in Windows", 'WARN')
      return
    end

    puts2("Parse value's from the Window's Registry...")

    # Define a Windows Registry key to be read
    sRegHive = 'HKEY_LOCAL_MACHINE'
    sRegPath = 'SOFTWARE\Microsoft\Windows NT\CurrentVersion'
    hRegKeyNames = ['ProductName','CurrentVersion']

    puts2("Key's to read = " + hRegKeyNames.to_s)

    hRegKeyNames.each do |sRegKeyName|

      sRegFullpath = sRegHive + "\\" + sRegPath + "\\" + sRegKeyName
      puts2("\tParsing " + sRegFullpath)

      # Read the key's value
      sKeyValue = parseWinRegistryKey(sRegHive, sRegPath, sRegKeyName)

      # Display the key's value
      puts2("\tFound:  " + sRegFullpath.to_s + " = " + sKeyValue.to_s)

    end

  end # end Testcase - test_Windows_002_parseWinRegistryKey

  #===========================================================================#
  # Testcase method: test_Windows_003_getWindowsVersion
  #
  # Description: Test methods:
  #                 getWindowsVersion()
  #
  #===========================================================================#
  def test_Windows_003_getWindowsVersion

    puts2("")
    puts2("#######################")
    puts2("Testcase: test_Windows_003_getWindowsVersion")
    puts2("#######################")

    if(is_win? == false)
      puts2("WARNING - Test is only supported in Windows", 'WARN')
      return
    end

    # Read the Windows Version form the Registry
    sWinVersion = getWindowsVersion()

    # Display the key's value
    puts2("\tWindows Version = " + sWinVersion.to_s)

  end # end Testcase - test_Windows_003_getWindowsVersion

  #===========================================================================#
  # Testcase method: test_Windows_004_displayOSVersion
  #
  # Description: Test methods:
  #                 displayOSVersion()
  #
  #===========================================================================#
  def test_Windows_004_displayOSVersion

    puts2("")
    puts2("#######################")
    puts2("Testcase: test_Windows_004_displayOSVersion")
    puts2("#######################")

    # Display the OS Version
    display_OSVersion()

  end # end Testcase - test_Windows_004_displayOSVersion

end # end of Class - UnitTest_Windows
