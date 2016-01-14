#--
#=============================================================================#
# File: watirworks_os_unittest.rb
#
#  Copyright (c) 2008-2016, Joe DiMauro
#  All rights reserved.
#
# Description: Unit tests for WatirWorks OS methods:
#
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
  include WatirWorks_MacUtilities # WatirWorks OSX Utilities
  #puts2("*** ERROR - These tests are not supported on this platform")
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
# Class: Unittest_OS
#
#
# Test Case Methods: setup, teardown
#                    test_OS_001_ReadRegistryKey
#                    test_OS_002_parseWinRegistryKey
#                    test_OS_003_getWindowsVersion
#                    test_OS_004_displayOSVersion
#                    test_OS_005_getOSXVersion
#                    test_OS_006_is_os
#
#=============================================================================#
class UnitTest_OS < Test::Unit::TestCase
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
  # Testcase method: test_OS_001_ReadRegistryKey
  #
  # Description: Read single value's from the Window's Registry
  #
  #===========================================================================#
  def test_OS_001_ReadRegistryKey

    puts2("")
    puts2("#######################")
    puts2("Testcase: test_OS_001_ReadRegistryKey")
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

  end # end Testcase - test_OS_001_ReadRegistryKey

  #===========================================================================#
  # Testcase method: test_OS_002_parseWinRegistryKey
  #
  # Description: Test methods:
  #                 parseWinRegistryKey(...)
  #
  #===========================================================================#
  def test_OS_002_parseWinRegistryKey

    puts2("")
    puts2("#######################")
    puts2("Testcase: test_OS_002_parseWinRegistryKey")
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

  end # end Testcase - test_OS_002_parseWinRegistryKey

  #===========================================================================#
  # Testcase method: test_OS_003_getWindowsVersion
  #
  # Description: Test methods:
  #                 getWindowsVersion()
  #
  #===========================================================================#
  def test_OS_003_getWindowsVersion

    puts2("")
    puts2("#######################")
    puts2("Testcase: test_OS_003_getWindowsVersion")
    puts2("#######################")

    if(is_win? == false)
      puts2("WARNING - Test is only supported in Windows", 'WARN')
      return
    end

    # Read the Windows Version form the Registry
    sWinVersion = getWindowsVersion()

    # Display the key's value
    puts2("\tWindows Version = " + sWinVersion.to_s)

  end # end Testcase - test_OS_003_getWindowsVersion

  #===========================================================================#
  # Testcase method: test_OS_004_displayOSVersion
  #
  # Description: Test methods:
  #                 displayOSVersion()
  #
  #===========================================================================#
  def test_OS_004_displayOSVersion

    puts2("")
    puts2("#######################")
    puts2("Testcase: test_OS_004_displayOSVersion")
    puts2("#######################")

    # Display the OS Version
    display_OSVersion()

  end # end Testcase - test_OS_004_displayOSVersion

  #===========================================================================#
  # Testcase method: test_OS_005_getOSXVersion
  #
  # Description: Test methods:
  #                 getOSXVersion()
  #
  #===========================================================================#
  def test_OS_005_getOSXVersion

    puts2("")
    puts2("#######################")
    puts2("Testcase: test_OS_005_getOSXVersion")
    puts2("#######################")

    if(is_osx? == true)
      # Get the OS Version
      sOSVersion = getOSXVersion()
    end

    #puts2('sOSVersion.class = ' + sOSVersion.class.to_s)

    puts2("OSX " + sOSVersion.to_s)
  end # end Testcase - test_OS_005_getOSXVersion

  #===========================================================================#
  # Testcase method: test_OS_006_is_os
  #
  # Description: Test methods:
  #                 is_win?(...)
  #                 is_osx?(...)
  #                 is_linux?(...)
  #
  #===========================================================================#
  def test_OS_006_is_os()

    puts2("")
    puts2("#######################")
    puts2("Testcase: test_OS_006_is_os")
    puts2("#######################")

    puts2("\nWhat's the OS?...")
    puts2("\tWindows = " + is_win?.to_s)
    puts2("\tOSX = " + is_osx?.to_s)
    puts2("\tLinux = " + is_linux?.to_s)

    sVersion = '99'
    puts2("\nIs it OS version " + sVersion + "...")
    puts2("\tWindows 99 = " + is_win?(sVersion).to_s)
    puts2("\tOSX 99 = " + is_osx?(sVersion).to_s)
    #puts2("\tLinux = " + is_linux?(sVersion).to_s) # Not implimented yet

    puts2("\nWhat OS version is it ...")
    if(is_win? == true)

      puts2("\tIs it Windows XP: "  + is_win?("XP").to_s)
      puts2("\tIs it Windows Vista: "  + is_win?("Vista").to_s)
      puts2("\tIs it Windows 7: "  + is_win?("7").to_s)
      puts2("\tIs it Windows 8: "  + is_win?("8").to_s)
      puts2("\tIs it Windows 8.1: "  + is_win?("8.1").to_s)
      puts2("\tIs it Windows 10: "  + is_win?("10").to_s)

      # Get the OS Version
      sWindowsVersion = getWindowsVersion()
      puts2("\tFull version info: " + sWindowsVersion + " = " + is_win?(sWindowsVersion).to_s)
    end

    if(is_osx? == true)
      # Get the OS Version
      sOSXVersion = getOSXVersion()
      puts2("\tOSX " + sOSXVersion + " = " + is_osx?(sOSXVersion).to_s)
    end

  end # end Testcase - test_OS_006_is_os

end # end of Class - UnitTest_OS
