#--
#=============================================================================#
# File: watirworks_environment_unittest.rb
#
#  Copyright (c) 2008-2012, Joe DiMauro
#  All rights reserved.
#
# Description: Unit tests for WatirWorks methods:
#                display_ruby_env()
#                display_ruby_environment()
#                display_watir_env()
#                find_tmp_dir()
#                is_win?()
#                is_win32?()
#                is_win64?()
#                is_linux?()
#                is_java?()
#                is_osx?()
#                display_watirworks_env()
#                printenv(...)
#                getenv(...)
#                setenv(...)
#=============================================================================#

#=============================================================================#
# Require and Include section
# Entries for additional files or methods needed by this test
#=============================================================================#
require 'rubygems'

# WatirWorks
require 'watirworks'  # The WatirWorks library loader
include WatirWorks_Utilities    #  WatirWorks General Utilities
include WatirWorks_WebUtilities    #  WatirWorks Web Utilities

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
sRun_TestType = "nobrowser"
iRun_TestLevel = 0
#=============================================================================#

#=============================================================================#
# Class: UnitTest_Enviroment
#
# Test Case Methods: setup, teardown
#                    test_Enviroment_001_showRubyEnv
#                    test_Enviroment_002_isPlatform
#                    test_Enviroment_003_showWatirWorksEnv
#                    test_Enviroment_004_SortMethods
#                    test_Enviroment_005_PrintEnv
#                    test_Enviroment_006_GetEnv
#                    test_Enviroment_007_SetEnv
#
#=============================================================================#
class UnitTest_Enviroment < Test::Unit::TestCase
  
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
  # Testcase method: test_Enviroment_001_showRubyEnv
  #
  # Description: Test the methods: display_ruby_env()
  #                                             display_ruby_environment()
  #                                             find_tmp_dir()
  #===========================================================================#
  def test_Enviroment_001_showRubyEnv
    
    puts2("")
    puts2("#######################")
    puts2("Testcase: test_Enviroment_001_showRubyEnv")
    puts2("#######################")
    
    puts2("\nTest - display_ruby_env")
    # Record info on the Ruby Environment
    display_ruby_env()  # Record output
    
    puts2("\n\nTest - display_ruby_environment")
    display_ruby_environment()
    
    puts2("\n\nTest - display_watir_env")
    display_watir_env()
    
    puts2("\n\nTest - find_tmp_dir")
    puts2(find_tmp_dir)
    
  end # Unit test - test_Enviroment_001_showRubyEnv
  
  
  #===========================================================================#
  # Testcase method: test_Enviroment_002_isPlatform
  #
  # Description: Test the methods
  #                is_win?()
  #                is_win32?()
  #                is_win64?()
  #                is_linux?()
  #                is_java?()
  #                is_osx?()
  #                get_registered_ie_version()
  #                is_ie6_registered?()
  #                is_ie7_registered?()
  #                is_ie8_registered?()
  #                get_registered_firefox_version()
  #                is_firefox2_registered?()
  #                is_firefox3_registered?()
  #                is_firefox4_registered?()
  #                is_firefox5_registered?()
  #                is_firefox6_registered?()
  #                is_firefox7_registered?()
  #                is_firefox8_registered?()
  #                is_firefox9_registered?()
  #                is_firefox10_registered?()
  #
  #===========================================================================#
  def test_Enviroment_002_isPlatform
    
    puts2("")
    puts2("#######################")
    puts2("Testcase: test_Enviroment_002_isPlatform")
    puts2("#######################")
    
    puts2("Running Ruby for Windows: " + is_win?.to_s)
    puts2("Running Ruby for Windows 32-bit: " + is_win32?.to_s)
    puts2("Running Ruby for Windows 64 bit: " + is_win64?.to_s)
    puts2("Running Ruby for Linux: " + is_linux?.to_s)
    puts2("Running Ruby for OS/X: " + is_osx?.to_s)
    puts2("Running on JRuby: " + is_java?.to_s)
    
    if(is_win?)
      
      puts2("\nRegistered IE version: " + get_registered_ie_version)
      puts2("Is IE6: " + is_ie_installed?(6).to_s)
      puts2("Is IE7: " + is_ie_installed?(7).to_s)
      puts2("Is IE8: " + is_ie_installed?(8).to_s)
      puts2("Is IE9: " + is_ie_installed?(9).to_s)
      puts2("Is IE10: " + is_ie_installed?(10).to_s)
      
      puts2("\nRegistered Firefox version: " + get_registered_firefox_version)
      puts2("Is FF2: " + is_firefox_installed?(2).to_s)
      puts2("Is FF3: " + is_firefox_installed?(3).to_s)
      puts2("Is FF4: " + is_firefox_installed?(4).to_s)
      puts2("Is FF5: " + is_firefox_installed?(5).to_s)
      puts2("Is FF6: " + is_firefox_installed?(6).to_s)
      puts2("Is FF7: " + is_firefox_installed?(7).to_s)
      puts2("Is FF8: " + is_firefox_installed?(8).to_s)
      puts2("Is FF9: " + is_firefox_installed?(9).to_s)
      puts2("Is FF10: " + is_firefox_installed?(10).to_s)
      
    end
    
    puts2("\n Platform independant installed version methods:")
    puts2("IE version: " + get_ie_version.to_s)
    puts2("Firefox version: " + get_firefox_version.to_s)
    
  end # Unit test - test_Enviroment_002_isPlatform
  
  #===========================================================================#
  # Testcase method: test_Enviroment_003_showWatirWorksEnv
  #
  # Description: Test the method - display_watirworks_env()
  #===========================================================================#
  def test_Enviroment_003_showWatirWorksEnv
    
    puts2("")
    puts2("#######################")
    puts2("Testcase: test_Enviroment_003_showWatirWorksEnv")
    puts2("#######################")
    
    # Record info on the WatirWorks Environment
    display_watirworks_env() # Record output
  end # Unit test - test_Enviroment_003_showWatirWorksEnv
  
  
  #===========================================================================#
  # Testcase method: test_Enviroment_004_SortMethods
  #
  # Description: Test the method sorting abilities of Ruby
  #===========================================================================#
  def test_Enviroment_004_SortMethods
    
    puts2("")
    puts2("#######################")
    puts2("Testcase: test_Enviroment_004_SortMethods")
    puts2("#######################")
    puts2("  Sorted list of Methods in use:")
    puts2(Object.new.methods.sort)
    puts2("######################")
    
  end # End of test method - test_Enviroment_004_SortMethods
  
  #===========================================================================#
  # Testcase method: test_Enviroment_005_PrintEnv
  #
  # Description: Test OS environment variables using printenv(...)
  #===========================================================================#
  def test_Enviroment_005_PrintEnv
    
    puts2("")
    puts2("#######################")
    puts2("Testcase: test_Enviroment_005_PrintEnv")
    puts2("#######################")
    
    puts2("")
    puts2(" Display current settings of some OS variables using printenv()...")
    printenv("BOGUS_ENVVAR")
    printenv("COMPUTERNAME") # Is this one platform independent?
    printenv("USERDNSDOMAIN") # Is this one platform independent?
    printenv("NUMBER_OF_PROCESSORS") # Is this one platform independent?
    printenv("OS") # Is this one platform independent?
    printenv("PROCESSOR_IDENTIFIER") # Is this one platform independent?
    printenv("SHELL") # Is this one platform independent? Yes on: Ubuntu,
    printenv("USERNAME") # Is this one platform independent? Yes on: Win, Ubuntu
    
    puts2("")
    puts2("")
    puts2(" Display current settings of ALL OS variables using printenv()...")
    printenv()
    
  end # END Testcase method - test_Enviroment_005_PrintEnv
  
  
  #===========================================================================#
  # Testcase method: test_Enviroment_006_GetEnv
  #
  # Description: Test OS environment variables using getenv(...)
  #===========================================================================#
  def test_Enviroment_006_GetEnv
    
    puts2("")
    puts2("#######################")
    puts2("Testcase: test_Enviroment_006_GetEnv")
    puts2("#######################")
    
    sEnvVarName = "COMPUTERNAME" # Is this one platform independent?
    
    puts2("")
    puts2("Retrieve all OS variables using getenv()")
    hMyEnvVars = getenv() # Get them all
    
    # Loop through the hash and display each variable name and its setting
    hMyEnvVars.each do  | key, value |
      puts2(" OS variable: \"#{key.to_s}\" is set to \"#{value}\" ")
    end
    
    puts2("")
    puts2("Retrieve a specific OS variable using getenv")
    hMyEnvVars = getenv(sEnvVarName)
    
    # Loop through the hash and display each variable name and its setting
    hMyEnvVars.each do  | key, value |
      puts2(" OS variable: \"#{key.to_s}\" is set to \"#{value}\" ")
    end
    
  end # END Testcase - test_Enviroment_006_GetEnv
  
  #===========================================================================#
  # Testcase method: test_Enviroment_007_SetEnv
  #
  # Description: Test setting an OS environment variable using setenv(...)
  #===========================================================================#
  def test_Enviroment_007_SetEnv
    
    puts2("")
    puts2("#######################")
    puts2("Testcase: test_Enviroment_007_SetEnv")
    puts2("#######################")
    
    sEnvVarName = "COMPUTERNAME" # Is this one platform independent?
    sNewValue = "MyNewName"
    
    # Display the current value
    puts2("Current value of " + sEnvVarName)
    printenv(sEnvVarName)
    
    puts2(" Setting " + sEnvVarName + " to " + sNewValue)
    
    # Set new value that will be in effect for duration of this Ruby session's test run
    setenv(sEnvVarName, sNewValue)
    
    # Display the current value
    puts2("Current value of " + sEnvVarName)
    printenv(sEnvVarName)
    
    
    sNewEnvVarName = "Ruby"
    sNewSetting = "Is Cool"
    puts2(" Setting a new Environment Variable " + sNewEnvVarName + " to a new setting " + sNewSetting)
    
    # Set new value that will be in effect for duration of this Ruby session's test run
    setenv(sNewEnvVarName, sNewSetting)
    
    # Display the current value
    puts2("Current value of " + sNewEnvVarName)
    printenv(sNewEnvVarName)
    
  end # END Testcase method - test_Enviroment_007_SetEnv
  
  #===========================================================================#
  # Testcase method: test_Enviroment_008_watirworks_install_path
  #
  # Description: Test method: watirworks_install_path()
  #===========================================================================#
  def test_Enviroment_008_watirworks_install_path
    
    puts2("")
    puts2("#######################")
    puts2("Testcase: test_Enviroment_008_watirworks_install_path")
    puts2("#######################")
    
    puts2("WatirWorks install path: " + get_watirworks_install_path)
    
  end # END Testcase method - test_Enviroment_008_watirworks_install_path
  
end # END - Class - UnitTest_Enviroment
