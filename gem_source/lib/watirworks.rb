#=============================================================================#
# File: watirworks.rb
#
#  Copyright (c) 2010-2012, Joe DiMauro
#  All rights reserved.
#
# Description: This script auto-loads WatirWorks modules and contains includes
#              for some Ruby/Watir libraries commonly needed by WatirWorks.
#
# Prerequisites: Ruby1.8.7, Watir1.9.x
#
# Instructions: Add the following entry to each of your test script files :
#                  require 'watirworks'
#
#               To access a WatirWorks methods or functions from your test script file either use:
#
#                  A) The full name syntax of <module>::<object> for the WatirWorks method, function or object.
#                       Where
#                          <module> is the name of the Module containing the object
#                          <object> is a class, method, array, hash or other object to be used
#
#                       For example, to access the state abbreviations from the WatirWorks Reference library:
#                          sMyFullStateName = WatirWorks_RefLib:USPS_StateAbbreviation["CO"]
#
#                  B) (RECOMENDED) Within each of your test script files add an entry for
#                      any WartirWorks module you're using.  For example:
#                        	include WatirWorks_RefLib
#
#                Then access the objects in that WatirWorks module by only specifying its relative name.
#                    sMyFullStateName = USPS_StateAbbreviation["CO"]
#
#=============================================================================#

#=============================================================================#
# BEGIN - Require and Include section
#
# Entries are inherited by all test files / testsuite files that contain the entry:
#    require 'watirworks'
#=============================================================================#

# Ruby section
#==============
require "test/unit"               # Require Ruby's Unit Test framework files
require "test/unit/assertions"    # Require Ruby's assertions files
include Test::Unit::Assertions    # A Ruby Module

# Watir section
#===============
#require 'watir'              # Require the files for the Watir gem

# To use Watir-WebDriver uncomment this command
# To use Watir or Firewatir comment out this command
#$bUseWebDriver = false

if($bUseWebDriver == true)
  require 'watir-webdriver'
end

# WatirWorks section
#====================
#  Use ruby's auto-load capabilities to associate a module name with the proper file to load.
#  Files will be loaded upon first 'include' statement for the associated module within your test file.
#  If you are NOT using a specific WatirWorks module you may comment out that modules entry, but its not really necessary
#  as by using ruby's autoload capability it has no effect unless the module is included.
#
autoload :WatirWorks_RefLib, "watirworks/watirworks_reflib.rb"		# The WatirWorks Reference Library
autoload :WatirWorks_Utilities, "watirworks/watirworks_utilities.rb"	# The WatirWorks Utilities Library
autoload :WatirWorks_WebUtilities, "watirworks/watirworks_web-utilities.rb"	# The WatirWorks Web Utilities Library
autoload :WatirWorks_WinUtilities, "watirworks/watirworks_win-utilities.rb"	# The WatirWorks Windows Utilities Library
autoload :WatirWorks_LinuxUtilities, "watirworks/watirworks_linux-utilities.rb"	# The WatirWorks Linux Utilities Library
autoload :WatirWorks_MacUtilities, "watirworks/watirworks_mac-utilities.rb"	# The WatirWorks Mac/OSX Utilities Library



# Application Under Test section
#================================
#  Additional entries for libraries or methods that are common to the AUT
#
#autoload :MyModuleName, "MyAppsGemDirectory/MyAppsLibrary.rb"
#
# END - User specific section

#=============================================================================#
# END - Require and Include section
#=============================================================================#

# END - File: watirworks.rb
