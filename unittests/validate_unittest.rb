#--
#=============================================================================#
# File: validate_unittest.rb
#
#  Copyright (c) 2008-2018, Joe DiMauro
#  All rights reserved.
#
# Description: Unit tests for WatirWorks methods:
#                       isValid_Password(...)
#                       isValid_EmailAddress?(...)
#                       sValid_ZipCode?(...)
#                       isValid_TopLevelDomain(...)
#=============================================================================#
require 'rubygems'

# WatirWorks
require 'watirworks'  # The WatirWorks library loader
include WatirWorks_Utilities   #  WatirWorks  General Utilities
include WatirWorks_RefLib      #  WatirWorks Reference data module

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
bIncludeInSuite = true
sRun_TestType = "nobrowser"
iRun_TestLevel = 0
#=============================================================================#

#=============================================================================#
# Class: UnitTest_IsValid
#
#
# Test Case Methods: setup, teardown,
#                    test_001_isValid_Password
#                    test_002_isValid_ZipCode
#                    test_003_isValid_TopLevelDomain
#                    test_004_isValid_EmailAddress
#=============================================================================#
class UnitTest_IsValid < Test::Unit::TestCase

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
  # Testcase method: test_IsValid_001_Password
  #--
  #
  # Description: Test the methods:
  #                       isValid_Password(...)
  #===========================================================================#
  def test_IsValid_001_Password

    puts2("")
    puts2("#######################")
    puts2("Testcase: test_IsValid_001_Password")
    puts2("#######################")

    #$VERBOSE=true

    # Define an array of zip codes to try
    aPasswords = [ "pwd", "Passw0rd", "123qweasdZXC", "MyPa55w0rd", "12345678","123456Az" ]

    # Loop
    aPasswords.each do | sPassword |

      puts2("\nPassword = " + sPassword.to_s)
      if(sPassword.isValid_Password?) # Check validity
        puts2("Valid")
      else
        puts2("Invalid")
      end # Check validity
    end # Loop

  end # End of test method - test_IsValid_001_Password


  #===========================================================================#
  # Testcase method: test_IsValid_002_ZipCode
  #--
  #
  # Description: Test the methods:
  #                       sValid_ZipCode?(...)
  #===========================================================================#
  def test_IsValid_002_ZipCode

    puts2("")
    puts2("#######################")
    puts2("Testcase: test_IsValid_002_ZipCode")
    puts2("#######################")

    #$VERBOSE=true

    # Define an array of zip codes to try
    aZipCodes = [ "80021", "12345", "123456", "1", "1234",  "12345-1234", "12345-123", "00000" ]

    # Loop
    aZipCodes.each do | sZipCode |

      puts2("\nZip Code = " + sZipCode.to_s)
      if(sZipCode.isValid_ZipCode?) # Check validity
        puts2("Valid")
      else
        puts2("Invalid")
      end # Check validity
    end # Loop

  end # End of test method - test_IsValid_002_ZipCode

  #===========================================================================#
  # Testcase method: test_IsValid_003_TopLevelDomain
  #--
  #
  # Description: Test the methods:
  #                       isValid_TopLevelDomain(...)
  #===========================================================================#
  def test_IsValid_003_TopLevelDomain

    puts2("")
    puts2("#######################")
    puts2("Testcase: test_IsValid_003_TopLevelDomain")
    puts2("#######################")

    #$VERBOSE=true

    sTopLevelDomains = "com"

    # Define an array of TLD's to try
    sTopLevelDomains = [ "com", "biz", "gov", "net", "org", "de", "museum", "travel", "d", "bizz", "xyv", "123" ]

    # Loop
    sTopLevelDomains.each do | sTLD |

      puts2("\nTop Level Domain = " + sTLD.to_s)

      if(sTLD.isValid_TopLevelDomain?) # Check validity
        puts2("Valid")
      else
        puts2("Invalid")
      end # Check validity
    end # Loop


  end # End of test method - test_IsValid_003_TopLevelDomain

  #===========================================================================#
  # Testcase method: test_IsValid_004_EmailAddress
  #--
  #
  # Description: Test the methods:
  #                       isValid_EmailAddress?(...)
  #===========================================================================#
  def test_IsValid_004_EmailAddress

    puts2("")
    puts2("#######################")
    puts2("Testcase: test_IsValid_004_EmailAddress")
    puts2("#######################")

    #$VERBOSE=true

    # Define an array of email addresses to try
    sEmailAddresses = [ "me@server.com", "you@yourserver.gov", "me@123.xyz", "$5@_#.xyz"]

    # Loop
    sEmailAddresses.each do | sAddress |

      puts2("\nEmail Address = " + sAddress.to_s)
      if(sAddress.isValid_EmailAddress?) # Check validity
        puts2("Valid")
      else
        puts2("Invalid")
      end # Check validity
    end # Loop

  end # End of test method - test_IsValid_004_EmailAddress


end # end of Class - UnitTest_IsValid
