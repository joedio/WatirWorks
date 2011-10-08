#--
#=============================================================================#
# File: watirworks_xml_unittest.rb
#
#  Copyright (c) 2008-2010, Joe DiMauro
#  All rights reserved.
#
# Description: Unit tests for WatirWorks WebUtilities methods:
#    createXMLTags(...)
#    get_xml_tag_value(...)
#    is_tag_in_xml?(..)
#    remove_xml_brackets(...)
#
#=============================================================================#

#=============================================================================#
# Require and Include section
# Entries for additional files or methods needed by this test
#=============================================================================#
require 'rubygems'

# WatirWorks
require 'watirworks'  # The WatirWorks library loader
include WatirWorks_Utilities    # WatirWorks General Utilities
include WatirWorks_WebUtilities # WatirWorks Web Utilities
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
sRun_TestType = "nobrowser"  #"wip" 
iRun_TestLevel = 0
#=============================================================================#


#=============================================================================#
# Class: UnitTest_WebUtilities
#
#
# Test Case Methods: setup, teardown
#
#
#
#=============================================================================#
class UnitTest_WebUtilities < Test::Unit::TestCase
  
  #===========================================================================#
  # Method: setUp
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
  # Method: tearDown
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
  # Testcase method: test_xml_001_is_tag_in_xml?
  #
  # Description: Test the methods:
  #                                is_tag_in_xml?(...)
  #                                create_xml_tags(...)
  #                                remove_xml_brackets(...)
  #===========================================================================#
  def test_xml_001_is_tag_in_xml?
    
    puts2("")
    puts2("#######################")
    puts2("Testcase: test_xml_001_is_tag_in_xml?")
    puts2("#######################")
    
    #$VERBOSE = true
    
    if($VERBOSE == true)
      # pass
    end
    
    sXML = '<soapenv:Body><getUserInfoResponse><result><accessibilityMode>false</accessibilityMode><currencySymbol>$</currencySymbol><orgDefaultCurrencyIsoCode>USD</orgDefaultCurrencyIsoCode><orgDisallowHtmlAttachments>false</orgDisallowHtmlAttachments><orgHasPersonAccounts>false</orgHasPersonAccounts><organizationId>00DS00000009AAaMAM</organizationId><organizationMultiCurrency>false</organizationMultiCurrency><organizationName>Qwest (BMG)</organizationName><profileId>00eA0000000tw4dIAA</profileId><roleId>00EA0000000UO5PMAW</roleId><userDefaultCurrencyIsoCode xsi:nil="true"/><userEmail>sfdcitv1@qwest.com</userEmail><userFullName>Sfainttest Sfainttest</userFullName><userId>005S0000000iQPQIA2</userId><userLanguage>en_US</userLanguage><userLocale>en_US</userLocale><userName>sfainttest1@qwest.com.e2e</userName><userTimeZone>America/Denver</userTimeZone><userType>Standard</userType><userUiSkin>Theme3</userUiSkin></result></getUserInfoResponse></soapenv:Body>'
    
    aTags = ["bogus_tag", "<bogus_tag>", "</bogus_tag>", "userName", "<userName>", "</userName>", "userEmail", "userId", "profileId", "roleId"]
    
    aTags.each do | sTag |
      
      sTagExists = is_tag_in_xml?(sXML, sTag).to_s
      puts2("Closing Tag for " + sTag + " in XML = " + sTagExists.to_s)
    end # end
    
  end # end test_XMLTtest_xml_001_is_tag_in_xml?()
  
  
  #===========================================================================#
  # Testcase method: test_xml_002_get_xml_tag_value
  #
  # Description: Test the methods:
  #                                get_xml_tag_value(...)
  #===========================================================================#
  def test_xml_002_get_xml_tag_value
    
    puts2("")
    puts2("#######################")
    puts2("Testcase: test_xml_002_get_xml_tag_value")
    puts2("#######################")
    
    #$VERBOSE = true
    
    if($VERBOSE == true)
      # pass
    end
    
    sXML = '<soapenv:Body><getUserInfoResponse><result><accessibilityMode>false</accessibilityMode><currencySymbol>$</currencySymbol><orgDefaultCurrencyIsoCode>USD</orgDefaultCurrencyIsoCode><orgDisallowHtmlAttachments>false</orgDisallowHtmlAttachments><orgHasPersonAccounts>false</orgHasPersonAccounts><organizationId>00DS00000009AAaMAM</organizationId><organizationMultiCurrency>false</organizationMultiCurrency><organizationName>Qwest (BMG)</organizationName><profileId>00eA0000000tw4dIAA</profileId><roleId>00EA0000000UO5PMAW</roleId><userDefaultCurrencyIsoCode xsi:nil="true"/><userEmail>sfdcitv1@qwest.com</userEmail><userFullName>Sfainttest Sfainttest</userFullName><userId>005S0000000iQPQIA2</userId><userLanguage>en_US</userLanguage><userLocale>en_US</userLocale><userName>sfainttest1@qwest.com.e2e</userName><userTimeZone>America/Denver</userTimeZone><userType>Standard</userType><userUiSkin>Theme3</userUiSkin></a_null_tag></result></getUserInfoResponse></soapenv:Body>'
    
    aTags = ["bogus_tag", "<bogus_tag>", "</bogus_tag>", "userName", "<userName>", "</userName>", "userEmail", "userId", "profileId", "roleId", "a_null_tag", "result"]
    
    aTags.each do | sTag |
      
      sXMLTagValue = get_xml_tag_value(sXML, sTag).to_s
      puts2("Value of XML Tag '" + sTag + "' in XML = '" + sXMLTagValue + "'")
    end
    
  end # end test_xml_002_get_xml_tag_value()(...)
  
  
  #===========================================================================#
  # Testcase method: test_xml_003_get_multiple_xml_tag_values
  #
  # Description: Test the methods:
  #                                get_multiple_xml_tag_values(...)
  #===========================================================================#
  def test_xml_003_get_multiple_xml_tag_values
    
    puts2("")
    puts2("#######################")
    puts2("Testcase: test_xml_003_get_multiple_xml_tag_values")
    puts2("#######################")
    
    #$VERBOSE = true
    
    if($VERBOSE == true)
      # pass
    end
    
    sXML = '<soapenv:Body><getUserInfoResponse><result><userName><FirstName>Bob</FirstName><userId>01</userId></userName><userName><FirstName>Tom</FirstName><userId>02</userId></userName></a_null_tag></result></getUserInfoResponse></soapenv:Body>'
    
    #sXML = '<soapenv:Body><getUserInfoResponse><result><accessibilityMode>false</accessibilityMode><currencySymbol>$</currencySymbol><orgDefaultCurrencyIsoCode>USD</orgDefaultCurrencyIsoCode><orgDisallowHtmlAttachments>false</orgDisallowHtmlAttachments><orgHasPersonAccounts>false</orgHasPersonAccounts><organizationId>00DS00000009AAaMAM</organizationId><organizationMultiCurrency>false</organizationMultiCurrency><organizationName>Qwest (BMG)</organizationName><profileId>00eA0000000tw4dIAA</profileId><roleId>00EA0000000UO5PMAW</roleId><userDefaultCurrencyIsoCode xsi:nil="true"/><userEmail>sfdcitv1@qwest.com</userEmail><userFullName>Sfainttest Sfainttest</userFullName><userId>005S0000000iQPQIA2</userId><userLanguage>en_US</userLanguage><userLocale>en_US</userLocale><userName>sfainttest1@qwest.com.e2e</userName><userTimeZone>America/Denver</userTimeZone><userType>Standard</userType><userUiSkin>Theme3</userUiSkin></a_null_tag></result></getUserInfoResponse></soapenv:Body>'
    
    aTags = ["bogus_tag", "<bogus_tag>", "</bogus_tag>", "userName", "<userName>", "</userName>", "FirstName", "userId", "userEmail", "a_null_tag", "result"]
    
    aTags.each do | sTag |
      
      aXMLTagValue = get_multiple_xml_tag_values(sXML, sTag)
      #sXMLTagValue = get_multiple_xml_tag_values(sXML, sTag).to_s
      aXMLTagValue.each do | sXMLTagValue |
        puts2("Value of XML Tag '" + sTag + "' in XML = '" + sXMLTagValue + "'")
      end
    end
    
    puts2("-"*15)
    
    sXML = '<env:Body> <CreateProjectTasksRequest xmlns="http://com/qwest/qcworkflow/service"> <OpportunityId>50025454</OpportunityId> <PrimaryRepId>A6W0</PrimaryRepId> <SecondaryRepId xsi:nil="true" /> <LoggedInSalesRepId xsi:nil="true" /> <LoggedInCUID>rxpras2</LoggedInCUID> <CustomerName>Testing_QNDC</CustomerName> <CustomerHubUUID>123545245234</CustomerHubUUID> <CompanyMainAddr> <StreetAddr1>700 W mineral Ave</StreetAddr1> <StreetAddr2 xsi:nil="true" /> <PostalCd>80120</PostalCd> <City>Littleton</City> <StateCd>CO</StateCd> <Country>USA</Country> </CompanyMainAddr> <QCID>1234567890</QCID> <CompanyMainPhone>(720) 229-0655</CompanyMainPhone> <CompanyMainFax xsi:nil="true" /> <SalesChannelId>1</SalesChannelId> <BusinessProcessType>BMG</BusinessProcessType> <ContactList> <Contact xsi:nil="true" /> <Contact> <ContactType>RATE</ContactType> <ContactName xsi:nil="true" /> <Phone xsi:nil="true" /> <Fax xsi:nil="true" /> <Pager xsi:nil="true" /> <Email xsi:nil="true" /> </Contact> <Contact> <ContactType>LEGAL</ContactType> <ContactName xsi:nil="true" /> <Phone xsi:nil="true" /> <Fax xsi:nil="true" /> <Pager xsi:nil="true" /> <Email xsi:nil="true" /> </Contact> <Contact> <ContactType>CONTR</ContactType> <ContactName xsi:nil="true" /> <Phone xsi:nil="true" /> <Fax xsi:nil="true" /> <Pager xsi:nil="true" /> <Email xsi:nil="true" /> </Contact> <Contact> <ContactType>OPPTY</ContactType> <ContactName xsi:nil="true" /> <Phone xsi:nil="true" /> <Fax xsi:nil="true" /> <Pager xsi:nil="true" /> <Email xsi:nil="true" /> </Contact> </ContactList> <QuoteList> <Quote> <QoaRequestId>235847637</QoaRequestId> <OfferingId>5076</OfferingId> <QuoteSourceCode>DETAIL</QuoteSourceCode> <TaskTypeCode>OAEID</TaskTypeCode> <ServiceCategoryCode>CPE</ServiceCategoryCode> </Quote> </QuoteList> </CreateProjectTasksRequest> </env:Body> '
    aTags = ["Contact"]
    
    for sTag in aTags
      
      aXMLTagValue = get_multiple_xml_tag_values(sXML, sTag)
      #sXMLTagValue = get_multiple_xml_tag_values(sXML, sTag).to_s
      
      aXMLTagValue.each do | sXMLTagValue |
        puts2("Value of XML Tag '" + sTag + "' in XML = '" + sXMLTagValue + "'")
      end
    end
    
    puts2("-"*15)
    sXML = '<env:Body> <n1:CIESubmitForApprovalResponse xmlns:n1="http://www.qwest.com/CIE/xsd"> <n1:CIEId xsi:nil="true"></n1:CIEId> <n1:CIEStatus xsi:nil="true"></n1:CIEStatus> <n1:OpportunityId xsi:nil="true"></n1:OpportunityId> <n1:MsgResponseCd>2</n1:MsgResponseCd> <n1:MsgResponseDesc>CIE Request must include a direct rep and at least one partner (QC or QCC) rep</n1:MsgResponseDesc> <n1:MsgResponseDesc>Federal CIE Request must include Federal Account Manager Id</n1:MsgResponseDesc> </n1:CIESubmitForApprovalResponse> </env:Body>'
    aTags = ["n1:MsgResponseDesc"]
    
    for sTag in aTags
      aXMLTagValue = get_multiple_xml_tag_values(sXML, sTag)
      #sXMLTagValue = get_multiple_xml_tag_values(sXML, sTag).to_s
      aXMLTagValue.each do | sXMLTagValue |
        puts2("Value of XML Tag '" + sTag + "' in XML = '" + sXMLTagValue + "'")
      end
    end
    
  end # end test_xml_003_get_multiple_xml_tag_values()(...)
  
end # End of class - UnitTest_WebUtilities
