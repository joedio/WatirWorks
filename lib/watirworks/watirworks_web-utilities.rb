#=============================================================================#
# File: watirworks_web-utilities.rb
#
#  Copyright (c) 2008-2012, Joe DiMauro
#  All rights reserved.
#
# Description: Web application specific functions and methods for WatirWorks.
#
#    These functions and methods are application and platform independent, but
#    related to the Web and Web Browsers in general, or specific to a
#    particular browser (e.g. specific to IE or Firefox).
#    Extends some Ruby or Watir classes with additional, hopefully useful, methods.
#
#    Some of these methods and functions have been collected from, or based upon
#    Open Source versions found on various sites in the Internet, and are noted.
#
#--
# Modules:
#    WatirWorks_WebUtilities
#
# Extends Classes:
#    Fixnum
#    String
#
#    FireWatir::Firefox
#    FireWatir::SelectList
#    Watir::Element
#    Watir::IE
#
#    Watir::Browser   (For watir-webdriver)
#    Watir::Select   (For watir-webdriver)
#    Watir::Table   (For watir-webdriver)
#    Watir::TableRow   (For watir-webdriver)
#
#++
#=============================================================================#

#=============================================================================#
# Require and Include section
# Entries for additional files or methods needed by these methods
#=============================================================================#
require 'rubygems'

# WatirWorks
require 'watirworks'  # The WatirWorks library loader
include WatirWorks_Utilities  # The WatirWorks Utilities Library
include WatirWorks_RefLib  # The WatirWorks Reference Library

# Uncomment this command if running under Watir-WebDriver
# If using Watir or Firewatir comment it out.
#require 'watir-webdriver'

# Determine if executing under watir-webdriver or under Watir/FireWatir
if(is_webdriver? != true)
  require 'firewatir'
  if(RUBY_PLATFORM.downcase =~ /mswin|window|mingw/)
    require 'watir'
  end
end

#============================================================================#
# Module: WatirWorks_WebUtilities
#============================================================================#
#
# Description:
#      Web application specific functions and methods for WatirWorks.
#
#      These functions and methods are application and platform independent, but
#      related to the Web and Web Browsers in general, or  specific to a
#      particular browser (e.g.  specific to IE or Firefox).
#      Extends some Ruby or Watir classes with additional, hopefully useful, methods.
#
#      Some of these methods and functions have been collected from, or based upon
#      Open Source versions found on various sites in the Internet, and are noted.
#
# Instructions: To use these methods in your scripts add these commands:
#                        require 'watirworks'
#                        include WatirWorks_WebUtilities
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
#    brand()
#    clear_cache()
#    count_html_tags()
#    create_xml_tags(...)   # Deprecating - createXMLTags(...)
#    exit_browsers(...)
#    find_string_in_div(...)
#    find_string_in_span(...)
#    find_string_in_table(...)
#    find_strings_in_table(...)
#    generate_testcode_html_tag_attributes(...)
#    generate_testcode_html_tag_counts(...)
#    get_doc_app_version()
#    get_hwnd_js_dialog(...)   # NOT working with Watir1.6.5. See issue with click_no_wait()
#    get_multiple_xml_tag_values(...) # Deprecating - getMultipleXMLTagValues(...)
#    get_xml_tag_value(...)   # Deprecating -  getXMLTagValue
#    handle_js_dialog(...)   # NOT working with Watir1.6.5.  See issue with click_no_wait()
#    is_chrome?(...)
#    is_firefox?(...)
#    is_firefox_installed?(...)
#    is_ie?(...)
#    is_opera?()
#    is_safari?()
#    is_global_browser_running?()
#    is_tag_in_xml?(..)        # Deprecating - isTagInXML?(..)
#    is_text_in_div_class?(...)   # Deprecating - isTextIn_DivClass?(...)
#    is_text_in_div_id?(...)      # Deprecating - isTextIn_DivID?(...)
#    is_text_in_div_index?(...)   # Deprecating - isTextIn_DivIndex?(...)
#    is_text_in_div_xpath?(...)   # Deprecating - isTextIn_DivXpath?(...)
#    is_text_in_span_class?(...)  # Deprecating - isTextIn_SpanClass?(...)
#    is_text_in_span_id?(...)     # Deprecating - isTextIn_SpanID?(...)
#    is_text_in_span_index?(...)  # Deprecating - isTextIn_SpanIndex?(...)
#    is_text_in_span_xpath?(...)  # Deprecating - isTextIn_SpanXpath?(...)
#    is_text_in_table_class?(...) # Deprecating - isTextIn_TableClass?(...)
#    is_text_in_table_id?(...)    # Deprecating - isTextIn_TableID?(...)
#    is_text_in_table_index?(...) # Deprecating - isTextIn_TableIndex?(...)
#    is_text_in_table_name?(...)  # Deprecating - isTextIn_TableName?(...)
#    is_url_accessible?(...)
#    kill_browsers()
#    parse_table_by_row(...)
#    remove_xml_brackets(...)   # Deprecating - removeXMLBrackets(...)
#    restart_browser()
#    save_screencapture(...)
#    scroll_element_intoview(...)
#    save_html(...)
#    set_multiselect_list_by_name(...)
#    set_multiselect_list_by_id(...)
#    set_multiselect_list_by_index(...)
#    set_select_list_by_name(...)
#    set_select_list_by_id?(...)
#    set_select_list_by_index?(...)
#    show_html_tag_attributes(...)
#    start_browser(...)
#    version()
#    wait_until_status(...)
#
#
# Pre-requisites:
# ++
#=============================================================================#
module WatirWorks_WebUtilities
  
  # Version of this module
  WW_WEB_UTILITIES_VERSION = "1.1.1"
  
  # Flag indicating if a browser was started
  $bBrowserStarted = false
  
  #  Define the WatirWorks Global browser variable to suppress messages when $VERBOSE is true
  $browser = nil
  
  # The URL to open in a new browser
  #DEFAULT_URL = "about:blank"
  
  
  #=============================================================================#
  #--
  # Method: clear_cache()
  #
  #++
  #
  # Description:  Wrapper to select and run the proper cache/cookie cleaner for the Windows, Linux or OSx platform.
  #
  # Per Watir: The method "Watir::CookieManager::WatirHelper" has been deprecated, thus leaving no other means to do this from Watir.
  #
  #            By installing and using a 3rd party tool on each platform, the cache and cookies
  #            for IE, Firefox, and other Web browsers on the platform can be cleared.
  #
  # Usage Examples: To clear the cache and cookies on a windows system:
  #                    browser.close
  #                    clear_cache()
  #
  # Pre-requisites:
  #              The proper cache/cookie cleaner for each platform must be installed and configured.
  #
  #=============================================================================#
  def clear_cache()
    
    # Check if a browser is running. Cookies & cache can not be cleared if the browser is open.
    # How to do this w/o specifying a browser object, and is platform independent?
    # put stuff here
    
    if($bBrowserStarted == true)  # Browser exists
      
      puts2("")
      puts2("WARNING - Browser is open, cache and cookies may not be cleared", "WARN") # log a warning
      
    end # Browser exists
    
    # Use RUBY_PLATFORM to auto-select the proper version clear_xxx_cache() based on the operating system
    # Under Windows reports "mswin". under Linux it reports "linux", under Mac/OSX reports "dawrin"
    case RUBY_PLATFORM.downcase
      
      when (/mswin|window|mingw/)
      #include _watir_works__win_utilities
      clear_cache_win()
      
      when /linux/
      #include _watir_works__linux_utilities
      clear_cache_linux()
      
      when /darwin/
      #include _watir_works__mac_utilities
      clear_cache_mac()
      
    end # Only run on windows
    
  end # END - Method - clear_cache()
  
  #=============================================================================#
  #--
  # Method: count_html_tags()
  #++
  #
  # Description: Count the HTML elements with Watir length methods on the current Web page
  #
  #              Supported HTML Tag elements are:
  #                area, button, checkbox, dd, div, dl, dt, em, file_field, form,
  #                hidden, image, label, link, li, map, pre, p, radio, select_list,
  #                strong, span, table, text_field
  #
  #               FireWatir is missing a forms method, so it is set to -1 as a flag
  #               indicating that the forms element was NOT counted.
  #
  # Returns: HASH - Containing the name and count of each element
  #                   Key = STRING - The name of the HTML object counted
  #                                  For example: area, button, radio, etc.
  #                   Value = INTEGER - The number of the HTML elements counted
  #
  # Syntax: oElementToCount = OBJECT - One of the following object types:
  #                                    nil - Count all HTML elements types with Watir length methods
  #
  #                                    STRING - Any single HTML elements type with Watir length method,
  #                                             or "all" to count them all.
  #
  #                                    ARRAY of STRINGS -  A single or multiple HTML elements to count,
  #                                                        or
  #                                                        if oElementToCount[0] == "all" then count them all.
  #
  #
  # Usage Examples:
  #                 1) To Count ALL of the HTML elements with Watir length methods on the page:
  #                             browser = Watir::Browser.start("http://google.com")
  #                             hMyPageObjects = browser.count_html_tags()   #  Also works using: count_html_tags("all")
  #                             hMyPageObjects.sort.each do | key, value|
  #                                  puts2(" #{key} =  #{value.to_s}")
  #                             end
  #
  #                 2) To Count ONLY of the link HTML elements on the page:
  #                             browser = Watir::Browser.start("http://google.com")
  #                             hMyPageObjects = browser.count_html_tags("link")
  #                             hMyPageObjects.sort.each do | key, value|
  #                                  puts2(" #{key} =  #{value.to_s}")
  #                             end
  #
  #                 3) To Count ONLY the image and button HTML elements on the page:
  #                             aObjectsToCount = ["image", "button"]
  #                             browser = Watir::Browser.start("http://google.com")
  #                             hMyPageObjects = browser.count_html_tags(aObjectsToCount)
  #                             hMyPageObjects.sort.each do | key, value|
  #                                  puts2(" #{key} =  #{value.to_s}")
  #                             end
  #
  #=======================================================================#
  def count_html_tags(oElementToCount=nil)
    
    # Define the array of all currently supported HTML element types with Watir methods to count them
    aAllWatirElements = SUPPORTED_HTML_ELEMENTS
    
    # Remove the unsupported elements form the supported list
    if(is_safari? == true)
      SAFARIWATIR_UNSUPPORTED_HTML_ELEMENTS.each do |sUnsupportedElement |
        aAllWatirElements.delete(sUnsupportedElement)
      end
    end # Remove the unsupported elements form the supported list
    
    # Define default return value
    hObjectsFound = {}
    
    # Determine the object type
    case
      
      when oElementToCount.class.to_s == "String"
      
      # Populate array with the string of the single HTML element to count
      aElementsToCount = [oElementToCount]
      
      when oElementToCount.class.to_s == "Array"
      
      # Populate array with the array of the single or multiple HTML elements to count
      aElementsToCount = oElementToCount
      
      when oElementToCount.class.to_s == "NilClass"
      
      # Populate array with the array of the string "All" to count all HTML elements
      aElementsToCount = ["All"]
      
    else
      puts2(oElementToCount.class.to_s + " class objects are NOT supported. Please use a nil, String or Array of Strings.", "WARN")
      
      # Return the default value
      return  hObjectsFound
      
    end # Determine the object type
    
    if($VERBOSE == true)
      puts2("Counting HTML element types:")
      puts2(aElementsToCount)
    end
    
    
    if(aElementsToCount[0].downcase == "all")
      aElementsToCount = aAllWatirElements
    end
    
    # Loop through the elements to be counted
    aElementsToCount.each do | sElementToCount |
      
      # Select the proper count method to use
      case sElementToCount.to_s.downcase
        when  "area"
        iArea = self.areas.length
        hObjectsFound.store("area", iArea)
        when  "button"
        iButton = self.buttons.length
        hObjectsFound.store("button", iButton)
        when  "checkbox"
        iCheckbox = self.checkboxes.length
        hObjectsFound.store("checkbox", iCheckbox)
        when  "dd"
        iDd = self.dds.length
        hObjectsFound.store("dd", iDd)
        when  "div"
        iDiv = self.divs.length
        hObjectsFound.store("div", iDiv)
        when  "dl"
        iDl = self.dls.length
        hObjectsFound.store("dl", iDl)
        when  "dt"
        iDt = self.dts.length
        hObjectsFound.store("dt", iDt)
        when  "em"
        iEm = self.ems.length
        hObjectsFound.store("em", iEm)
        when  "file_field"
        iFile_field = self.file_fields.length
        hObjectsFound.store("file_field", iFile_field)
        when  "form"
        if(is_firefox?)
          iForm = -1  # FireWatir is missing a forms method, so it is set to -1 as a flag indicating that the forms element was NOT counted.
        else  # Watir supports forms so count them
          iForm = self.forms.length
        end
        hObjectsFound.store("form", iForm)
        when  "hidden"
        iHidden = self.hiddens.length
        hObjectsFound.store("hidden", iHidden)
        when  "image"
        iImage = self.images.length
        hObjectsFound.store("image", iImage)
        when  "label"
        iLabel = self.labels.length
        hObjectsFound.store("label", iLabel)
        when  "link"
        iLink = self.links.length
        hObjectsFound.store("link", iLink)
        when  "li"
        iLi = self.lis.length
        hObjectsFound.store("li", iLi)
        when  "map"
        iMap = self.maps.length
        hObjectsFound.store("map", iMap)
        when  "pre"
        iPre = self.pres.length
        hObjectsFound.store("pre", iPre)
        when  "p"
        iP = self.ps.length
        hObjectsFound.store("p", iP)
        when  "radio"
        iRadio = self.radios.length
        hObjectsFound.store("radio", iRadio)
        when  "select_list"
        iSelect_list = self.select_lists.length
        hObjectsFound.store("select_list", iSelect_list)
        when  "strong"
        iStrong = self.strongs.length
        hObjectsFound.store("strong", iStrong)
        when  "span"
        iSpan = self.spans.length
        hObjectsFound.store("span", iSpan)
        when  "table"
        iTable = self.tables.length
        hObjectsFound.store("table", iTable)
        when  "text_field"
        iText_field = self.text_fields.length
        hObjectsFound.store("text_field", iText_field)
      end
    end # Loop through the elements to be counted
    
    return  hObjectsFound
    
  end # END Method - count_html_tags()
  
  
  #=============================================================================#
  #--
  # Function: create_xml_tags(...)
  #++
  #
  # Description:  Adds the brackets to tag name to make Opening and Closing XML tags
  #               Returns '<tag_name>' and '</tag_name>'  from 'tag_name'
  #
  # Returns: ARRAY = The Opening and Closing XML tags
  #                 [0] = STRING - Opening Tag
  #                 [1] = STRING - Closing Tag
  #
  # Syntax: sTag =  STRING - The XML tags to strip of the enclosing brackets "<>"
  #
  # Usage Examples:
  #                    sTag = 'UserName'     # Tag name w/o brackets
  #                    addXMLBrackets(sTag)  #=>  UserName
  #
  #                    sTag = '<Username>'   # Opening tag with Brackets
  #                    addXMLBrackets(sTag)  #=>  UserName
  #
  #                    sTag = '</UserName>'  # Closing tag with Brackets
  #                    create_xml_tags(sTag)  #=>  UserName
  #
  #=============================================================================#
  def create_xml_tags(sTagName)
    
    #$VERBOSE = true
    
    if($VERBOSE == true)
      puts2("Parameters - create_xml_tags:")
      puts2("  sTagName: " + sTagName)
    end
    
    # Add the brackets to make the Opening tag
    sFullOpeningTag = "<" + sTagName + ">"
    
    # Add the brackets and slash to make the Closing tag
    sFullClosingTag = "</" + sTagName + ">"
    
    if ($VERBOSE == true)
      puts2("Opening tag:  " + sFullOpeningTag)
      puts2("Closing tag:  " + sFullClosingTag)
    end
    
    sXMLTags = [sFullOpeningTag, sFullClosingTag]
    
    return sXMLTags
    
  end # END method - create_xml_tags()
  
  alias createXMLTags create_xml_tags
  
  
  #=============================================================================#
  #--
  # Method: exit_browsers()
  #++
  #
  # Description: Close an Internet Explorer, Firefox, Safari, Chrome, or Opera browser
  #
  # Returns: N/A
  #
  # Syntax:
  #         oBrowsersToClose = OBJECT - One of the following object types:
  #                                    nil - Close all browsers (ie, ff, opera, chrome, safari)
  #
  #                                    STRING - Any single Browser type (ie, ff, opera, chrome, safari) to close,
  #                                                i.e "ff" to only close the Firefox browsers
  #                                              Or "all" to close all the Browsers (ie, ff, opera, chrome, safari)
  #
  #                                    ARRAY of STRINGS - A single or a set of multiple Browsers
  #                                                           i.e ["firefox"] or ["ie", "chrome"]
  #                                                         Or if ["all"] for all the browsers
  #
  #
  # Usage examples: Close IE and Firefox, but leave Safari, Chrome and Opera open
  #                    browser.exit_browsers(["ie", "ff"])
  #
  #=============================================================================#
  def exit_browsers(oBrowsersToClose=nil)
    
    # NOTE: RAutomation currently only runs on Windows
    if(is_win?() == true)
      
      require 'rautomation'
      
      # Define set of browsers supported by this function
      aAllBrowserTypes = ["ie", "ff", "chrome", "opera", "safair"]
      
      # Determine the object type
      case
        
        when oBrowsersToClose.class.to_s == "String"
        
        # Populate array with the string of the single browser type to close
        aBrowsersToClose = [oBrowsersToClose]
        
        when oBrowsersToClose.class.to_s == "Array"
        
        # Populate array with the array of the single or multiple browser types to close
        aBrowsersToClose = oBrowsersToClose
        
        when oBrowsersToClose.class.to_s == "NilClass"
        
        # Populate array with the array of the string "All" to close all browser types
        aBrowsersToClose = ["all"]
        
      else
        puts2(oBrowsersToClose.class.to_s + " class objects are NOT supported. Please use a nil, String, or Array of Strings.", "WARN")
        
        # Return the default value
        return  false
        
      end # Determine the object type
      
      if(aBrowsersToClose[0].downcase.strip == "all")
        aBrowsersToClose = aAllBrowserTypes
      end
      
      # Loop through the array
      aBrowsersToClose.each do | sBrowserType|
        
        # Select the proper close method to use
        case sBrowserType.to_s.downcase.strip
          when  ("ie" or "internet explorer")
          sClass = "IEFrame"
          # Create an rAutomation object
          oWindow = RAutomation::Window.new(:class => sClass)
          until oWindow.exists? == false
            oWindow.close()
            puts2("Closed an IE browser")
            sleep(0.1)
          end
          
          when  ("ff" or "firefox")
          sClass = "MozillaUIWindowClass"
          # Create an rAutomation object
          oWindow = RAutomation::Window.new(:class => sClass)
          until oWindow.exists? == false
            oWindow.close()
            puts2("Closed a Firefox browser")
            sleep(0.1)
          end
          
          when  "opera"
          sClass = "OperaWindowClass" # AutoIt identified as "[CLASS:OperaWindowClass]"
          # Create an rAutomation object
          oWindow = RAutomation::Window.new(:class => sClass)
          until oWindow.exists? == false
            oWindow.close()
            puts2("Closed an Opera browser")
            sleep(0.1)
          end
          
          when  ("chrome" or "google chrome")
          sClass = "Chrome_WidgetWin_0"
          oWindow = RAutomation::Window.new(:class => sClass)
          until oWindow.exists? == false
            oWindow.close()
            puts2("Closed a Chrome browser")
            sleep(0.1)
          end
          
          when  "safari"
          sClass = "{1C03B488-D53B-4a81-97F8-754559640193}"
          # Create an rAutomation object
          oWindow = RAutomation::Window.new(:class => sClass)
          until oWindow.exists? == false
            oWindow.close()
            puts2("Closed a Safari browser")
            sleep(0.1)
          end
          
        end # Select the proper close method to use
      end # Loop through the array
      
    else
      self.close()
      
    end # NOTE: RAutomation currently only runs on Windows
    
    return true
    
  end # End Function - exit_browsers
  
  #=============================================================================#
  #--
  # Method find_string_in_div(...)
  #
  #++
  #
  # Description: Searches through the HTML <div> tags, starting with the highest
  #              indexed tag, looking for a match on the specified string.
  #              It starts at the highest indexed tag to account for nested tags.
  #              Thus the first match will be within the deepest nested tag.
  #
  # Syntax: sSearch_Value = STRING - The case sensitive string to locate
  #         bIgnoreCase = BOOLEAN - true = ignore case, false = case sensitive
  #
  # Returns:  ARRAY - Array[0] = INTEGER - Index of the tag containing the matching text
  #                   Array[1] = STRING - Complete text found within the tag
  #
  # Usage examples:
  #                   To find the div that contains the text "Expiration Date"
  #                      aDivWithString = browser.find_string_in_div("Expiration Date")
  #                      iDivIndex =  aDivWithString[0].to_i
  #                      sText =  aDivWithString[1].to_s
  #
  #=============================================================================#
  def find_string_in_div(sSearch_Value, bIgnoreCase = false)
    
    if($VERBOSE == true)
      puts2("Parameters - find_string_in_div:")
      puts2("  sSearch_Value: " + sSearch_Value)
      puts2("  bIgnoreCase: " + bIgnoreCase.to_s)
    end
    
    # Set default return values
    iDivIndex = -1
    sDivTextFound = ""
    
    # Strip off leading/trailing white spaces
    sSearch_String = sSearch_Value.to_s.strip
    
    # Case sensitive or ignore case ?
    if(bIgnoreCase == true)
      sSearch_String = sSearch_String.upcase
    end
    
    if($VERBOSE == true)
      puts2("  Searching for \"#{sSearch_String}\"")
    end
    
    # Determine the total number of divs on the page
    iNumberOfObjects = self.divs.length
    
    # Determine if there are divs on the page
    if(iNumberOfObjects < 1)
      
      # If there are no divs on the page return the default values
      return [iDivIndex, sDivTextFound]
      
    else  # There are divs on the page so set the counter
      
      iCurrentIndex = iNumberOfObjects
      
      # Adjust index for Watir-Webdriver's 1-based indexing vs. Watir's 0-based indexing
      #if(is_webdriver? == true)
      #  iCurrentIndex = iNumberOfObjects - 1
      #else
      #  iCurrentIndex = iNumberOfObjects
      #end
      
    end # Determine if there are divs on the page
    
    
    # BEGIN - Loop through the divs starting with the highest indexed div
    while iCurrentIndex > 0 do
      
      if(bIgnoreCase == true)
        sTextFound.upcase =  self.div(:index, iCurrentIndex.adjust_index).text
      else
        sTextFound =  self.div(:index, iCurrentIndex.adjust_index).text
      end
      
      # Determine if there is a match
      if(sTextFound =~ /#{sSearch_String}/)
        
        iDivIndex = iCurrentIndex
        sDivTextFound = sTextFound
        iCurrentIndex = -1 # Break out of the loop
        
      end
      
      # Check the next lower indexed div
      iCurrentIndex = iCurrentIndex -1
      
    end
    
  rescue => e
    
    puts2("*** WARNING - Searching for String \"#{sSearch_String}\" ", "WARN")
    puts2("*** WARNING and Backtrace: " + e.message + "\n" + e.backtrace.join("\n"),"WARN")
    
  ensure
    
    return [iDivIndex, sDivTextFound]
    
  end # find_string_in_div(...)
  
  
  #=============================================================================#
  #--
  # Method find_string_in_span(...)
  #
  #++
  #
  # Description: Searches through the HTML <span> tags, starting with the highest
  #              indexed tag, looking for a match on the specified string.
  #              It starts at the highest indexed tag to account for nested tags.
  #              Thus the first match will be within the deepest nested tag.
  #
  # Syntax: sSearch_Value = STRING - The case sensitive string to locate
  #         bIgnoreCase = BOOLEAN - true = ignore case, false = case sensitive
  #
  # Returns:  ARRAY -  Array[0] = INTEGER - Index of the tag containing the matching text
  #                    Array[1] = STRING - Complete text found within the tag
  #
  # Usage examples: To find the span that contains the text "Expiration Date"
  #                      aSpanWithString = browser.find_string_in_span("Expiration Date")
  #                      iSpanIndex =  aSpanWithString[0].to_i
  #                      sText =  aSpanWithString[1].to_s
  #
  #=============================================================================#
  def find_string_in_span(sSearch_Value, bIgnoreCase = false)
    
    if($VERBOSE == true)
      puts2("Parameters - find_string_in_span:")
      puts2("  sSearch_Value: " + sSearch_Value)
      puts2("  bIgnoreCase: " + bIgnoreCase.to_s)
    end
    
    # Set default return values
    iSpanIndex = -1
    sSpanTextFound = ""
    
    # Strip off leading/trailing white spaces
    sSearch_String = sSearch_Value.to_s.strip
    
    # Case sensitive or ignore case ?
    if(bIgnoreCase == true)
      sSearch_String = sSearch_String.upcase
    end
    
    if($VERBOSE == true)
      puts2("  Searching for \"#{sSearch_String}\"")
    end
    
    # Determine the total number of spans on the page
    iNumberOfObjects = self.spans.length
    
    # Determine if there are divs on the page
    if(iNumberOfObjects < 1)
      
      # If there are no spans on the page return the default values
      return [iSpanIndex, sSpanTextFound]
      
    else  # There are spans on the page so set the counter
      
      iCurrentIndex = iNumberOfObjects
      
      # Adjust index for Watir-Webdriver's 1-based indexing vs. Watir's 0-based indexing
      #if(is_webdriver? == true)
      #  iCurrentIndex = iNumberOfObjects - 1
      #else
      #  iCurrentIndex = iNumberOfObjects
      #end
      
    end # Determine if there are spans on the page
    
    
    # BEGIN - Loop through the spans starting with the highest indexed span
    while iCurrentIndex > 0 do
      
      if(bIgnoreCase == true)
        sTextFound.upcase =  self.span(:index, iCurrentIndex.adjust_index).text
      else
        sTextFound =  self.span(:index, iCurrentIndex.adjust_index).text
      end
      
      # Determine if there is a match
      if(sTextFound =~ /#{sSearch_String}/)
        
        iSpanIndex = iCurrentIndex
        sSpanTextFound = sTextFound
        iCurrentIndex = -1 # Break out of the loop
        
      end
      
      # Check the next lower indexed span
      iCurrentIndex = iCurrentIndex -1
      
    end
    
  rescue => e
    
    puts2("*** WARNING - Searching for String \"#{sSearch_String}\" ", "WARN")
    puts2("*** WARNING and Backtrace: " + e.message + "\n" + e.backtrace.join("\n"),"WARN")
    
  ensure
    
    return [iSpanIndex, sSpanTextFound]
    
  end # find_string_in_span(...)
  
  
  #=============================================================================#
  #--
  # Method find_string_in_table(...)
  #
  #++
  #
  # Description: Searches through the HTML <table> tags, starting with the highest
  #              indexed tag, looking for a match on the specified string.
  #              It starts at the highest indexed tag to account for nested tags.
  #              It does however search each table from the first row to the last row.
  #              The first match will be within the deepest nested tag.
  #
  # NOTE: Issues with nested tables: See Watir bug: http://jira.openqa.org/browse/WTR-26
  #
  # Syntax: sSearch_Value = STRING - The case sensitive string to locate
  #         bIgnoreCase = BOOLEAN - true = ignore case, false = case sensitive
  #
  # Returns: ARRAY - Array[0] = INTEGER - table index
  #                  Array[1] = INTEGER - row index
  #                  Array[2] = ARRAY - STRINGs of the matching text in each cell
  #
  # Usage examples: To find the table & row that contain the text "Expiration Date"
  #                      aTableWithString = browser.find_string_in_table("Expiration Date")
  #                      iTableContainingString =  aTableWithString[0].to_i
  #                      iRowContainingString =  aTableWithString[1].to_i
  #                      sTextInRow =  aTableWithString[2].to_s
  #
  #=============================================================================#
  def find_string_in_table(sSearch_Value, bIgnoreCase = false)
    
    if($VERBOSE == true)
      puts2("Parameters - find_string_in_table:")
      puts2("  sSearch_Value: " + sSearch_Value)
      puts2("  bIgnoreCase: " + bIgnoreCase.to_s)
    end
    
    iTotalTables = self.tables.length
    iFoundTextInRow = 0
    iFoundTextInTable = 0
    
    if(is_webdriver? == true)
      puts2("Watir method Watir::Table.row_values not supported by Watir WebDriver")
      return []
    end
    
=begin  watir-webdriver - missing method - options
    # Determine which type of browser is set as the current default
    sBrowserType = Watir.options[:browser]
=end
    sBrowserType = "firefox"
    
    # Strip off leading/trailing white spaces
    sSearch_String = sSearch_Value.to_s.strip
    
    # Case sensitive or ignore case ?
    if(bIgnoreCase == true)
      sSearch_String = sSearch_String.upcase
    end
    
    if($VERBOSE == true)
      puts2("  Searching for \"#{sSearch_String}\"")
    end
    
    iTableIndex = iTotalTables
    
    # Adjust index for Watir-Webdriver's 1-based indexing vs. Watir's 0-based indexing
    #if(is_webdriver? == true)
    #  iTableIndex = iTableIndex - 1
    #end
    
    # BEGIN - Loop through the tables
    while(iTableIndex > 0)
      
      if((sBrowserType.downcase) == "ie")
        # Find the total rows in the current table
        iTotalRows = self.table(:index, iTableIndex.adjust_index).row_count_excluding_nested_tables.to_i
        
      elsif((sBrowserType.downcase) == "firefox")
        # Find the total rows in the current table
        iTotalRows = self.table(:index, iTableIndex.adjust_index).row_count.to_i
      end
      
      
      if($VERBOSE == true)
        puts2("   Table #{iTableIndex.to_s} contains #{iTotalRows.to_s} rows")
      end
      
      # Start the row counter at the 1st row for each table (index 0)
      iRowIndex = 1
      
      # Only continue if the table has a row object
      if(iTotalRows > 0)
        
        # BEGIN - Loop through the rows
        while(iRowIndex <= iTotalRows)
          
          if($VERBOSE == true)
            puts2("    Searching table #{iTableIndex.to_s}, row #{iRowIndex.to_s}")
          end
          
          # Collect text if there are no buttons in the row (Watir issue with collecting text from tables with buttons)
          #          if(self.table(:index, iTableIndex.adjust_index).buttons.length == 0)
          
          # Collect the text in the current row
          # Note that the Watir method row_values fails if there are either Buttons or no columns in the row
          aRowText = (self.table(:index, iTableIndex.adjust_index).row_values(iRowIndex))
          
          if($VERBOSE == true)
            puts2(aRowText.to_s)
          end
          
          #          else # There was a button in the row
          #            puts2("*** WARNING - Button found - Skipping table #{iTableIndex.to_s}, row #{iRowIndex.to_s}", "WARN")
          #          end # Collect text if there are no buttons in the row
          
          ########################
          # BEGIN - Loop on Array of text found
          ########################
          aRowText.each do | sRowText |
            
            # Case sensitive or ignore case ?
            if(bIgnoreCase == true)
              sRowText = sRowText.upcase
            end
            
            if($VERBOSE == true)
              puts2("   Comparing expected: \"#{sSearch_String.strip}\" to actual \"#{sRowText.to_s.strip}\" ")
            end
            
            # Was the text found?
            #if(sRowText =~ /#{sSearch_String}/)
            if((sRowText.to_s.strip !="") && (sRowText.to_s.strip =~ /#{sSearch_String.strip}/))
              
              iFoundTextInTable =  iTableIndex
              iFoundTextInRow =  iRowIndex
              
              if($VERBOSE == true)
                puts2("   Found String: \"#{sSearch_String}\" in table #{iFoundTextInTable.to_s}, row #{iFoundTextInRow.to_s}")
              end
              
              # Break out of the while loops
              iRowIndex = (iTotalRows +1)
              iTableIndex = 0
              
              if($VERBOSE == true)
                puts2("   iRowIndex: #{iRowIndex.to_s}, iTableIndex: #{iTableIndex.to_s}")
              end
              
            end # Was the text found?
            # END - Was the text found?
            
          end # END - Loop on Array of text found
          ########################
          # END - Loop on Array of text found
          ########################
          
          iRowIndex = iRowIndex + 1
          if($VERBOSE == true)
            puts2("    Next row could be #{iRowIndex.to_s}")
          end
          
        end # END - Loop through the rows
        # END - Loop through the rows
        
      end # Only continue if the table has a row object
      # Only continue if the table has a row object
      
      iTableIndex = (iTableIndex - 1)
      if($VERBOSE == true)
        puts2("   Next table could be #{iTableIndex.to_s}")
      end
      
    end # END - Loop through the tables
    # END - Loop through the tables
    
  rescue => e
    
    puts2("*** WARNING - Searching for String \"#{sSearch_String}\" ", "WARN")
    puts2("*** WARNING and Backtrace: " + e.message + "\n" + e.backtrace.join("\n"),"WARN")
    
  ensure
    
    return iFoundTextInTable, iFoundTextInRow,  aRowText.to_s.strip
    
  end # find_string_in_table(...)
  
  
  #=============================================================================#
  #--
  # Method: find_strings_in_table()
  #
  #
  #++
  #
  # Description: Searches the web page for multiple occurrences of strings in the array within a single row of a HTML table.
  #
  #              Search can be for one or more occurrence of a single string within the text contained in a table's row
  #              or search for multiple strings all occurring within the text contained in a table's row.
  #
  #              Match can be an exact match, where the set of stings exactly matches the row's contents,
  #              or it can be a relative match where the row's text may contain additional text, along with
  #              the specified strings.
  #
  #              Searches through the tables row-by-row, starting with the highest
  #              indexed table, and work its way to the lowest indexed table; counting
  #              the matches on the strings in the specified array.  Once a  row of text is found
  #              who's match count is equal to or exceeds the specified Minimum match count, its
  #              returns, the table index, row index, number of matches and matching text
  #              If a String in the  array matches two or more strings in the row
  #              both matches will be counted.
  #
  #              Tables are searched from the first row to the last row,
  #              but the search starts at the highest indexed table to account for nested tables.
  #              The first match will be within the deepest nested table.
  #
  # Note: Issues with nested tables: See Watir bug WTR-26   http://jira.openqa.org/browse/WTR-26
  #
  # Returns: ARRAY - Four element array, aMatch[]
  #                      aMatch[0] = Fixnum index of table with matching string
  #                      aMatch[1] = Fixnum index of row in table with matching string
  #                      aMatch[2] = Fixnum count of the string matches found
  #                      aMatch[3] = Array of each of the strings that matched
  #
  #
  # Syntax: iMinMatches = FIXNUM - The Minimum number of String matches required for a valid match.
  #                                Thus if your array contains 5 string elements, and 4 of them must match
  #                                set this value to 4. If 0 is specified then then Minimum number
  #                                of matches will be the number of elements in the specified array.
  #
  #           aArrayOfStringsToMatch = ARRAY -  of strings to compare against text found in table's row
  #           bIgnoreCase =  BOOLEAN - true = Ignore case, false = Case sensitive
  #           bExactMatch  = BOOLEAN -  true = Row contents are an exact match for string (Compare as strings)
  #                                                            false = Row contains the string. (Compare as Regular Expression) (Default)
  #
  # Usage Examples:
  #
  #                To perform a case sensitive search of the tables & rows to find one
  #                that contain both the strings "Expiration Date" and "Expired"
  #
  #                      aStringsToMatch = ["Expiration Date", "Expired"]
  #                      aMatchingData = browser.find_strings_in_table(aStringsToMatch)
  #
  #                To perform a case insensitive search of the tables & rows to find one
  #                that contain at least 2 matches of any of the three strings "Expiration Date", "Expired", and "TX"
  #
  #                      aStringsToMatch = ["Expiration Date", "Expired", "TX"]
  #                      aMatchingData = browser.find_strings_in_table(aStringsToMatch, 2, true)
  #
  #                In either case:
  #                      iTableContainingString =  aMatchingData[0].to_i
  #                      iRowContainingString =  aMatchingData[1].to_i
  #                      iNumberOfMatchesFound =  aMatchingData[2].to_i
  #                      aMatchingStrings =  aMatchingData[3]
  #                      sMatchingString_1 =  aMatchingStrings[0].to_s
  #                      sMatchingString_2=  aMatchingStrings[1].to_s
  #=============================================================================#
  def find_strings_in_table(aArrayOfStringsToMatch = nil, iMinMatches = 0 , bIgnoreCase = false, bExactMatch = false)
    
    if($VERBOSE == true)
      puts2("Parameters - find_strings_in_table:")
      puts2("  aArrayOfStringsToMatch: ")
      puts2(     aArrayOfStringsToMatch)
      puts2("  iMinMatches: " + iMinMatches.to_s)
      puts2("  bIgnoreCase: " + bIgnoreCase.to_s)
      puts2("  bExactMatch: " + bExactMatch.to_s)
    end
    
    if(is_webdriver? == true)
      puts2("Watir method Watir::Table.row_values not supported by Watir WebDriver")
      return []
    end
    
=begin  watir-webdriver - missing method - options
    # Determine which type of browser is set as the current default
    sBrowserType = Watir.options[:browser]
=end
    sBrowserType = "firefox"
    
    # Clear the table counter
    iTableIndex = 0
    
    # Clear the row counter
    iRowIndex = 0
    
    # Clear the match counter
    iMatchesFound = 0
    
    # Clear the matching text
    aMatchingText = []
    
    # Determine the number of elements in the array
    iNumberOfElementsInArray = aArrayOfStringsToMatch.length
    
    # Disallow negative numbers for the  Minimum number of matches
    if(iMinMatches < 0)
      iMinMatches = 0
    end
    
    # Set the Minimum number of matches to equal the number of elements in the array
    if(iMinMatches == 0)
      iMinMatches = iNumberOfElementsInArray
    end
    
    iTotalTables = self.tables.length
    iFoundMatchInRow = 0
    iFoundMatchInTable = 0
    
    if($VERBOSE == true)
      puts2("  Searching for minimum of #{iMinMatches} matches of strings:")
      aArrayOfStringsToMatch.each do  | sString| puts2(sString.strip) end
    end
    
    iTableIndex = iTotalTables
    
    # Adjust index for Watir-Webdriver's 1-based indexing vs. Watir's 0-based indexing
    #if(is_webdriver? == true)
    #  iTableIndex = iTableIndex - 1
    #end
    
    # BEGIN - Loop through the tables
    while(iTableIndex.adjust_index > 0)
      #while(iTableIndex >= 0)
      
      if((sBrowserType.downcase) == "ie")
        # Find the total rows in the current table
        iTotalRows = self.table(:index, iTableIndex.adjust_index).row_count_excluding_nested_tables.to_i
      elsif((sBrowserType.downcase) == "firefox")
        # Find the total rows in the current table
        iTotalRows = self.table(:index, iTableIndex.adjust_index).row_count.to_i
      end
      
      if($VERBOSE == true)
        puts2("   Table #{iTableIndex.to_s} contains #{iTotalRows.to_s} rows")
      end
      
      # Start the row counter at the 1st row for each table (index 0)
      iRowIndex = 1
      
      # Only continue if the table has a row object
      if(iTotalRows != 0)
        
        # BEGIN - Loop through the rows
        while(iRowIndex <= iTotalRows)
          
          if($VERBOSE == true)
            puts2("    Searching table #{iTableIndex.to_s}, row #{iRowIndex.to_s}")
          end
          
          # Collect text if there are no buttons in the row (Watir issue with collecting text from tables with buttons)
          #          if(self.table(:index, iTableIndex.adjust_index).buttons.length == 0)
          #if(self.table(:index, iTableIndex).row(:index, iRowIndex).exists?)
          
          # Populate an array with the text in the current row
          aRowText = (self.table(:index, iTableIndex.adjust_index).row_values(iRowIndex))
          
          if($VERBOSE == true)
            puts2("Row Text: ")
            aRowText.each do | sString |
              puts2(sString.to_s)
            end
            
          end
          
          #          else # There was a button in the row
          #            puts2("*** WARNING - Button found - Skipping table #{iTableIndex.to_s}, row #{iRowIndex.to_s}", "WARN")
          #          end # Collect text if there are no buttons in the row
          
          # Check the strings in the current row for matches
          aPossibleMatch = compare_strings_in_arrays(aArrayOfStringsToMatch, aRowText, bIgnoreCase, bExactMatch)
          
          if($VERBOSE == true)
            puts2("Possible match:")
            puts2(aPossibleMatch)
          end
          
          iNumberOfMatches = aPossibleMatch[0].to_i
          
          if(iNumberOfMatches >= iMinMatches)
            
            iFoundMatchInTable =  iTableIndex
            iFoundMatchInRow =  iRowIndex
            iMatchesFound = iNumberOfMatches
            aMatchingText = aPossibleMatch[1]
            
            if($VERBOSE == true)
              puts2("   Found #{iMinMatches} matches of strings in table #{iFoundMatchInTable.to_s}, row #{iFoundMatchInRow.to_s}")
              aMatchingText.each do  | sString| puts2(sString) end
            end
            
            # Break out of the while loops
            iRowIndex = (iTotalRows +1)
            iTableIndex = 0
            if($VERBOSE == true)
              puts2("   iRowIndex: #{iRowIndex.to_s}, iTableIndex: #{iTableIndex.to_s}")
            end
            
          end # Was the text found?
          # END - Was the text found?
          
          iRowIndex = iRowIndex + 1
          if($VERBOSE == true)
            puts2("    Next row could be #{iRowIndex.to_s}")
          end
          
        end # END - Loop through the rows
        # END - Loop through the rows
        
      end # Only continue if the table has a row object
      # Only continue if the table has a row object
      
      iTableIndex = (iTableIndex - 1)
      if($VERBOSE == true)
        puts2("   Next table could be #{iTableIndex.to_s}")
      end
      
    end # END - Loop through the tables
    # END - Loop through the tables
    
  rescue => e
    
    puts2("*** WARNING - Searching for Matching Strings", "WARN")
    puts2("*** WARNING and Backtrace: " + e.message + "\n" + e.backtrace.join("\n"),"WARN")
    
  ensure
    
    return iFoundMatchInTable, iFoundMatchInRow, iMatchesFound, aMatchingText
    
  end # END Method - find_strings_in_table(...)
  
  
  #=============================================================================#
  #--
  # Method: generate_testcode_html_tag_attributes(...)
  #
  #++
  #
  # Description: Generates assert statements for the attributes of the HTML Tag Elements on the current Web page
  #              The assert statements are displayed to STDOUT and into the global log file (if it exists).
  #              The code can be manually copied and entered into a test case for use as the basis of a regression test.
  #
  #              Example partial output:
  #
  #                  #-------------------------#
  #                  # Attributes of image 1
  #                  #-------------------------#
  #                  assert($browser.image(:index, 1).alt == "Search Google" )
  #                  assert($browser.image(:index, 1).enabled? == "" )
  #                  assert($browser.image(:index, 1).file_size == "4325" )
  #                  assert($browser.image(:index, 1).loaded? == "SyntaxError: syntax error" )
  #                  assert($browser.image(:index, 1).height == "32" )
  #                  assert($browser.image(:index, 1).id == "" )
  #                  assert($browser.image(:index, 1).name == "" )
  #                  assert($browser.image(:index, 1).src == "logo_25wht.gif" )
  #                  assert($browser.image(:index, 1).title == "Search Google" )
  #                  assert($browser.image(:index, 1).type == "" )
  #                  assert($browser.image(:index, 1).value == "" )
  #
  #              Supported HTML Tag Elements are:
  #                area, button, checkbox, dd, div, dl, dt, em, file_field,
  #                hidden, image, label, link, li, map, pre, p, radio,
  #                select_list, strong, span, table, text_field
  #
  #               The forms and form methods are NOT supported.
  #
  #
  # HINT: Run this once against a web page to generate code to subsequently use for testing the web page.
  #
  #       You may NOT need to count all the HTML tags, but only those necessary for use in a regression test
  #       to provide a reasonable sense that the important the HTML tags on the page are unchanged.
  #       Determine what will work for your situation and set the passed parameters accordingly.
  #
  #       Manually Cut 'n Paste the output to a test case for use to subsequently test that web page.
  #
  #       For pages with dynamic content, you may need to edit the generated assert statements.
  #       For example, on a web page which always has at least 20 links, but that can grow to a larger number
  #       the output from this method may generates the code:
  #             assert(browser.links.length == 100) # Number of links
  #
  #       You can modify it in your test case to be:
  #             assert(browser.links.length >= 20) # Number of links
  #
  # Returns: BOOLEAN - true on success, otherwise false
  #
  # Syntax: oElementsToCheck = OBJECT - One of the following object types:
  #
  #                                    nil - All HTML Element attributes
  #
  #                                    STRING - Name of any single HTML Element attribute
  #                                                 i.e. "link"
  #                                               Or "all" for them all.
  #
  #                                    ARRAY of STRINGS - A single or a set of multiple HTML Tag Elements
  #                                                           i.e ["link"] or ["button", "checkbox"]
  #                                                         Or if ["all"] for all the Element's.
  #
  #              sBrowserName = STRING - The name to use in the print statement
  #
  #
  # Examples: To generate testcode for all the HTML Tag Elements on the page in the current web browser:
  #                 myBrowser.generate_testcode_html_tag_attributes("all", "myBrowser")
  #
  #           To generate testcode for only the LINK objects on the page in the current web browser :
  #                 browser.generate_testcode_html_tag_attributes("link", "browser")
  #
  #           To generate testcode for only IMAGE  and LINK objects on the page in the current web browser:
  #                 $browser.generate_testcode_html_tag_attributes(["image", "link"])
  #
  #=============================================================================#
  def generate_testcode_html_tag_attributes(oElementsToCheck="all", sBrowserName="$browser")
    
    if($VERBOSE == true)
      puts2("Parameters - generate_testcode_html_tag_attributes:")
      puts2("  oElementsToCheck: ")
      puts2(     oElementsToCheck.to_s)
    end
    
    # Define the elements to check
    aSupportedHTMLElementNames = SUPPORTED_HTML_ELEMENTS
    
    # Remove the unsupported elements form the supported list
    if(is_safari? == true)
      SAFARIWATIR_UNSUPPORTED_HTML_ELEMENTS.each do |sUnsupportedElement |
        aSupportedHTMLElementNames.delete(sUnsupportedElement)
      end
    end # Remove the unsupported elements form the supported list
    
    # Define the element attributes to collect
    aAttributes = []
    
    # Define arrays for each tag and the attributes that apply to each
    #
    # Those attributes that are not listed for a particular element were either tried and
    #  did NOT appear to be useful (e.g. exists?) or are not supported by that element. in Watir1.6.5/Firewatir1.6.5
    aAttribs_area = ["type", "id", "name", "title", "value", "alt", "href", "text","enabled?", "visible?"]
    aAttribs_button = ["type", "id", "name", "title", "value", "src", "enabled?", "visible?"]
    aAttribs_checkbox = ["type", "id", "name", "title", "value", "enabled?", "visible?", "set?"]
    aAttribs_dd = ["type", "id", "name", "title", "value", "enabled?", "visible?"]
    aAttribs_div = ["id", "name", "title", "value", "class_name", "enabled?", "visible?"]
    aAttribs_dl = ["type", "id", "name", "title", "value", "enabled?", "visible?"]
    aAttribs_dt = ["type", "id", "name", "title", "value", "enabled?", "visible?"]
    aAttribs_em = ["type", "id", "name", "title", "value", "enabled?", "visible?"]
    aAttribs_file_field = ["type", "id", "name", "title", "value", "enabled?", "visible?"]
    aAttribs_form = ["class", "id", "name", "action", "method", "visible?"]
    aAttribs_hidden = ["type", "id", "name", "title", "value", "enabled?", "visible?"]
    aAttribs_image = ["type", "id", "name", "title", "value", "src", "height", "width", "file_size", "file_created_date", "alt", "enabled?", "visible?", "loaded?"]
    aAttribs_label = ["type", "id", "name", "title", "value", "text", "enabled?", "visible?"]
    aAttribs_link = ["type", "id", "name", "title", "value", "href", "text", "src","enabled?", "visible?"]
    aAttribs_li = ["type", "id", "name", "title", "value", "enabled?", "visible?"]
    aAttribs_map = ["type", "id", "name", "title", "value", "enabled?", "visible?"]
    aAttribs_pre = ["type", "id", "name", "title", "value", "enabled?", "visible?"]
    aAttribs_p = ["type", "id", "name", "title", "value", "enabled?", "visible?"]
    aAttribs_radio = ["type", "id", "name", "title", "value", "enabled?", "visible?", "set?"]
    aAttribs_select_list = ["type", "id", "name", "title", "value", "selected_options", "options", "text", "enabled?", "visible?"]
    
    
    aAttribs_span = ["type", "id", "name", "title", "value", "class_name", "enabled?", "visible?"]
    aAttribs_strong = ["type", "id", "name", "title", "value", "enabled?", "visible?"]
    aAttribs_table = ["type", "id", "name", "title", "value", "row_count_excluding_nested_tables", "enabled?", "visible?"]
    aAttribs_text_field = ["type", "id", "name", "title", "value", "text", "size", "maxLength", "enabled?", "visible?"]
    
    # Determine the object type
    case
      
      when oElementsToCheck.class.to_s == "String"
      
      # Populate array with the string of the single HTML element to count
      aElements = [oElementsToCheck]
      
      when oElementsToCheck.class.to_s == "Array"
      
      # Populate array with the array of the single or multiple HTML elements to count
      aElements = oElementsToCheck
      
      when oElementsToCheck.class.to_s == "NilClass"
      
      # Populate array with the array of the string "All" to count all HTML elements
      aElements = aSupportedHTMLElementNames
      
    else
      puts2(oElementsToCheck.class.to_s + " class objects are NOT supported. Please use a nil, String or Array of Strings.", "WARN")
      return  false
      
    end # Determine the object type
    
    # If the first string in the array is "All" populate the array with all the supported HTML tags
    if(aElements[0].to_s.downcase == "all")
      aElements = aSupportedHTMLElementNames
    end
    
    # Remove any Elements that are NOT supported by Firewatir
    if(self.is_firefox?)
      #puts2("*** Skipping HTML Element that is NOT supported by Firewatir - form", "WARN")
      aElements.delete("form")
    end
    
    # Remove any Elements that are NOT supported by IE
    if(self.is_ie?)
      #puts2("WARNING: Skipping HTML Element that has issues with IE - form")
      aElements.delete("form")
    end
    
    # Validate that the current element is valid
    aElements.each do | sElement |
      
      if((aSupportedHTMLElementNames.include?(sElement)) == false)
        puts2("WARNING: HTML Element  " +  sElement + "  is NOT supported.", "WARN")
        return false
      end
      
    end # Validate that the current element is valid
    
    #####################
    # Collect information on Title
    #####################
    sTitle = self.title
    
    puts2("\n###############")
    puts2("# Verify title: ")
    puts2("###############\n\n")
    puts2("puts2(\"\t # Verify - title\")")
    puts2("assert(#{sBrowserName}.title == \"" + sTitle + "\" )")
    
    # Loop for HTML Element types
    aElements.each do | sElement|
      
      
      # Define the proper attributes based on the type of HTML Element
      case sElement.to_s.downcase
        
        when "area"
        aAttributes = aAttribs_area
        when "button"
        aAttributes = aAttribs_button
        when "checkbox"
        aAttributes = aAttribs_checkbox
        when "dd"
        aAttributes = aAttribs_dd
        when "div"
        aAttributes = aAttribs_div
        when "dl"
        aAttributes = aAttribs_dl
        when "dt"
        aAttributes = aAttribs_dt
        when "em"
        aAttributes = aAttribs_em
        when "file_field"
        aAttributes = aAttribs_file_field
        when "form"
        aAttributes = aAttribs_form
        when "hidden"
        aAttributes = aAttribs_hidden
        when "image"
        aAttributes = aAttribs_image
        when "label"
        aAttributes = aAttribs_label
        when "link"
        aAttributes = aAttribs_link
        when "li"
        aAttributes = aAttribs_li
        when "map"
        aAttributes = aAttribs_map
        when "pre"
        aAttributes = aAttribs_pre
        when "p"
        aAttributes = aAttribs_p
        when "radio"
        aAttributes = aAttribs_radio
        when "select_list"
        aAttributes = aAttribs_select_list
        when "span"
        aAttributes = aAttribs_span
        when "strong"
        aAttributes = aAttribs_strong
        when "table"
        aAttributes = aAttribs_table
        when "text_field"
        aAttributes = aAttribs_text_field
      end # Define the proper attributes based on the type of HTML Element
      
      # Sort the attributes
      aAttributes.sort!
      
      puts2("\n################")
      puts2("# Verifying attributes for: #{sElement}")
      puts2("################\n\n")
      puts2("puts2(\"\t # Verifying attributes for: #{sElement}\")")
      
      # Compose the plural version for the current elements so we can get the count of each element type
      if(sElement == "checkbox")
        sElementPlural = "checkboxes"
      else
        sElementPlural = sElement + "s"
      end
      
      # Determine the total number of the current Element type
      iElementCount = self.send(sElementPlural).length
      
      # Generate the test code for the tag count
      puts2("assert(#{sBrowserName}.#{sElementPlural}.length == #{iElementCount.to_s}) # Number of #{sElementPlural}")
      
      # Only check existing elements
      if(iElementCount > 0)
        
        iIndex = 1
        
        while iIndex <= iElementCount
          
          puts2("\n#-------------------------#")
          puts2("# Attributes of #{sElement} #{iIndex}")
          puts2("#-------------------------#")
          
          aAttributes.each do | sAttribute |
            
            # Catcher
            #
            # Wrap the checks for the attributes in a begin/rescue/end block
            # Any error for an attribute that is unsupported for the current
            # Element type will be caught and not stop the test
            begin
              
              # Collect the setting of the current HTML element
              mySetting = self.send(sElement, :index => iIndex.adjust_index).send(sAttribute)
              
              # To make strings more human readable put parenthesis around the string
              if(mySetting.class.to_s == "String")
                mySetting = "\"" + mySetting + "\""
              end
              
              # To make arrays more human readable put brackets around its comma separated strings
              #              if(mySetting.class.to_s == "Array")
              #                mySetting = "\[\"" + mySetting + "\"\]"
              #              end
              
              # puts2("#{sAttribute}  = " + mySetting.to_s)
              puts2("assert(#{sBrowserName}.#{sElement}(:index, "+ iIndex.adjust_index.to_s + ").#{sAttribute} == #{mySetting} )")
              
            rescue
              # Element does not support the current attribute
              # no harm no foul
            ensure
            end # Catcher
            
          end # Loop for Attribute
          
          iIndex = iIndex +1
        end # while
        
      end # Only check existing elements
      
    end # Loop for HTML Element types
    
  end # Method - generate_testcode_html_tag_attributes()
  
  
  #=============================================================================#
  #--
  # Method: generate_testcode_html_tag_counts(...)
  #
  #++
  #
  # Description: Generates assert statements for the counts of the HTML elements with Watir length methods on the current Web page
  #              The assert statements are displayed to STDOUT and into the global log file (if it exists).
  #              The code can be manually copied and entered into a test case for use as the basis of a regression test.
  #
  #              Example partial output:
  #                  assert($browser.areas.length == 3) # Number of areas
  #                  assert($browser.buttons.length == 16) # Number of buttons
  #                  assert($browser.checkboxes.length == 3) # Number of checkboxes
  #
  #              Supported HTML Tag Elements are:
  #                area, button, checkbox, dd, div, dl, dt, em, file_field,
  #                hidden, image, label, link, li, map, pre, p, radio,
  #                select_list, strong, span, table, text_field
  #
  #               The forms and form methods are NOT supported.
  #
  # HINT: Run this once against a web page to generate code to subsequently use for testing the web page.
  #
  #       You may NOT need to count all the HTML tags, but only those necessary for use in a regression test
  #       to provide a reasonable sense that count of important the HTML tags on the page is unchanged.
  #       Determine what will work for your situation and set the passed parameters accordingly.
  #
  #       Manually Cut 'n Paste the output to a test case for use to subsequently test that web page.
  #
  #       For pages with dynamic content, you may need to edit the generated assert statements.
  #       For example, on a web page which always has at least 20 links, but that can grow to a larger number
  #       the output from this method may generates the code:
  #            assert($browser.links.length == 100) # Number of links
  #
  #       You can modify it in your test case to be:
  #             assert($browser.links.length >= 20) # Number of links
  #
  # Returns: BOOLEAN - true on success, otherwise false
  #
  #
  # Syntax: sBrowserName = STRING - The name to use in the print statement (defaults to "$browser")
  #
  #         oElementToCount = OBJECT - One of the following object types:
  #                                    nil - Count all HTML elements types with Watir length methods
  #
  #                                    STRING - Any single HTML elements type with Watir length method,
  #                                                i.e "link" to only count the link objects
  #                                              Or "all" to count them all.
  #
  #                                    ARRAY of STRINGS - A single or a set of multiple HTML Tag Elements
  #                                                           i.e ["link"] or ["button", "checkbox"]
  #                                                         Or if ["all"] for all the Element's.
  #
  #
  # Usage Examples:
  #                 1) To generate testcode for HTML Counts for ALL of the HTML elements with Watir length methods on the page:
  #                             browser = Watir::Browser.start("http://google.com")
  #                             hMyPageObjects = browser.generate_testcode_html_tag_counts("all", "browser")   #  Also works using: count_html_tags("all")
  #
  #
  #                 2) To generate testcode for HTML Counts for ONLY of the link HTML elements on the page:
  #                             $browser = Watir::Browser.start("http://google.com")
  #                             hMyPageObjects = $browser.generate_testcode_html_tag_counts("link")
  #                                         #=>  assert($browser.links.length == 30) # Number of links
  #
  #                 3) To generate testcode for HTML Counts for ONLY the image and button HTML elements on the page:
  #                             aObjectsToCount = ["image", "button"]
  #                             my_browser = Watir::Browser.start("http://google.com")
  #                             hMyPageObjects = my_browser.generate_testcode_html_tag_counts(aObjectsToCount, "my_browser")
  #                                        #=> assert(my_browser.buttons.length == 2) # Number of buttons
  #                                            assert(my_browser.images.length  = 5) # Number of images
  #=======================================================================#
  def generate_testcode_html_tag_counts(oElementToCount=nil, sBrowserName="$browser")
    
    
    hCountedHTMLTags = self.count_html_tags(oElementToCount)
    hCountedHTMLTags.sort.each do | sElement, iCount|
      
      # Adjust the Tag name as necessary so that adding an "s" will create the correct plural version
      if(sElement == "checkbox")
        sElementPlural = "checkboxes"
      else
        sElementPlural = sElement + "s"
      end
      if(iCount >= 0) # skip for negative counts, as negative values indicate that the tag count is invalid
        puts2("assert(#{sBrowserName}.#{sElementPlural}.length == #{iCount.to_s}) # Number of #{sElementPlural}")
      end
      
    end
    
  end
  
  
  #=============================================================================#
  #--
  # Method: get_doc_app_version()
  #
  #++
  #
  # Description: Gets the version of the currently loaded HTML document that the IE browser is displaying.
  #              Remember that once a URL is loaded an IE 8 browser may downrev to emulate a IE 7 browser.
  #              Thus the same browser may report IE 8 before a page is loaded and IE 6 or IE 7 after a page loads.
  #
  # Returns: STRING - Version of document that was found
  #                           "MSIE 8.0" if an MSIE 8.x compatible document is found
  #                           "MSIE 7.0" if an MSIE 7.x compatible document is found
  #                           "MSIE 6.0" if an MSIE 6.x compatible document is found
  #
  # Syntax: N/A
  #
  # Usage examples:
  #                sMyDocVersion = browser.get_doc_app_version
  #
  # Pre-requisites: Browser (e.g. IE 6 or later),  has been started,
  #
  #=============================================================================#
  def get_doc_app_version()
    
    
    
    sVersionNumber = "N/A"
    
    # Skip if executing under webdriver
    if(is_webdriver? == false)
      
      # Only run with Internet Explorer
      if(is_ie?)
        
        # Example IE browser versions:
        #   IE 6 returns: "4.0 (compatible; MSIE 6.0; Windows NT 5.1)"
        #   IE 7 returns: "4.0 (compatible; MSIE 7.0; Windows NT 6.0; WOW64; Trident/4.0; SLCC1; .NET CLR 2.0.50727; Media Center PC 5.0; .NET CLR 3.5.30729; .NET CLR 3.0.30729)"
        #   IE 8 returns: "4.0 (compatible; MSIE 8.0; Windows NT 6.0; WOW64; Trident/4.0; SLCC1; .NET CLR 2.0.50727; Media Center PC 5.0; .NET CLR 3.5.30729; .NET CLR 3.0.30729))"
        
        sRawAppVersion = self.document.invoke('parentWindow').navigator.appVersion
        
        if($VERBOSE == true)
          puts2(sRawAppVersion)
        end
        
        sVersionNumber = /MSIE\s(.*?);/.match( sRawAppVersion.upcase )
        
        if($VERBOSE == true)
          puts2("Version Number = " + sVersionNumber.to_s)
        end
        
        # Strip off the trailing semicolon (;)
        sVersionNumber = sVersionNumber.to_s.prefix(";")
        
      end # Only run with Internet Explorer
      
    end # Skip if executing under webdriver
    
    return  sVersionNumber
    
  end # Method - get_doc_app_version()
  
  
  #=============================================================================#
  #--
  # Method: get_chrome_version()
  #
  #++
  #
  # Description: Identifies the version of Chrome browser installed on the OS
  #
  # Returns: STRING - The version of the browser
  #
  # Syntax: N/A
  #
  # Usage Examples:  puts2("Chrome version: " + get_chrome_version())
  #
  #
  #=============================================================================#
  def get_chrome_version()
    
    if(is_win?)
      return get_chrome_version_win()
    elsif(is_linux?)
      return get_chrome_version_linux()
    elsif(is_osx?)
      return get_chrome_version_mac()
    end
  end # Function - get_chrome_version
  
  #=============================================================================#
  #--
  # Method: get_firefox_version()
  #
  #++
  #
  # Description: Identifies the version of Firefox browser installed on the OS
  #
  # Returns: STRING - The version of the browser
  #
  # Syntax: N/A
  #
  # Usage Examples:  puts2("Firefox version: " + get_firefox_version())
  #
  #
  #=============================================================================#
  def get_firefox_version()
    
    if(is_win?)
      return get_firefox_version_win()
    elsif(is_linux?)
      return get_firefox_version_linux()
    elsif(is_osx?)
      return get_firefox_version_mac()
    end
  end # Function - get_firefox_version
  
  #=============================================================================#
  #--
  # Method: get_ie_version()
  #
  #++
  #
  # Description: Identifies the version of IE browser installed on the OS
  #
  # Returns: STRING - The version of the browser
  #
  # Syntax: N/A
  #
  # Usage Examples:  puts2("IE version: " + get_ie_version())
  #
  #
  #=============================================================================#
  def get_ie_version()
    
    if(is_win?)
      return get_ie_version_win()
    elsif(is_linux?)
      return "N/A"
    elsif(is_osx?)
      return "N/A"
    end
  end # Function - get_ie_version
  
  
  #=============================================================================#
  #--
  # Method: get_opera_version()
  #
  #++
  #
  # Description: Identifies the version of Opera browser installed on the OS
  #
  # Returns: STRING - The version of the browser
  #
  # Syntax: N/A
  #
  # Usage Examples:  puts2("Opera version: " + get_opera_version())
  #
  #
  #=============================================================================#
  def get_opera_version()
    
    if(is_win?)
      return get_opera_version_win()
    elsif(is_linux?)
      return get_opera_version_linux()
    elsif(is_osx?)
      return get_opera_version_mac()
    end
  end # Function - get_opera_version
  
  
  #=============================================================================#
  #--
  # Method: get_safari_version()
  #
  #++
  #
  # Description: Identifies the version of Safari browser installed on the OS
  #
  # Returns: STRING - The version of the browser
  #
  # Syntax: N/A
  #
  # Usage Examples:  puts2("Safari version: " + get_safari_version())
  #
  #
  #=============================================================================#
  def get_safari_version()
    
    if(is_win?)
      return get_safari_version_win()
    elsif(is_linux?)
      return get_safari_version_linux()
    elsif(is_osx?)
      return get_safari_version_mac()
    end
  end # Function - get_safari_version
  
  #=============================================================================#
  #--
  # Method: get_hwnd_js_dialog(...)
  #
  #++
  #
  # Description:  Returns the Handle of the Windows for a JavaScript Dialog.
  #               The handle (hwnd) can then be used to access the text or buttons
  #               in the JS-Dialog, using WinClicker methods like:
  #                                get_static_text_hwnd(hwnd)
  #                                setTextValueForFileNameField(hwnd, sString)
  #                                getTextValueForFileNameField(hwnd)
  #                                clickWindowsButton_hwnd(hwnd, sButtonCaption)
  #
  # Restrictions:  The selection of the object that opens the JS-Dialog must be accessed with a
  #                "click_no_wait" method, and NOT with a "click" method. For example if the selection
  #                of a button "Submit" could raise a JS-Dialog Alert use:
  #                           browser.button(:value, "Submit").click_no_wait
  #                Then call this method with:
  #                           browser.get_JSDialog_hwnd()
  #
  # The Watir method click_no_wait does not work with ruby186-27_rc2.exe , works in prior versions, not fixed until ??
  #                       See:  http://wiki.openqa.org/display/WTR/JavaScript+Pop+Ups
  #                             http://groups.google.com/group/watir-general/browse_thread/thread/1d09c5963edef977
  #
  # Returns: INTEGER - If no JavaScript Popup window handle was found returns -1
  #                                     Otherwise returns  the integer value (e.g. 12345678) of the hwnd for the JavaScript Dialog window
  #
  # Syntax: iWaitTime = INTEGER - Length of time (ins seconds) to wait before checking if the JS-Dialog exists
  #
  # Usage Examples:
  #                   browser.get_hwnd_js_dialog()
  #                   browser.get_hwnd_js_dialog(3)
  #
  #=============================================================================#
  def get_hwnd_js_dialog(iWaitTime = 1)
    
    if($VERBOSE == true)
      puts2("Parameters - get_hwnd_js_dialog:")
      puts2("  iWaitTime: " + iWaitTime.to_s)
    end
    
    require 'watir\contrib\enabled_popup'
    require 'watir\page-container'
    
    # Don't allow zero or negative wait times
    if(iWaitTime < 1)
      iWaitTime = 1
      
      if($VERBOSE == true)
        puts2("Adjusted Wait (sec): #{iWaitTime.to_s}")
      end
      
    end # Don't allow zero or negative wait times
    
    # Get a handle for the JS-Dialog window if one exists
    hwnd = self.enabled_popup(iWaitTime)
    
    # Only continue if the JS-Dialog exists
    if(hwnd)
      
      puts2("JS-Dialog WindowID(hwnd): #{hwnd.to_s}")
      
      return  hwnd
      
    else # No JS-Dialog found
      
      return -1
      
    end # Only continue if the JS-Dialog exists
    
  end # Method: get_hwnd_js_dialog
  
  
  #=============================================================================#
  #--
  # Function: get_multiple_xml_tag_values(...)
  #++
  #
  # Description:  Parses a string containing XML Tags to get the values of the specified
  #               XML tag name, when there are multiple occurrences of the same Tag name .
  #               Checks that the Tags exists, NOT if they holds any content.
  #               Note that a Closing XML tag </tag_name> with
  #               no Opening tag <tag_name> proceeding it will return ''.
  #
  # Returns: ARRAY of STRINGS - Each STRING in the ARRAY contains the value of an XML Tag
  #                 [0] = The STRING between the first Opening and Closing XML Tags, or None
  #                 [1] = The STRING between the second Opening and Closing XML Tags, or None
  #                 [n] = The STRING between the nth Tags
  #
  #                 Returns [] If no occurrence of the Tag exists in the XML STRING
  #                 Returns a empty STRING' For any an occurrence of the Closing Tag,
  #                 with not Opening Tag in the XML STRING
  #
  # Syntax: sXML =  STRING - The string containing the XML tags to be searched.
  #         sTagName =  STRING - The name of the XML tag to match. Tags can be
  #                              specified with or without the enclosing brackets "<>"
  #
  # Usage Examples:
  #                   sXML = '<response><UserName>Bob</UserName><UserName>Pat</UserName><UserName>Tom</UserName></Nickname></response>'
  #
  #                   sTagName = "UserName"
  #                   get_multiple_xml_tag_values(sXML, sTag)  #=>  ['Bob','Pat','Tom']
  #
  #                   sTagName = "response"       # XML Tag containing other XML Tags
  #                   get_xml_tag_value(sXML, sTag)  #=>  ['<UserName>Bob</UserName><UserName>Pat</UserName><UserName>Tom</UserName></Nickname>']
  #
  #                   sTagName = "Nickname"  # Closing XML tag with no Opening Tag
  #                   get_xml_tag_value(sXML, sTag)  #=>  ['']
  #
  #                   sTagName = "<BogusTag>"  # An XML tag not contained within the XML String
  #                   get_xml_tag_value(sXML, sTag)  #=>  []
  #
  #=============================================================================#
  def get_multiple_xml_tag_values(sXML, sTagName)
    
    #$VERBOSE = true
    
    # Define default return value
    aMatchingTagValues = []
    
    if($VERBOSE == true)
      puts2("Parameters - get_multiple_xml_tag_values:")
      puts2("  sXML: " + sXML)
      puts2("  sTagName: " + sTagName)
    end
    
    # Generate the Opening and Closing XML tags
    #
    # Its easier to first remove brackets (if they existed).
    sTagWithoutBrackets = remove_xml_brackets(sTagName)
    
    # Generate the Opening and Closing tags (with brackets)
    aXMLTags = create_xml_tags(sTagWithoutBrackets)
    
    sFullOpeningTag = aXMLTags[0]
    sFullClosingTag = aXMLTags[1]
    
    if ($VERBOSE == true)
      puts2("Opening tag:  " + sFullOpeningTag)
      puts2("Closing tag:  " + sFullClosingTag)
    end
    
    # Determine the length of the Opening and Closing Tags
    iOpeningTagLength = sFullOpeningTag.length
    iClosingTagLength = sFullClosingTag.length
    
    if ($VERBOSE == true)
      puts2("Opening tag length:  " + iOpeningTagLength.to_s)
      puts2("Closing tag length:  " + iClosingTagLength.to_s)
    end
    
    # Determine the total number of closing tags in the XML
    iTotalTagCount = sXML.scan(sFullClosingTag).length
    
    # Verify that the specified tag exists
    if (iTotalTagCount == 0)
      if ($VERBOSE == true)
        puts2("No Closing tag found:  " + sFullClosingTag)
      end
      # No occurrence of the Closing Tag found so get out of this function
      return aMatchingTagValues
    end
    
    if ($VERBOSE == true)
      puts2("Total Closing tags found:  " + iTotalTagCount.to_s)
    end
    
    # Seed the counter
    iCurrentTag = iTotalTagCount
    
    # Loop to get that values of each of the Tags
    while iCurrentTag > 0
      
      # Find the position of the first character of each Tag in the XML string
      iIndexOfFirstOpeningTag = sXML.index(sFullOpeningTag)
      iIndexOfFirstClosingTag = sXML.index(sFullClosingTag)
      
      if ($VERBOSE == true)
        puts2("Opening tag index:  " + iIndexOfFirstOpeningTag.to_s)
        puts2("Closing tag index:  " + iIndexOfFirstClosingTag.to_s)
      end
      
      # See if either of the Tags can't be found, save a value of ''
      if ((iIndexOfFirstOpeningTag == nil ) | (iIndexOfFirstClosingTag == nil ))
        if ($VERBOSE == true)
          puts2("Missing either Opening XML Tag or Closing XML tag")
        end
        # Save a value of '' for the current occurrence of the Tag
        aMatchingTagValues. << ''
        
      else
        # Get the text between the Opening and Closing Tags
        sFoundXMLTagValue = sXML[(iIndexOfFirstOpeningTag + iOpeningTagLength)..iIndexOfFirstClosingTag -1]
        
        if ($VERBOSE == true)
          puts2("Found XML tag value: '" + sFoundXMLTagValue + "'")
        end
        
        # Save the STRING between the Opening and Closing Tags
        aMatchingTagValues << sFoundXMLTagValue
        
      end # See if either of the Tags...
      
      # Update the XML STRING with the current Closing tag removed
      sXML = sXML[(iIndexOfFirstClosingTag + (iClosingTagLength)..-1)]
      
      if ($VERBOSE == true)
        puts2("Updated XML STRING: '" + sXML + "'")
      end
      
      # Update the count of the remaining Closing Tags
      iCurrentTag = sXML.scan(sFullClosingTag).length
      
      if ($VERBOSE == true)
        puts2("Remaining number of XML Tags: " + iCurrentTag.to_s)
      end
      
    end # Loop to get that values
    
    return aMatchingTagValues
    
  end # END method - get_multiple_xml_tag_values()
  
  alias getMultipleXMLTagValues get_multiple_xml_tag_values
  
  #=============================================================================#
  #--
  # Function: get_xml_tag_value(...)
  #++
  #
  # Description:  Parses an XML string containing XML Tags to get the values of the
  #               first occurrence of the specified tag name.
  #
  #               If more than one occurrence of the specified tag name can exist
  #               in the XML string use: get_multiple_xml_tag_values()
  #
  #               Checks that the Tag exists, NOT if it holds any content.
  #               Note that a Closing XML tag </tag_name> with
  #               no Opening tag <tag_name> proceeding it will return None.
  #
  # Returns: STRING = The STRING between the Opening and Closing XML Tags, or None
  #
  # Syntax: sXML =  STRING - The string containing the XML tags to be searched.
  #         sTagName =  STRING - The name of the XML tags to match. Tags can be
  #                              specified with or without the enclosing brackets "<>"
  #
  # Usage Examples:
  #                   sXML = '<response><UserName>Bob</UserName></Nickname></response>'
  #
  #                   sTagName = "UserName"
  #                   get_xml_tag_value(sXML, sTag)  #=>  Bob
  #
  #                   sTagName = "response"       # XML Tag containing other XML Tags
  #                   get_xml_tag_value(sXML, sTag)  #=>  <UserName>Bob</UserName></Nickname>
  #
  #                   sTagName = "Nickname"  # Closing XML tag with no Opening Tag
  #                   get_xml_tag_value(sXML, sTag)  #=>  nil
  #
  #=============================================================================#
  def get_xml_tag_value(sXML, sTagName)
    
    #$VERBOSE = true
    
    if($VERBOSE == true)
      puts2("Parameters - get_xml_tag_value:")
      puts2("  sXML: " + sXML)
      puts2("  sTagName: " + sTagName)
    end
    
    # Define default return value
    sXMLTagValue = nil
    
    # Verify that the specified tag exists
    if (is_tag_in_xml?(sXML, sTagName) == false)
      if ($VERBOSE == true)
        puts2("No tag:  " + sTagName)
      end
      return sXMLTagValue
    end
    
    # Generate the Opening and Closing XML tags
    
    # Its easier to first remove brackets (if they existed).
    sTagWithoutBrackets = remove_xml_brackets(sTagName)
    
    # Generate the Opening and Closing tags (with brackets)
    aXMLTags = create_xml_tags(sTagWithoutBrackets)
    
    sFullOpeningTag = aXMLTags[0]
    sFullClosingTag = aXMLTags[1]
    
    if ($VERBOSE == true)
      puts2("Opening tag:  " + sFullOpeningTag)
      puts2("Closing tag:  " + sFullClosingTag)
    end
    
    # Determine the length of the Opening and Closing Tags
    iOpeningTagLength = sFullOpeningTag.length
    iClosingTagLength = sFullClosingTag.length
    
    if ($VERBOSE == true)
      puts2("Opening tag length:  " + iOpeningTagLength.to_s)
      puts2("Closing tag length:  " + iClosingTagLength.to_s)
    end
    #
    # Find the position of the first character of each Tag in the XML string
    iIndexOfOpeningTag = sXML.index(sFullOpeningTag)
    iIndexOfClosingTag = (sXML.index(sFullClosingTag) -1)
    
    if ($VERBOSE == true)
      puts2("Opening tag index:  " + iIndexOfOpeningTag.to_s)
      puts2("Closing tag index:  " + iIndexOfClosingTag.to_s)
    end
    
    # If either of the Tags can't be found, return nil
    if ((iIndexOfOpeningTag == nil ) | (iIndexOfClosingTag == nil ))
      if ($VERBOSE == true)
        puts2("Missing either Opening XML Tag or Closing XML tag")
      end
      return nil
    end
    
    # Save the STRING between the Opening and Closing Tags
    sXMLTagValue = sXML[(iIndexOfOpeningTag + iOpeningTagLength) .. iIndexOfClosingTag ]
    
    return sXMLTagValue
    
  end # END method - get_xml_tag_value()
  
  alias getXMLTagValue get_xml_tag_value
  
  
  #=============================================================================#
  #--
  # Method: handle_js_dialog(...)
  #
  #
  #++
  #
  # Description: Handles a JavaScript Popup Dialog using the specified button, and
  #              if it is a JS-Prompt-Dialog it can enter a string into the prompt inout field.
  #
  #              It can be used with each of the three type of JS-Dialogs:
  #                       Alert, Confirmation, or Prompt
  #              However it can not tell which type of JS-Dialog is displayed, nor what buttons,
  #              nor the default text prompt that exists in that JS-Dialog.
  #
  #              This method was developed from code posted by Mark_cain@rl.gov
  #
  # Restrictions: The selection of the object that opens the JS-Dialog must be accessed with a
  #               "click_no_wait" method, and NOT with a "click" method. For example if the selection
  #               of a button "Submit" could raise a JS-Dialog Alert use:
  #                           browser.button(:value, "Submit").click_no_wait
  #               Then call this method with:
  #                           browser.handle_js_dialog("OK")
  #
  # Returns: N/A
  #
  # Syntax: sButtonCaption = STRING - Name of the button on the JS-Dialog (Case sensitive)
  #                                     (e.g. "OK", "Cancel")
  #         iWaitTime = INTEGER -  Number of seconds to wait before checking if the JS-Dialog exists
  #         sString = STRING - Text to enter into text_field of JS-Prompt-Dialog (if one exists)
  #
  # Usage Examples:
  #                To dismiss a JS-Alert-Dialog with an "OK" button:
  #                     browser.handle_js_dialog("OK")
  #                To dismiss a JS-Confirmation-Dialog with an "Cancel" button after 3 seconds:
  #                     browser.handle_js_dialog("Cancel", 3)
  #                To dismiss a JS-Prompt-Dialog with an "OK" button after entering a string:
  #                     browser.handle_js_dialog("OK", 3, "My Answer To The Prompt")
  #
  #=============================================================================#
  def handle_js_dialog(sButtonCaption, iWaitTime = 1, sString = nil)
    
    if($VERBOSE == true)
      puts2("Parameters - handle_js_dialog:")
      puts2("  Button: \"#{sButtonCaption.to_s}\" ")
      puts2("  Wait (sec): #{iWaitTime.to_s}")
      puts2("  String: \"#{sString.to_s}\" ")
    end
    
    require 'watir\contrib\enabled_popup'
    
    # Don't allow zero or negative wait times
    if(iWaitTime <= 1)
      iWaitTime = 1
      
      if($VERBOSE == true)
        puts2("Adjusted Wait (sec): #{iWaitTime.to_s}")
      end
    end # Don't allow zero or negative wait times
    
    # Get a handle for the JS-Dialog window if it exists
    hwnd = self.enabled_popup(iWaitTime)
    
    # Only continue if the JS-Dialog exists
    if(hwnd)
      
      # Create a WinClicker object
      wJSDialog = WinClicker.new
      
      if($VERBOSE == true)
        puts2("JS-Dialog's WindowID(hwnd): #{hwnd.to_s}")
        
        sJSDialogStaticText = wJSDialog.get_static_text_hwnd(hwnd)
        puts2("JS-Dialog's static text: \"#{sJSDialogStaticText}\" ")
      end
      
      # Enter the String
      if(sString.to_s.upcase != "")
        
        if($VERBOSE == true)
          
          sJSDialogDefaultPromptText = wJSDialog.getTextValueForFileNameField(hwnd)
          puts2("JS-Dialog's Default Prompt text: \"#{sJSDialogDefaultPromptText}\" ")
        end
        
        wJSDialog.setTextValueForFileNameField(hwnd, sString)
        
      end
      
      # Pause to view the JS-Dialog before dismissing it
      sleep iWaitTime
      
      # Select the specified button ("OK" , "Cancel", etc.) by the  button's caption
      wJSDialog.clickWindowsButton_hwnd(hwnd, sButtonCaption)
      
      # After the JS Popup window is closed cleanup the window object
      wJSDialog = nil
      
    end # Only continue if the JS-Dialog exists
  end # Method: handle_js_dialog()
  
  #=============================================================================#
  #--
  # Method: is_android?()
  #
  #++
  #
  # Description: Identifies if running a android browser
  #
  # Returns: BOOLEAN - true if browser is android, otherwise false
  #
  # Syntax: N/A
  #
  # Usage Examples:  if(browser.is_android?)
  #                      # Execute your android specific code
  #                  end
  #
  #=============================================================================#
  def is_android?()
    
    if(is_webdriver? == true)
      return (self.driver.browser.to_s.downcase == "android")
    else
      return false
    end
    
  end
  
  #=============================================================================#
  #--
  # Method: is_celerity?()
  #
  #++
  #
  # Description: Identifies if running a Celerity browser
  #
  # Returns: BOOLEAN - true if browser is Celerity, otherwise false
  #
  # Syntax: N/A
  #
  # Usage Examples:  if(browser.is_celerity?)
  #                      # Execute your Celerity specific code
  #                  end
  #
  #=============================================================================#
  def is_celerity?()
    
    if(is_webdriver? == true)
      return false
    else
      return (self.class.to_s == "Celerity::Browser")
    end
    
  end
  
  
  #=============================================================================#
  #--
  # Method: is_chrome?(...)
  #
  #++
  #
  # Description: Identifies if running a Chrome browser
  #
  # Returns: BOOLEAN - true if browser is Chrome, otherwise false
  #
  # Syntax: N/A
  #
  # Usage Examples:  if(browser.is_chrome?)
  #                      # Execute your Chrome specific code
  #                  end
  #
  #=============================================================================#
  def is_chrome?(iVersion = nil)
    
    if($VERBOSE == true)
      puts2("Parameters - is_chrome?")
      puts2("  iVersion " + iVersion.to_s)
    end
    
    if(iVersion == nil)
      if(is_webdriver? == true)
        return (self.driver.browser.to_s.downcase == "chrome")
      else
        return (self.class.to_s == "ChromeWatir::Browser")
      end
      
    elsif(iVersion >= 10)
      
      # Get the major release number of current browser
      sAcutalBrowserVersion = self.version.prefix(".")
      sAcutalBrowserBrand = self.brand.downcase
      
      if((iVersion == sAcutalBrowserVersion.to_i) and (sAcutalBrowserBrand == "chrome"))
        return true
      else
        return false
      end
      
    else # Not nil and not >=10
      return false
    end
    
  end # Method - is_chrome?(...)
  
  
  #=============================================================================#
  #--
  # Method: is_chrome_installed?(...)
  #
  #++
  #
  # Description: Identifies if the specified Chrome version in installed on the OS
  #
  # Returns: BOOLEAN - true if specified Chrome browser is installed, otherwise false
  #
  # Syntax: N/A
  #
  # Usage Examples:  if(browser.is_chrome_installed?(17))
  #                      # Execute Chrome 17.x specific code
  #                  end
  #
  #=============================================================================#
  def is_chrome_installed?(iVersion = 10)
    
    if($VERBOSE == true)
      puts2("Parameters - is_chrome_installed?")
      puts2("  iVersion " + iVersion.to_s)
    end
    
    if(is_win?)
      return is_chrome_installed_win?(iVersion)
    elsif(is_linux?)
      return is_chrome_installed_linux?(iVersion)
    elsif(is_osx?)
      return is_chrome_installed_mac?(iVersion)
    end
    
  end # Method - is_chrome_installed?(...)
  
  #=============================================================================#
  #--
  # Method: is_firefox?()
  #
  #++
  #
  # Description: Identifies if running a Firefox browser
  #
  # Returns: BOOLEAN - true if browser is Firefox, otherwise false
  #
  # Syntax: N/A
  #
  # Usage Examples:  if(browser.is_firefox?())
  #                      # Execute Firefox specific code
  #                  end
  #
  #=============================================================================#
  def is_firefox?(iVersion = nil)
    
    if($VERBOSE == true)
      puts2("Parameters - is_firefox?")
      puts2("  iVersion " + iVersion.to_s)
    end
    
    if(iVersion == nil)
      if(is_webdriver? == true)
        return (self.driver.browser.to_s.downcase == "firefox")
      else
        return (self.class.to_s == "FireWatir::Firefox")
      end
      
    elsif(iVersion >= 2)
      
      # Get the major release number of current browser
      sAcutalBrowserVersion = self.version.prefix(".")
      sAcutalBrowserBrand = self.brand.downcase
      
      if((iVersion == sAcutalBrowserVersion.to_i) and (sAcutalBrowserBrand == "firefox"))
        return true
      else
        return false
      end
      
    else # Not nil and not >=2
      return false
    end
    
  end # Method - is_firefox?(...)
  
  alias is_ff? is_firefox?
  
  
  #=============================================================================#
  #--
  # Method: is_firefox_installed?(...)
  #
  #++
  #
  # Description: Identifies if the specified Firefox version in installed on the OS
  #
  # Returns: BOOLEAN - true if specified Firefox browser is installed, otherwise false
  #
  # Syntax: N/A
  #
  # Usage Examples:  if(browser.is_firefox_installed?(7))
  #                      # Execute Firefox 7.x specific code
  #                  end
  #
  #=============================================================================#
  def is_firefox_installed?(iVersion = 3)
    
    if($VERBOSE == true)
      puts2("Parameters - is_firefox_installed?")
      puts2("  iVersion " + iVersion.to_s)
    end
    
    if(is_win?)
      return is_firefox_installed_win?(iVersion)
    elsif(is_linux?)
      return is_firefox_installed_linux?(iVersion)
    elsif(is_osx?)
      return is_firefox_installed_mac?(iVersion)
    end
    
  end # Method - is_firefox_installed?(...)
  
  alias is_ff_installed?   is_firefox_installed?
  
  
  #=============================================================================#
  #--
  # Method: is_ie?(...)
  #
  #++
  #
  # Description: Identifies if running a Internet Explorer browser
  #
  # Returns: BOOLEAN - true if browser is Internet Explorer, otherwise false
  #
  # Syntax: N/A
  #
  # Usage Examples:  if(browser.is_ie?)
  #                      # Execute IE specific code
  #                  end
  #
  #=============================================================================#
  def is_ie?(iVersion = nil)
    
    if($VERBOSE == true)
      puts2("Parameters - is_ie?")
      puts2("  iVersion " + iVersion.to_s)
    end
    
    if(iVersion == nil)
      if(is_webdriver? == true)
        return (self.driver.browser.to_s.downcase == "internet_explorer")
      else
        return (self.class.to_s == "Watir::IE")
      end
      
    elsif(iVersion >= 6)
      
      # Get the major release number of current browser
      sAcutalBrowserVersion = self.version.prefix(".")
      sAcutalBrowserBrand = self.brand.downcase
      
      if((iVersion == sAcutalBrowserVersion.to_i) and (sAcutalBrowserBrand == "ie"))
        return true
      else
        return false
      end
      
    else # Not nil and not >=6
      return false
    end
    
  end # Method - is_ie?(...)
  
  
  #=============================================================================#
  #--
  # Method: is_ie_installed?(...)
  #
  #++
  #
  # Description: Identifies if the specified INternet Explorer version in installed on the OS
  #
  # Returns: BOOLEAN - true if specified IE browser is installed, otherwise false
  #
  # Syntax: N/A
  #
  # Usage Examples:  if(browser.is_ie_installed?(7))
  #                      # Execute IE 7.x specific code
  #                  end
  #
  #=============================================================================#
  def is_ie_installed?(iVersion = 10)
    
    if($VERBOSE == true)
      puts2("Parameters - is_ie_installed?")
      puts2("  iVersion " + iVersion.to_s)
    end
    
    if(is_win?)
      return is_ie_installed_win?(iVersion)
    elsif(is_linux?)
      return false
    elsif(is_osx?)
      return false
    end
    
  end # Method - is_ie_installed?(...)
  
  #=============================================================================#
  #--
  # Method: is_opera?(...)
  #
  #++
  #
  # Description: Identifies if running a Opera browser
  #
  # Returns: BOOLEAN - true if browser is Opera, otherwise false
  #
  # Syntax: N/A
  #
  # Usage Examples:  if(browser.is_is_opera?)
  #                      # Execute your Opera specific code
  #                  end
  #
  #=============================================================================#
  def is_opera?(iVersion = nil)
    
    if($VERBOSE == true)
      puts2("Parameters - is_opera?")
      puts2("  iVersion " + iVersion.to_s)
    end
    
    if(iVersion == nil)
      if(is_webdriver? == true)
        return (self.driver.browser.to_s.downcase == "opera")
      else
        return false
      end
    elsif(iVersion >= 8)
      
      # Get the major release number of current browser
      sAcutalBrowserVersion = self.version.prefix(".")
      sAcutalBrowserBrand = self.brand.downcase
      
      if((iVersion == sAcutalBrowserVersion.to_i) and (sAcutalBrowserBrand == "opera"))
        return true
      else
        return false
      end
      
    else # Not nil and not >= 8
      return false
    end
    
  end # Method - is_opera?(...)
  
  
  #=============================================================================#
  #--
  # Method: is_opera_installed?(...)
  #
  #++
  #
  # Description: Identifies if the specified Opera version in installed on the OS
  #
  # Returns: BOOLEAN - true if specified Opera browser is installed, otherwise false
  #
  # Syntax: N/A
  #
  # Usage Examples:  if(browser.is_opera_installed?(10))
  #                      # Execute Opera 10.x specific code
  #                  end
  #
  #=============================================================================#
  def is_opera_installed?(iVersion = 10)
    
    if($VERBOSE == true)
      puts2("Parameters - is_opera_installed?")
      puts2("  iVersion " + iVersion.to_s)
    end
    
    if(is_win?)
      return is_opera_installed_win?(iVersion)
    elsif(is_linux?)
      return is_opera_installed_linux?(iVersion)
    elsif(is_osx?)
      return is_opera_installed_mac?(iVersion)
    end
    
  end # Method - is_opera_installed?(...)
  
  
  #=============================================================================#
  #--
  # Method: is_safari?()
  #
  #++
  #
  # Description: Identifies if running a Safari browser
  #
  # Returns: BOOLEAN - true if browser is Safari, otherwise false
  #
  # Syntax: N/A
  #
  # Usage Examples:  if(browser.is_safari?)
  #                      # Execute your Safari specific code
  #                  end
  #
  #=============================================================================#
  def is_safari?(iVersion = nil)
    
    if($VERBOSE == true)
      puts2("Parameters - is_safari?")
      puts2("  iVersion " + iVersion.to_s)
    end
    
    if(iVersion == nil)
      if(is_webdriver? == true)
        return (self.driver.browser.to_s.downcase == "safari")
      else
        return (self.class.to_s == "Watir::Safari")
      end
      
    elsif(iVersion >= 4)
      
      # Get the major release number of current browser
      sAcutalBrowserVersion = self.version.prefix(".")
      sAcutalBrowserBrand = self.brand.downcase
      
      if((iVersion == sAcutalBrowserVersion.to_i) and (sAcutalBrowserBrand == "safari"))
        return true
      else
        return false
      end
      
    else # Not nil and not >= 4
      return false
    end
    
  end # Method - is_safari?...)
  
  
  #=============================================================================#
  #--
  # Method: is_safari_installed?(...)
  #
  #++
  #
  # Description: Identifies if the specified Safari version in installed on the OS
  #
  # Returns: BOOLEAN - true if specified Safari browser is installed, otherwise false
  #
  # Syntax: N/A
  #
  # Usage Examples:  if(browser.is_safari_installed?(10))
  #                      # Execute Safari 5.x specific code
  #                  end
  #
  #=============================================================================#
  def is_safari_installed?(iVersion = 5)
    
    if($VERBOSE == true)
      puts2("Parameters - is_safari_installed?")
      puts2("  iVersion " + iVersion.to_s)
    end
    
    if(is_win?)
      return false
    elsif(is_linux?)
      return false
    elsif(is_osx?)
      return is_safari_installed_mac?(iVersion)
    end
    
  end # Method - is_safari_installed?(...)
  
  #=============================================================================#
  #--
  # Method: is_global_browser_running?()
  #
  #++
  #
  # Description: Checks the list of Global variables to see if Global Browser exists.
  #
  #              When a Global browser is running the list of Global variables will
  #              contain an entry who's class is either "Watir::IE",  "FireWatir::Firefox"
  #              or "Watir::Safari", based on which browser you have Watir set to run.
  #
  # HINT: When running a test suite with several test all sharing a single Global browsers
  #       there's always a chance that the AUT may cause that browser to crash.
  #       So prior to each test check if its still running, and start one up only if it is NOT.
  #       A good place to do this is in the startup method of your Test::Unit::TestCase
  #
  # Returns: BOOLAEN = true if found, otherwise returns false
  #
  # Syntax: N/A
  #
  # Usage Examples: Start a new Global browser if one is NOT running
  #                     if(is_global_browser_running? == false)
  #                        $browser = Watir::Browser.new
  #                     end
  #
  #
  #=============================================================================#
  def is_global_browser_running?()
    
=begin  watir-webdriver - missing method - options
    # Determine which type of browser is set as the current default
    sBrowserType = Watir.options[:browser]
=end
    sBrowserType = "firefox"
    
    case sBrowserType.downcase
      when "firefox"
      sClassString = "FireWatir::Firefox"
      when "safari"
      sClassString = "Watir::Safari"
    else
      sClassString = "Watir::IE"
    end
    
    # Populate array with the names of all Global variables
    aCurrentGlobalVars = global_variables()
    
    # Check each Global variable
    aCurrentGlobalVars.each do | sGlobalVarName |
      
      # Get the class of the variable
      sGlobalVarClass = eval(sGlobalVarName).class.to_s.strip
      
      if($VERBOSE == true)
        puts2("Name: " + sGlobalVarName + " Class: " + sGlobalVarClass)
      end
      
      # Test the Class of each one for a match
      if(sGlobalVarClass == sClassString)
        return  true
      end
      
    end
    
    # No match found if it reaches this point
    return false
    
  end # Method - is_global_browser_running?()
  
  
  #=============================================================================#
  #--
  # Method: is_browser_minimized?(...)
  #
  #++
  #
  # Description: Determines if the browser window is minimized by using it's title
  #
  # Returns: BOOLEAN - true if minimized, otherwise false
  #
  # Syntax: sWinTitle = STRING - The title used to identify the window (e.g. "My WebSite - Home")
  #
  # Usage Examples:      assert(browser.is_browser_minimized?)
  #
  #=============================================================================#
  def is_browser_minimized?(sWinTitle=self.title)
    
    if($VERBOSE == true)
      puts2("Parameters - is_browser_minimized?:")
      puts2("  sWinTitle: " + sWinTitle)
    end
    
    return is_minimized?(sWinTitle)
    
  end # Method - is_minimized?()
  
  #=============================================================================#
  #--
  # Function: is_tag_in_xml?(...)
  #++
  #
  # Description:  Parses a string containing XML Tags to see if the specified
  #               tag name exists.
  #               Checks that the Tag exists, NOT if it holds any content.
  #               Note that a null tag (e.g. a Closing tag </tag_name> with
  #               no Opening tag <tag_name>) will be identified as existing.
  #
  # Returns: BOOLEAN = True if the Tag exists, otherwise False
  #
  # Syntax: sXML =  STRING - The string containing the XML tags to be searched.
  #         sTagName =  STRING - The name of the XML tags to match. Names can be
  #                          specified with or without the enclosing brackets "<>"
  #
  # Usage Examples:
  #                   sXML = '<response><UserName>Bob</UserName></Password></response>'
  #                   sTagName = "UserName"
  #                   is_tag_in_xml?(sXML, sTag)  #=>  true
  #
  #                   sTagName = "Username"
  #                   is_tag_in_xml?(sXML, sTag)  #=>  false
  #
  #                   sTagName = "<UserName>"  # With Brackets
  #                   is_tag_in_xml?(sXML, sTag)  #=>  true
  #
  #                   sTagName = "Password"  # With no Opening tag
  #                   is_tag_in_xml?(sXML, sTag)  #=>  true
  #
  #=============================================================================#
  def is_tag_in_xml?(sXML, sTagName)
    
    # $VERBOSE = true
    
    if($VERBOSE == true)
      puts2("Parameters - is_tag_in_xml?:")
      puts2("  sXML: " + sXML)
      puts2("  sTagName: " + sTagName)
    end
    
    # Set default return value
    bFound = false
    
    # Instead of checking the specified tag for enclosing brackets <tag_name>.
    # ITs easier to just remove them (if they existed) and then adding them.
    sTagWithoutBrackets = remove_xml_brackets(sTagName)
    
    # Generate the Opening and Closing tags (with brackets)
    aXMLTags = create_xml_tags(sTagWithoutBrackets)
    
    #sFullOpeningTag = aTags[0]
    sFullClosingTag = aXMLTags[1]
    
    if ($VERBOSE == true)
      #puts2("Opening tag:  " + sFullOpeningTag)
      puts2("Closing tag:  " + sFullClosingTag)
    end
    
    # Parse the XML String to see if there is a Closing Tag
    # If the Closing tag is found then the tag exists, even if
    # there is no Opening tag
    if(sXML =~ /#{sFullClosingTag}/)
      #if(re.search(sFullClosingTag, sXML))
      bFound = true
    end
    
    
    return bFound
    
  end # END method - is_tag_in_xml?()
  
  alias isTagInXML? is_tag_in_xml?
  
  
  #=============================================================================#
  #--
  # Method: is_text_in_div_class?(...)
  #
  #++
  #
  # Description: Verifies if a string is present in a div on the page.
  #              The div is identified by its class name.
  #              The specified object is searched to see if it contains the expected text.
  #              If the expected text is not found, it optionally saves the HTML
  #
  # Returns: BOOLAEN = true if found, otherwise returns false
  #
  # Syntax: sExpectedText = STRING - The expected text string
  #         sObjectIdentifier = STRING - div's class that hold the expected text
  #         bSaveIssues = BOOLEAN - true = Save a screen capture and HTML page if match not found.
  #                                 false = don't save
  #         sCaptureFileNamePrefix = STRING - Name to be pre-pended to the file name of any screen capture or HTML saves
  #
  # Usage Examples:
  #                   browser = Watir::Browser.new
  #                   browser.goto("www.mypage.html")
  #                   bFound = browser.is_text_in_div_class?("Some Text", "main_div", false, "Issue" )
  #
  #=============================================================================#
  def is_text_in_div_class?(sExpectedText, sObjectIdentifier, bSaveIssues=false, sCaptureFileNamePrefix="")
    
    if($VERBOSE == true)
      puts2("Parameters - is_text_in_div_class?:")
      puts2("  sExpectedText: " + sExpectedText)
      puts2("  sObjectIdentifier: " + sObjectIdentifier)
      puts2("  bSaveIssues: " + bSaveIssues.to_s)
      puts2("  sCaptureFileNamePrefix: " + sCaptureFileNamePrefix)
    end
    
    # Clear status flag
    bStatus = false
    
    # Validate text message
    if((sExpectedText.upcase != "NIL") && (sObjectIdentifier.upcase != "NIL"))
      
      sExpectedText = sExpectedText.strip
      
      if(self.div(:class, "#{sObjectIdentifier}").exists?) # Verify the specified object exists on the page
        
        if($VERBOSE == true)
          puts2("Searching for text: " + sExpectedText + " in class: " + sObjectIdentifier)
        end
        
        if((self.div(:class, sObjectIdentifier).text) =~ /#{sExpectedText}/) # Perform verification
          
          # Set status flag
          bStatus = true
          
          if($VERBOSE == true)
            puts2("    Text Verified: " + sExpectedText)
          end
          
        else # Text verification failed
          
          puts2("*** WARNING - Verifying text", "WARN")
          puts2("     Expected: " + sExpectedText, "WARN")
          puts2("     Actual:   " + self.div(:class, sObjectIdentifier).text.strip, "WARN")
          
          if(bSaveIssues)
            # Save the HTML contents of the current web page to a file
            self.save_html(sCaptureFileNamePrefix)
          end
          
        end # Perform verification
      else # Verify the specified object exists on the page
        
        puts2("*** WARNING - Unable to locate div(:class, \"" + sObjectIdentifier + "\") on page.", "WARNING")
        
        if(bSaveIssues)
          # Save an image capture of the current web page window as a BMP
          seelf.save_screencapture(sCaptureFileNamePrefix )
          
          # Save the HTML contents of the current web page to a file
          self.save_html(sCaptureFileNamePrefix)
        end
        
      end # Verify the specified object exists on the page
    end # Validate text message
    
    # Return status flag
    return bStatus
    
  end # Method - is_text_in_div_class?
  
  alias isTextIn_DivClass? is_text_in_div_class?
  
  #=============================================================================#
  #--
  # Method: is_text_in_div_id?(...)
  #
  #++
  #
  # Description: Verifies if a string is present in a div on the page.
  #              The div is identified by its id.
  #              The specified object is searched to see if it contains the expected text.
  #              If the expected text is not found, it optionally saves the HTML
  #
  # Returns: BOOLEAN - true if found, otherwise returns false
  #
  # Syntax:
  #         sExpectedText = STRING - The expected text string
  #         sObjectIdentifier = STRING - div's ID that hold the expected text
  #         bSaveIssues = BOOLEAN - true = Save a screen capture and HTML page if match not found.
  #                                 false = don't save
  #        sCaptureFileNamePrefix = STRING - Name to be pre-pended to the file name of any HTML saves
  #
  # Usage Examples:
  #                   browser = Watir::Browser.new
  #                   browser.goto("www.mypage.html")
  #                   bFound = browser.is_text_in_div_id?("Some Text", "main_div", false, "Issue" )
  #
  #=============================================================================#
  def is_text_in_div_id?(sExpectedText, sObjectIdentifier, bSaveIssues=false, sCaptureFileNamePrefix="")
    
    if($VERBOSE == true)
      puts2("Parameters - is_text_in_div_id?:")
      puts2("  sExpectedText: " + sExpectedText)
      puts2("  sObjectIdentifier: " + sObjectIdentifier)
      puts2("  bSaveIssues: " + bSaveIssues.to_s)
      puts2("  sCaptureFileNamePrefix: " + sCaptureFileNamePrefix)
    end
    
    # Clear status flag
    bStatus = false
    
    # Validate text message
    if((sExpectedText.upcase != "NIL") && (sObjectIdentifier.upcase != "NIL"))
      
      sExpectedText = sExpectedText.strip
      
      if(self.div(:id, sObjectIdentifier).exists?) # Verify the specified object exists on the page
        
        if($VERBOSE == true)
          puts2("Searching for text: " + sExpectedText + " in class: " + sObjectIdentifier)
        end
        
        if((self.div(:id, sObjectIdentifier).text) =~ /#{sExpectedText}/) # Perform verification
          
          # Set status flag
          bStatus = true
          
          if($VERBOSE == true)
            puts2("    Text Verified: " + sExpectedText)
          end
          
        else # Text verification failed
          
          puts2("*** WARNING - Verifying text", "WARN")
          puts2("     Expected: " + sExpectedText, "WARN")
          puts2("     Actual:   " + self.div(:id, sObjectIdentifier).text.strip, "WARN")
          
          if(bSaveIssues)
            # Save the HTML <body> contents of the current web page to a file
            self.save_html(sCaptureFileNamePrefix)
          end
          
        end # Perform verification
      else # Verify the specified object exists on the page
        
        puts2("*** WARNING - Unable to locate div(:id, \"" + sObjectIdentifier + "\") on page.", "WARN")
        
        if(bSaveIssues)
          # Save an image capture of the current web page window as a BMP
          #self.save_screencapture(sCaptureFileNamePrefix )
          
          # Save the HTML contents of the current web page to a file
          self.save_html(sCaptureFileNamePrefix)
        end
        
      end # Verify the specified object exists on the page
    end # Validate text message
    
    # Return status flag
    return bStatus
    
  end # Method - is_text_in_div_id?
  
  alias isTextIn_DivID? is_text_in_div_id?
  
  #=============================================================================#
  #--
  # Method: is_text_in_div_index?(...)
  #
  #++
  #
  # Description: Verifies if a string is present in a div on the page.
  #              The div is identified by its index.
  #              The specified object is searched to see if the expected text exists.
  #              If the expected text is not found, it optionally saves the HTML
  #
  # Returns: BOOLEAN - true if found, otherwise returns false
  #
  # Syntax:
  #         sExpectedText = STRING - The expected text string
  #         iObjectIdentifier = STRING - Div's index that hold the expected text (a number not a string)
  #         bSaveIssues = BOOLEAN - true = Save a screen capture and HTML page if match not found.
  #                                 false = don't save
  #         sCaptureFileNamePrefix = STRING - Name to be pre-pended to the file name of any HTML saves
  #
  # Usage Examples:
  #                   browser = Watir::Browser.new
  #                   browser.goto("www.mypage.html")
  #                   bFound = browser.is_text_in_div_index?("Some Text", 1, false, "Issue" )
  #
  #=============================================================================#
  def is_text_in_div_index?(sExpectedText, iObjectIdentifier, bSaveIssues=false, sCaptureFileNamePrefix="")
    
    if($VERBOSE == true)
      puts2("Parameters - is_text_in_div_index?:")
      puts2("  sExpectedText: " + sExpectedText)
      puts2("  iObjectIdentifier: " + iObjectIdentifier.to_s)
      puts2("  bSaveIssues: " + bSaveIssues.to_s)
      puts2("  sCaptureFileNamePrefix: " + sCaptureFileNamePrefix)
    end
    
    # Clear status flag
    bStatus = false
    
    # Disallow negative numbers for the index
    if(iObjectIdentifier < 0)
      iObjectIdentifier = 0
    end
    
    # Validate text message
    if((sExpectedText.upcase != "NIL") && (iObjectIdentifier >= 1))
      
      sExpectedText = sExpectedText.strip
      
      if(self.div(:index, iObjectIdentifier.adjust_index).exists?) # Verify the specified object exists on the page
        
        if($VERBOSE == true)
          puts2("Searching for text: " + sExpectedText + " in div: " + iObjectIdentifier.to_s)
        end
        
        if((self.div(:index, iObjectIdentifier.adjust_index).text) =~ /#{sExpectedText}/) # Perform verification
          
          # Set status flag
          bStatus = true
          
          if($VERBOSE == true)
            puts2("    Text Verified: " + sExpectedText)
          end
          
        else # Text verification failed
          
          puts2("*** WARNING - Verifying text", "WARN")
          puts2("     Expected: " + sExpectedText, "WARN")
          puts2("     Actual:   " + self.div(:index, iObjectIdentifier.adjust_index).text.strip, "WARN")
          
          if(bSaveIssues)
            # Save the HTML <body> contents of the current web page to a file
            self.save_html(sCaptureFileNamePrefix)
          end
          
        end # Perform verification
      else # Verify the specified object exists on the page
        
        puts2("*** WARNING - Unable to locate div(:index, \"" + iObjectIdentifier.adjust_index.to_s + "\") on page.", "WARN")
        
        if(bSaveIssues)
          # Save an image capture of the current web page window as a BMP
          #self.save_screencapture(sCaptureFileNamePrefix )
          
          # Save the HTML contents of the current web page to a file
          self.save_html(sCaptureFileNamePrefix)
        end
        
      end # Verify the specified object exists on the page
    end # Validate text message
    
    # Return status flag
    return bStatus
    
  end # Method - is_text_in_div_index?
  
  alias isTextIn_DivIndex? is_text_in_div_index?
  
  #=============================================================================#
  #--
  # Method: is_text_in_div_xpath?(...)
  #
  #++
  #
  # Description: Verifies if a string is present in a div on the page.
  #              The div is identified by its xpath.
  #              The specified object is searched to see if it contains the expected text.
  #              If the expected text is not found, it optionally saves the HTML
  #
  # Returns: BOOLEAN - true if found, otherwise returns false
  #
  # Syntax:
  #         sExpectedText = STRING -  The expected text string
  #         sObjectIdentifier = STRING - div's xpath that hold the expected text
  #         bSaveIssues = BOOLEAN - true = Save a screen capture and HTML page if match not found.
  #                                 false = don't save
  #         sCaptureFileNamePrefix = STRING - Name to be pre-pended to the file name of any HTML saves
  #
  # Usage Examples:
  #                   browser = Watir::Browser.new
  #                   browser.goto("www.mypage.html")
  #                   bFound = browser.is_text_in_div_xpath?("Some Text", "xpath", false, "Issue" )
  #
  #=============================================================================#
  def is_text_in_div_xpath?(sExpectedText, sObjectIdentifier, bSaveIssues=false, sCaptureFileNamePrefix="")
    
    if($VERBOSE == true)
      puts2("Parameters - is_text_in_div_xpath?:")
      puts2("  sExpectedText: " + sExpectedText)
      puts2("  sObjectIdentifier: " + sObjectIdentifier)
      puts2("  bSaveIssues: " + bSaveIssues.to_s)
      puts2("  sCaptureFileNamePrefix: " + sCaptureFileNamePrefix)
    end
    
    # Clear status flag
    bStatus = false
    
    # Validate text message
    if((sExpectedText.upcase != "NIL") && (sObjectIdentifier.upcase != "NIL"))
      
      sExpectedText = sExpectedText.strip
      
      if(self.div(:xpath, sObjectIdentifier).exists?) # Verify the specified object exists on the page
        
        if($VERBOSE == true)
          puts2("Searching for text: " + sExpectedText + " in class: " + sObjectIdentifier)
        end
        
        if((self.div(:xpath, sObjectIdentifier).text) =~ /#{sExpectedText}/) # Perform verification
          
          # Set status flag
          bStatus = true
          
          if($VERBOSE == true)
            puts2("    Text Verified: " + sExpectedText)
          end
          
        else # Text verification failed
          
          puts2("*** WARNING - Verifying text", "WARN")
          puts2("     Expected: " + sExpectedText, "WARN")
          puts2("     Actual:   " + self.div(:xpath, sObjectIdentifier).text.strip, "WARN")
          
          if(bSaveIssues)
            # Save the HTML <body> contents of the current web page to a file
            self.save_html(sCaptureFileNamePrefix)
          end
          
        end # Perform verification
      else # Verify the specified object exists on the page
        
        puts2("*** WARNING - Unable to locate div(:xpath, \"" + sObjectIdentifier + "\") on page.", "WARN")
        
        if(bSaveIssues)
          # Save an image capture of the current web page window as a BMP
          #self.save_screencapture(sCaptureFileNamePrefix )
          
          # Save the HTML contents of the current web page to a file
          self.save_html(sCaptureFileNamePrefix)
        end
        
      end # Verify the specified object exists on the page
    end # Validate text message
    
    # Return status flag
    return bStatus
    
  end # Method - is_text_in_div_xpath?
  
  alias isTextIn_DivXpath? is_text_in_div_xpath?
  
  #=============================================================================#
  #--
  # Method: is_text_in_span_class?(...)
  #
  #++
  #
  # Description: Verifies if a string is present in a span on the page.
  #              The span is identified by its class name.
  #              The specified object is searched to see if it contains the expected text.
  #              If the expected text is not found, it optionally saves the HTML
  #
  # Returns: BOOLEAN - true if found, otherwise returns false
  #
  # Syntax: sExpectedText = STRING - The expected text string
  #         sObjectIdentifier = STRING - Span's class that hold the expected text
  #         bSaveIssues = BOOLEAN - true = Save a screen capture and HTML page if match not found.
  #                                 false = don't save
  #         sCaptureFileNamePrefix = STRING - Name to be pre-pended to the file name of any HTML saves
  #
  # Usage Examples:
  #                   browser = Watir::Browser.new
  #                   browser.goto("www.mypage.html")
  #                   bFound = browser.is_text_in_span_class?("Some Text", "main_span", false, "Issue" )
  #
  #=============================================================================#
  def is_text_in_span_class?(sExpectedText, sObjectIdentifier, bSaveIssues=false, sCaptureFileNamePrefix="")
    
    if($VERBOSE == true)
      puts2("Parameters - is_text_in_span_class?:")
      puts2("  sExpectedText: " + sExpectedText)
      puts2("  sObjectIdentifier: " + sObjectIdentifier)
      puts2("  bSaveIssues: " + bSaveIssues.to_s)
      puts2("  sCaptureFileNamePrefix: " + sCaptureFileNamePrefix)
    end
    
    # Clear status flag
    bStatus = false
    
    # Validate text message
    if((sExpectedText.upcase != "NIL") && (sObjectIdentifier.upcase != "NIL"))
      
      sExpectedText = sExpectedText.strip
      
      if(self.span(:class, sObjectIdentifier).exists?) # Verify the specified object exists on the page
        
        if($VERBOSE == true)
          puts2("Searching for text: " + sExpectedText + " in span: " + sObjectIdentifier)
        end
        
        if((self.span(:class, sObjectIdentifier).text) =~ /#{sExpectedText}/) # Perform verification
          
          # Set status flag
          bStatus = true
          
          if($VERBOSE == true)
            puts2("    Text Verified: " + sExpectedText)
          end
          
        else # Text verification failed
          
          puts2("*** WARNING - Verifying text", "WARN")
          puts2("     Expected: " + sExpectedText, "WARN")
          puts2("     Actual:   " + self.span(:class, sObjectIdentifier).text.strip, "WARN")
          
          if(bSaveIssues)
            # Save the HTML <body> contents of the current web page to a file
            self.save_html(sCaptureFileNamePrefix)
          end
          
        end # Perform verification
      else # Verify the specified object exists on the page
        
        puts2("*** WARNING - Unable to locate span(:class, \"" + sObjectIdentifier + "\") on page.", "WARN")
        
        if(bSaveIssues)
          # Save an image capture of the current web page window as a BMP
          #self.save_screencapture(sCaptureFileNamePrefix )
          
          # Save the HTML contents of the current web page to a file
          self.save_html(sCaptureFileNamePrefix)
        end
        
      end # Verify the specified object exists on the page
    end # Validate text message
    
    # Return status flag
    return bStatus
    
  end # Method - is_text_in_span_class?
  
  alias isTextIn_SpanClass? is_text_in_span_class?
  
  #=============================================================================#
  #--
  # Method: is_text_in_span_id?(...)
  #
  #++
  #
  # Description: Verifies if a string is present in a span on the page.
  #              The span is identified by its id.
  #              The specified object is searched to see if it contains the expected text.
  #              If the expected text is not found, it optionally saves the HTML
  #
  # Returns: BOOLEAN - true if found, otherwise returns false
  #
  # Syntax: sExpectedText = STRING - The expected text string
  #         sObjectIdentifier = STRING - Span's ID that hold the expected text
  #         bSaveIssues = BOOLEAN - true = Save a screen capture and HTML page if match not found.
  #                                 false = don't save
  #         sCaptureFileNamePrefix = STRING - Name to be pre-pended to the file name of any HTML saves
  #
  # Usage Examples:
  #                   browser = Watir::Browser.new
  #                   browser.goto("www.mypage.html")
  #                   bFound = is_text_in_span_id?("Some Text", "main_spanid", false, "Issue" )
  #
  #=============================================================================#
  def is_text_in_span_id?(sExpectedText, sObjectIdentifier, bSaveIssues=false, sCaptureFileNamePrefix="")
    
    if($VERBOSE == true)
      puts2("Parameters - is_text_in_span_id?:")
      puts2("  sExpectedText: " + sExpectedText)
      puts2("  sObjectIdentifier: " + sObjectIdentifier)
      puts2("  bSaveIssues: " + bSaveIssues.to_s)
      puts2("  sCaptureFileNamePrefix: " + sCaptureFileNamePrefix)
    end
    
    # Clear status flag
    bStatus = false
    
    # Validate text message
    if((sExpectedText.upcase != "NIL") && (sObjectIdentifier.upcase != "NIL"))
      
      sExpectedText = sExpectedText.strip
      
      if(self.span(:id, sObjectIdentifier).exists?) # Verify the specified object exists on the page
        
        if($VERBOSE == true)
          puts2("Searching for text: " + sExpectedText + " in span: " + sObjectIdentifier)
        end
        
        if((self.span(:id, sObjectIdentifier).text) =~ /#{sExpectedText}/) # Perform verification
          
          # Set status flag
          bStatus = true
          
          if($VERBOSE == true)
            puts2("    Text Verified: " + sExpectedText)
          end
          
        else # Text verification failed
          
          puts2("*** WARNING - Verifying text", "WARN")
          puts2("     Expected: " + sExpectedText, "WARN")
          puts2("     Actual:   " + self.span(:id, sObjectIdentifier).text.strip, "WARN")
          
          if(bSaveIssues)
            # Save an image capture of the current web page window as a BMP
            #self.save_screencapture(sCaptureFileNamePrefix)
            
            # Save the HTML <body> contents of the current web page to a file
            self.save_html(sCaptureFileNamePrefix)
          end
          
        end # Perform verification
      else # Verify the specified object exists on the page
        
        puts2("*** WARNING - Unable to locate span(:id, \"" + sObjectIdentifier + "\") on page.", "WARN")
        
        if(bSaveIssues)
          # Save the HTML contents of the current web page to a file
          self.save_html(sCaptureFileNamePrefix)
        end
        
      end # Verify the specified object exists on the page
    end # Validate text message
    
    # Return status flag
    return bStatus
    
  end # Method - is_text_in_span_id?
  
  alias isTextIn_SpanID? is_text_in_span_id?
  
  #=============================================================================#
  #--
  # Method: is_text_in_span_index?(...)
  #
  #++
  #
  # Description: Verifies if a string is present in a span on the page.
  #              The span is identified by its index.
  #              The specified object is searched to see if the expected text exists.
  #              If the expected text is not found, it optionally saves the HTML
  #
  # Returns: BOOLEAN - true if found, otherwise returns false
  #
  # Syntax: sExpectedText = STRING - The expected text string
  #         iObjectIdentifier = STRING - Span's index that hold the expected text (a number not a string)
  #         bSaveIssues = BOOLEAN - true = Save a screen capture and HTML page if match not found.
  #                                 false = don't save
  #         sCaptureFileNamePrefix = STRING - Name to be pre-pended to the file name of any HTML saves
  #
  # Usage Examples:
  #                   browser = Watir::Browser.new
  #                   browser.goto("www.mypage.html")
  #                   bFound = is_text_in_span_index?("Some Text", 1, false, "Issue" )
  #
  #=============================================================================#
  def is_text_in_span_index?(sExpectedText, iObjectIdentifier, bSaveIssues=false, sCaptureFileNamePrefix="")
    
    if($VERBOSE == true)
      puts2("Parameters - is_text_in_span_index?:")
      puts2("  sExpectedText: " + sExpectedText)
      puts2("  iObjectIdentifier: " + iObjectIdentifier.to_s)
      puts2("  bSaveIssues: " + bSaveIssues.to_s)
      puts2("  sCaptureFileNamePrefix: " + sCaptureFileNamePrefix)
    end
    
    # Clear status flag
    bStatus = false
    
    # Disallow negative numbers for the index
    if(iObjectIdentifier < 0)
      iObjectIdentifier = 0
    end
    
    # Validate text message
    if((sExpectedText.upcase != "NIL") && (iObjectIdentifier >= 1))
      
      sExpectedText = sExpectedText.strip
      
      if(self.span(:index, iObjectIdentifier.adjust_index).exists?) # Verify the specified object exists on the page
        
        if($VERBOSE == true)
          puts2("Searching for text: " + sExpectedText + " in span: " + iObjectIdentifier.to_s)
        end
        
        if((self.span(:index, iObjectIdentifier.adjust_index).text) =~ /#{sExpectedText}/) # Perform verification
          
          # Set status flag
          bStatus = true
          
          if($VERBOSE == true)
            puts2("    Text Verified: " + sExpectedText)
          end
          
        else # Text verification failed
          
          puts2("*** WARNING - Verifying text", "WARN")
          puts2("     Expected: " + sExpectedText, "WARN")
          puts2("     Actual:   " + self.span(:index, iObjectIdentifier.adjust_index).text.strip, "WARN")
          
          if(bSaveIssues)
            # Save the HTML <body> contents of the current web page to a file
            self.save_html(sCaptureFileNamePrefix)
          end
          
        end # Perform verification
      else # Verify the specified object exists on the page
        
        puts2("*** WARNING - Unable to locate span(:index, \"" + iObjectIdentifier.adjust_index.to_s + "\") on page.", "WARN")
        
        if(bSaveIssues)
          # Save an image capture of the current web page window as a BMP
          #self.save_screencapture(sCaptureFileNamePrefix )
          
          # Save the HTML contents of the current web page to a file
          self.save_html(sCaptureFileNamePrefix)
        end
        
      end # Verify the specified object exists on the page
    end # Validate text message
    
    # Return status flag
    return bStatus
    
  end # Method - is_text_in_span_index?
  
  alias isTextIn_SpanIndex? is_text_in_span_index?
  
  
  #=============================================================================#
  #--
  # Method: is_text_in_span_xpath?(...)
  #
  #++
  #
  # Description: Verifies if a string is present in a span on the page.
  #              The span is identified by its xpath.
  #              The specified object is searched to see if it contains the expected text.
  #              If the expected text is not found, it optionally saves the HTML
  #
  # Returns: BOOLEAN - true if found, otherwise returns false
  #
  # Syntax: sExpectedText = STRING - The expected text string
  #         sObjectIdentifier = STRING - Span's xpath that hold the expected text
  #         bSaveIssues = BOOLEAN - true = Save a screen capture and HTML page if match not found.
  #                                 false = don't save
  #         sCaptureFileNamePrefix = STRING - Name to be pre-pended to the file name of any HTML saves
  #
  # Usage Examples:
  #                   browser = Watir::Browser.new
  #                   browser.goto("www.mypage.html")
  #                   bFound = is_text_in_span_xpath?("Some Text", "xpath", false, "Issue" )
  #
  #=============================================================================#
  def is_text_in_span_xpath?(sExpectedText, sObjectIdentifier, bSaveIssues=false, sCaptureFileNamePrefix="")
    
    if($VERBOSE == true)
      puts2("Parameters - is_text_in_span_xpath?:")
      puts2("  sExpectedText: " + sExpectedText)
      puts2("  sObjectIdentifier: " + sObjectIdentifier)
      puts2("  bSaveIssues: " + bSaveIssues.to_s)
      puts2("  sCaptureFileNamePrefix: " + sCaptureFileNamePrefix)
    end
    
    # Clear status flag
    bStatus = false
    
    # Validate text message
    if((sExpectedText.upcase != "NIL") && (sObjectIdentifier.upcase != "NIL"))
      
      sExpectedText = sExpectedText.strip
      
      if(self.span(:xpath, sObjectIdentifier).exists?) # Verify the specified object exists on the page
        
        if($VERBOSE == true)
          puts2("Searching for text: " + sExpectedText + " in span: " + sObjectIdentifier)
        end
        
        if((self.span(:xpath, sObjectIdentifier).text) =~ /#{sExpectedText}/) # Perform verification
          
          # Set status flag
          bStatus = true
          
          if($VERBOSE == true)
            puts2("    Text Verified: " + sExpectedText)
          end
          
        else # Text verification failed
          
          puts2("*** WARNING - Verifying text", "WARN")
          puts2("     Expected: " + sExpectedText, "WARN")
          puts2("     Actual:   " + self.span(:xpath, sObjectIdentifier).text.strip, "WARN")
          
          if(bSaveIssues)
            # Save the HTML <body> contents of the current web page to a file
            self.save_html(sCaptureFileNamePrefix)
          end
          
        end # Perform verification
      else # Verify the specified object exists on the page
        
        puts2("*** WARNING - Unable to locate span(:xpath, \"" + sObjectIdentifier + "\") on page.", "WARN")
        
        if(bSaveIssues)
          # Save an image capture of the current web page window as a BMP
          #self.save_screencapture(sCaptureFileNamePrefix )
          
          # Save the HTML contents of the current web page to a file
          self.save_html(sCaptureFileNamePrefix)
        end
        
      end # Verify the specified object exists on the page
    end # Validate text message
    
    # Return status flag
    return bStatus
    
  end # Method - is_text_in_span_xpath?
  
  alias isTextIn_SpanXpath? is_text_in_span_xpath?
  
  
  #=============================================================================#
  #--
  # Method: is_text_in_table_class?(...)
  #
  #++
  #
  # Description: Verifies if a string is present in a table on the page.
  #              The table is identified by its class name.
  #              The specified object is searched to see if it contains the expected text.
  #              If the expected text is not found, it optionally saves the HTML
  #
  # Returns: BOOLEAN - true if found, otherwise returns false
  #
  # Syntax: sExpectedText = STRING - The expected text string
  #         sObjectIdentifier = STRING - Table's class that hold the expected text
  #         bSaveIssues = BOOLEAN - true = Save a screen capture and HTML page if match not found.
  #                                 false = don't save
  #         sCaptureFileNamePrefix = STRING - Name to be pre-pended to the file name of any HTML saves
  #
  # Usage Examples:
  #                   browser = Watir::Browser.new
  #                   browser.goto("www.mypage.html")
  #                   bFound = browser.is_text_in_table_class?("Some Text", "main_table", false, "Issue" )
  #
  #=============================================================================#
  def is_text_in_table_class?(sExpectedText, sObjectIdentifier, bSaveIssues=false, sCaptureFileNamePrefix="")
    
    if($VERBOSE == true)
      puts2("Parameters - is_text_in_table_class?:")
      puts2("  sExpectedText: " + sExpectedText)
      puts2("  sObjectIdentifier: " + sObjectIdentifier)
      puts2("  bSaveIssues: " + bSaveIssues.to_s)
      puts2("  sCaptureFileNamePrefix: " + sCaptureFileNamePrefix)
    end
    
    # Clear status flag
    bStatus = false
    
    # Validate text message
    if((sExpectedText.upcase != "NIL") && (sObjectIdentifier.upcase != "NIL"))
      
      sExpectedText = sExpectedText.strip
      
      if(self.table(:class, sObjectIdentifier).exists?) # Verify the specified object exists on the page
        
        if($VERBOSE == true)
          puts2("Searching for text: " + sExpectedText + " in table: " + sObjectIdentifier)
        end
        
        if((self.table(:class, sObjectIdentifier).text) =~ /#{sExpectedText}/) # Perform verification
          
          # Set status flag
          bStatus = true
          
          if($VERBOSE == true)
            puts2("    Text Verified: " + sExpectedText)
          end
          
        else # Text verification failed
          
          puts2("*** WARNING - Verifying text", "WARN")
          puts2("     Expected: " + sExpectedText, "WARN")
          puts2("     Actual:   " + self.table(:class, sObjectIdentifier).text.strip, "WARN")
          
          if(bSaveIssues)
            # Save the HTML <body> contents of the current web page to a file
            self.save_html(sCaptureFileNamePrefix)
          end
          
        end # Perform verification
      else # Verify the specified object exists on the page
        
        puts2("*** WARNING - Unable to locate span(:class, \"" + sObjectIdentifier + "\") on page.", "WARN")
        
        if(bSaveIssues)
          # Save an image capture of the current web page window as a BMP
          #self.save_screencapture(sCaptureFileNamePrefix )
          
          # Save the HTML contents of the current web page to a file
          self.save_html(sCaptureFileNamePrefix)
        end
        
      end # Verify the specified object exists on the page
    end # Validate text message
    
    # Return status flag
    return bStatus
    
  end # Method - is_text_in_table_class?
  
  alias isTextIn_TableClass? is_text_in_table_class?
  
  #=============================================================================#
  #--
  # Method: is_text_in_table_id?(...)
  #
  #++
  #
  # Description: Verifies if a string is present in a table on the page.
  #              The table is identified by its id.
  #              The specified object is searched to see if it contains the expected text.
  #              If the expected text is not found, it optionally saves the HTML
  #
  # Returns: BOOLEAN - true if found, otherwise returns false
  #
  # Syntax: sExpectedText = STRING - The expected text string
  #         sObjectIdentifier = STRING - Table's ID that hold the expected text
  #         bSaveIssues = BOOLEAN - true = Save a screen capture and HTML page if match not found.
  #                                 false = don't save
  #         sCaptureFileNamePrefix = STRING - Name to be pre-pended to the file name of any HTML saves
  #
  # Usage Examples:
  #                   browser = Watir::Browser.new
  #                   browser.goto("www.mypage.html")
  #                   bFound = browser.is_text_in_table_id?("Some Text", "main_tableid", false, "Issue" )
  #
  #=============================================================================#
  def is_text_in_table_id?(sExpectedText, sObjectIdentifier, bSaveIssues=false, sCaptureFileNamePrefix="")
    
    if($VERBOSE == true)
      puts2("Parameters - is_text_in_table_id?:")
      puts2("  sExpectedText: " + sExpectedText)
      puts2("  sObjectIdentifier: " + sObjectIdentifier)
      puts2("  bSaveIssues: " + bSaveIssues.to_s)
      puts2("  sCaptureFileNamePrefix: " + sCaptureFileNamePrefix)
    end
    
    # Clear status flag
    bStatus = false
    
    # Validate text message
    if((sExpectedText.upcase != "NIL") && (sObjectIdentifier.upcase != "NIL"))
      
      sExpectedText = sExpectedText.strip
      
      if(self.table(:id, sObjectIdentifier).exists?) # Verify the specified object exists on the page
        
        if($VERBOSE == true)
          puts2("Searching for text: " + sExpectedText + " in table: " + sObjectIdentifier)
        end
        
        if((self.table(:id, sObjectIdentifier).text) =~ /#{sExpectedText}/) # Perform verification
          
          # Set status flag
          bStatus = true
          
          if($VERBOSE == true)
            puts2("    Text Verified: " + sExpectedText)
          end
          
        else # Text verification failed
          
          puts2("*** WARNING - Verifying text", "WARN")
          puts2("     Expected: " + sExpectedText, "WARN")
          puts2("     Actual:   " + self.table(:id, sObjectIdentifier).text.strip, "WARN")
          
          if(bSaveIssues)
            # Save the HTML <body> contents of the current web page to a file
            self.save_html(sCaptureFileNamePrefix)
          end
          
        end # Perform verification
      else # Verify the specified object exists on the page
        
        puts2("*** WARNING - Unable to locate table(:id, \"" + sObjectIdentifier + "\") on page.", "WARN")
        
        if(bSaveIssues)
          # Save an image capture of the current web page window as a BMP
          #self.save_screencapture(sCaptureFileNamePrefix )
          
          # Save the HTML contents of the current web page to a file
          self.save_html(sCaptureFileNamePrefix)
        end
        
      end # Verify the specified object exists on the page
    end # Validate text message
    
    # Return status flag
    return bStatus
    
  end # Method - is_text_in_table_id?
  
  alias isTextIn_TableID? is_text_in_table_id?
  
  #=============================================================================#
  #--
  # Method: is_text_in_table_index?(...)
  #
  #++
  #
  # Description: Verifies if a string is present in a table on the page.
  #              The table is identified by its index.
  #              The specified object is searched to see if the expected text exists.
  #              If the expected text is not found, it optionally saves the HTML
  #
  # Returns: BOOLEAN - true if found, otherwise returns false
  #
  # Syntax: sExpectedText = STRING - The expected text string
  #         iObjectIdentifier = STRING - Table's index that hold the expected text (a number not a string)
  #         bSaveIssues = BOOLEAN - true = Save a screen capture and HTML page if match not found.
  #                                 false = don't save
  #         sCaptureFileNamePrefix = STRING - Name to be pre-pended to the file name of any HTML saves
  #
  # Usage Examples:
  #                   browser = Watir::Browser.new
  #                   browser.goto("www.mypage.html")
  #                   bFound = browsesr.is_text_in_table_index?("Some Text", 1, false, "Issue" )
  #
  #=============================================================================#
  def is_text_in_table_index?(sExpectedText, iObjectIdentifier, bSaveIssues=false, sCaptureFileNamePrefix="")
    
    if($VERBOSE == true)
      puts2("Parameters - is_text_in_table_index?:")
      puts2("  sExpectedText: " + sExpectedText)
      puts2("  iObjectIdentifier: " + iObjectIdentifier.to_s)
      puts2("  bSaveIssues: " + bSaveIssues.to_s)
      puts2("  sCaptureFileNamePrefix: " + sCaptureFileNamePrefix)
    end
    
    # Clear status flag
    bStatus = false
    
    # Disallow negative numbers for the index
    if(iObjectIdentifier < 0)
      iObjectIdentifier = 0
    end
    
    # Validate text message
    if((sExpectedText.upcase != "NIL") && (iObjectIdentifier >= 1))
      
      sExpectedText = sExpectedText.strip
      
      if(self.table(:index, iObjectIdentifier.adjust_index).exists?) # Verify the specified object exists on the page
        
        if($VERBOSE == true)
          puts2("Searching for text: " + sExpectedText + " in table: " + iObjectIdentifier.to_s)
        end
        
        if((self.table(:index, iObjectIdentifier.adjust_index).text) =~ /#{sExpectedText}/) # Perform verification
          
          # Set status flag
          bStatus = true
          
          if($VERBOSE == true)
            puts2("    Text Verified: " + sExpectedText)
          end
          
        else # Text verification failed
          
          puts2("*** WARNING - Verifying text", "WARN")
          puts2("     Expected: " + sExpectedText, "WARN")
          puts2("     Actual:   " + self.table(:index, iObjectIdentifier.adjust_index).text.strip, "WARN")
          
          if(bSaveIssues)
            # Save the HTML <body> contents of the current web page to a file
            self.save_html(sCaptureFileNamePrefix)
          end
          
        end # Perform verification
      else # Verify the specified object exists on the page
        
        puts2("*** WARNING - Unable to locate table(:index, \"" + iObjectIdentifier.adjust_index.to_s + "\") on page.", "WARN")
        
        if(bSaveIssues)
          # Save an image capture of the current web page window as a BMP
          #self.save_screencapture(sCaptureFileNamePrefix )
          
          # Save the HTML contents of the current web page to a file
          self.save_html(sCaptureFileNamePrefix)
        end
        
      end # Verify the specified object exists on the page
    end # Validate text message
    
    # Return status flag
    return bStatus
    
  end # Method - is_text_in_table_index?
  
  alias isTextIn_TableIndex? is_text_in_table_index?
  
  #=============================================================================#
  #--
  # Method: is_text_in_table_name?(...)
  #
  #++
  #
  # Description: Verifies if a string is present in a table on the page.
  #              The table is identified by its name.
  #              The specified object is searched to see if it contains the expected text.
  #              If the expected text is not found, it optionally saves the HTML
  #
  # Returns: BOOLEAN - true if found, otherwise returns false
  #
  # Syntax: sExpectedText = STRING - The expected text string
  #         sObjectIdentifier = STRING - Table's name that hold the expected text
  #         bSaveIssues = BOOLEAN - true = Save a screen capture and HTML page if match not found.
  #                                 false = don't save
  #         sCaptureFileNamePrefix = STRING - Name to be pre-pended to the file name of any HTML saves
  #
  # Usage Examples:
  #                   browser = Watir::Browser.new
  #                   browser.goto("www.mypage.html")
  #                   bFound = browser.is_text_in_table_name?("Some Text", "main_tablename", false, "Issue" )
  #
  #=============================================================================#
  def is_text_in_table_name?(sExpectedText, sObjectIdentifier, bSaveIssues=false, sCaptureFileNamePrefix="")
    
    if($VERBOSE == true)
      puts2("Parameters - is_text_in_table_name?:")
      puts2("  sExpectedText: " + sExpectedText)
      puts2("  sObjectIdentifier: " + sObjectIdentifier)
      puts2("  bSaveIssues: " + bSaveIssues.to_s)
      puts2("  sCaptureFileNamePrefix: " + sCaptureFileNamePrefix)
    end
    
    if(is_webdriver? == true)
      puts2("Watir::Element tag attribute :name - Not supported in Watir WebDriver")
      return false
    end
    
    # Clear status flag
    bStatus = false
    
    # Validate text message
    if((sExpectedText.upcase != "NIL") && (sObjectIdentifier.upcase != "NIL"))
      
      sExpectedText = sExpectedText.strip
      
      #if(self.table(:tag_name, sObjectIdentifier).exists?) # Verify the specified object exists on the page
      if(self.table(:name, sObjectIdentifier).exists?) # Verify the specified object exists on the page
        
        if($VERBOSE == true)
          puts2("Searching for text: " + sExpectedText + " in table: " + sObjectIdentifier)
        end
        
        #if(self.table(:tag_name, sObjectIdentifier).text =~ /#{sExpectedText}/) # Perform verification
        if(self.table(:name, sObjectIdentifier).text =~ /#{sExpectedText}/) # Perform verification
          
          # Set status flag
          bStatus = true
          
          if($VERBOSE == true)
            puts2("    Text Verified: " + sExpectedText)
          end
          
        else # Text verification failed
          
          puts2("*** WARNING - Verifying text", "WARN")
          puts2("     Expected: " + sExpectedText, "WARN")
          #puts2("     Actual:   " + self.table(:tag_name, sObjectIdentifier).text.strip, "WARN")
          puts2("     Actual:   " + self.table(:name, sObjectIdentifier).text.strip, "WARN")
          
          if(bSaveIssues)
            # Save the HTML <body> contents of the current web page to a file
            self.save_html(sCaptureFileNamePrefix)
          end
          
        end # Perform verification
      else # Verify the specified object exists on the page
        
        #puts2("*** WARNING - Unable to locate table(:tag_name, \"" + sObjectIdentifier + "\") on page.", "WARN")
        puts2("*** WARNING - Unable to locate table(:name, \"" + sObjectIdentifier + "\") on page.", "WARN")
        
        if(bSaveIssues)
          # Save an image capture of the current web page window as a BMP
          #self.save_screencapture(sCaptureFileNamePrefix )
          
          # Save the HTML contents of the current web page to a file
          self.save_html(sCaptureFileNamePrefix)
        end
        
      end # Verify the specified object exists on the page
    end # Validate text message
    
    # Return status flag
    return bStatus
    
  end # Method - is_text_in_table_name?
  
  alias isTextIn_TableName? is_text_in_table_name?
  
  #=============================================================================#
  #--
  # Method is_url_accessible?(sURL)
  #++
  #
  # Description: Tries to access a specified URL with the current Global Browser.
  #              It checks for various http errors, and then closes the Browser
  #
  # Returns: BOOLEAN - true if the URL was accessible, otherwise returns false
  #
  # Syntax: sURL = STRING - Full URL of the site to be checked for accessibility
  #
  # Usage examples:
  #                  assert(browser.url_accessible?("http://google.com"))
  #=============================================================================#
  def is_url_accessible?(sURL)
    
    begin # Check the URL
      
      # Set the return flag, any failure will clear it
      bReturnValue = true
      
      # Browse the specified URL
      self.goto(sURL)
      
      sleep 2 # Allow time for the page to load
      
      if((self.check_for_http_error()) || (self.title.include?('cannot display')) ||(self.text.include?('The page cannot be displayed')) || (self.text.include?("HTTP Status 404")) || (self.text.include?("cannot display the webpage")) || (self.text.include?("Service Temporarily Unavailable")) )
        
        # Clear the flag
        bReturnValue = false
        
        return bReturnValue
        
      end
      
    rescue => e
      
      puts2("*** WARNING and Backtrace: " + e.message + "\n" + e.backtrace.join("\n"), "WARN")
      
    ensure
      
    end # Check the URL
    
    return bReturnValue
    
  end # END - Method - is_url_accessible?()
  
  
  #=============================================================================#
  #--
  # Method: kill_browsers(...)
  #
  #++
  #
  # Description: Use O/S commands to kill any open browser processes for only
  #              the type of browser that Watir is currently set to use.
  #
  #              A different procedure is used for each Operating System
  #
  # Returns: N/A
  #
  # Syntax: N/A
  #
  #
  # Usage examples:
  #               kill_browsers()
  #
  #=============================================================================#
  def kill_browsers()
    
=begin  watir-webdriver - missing method - options
    # Determine which type of browser is set as the current default
    sBrowserType = Watir.options[:browser]
=end
    sBrowserType = "firefox"
    
    if(is_win?) # Kill process for windows
      
      # Force any open browsers to exit (im=image, f=force, t=process tree)
      case sBrowserType
        when "chrome"
        system("taskkill /im chrome.exe /f /t >nul 2>&1")
        when "firefox"
        system("taskkill /im firefox.exe /f /t >nul 2>&1")
        when "ie"
        system("taskkill /im iexplore.exe /f /t >nul 2>&1")
        when "opera"
        system("taskkill /im opera.exe /f /t >nul 2>&1")
      end
    end # Kill process for windows
    
    
    if(is_linux?) # Kill process for linux
      
      # Force any open browsers to exit
      case sBrowserType
        when "chrome"
        #system("kill -f {ps -aef | grep chrome.exe | grep -v grep | cut -f1 -d" " | head -1}")
        when "firefox"
        #system("kill -f {ps -aef | grep firefox.exe | grep -v grep | cut -f1 -d" " | head -1}")
        when "ie"
        #system("kill -f {ps -aef | grep iexplore.exe | grep -v grep | cut -f1 -d" " | head -1}")
        when "opera"
        #system("kill -f {ps -aef | grep opera.exe | grep -v grep | cut -f1 -d" " | head -1}")
        when "safari"
        #system("kill -f {ps -aef | grep safari.exe | grep -v grep | cut -f1 -d" " | head -1}")
      end
    end
    
    if(is_osx?) # Kill process for Mac OS/X
      
      # Force any open browsers to exit
      case sBrowserType
        when "chrome"
        #system("kill -f {ps -aef | grep chrome.exe | grep -v grep | cut -f1 -d" " | head -1}")
        when "firefox"
        #system("kill -f {ps -aef | grep firefox.exe | grep -v grep | cut -f1 -d" " | head -1}")
        when "ie"
        #system("kill -f {ps -aef | grep iexplore.exe | grep -v grep | cut -f1 -d" " | head -1}")
        when "opera"
        #system("kill -f {ps -aef | grep opera.exe | grep -v grep | cut -f1 -d" " | head -1}")
        when "safari"
        #system("kill -f {ps -aef | grep safari.exe | grep -v grep | cut -f1 -d" " | head -1}")
      end
    end
    
    # Remove the global browser's Global variable, closing the browser does not remove its Global variable
    $browser=nil
    
  end
  
  
  #=============================================================================#
  #--
  # Method: parse_table_by_row(...)
  #
  #
  #++
  #
  # Description: Attempts to populate and return an array with the
  #              values in the specified table on the current page.
  #              From the first row specified to either the last row specified
  #              or to the actual last row (if no last row was specified).
  #
  # NOTE: Issues with nested tables: See Watir bug WTR-26
  #
  # Returns: ARRAY - aTableData_ByRow
  #
  # Syntax:  iTable = INTEGER - Index number of the table that holds data
  #          iFirstRow = INTEGER - Integer of the first row in the table to read
  #          iLastRow = INTEGER - Integer of the last row in the table to read
  #                               if iLastRow=nil then the last row in the
  #                               table is determined programmatically and
  #                               that value is used. In essence the actual last row.
  #           bSaveIssues = BOOLEAN - true = Save a screen capture and HTML page if match not found.
  #                                   false = don't save
  #
  #
  # Usage examples:
  #               To read table 5 from the 1st to the end of the table:
  #                   aProdAuthInfoData = browser.parse_table_by_row(5)
  #               To read table 2 from the 3rd to the 8th row:
  #                   aProdAuthInfoData = browser.parse_table_by_row(5,3,8)
  #
  # Pre-requisites: The current page must contain a table with at least one row of data.
  #                        The values of iTable, iFirstRow, iLastRow must be valid for the current page
  #=============================================================================#
  def parse_table_by_row(iTable=1, iFirstRow=1, iLastRow=-1, bSaveIssues=false)
    
    if($VERBOSE == true)
      puts2("Parameters - parse_table_by_row:")
      puts2("  iTable: " + iTable.to_s)
      puts2("  iFirstRow: " + iFirstRow.to_s)
      puts2("  iLastRow: " + iLastRow.to_s)
    end
    
    #if(is_webdriver? == true)
    #puts2("Watir method Watir::Table.row_values not supported by Watir WebDriver")
    #return []
    #end
    
    begin # Read the table contents into an array row-by-row
      
=begin  watir-webdriver - missing method - options
    # Determine which type of browser is set as the current default
    sBrowserType = Watir.options[:browser]
=end
      sBrowserType = "firefox"
      
      # Disallow negative rows
      if(iFirstRow < 1)
        iFirstRow = 1
      end
      
      
      if(iLastRow < 0) # No last row was specified to determine how many rows are in the table
        
        if((sBrowserType.downcase) == "ie")
          # Find the last row of the table that contains the date
          iLastRow = self.table(:index, iTable.adjust_index).row_count_excluding_nested_tables.to_i.adjust_index
        elsif((sBrowserType.downcase) == "firefox")
          # Find the total rows in the current table
          iLastRow = self.table(:index, iTable.adjust_index).row_count.to_i.adjust_index
        end
        
      end # No last row was specified to determine how many rows are in the table
      
      # Define empty arrays
      $aTable_DataByRow = [] # Define as global so it exists outside of the loop
      aSingleRowArray=[]
      
      for iRow in iFirstRow..iLastRow # Loop to populate the array with the contents of the table, row-by-row
        
        # Populate array with data in the current row
        # Note that the Watir method row_values fails if there are either Buttons or no columns in the row
        aSingleRowArray = [self.table(:index, iTable.adjust_index).row_values(iRow.adjust_index)]
        
        if($VERBOSE == true)
          puts2("Array aSingleRowArray length: " + aSingleRowArray.length.adjust_index.to_s)
          puts2("Contents of array: aSingleRowArray")
          puts2(aSingleRowArray)
        end
        
        # Append data in the array for the current row, to the array that holds the data for all rows
        $aTable_DataByRow << aSingleRowArray
        
      end # Loop to populate the array with the contents of the table, row-by-row
      
      if($VERBOSE == true)
        puts2("Array aTable_DataByRow length: " + $aTable_DataByRow.length.to_s)
        puts2("Contents of array aTable_DataByRow")
        
        # Loop through the array to output the row data
        $aTable_DataByRow.each do |record|
          puts2(record)
          puts2("_Next_Row_")
        end
        
      end
      
    rescue => e
      
      puts2("*** WARNING - Problem reading table data by row", "WARN")
      puts2("*** WARNING and Backtrace: " + e.message + "\n" + e.backtrace.join("\n"),"WARN")
      
      if(bSaveIssues)
        # Save an image capture of the current web page
        #self.save_screencapture()
        
        # Save the HTML contents of the current web page
        self.save_html()
      end
      
      # Raise the error with a custom message after the rest of the rescue actions
      raise("*** METHOD - parse_table_by_row(...)")
      
    ensure
      
      return $aTable_DataByRow
      
    end # Read the table contents into an array row-by-row
    
  end # end of method - parse_table_by_row
  
  
  #=============================================================================#
  #--
  # Function: remove_xml_brackets(...)
  #++
  #
  # Description:  Removes the brackets from Opening or Closing tags
  #               Modifies '</tag_name>'  or '<tag_name>'  to 'tag_name'
  #
  # Returns: STRING = The modified tag without the brackets
  #
  # Syntax: sTag =  STRING - The XML tags to strip of the enclosing brackets "<>"
  #
  # Usage Examples:
  #                    sTag = 'UserName'     # Tag name w/o brackets
  #                    remove_xml_brackets(sTag)  #=>  UserName
  #
  #                    sTag = '<Username>'   # Opening tag with Brackets
  #                    remove_xml_brackets(sTag)  #=>  UserName
  #
  #                    sTag = '</UserName>'  # Closing tag with Brackets
  #                    remove_xml_brackets(sTag)  #=>  UserName
  #
  #=============================================================================#
  def remove_xml_brackets(sTag)
    
    #$VERBOSE = true
    
    if($VERBOSE == true)
      puts2("Parameters - remove_xml_brackets:")
      puts2("  sTag: " + sTag)
    end
    
    # TODO: Improve to ignore brackets within the tag name
    # Remove the brackets and slash from the Closing tag
    sTag = sTag.sub('</', '')
    #sTag = sTag.sub(r'^</', '')
    
    # Remove the bracket from the Opening tag
    sTag = sTag.sub('<', '')
    #sTag = sTag.sub(r'^<', '')
    
    # Remove the trailing bracket
    sTag = sTag.sub('>', '')
    #sTag = sTag.sub(r'>$', '')
    
    if ($VERBOSE == true)
      puts2("Tag w/o brackets:  " + sTag)
    end
    
    return sTag
    
  end # END method - remove_xml_brackets()
  
  alias removeXMLBrackets remove_xml_brackets
  
  #=============================================================================#
  #--
  # Method: restart_browser(...)
  #
  #++
  #
  # Description: Close the current browser object, pause,
  #              then create and return a new browser object.
  #
  #              Any URL that the current browser is displaying is lost.
  #
  # Returns: BROWSER object
  #
  # Syntax: oBrowser = BROWSER object - The browser to be restarted
  #         bReloadURL = BOOLEAN - true - Interrogate browser to find its current URL, then point new browser at same URL
  #                                false - ignore URL of current browser, just start a new  browser.
  #
  # Usage Examples:
  #            To restart Global Browser Object:
  #                $browser = restart_browser($browser)
  #
  #            To restart local browser object (e.g. myCurrentBrowser):
  #                myRestartedBrowser = restart_browser(myCurrentBrowser)
  #
  #=============================================================================#
  def restart_browser(oBrowser, bReloadURL=false)
    
    if(bReloadURL == true)
      sURL = oBrowser.url.to_s  # Get the current URL so it can be reloaded in a new browser
    else
      sURL = "about:blank"  # Default page to load in a new browser
    end
    
=begin  watir-webdriver - missing method - options
    # Determine which type of browser is set as the current default
    sBrowserType = Watir.options[:browser]
=end
    sBrowserType = "firefox"
    
    puts2("Closing the " +  sBrowserType + " browser in the browser object.")
    
    # Is it an IE browser
    if(sBrowserType.downcase == "ie")
      oBrowser.close
      
      # Clear the Browser Object.
      # Merely closing a  Browser DOES NOT wipe out the Object.
      puts2(" Clearing the browser object")
      oBrowser = nil
      
      # Allow time to mourn the passing of the old browser.
      sleep 2  # That's long enough to mourn
      
      puts2("Starting a new browser object.")
      
      # Create a new browser object
      # Can't use start_Browser() as both local and Global Browser's may coexist, so use Waitr's method directly)
      oBrowser = Watir::Browser.start(sURL)
      
      # Allow time to celebrate the birth of the new browser.
      sleep 2  # That's long enough to celebrate
      
    end # Is it an IE browser
    
    # Is it an firefox browser
    if(sBrowserType.downcase == "firefox")
      if(bReloadURL == true)
        oBrowser = oBrowser.attach(:url, sURL)
      else
        oBrowser.attach(:url, /./)
        oBrowser.goto("about:blank")
      end
    end # Is it an firefox browser
    
    return oBrowser  # Return the new browser.
    
  end # END Method - restart_browser()
  
  
  #=============================================================================#
  #--
  # Method: save_html(...)
  #
  #++
  #
  # Description: Save the HTML of the current web page to a file.
  #
  #              The file name is based on the passed in parameters and the time (dd_mmm_yyyy_hhmmss).
  #                    For example:
  #                          Page_4_Jul_2007_123001.htm
  #
  # Syntax: sFileNamePrefix = STRING - Text to prepend to the file's name
  #         sOutputDir = STRING - Path to the directory into which to save the file.
  #                                            Defaults to saving into the Window's %TEMP% or the Linux /tmp folder.
  #
  # Restrictions: The Path to the directory into which to save the file must exist.
  #
  # Usage examples: Save the HTML contents of the current web page to the default file name
  #                   browser.save_html()
  #
  #=============================================================================#
  def save_html(sFileNamePrefix="HTML_", sOutputDir="" )
    
    if($VERBOSE == true)
      puts2("Parameters - save_html:")
      puts2("  sFileNamePrefix: " + sFileNamePrefix)
      puts2("  sOutputDir: " + sOutputDir)
    end
    
    # Don't allow a blank directory
    if(sOutputDir == "")
      
      #      # Use the OS's default Temporary directory
      #       sOutputDir = find_tmp_dir()
      
      # Save to the results directory if a logger is running
      if($sLoggerResultsDir.nil?)
        # Use the OS's default Temporary directory
        sOutputDir = find_tmp_dir()
      else
        if(is_win?)
          # Correct path for windows (switch and / with \)
          sOutputDir = $sLoggerResultsDir.gsub('/', '\\')
        else
          sOutputDir = $sLoggerResultsDir
        end
      end
      
    end # Don't allow a blank directory
    
    # Combine the elements of the file name
    sFilename = sFileNamePrefix + "_" + Time.now.strftime(DATETIME_FILEFORMAT) + ".htm"
    
    sFullPathToFile = File.join(sOutputDir, sFilename)
    
    # Perform the HTML capture
    open(sFullPathToFile , 'w') { |f| f << self.html }
    
    puts2("Saved HTML to file: #{sFullPathToFile}")
    
  end # Method - save_html()
  
  
  #=============================================================================#
  #--
  # Method: save_screencapture(...)
  #
  #++
  #
  # Description: Wrapper to select and run the proper platform specific method for Windows, Linux or MAC/OSX
  #
  # Syntax: sFileNamePrefix = STRING - The left most part of the filename (Defaults to "ScreenShot")
  #
  #         bActiveWindowOnly = BOOLEAN - true  = save current window (default)
  #                                       false = save entire desktop
  #
  #         bSaveAsJpg = BOOLEAN - true  = save a  file (JPEG)
  #                                false = save a bitmap file
  #
  #         sOutputDir = STRING -  sub-directory that the file is saved under (Defaults to the user account's temp directory)
  #
  #
  # Usage Examples: To screen capture of the desktop as a JPEG file:
  #                     browser.save_screencapture()
  #
  #
  #=============================================================================#
  def save_screencapture(sFileNamePrefix="Image", bActiveWindowOnly=true, bSaveAsJpg=true, sOutputDir="")
    
    if($VERBOSE == true)
      puts2("Parameters - save_screencapture:")
      puts2("  sFileNamePrefix: " + sFileNamePrefix)
      puts2("  bActiveWindowOnly: " + bActiveWindowOnly.to_s)
      puts2("  bSaveAsJpg: " + bSaveAsJpg.to_s)
      puts2("  sOutputDir: " + sOutputDir)
    end
    
    # Is this Watir / Firewatir or WatirWebDriver
    if(is_webdriver? == false)
      # Use RUBY_PLATFORM to auto-select the proper version based on the operating system
      # Under Windows reports "mswin". under Linux it reports "linux", under Mac/OSX reports "dawrin"
      case RUBY_PLATFORM.downcase
        
        when (/mswin|window|mingw/)
        self.save_screencapture_win(sFileNamePrefix, bActiveWindowOnly, bSaveAsJpg, sOutputDir)
        
        when /linux/
        self.save_screencapture_linux(sFileNamePrefix, bActiveWindowOnly, bSaveAsJpg, sOutputDir)
        
        when /darwin/
        self.save_screencapture_mac(sFileNamePrefix, bActiveWindowOnly, bSaveAsJpg, sOutputDir)
        
      end # case
    else
      # puts2("Screen capture currently not available for Watir Web Driver")
      # TODO: develop screen capture using RAutomation on Windows.
    end # Is this Watir / Firewatir or WatirWebDriver
    
  end # END - Method - save_screencapture()
  
  
  #=============================================================================#
  #--
  # Method scroll_element_intoview(...)
  #
  #++
  #
  # Description: Uses the Watir method scrollintoview to either
  #              scroll the first or last specified HTML element into view
  #
  # HINT: Use in conjuction with Screen captures for pages that are too tall
  #       to be captured within only one image.
  #
  # Syntax: sElement = STRING - The name of the HTML element to scroll into view
  #
  #         bScrollDown = BOOLEAN - true = scroll down to the last specified element
  #                                 false = scroll up to the first specified element
  #
  # Returns:  BOOLEAN - true if successful, otherwise false
  #
  # Usage examples: When needing screen captures on a page that is too tall, but has
  #                 an image (e.g. the company logo) at the top of the page
  #                 a link (e.g. the company copyright) at the bottom of the page
  #
  #                      browser.scroll_element_intoview("image", false)
  #                      browser.save_screencapture()
  #                      browser.scroll_element_intoview("link", true)
  #                      browser.save_screencapture()
  #
  #=============================================================================#
  def scroll_element_intoview(sElement="link", bScrollDown = true)
    
    if($VERBOSE == true)
      puts2("Parameters - scroll_element_intoview:")
      puts2("  sElement: " + sElement)
      puts2("  bScrollDown: " + bScrollDown.to_s)
    end
    
    if(self.is_ie?) # Only works with IE, not Firefox
      
      case sElement.downcase
        
        
        when "button"
        if(bScrollDown)
          # Scroll the last button on web page into view
          if((self.buttons.length) > 0)
            self.button(:index, self.buttons.length.adjust_index).document.scrollintoview
          end
        else
          # Scroll the first button on web page into view
          if((self.buttons.length) > 0)
            self.button(:index, 1.adjust_index).document.scrollintoview
          end
        end # button
        
        when "checkbox"
        if(bScrollDown)
          # Scroll the last checkbox on web page into view
          if((self.checkboxes.length) > 0)
            self.checkbox(:index, self.checkboxes.length.adjust_index).document.scrollintoview
          end
        else
          # Scroll the first checkbox on web page into view
          if((self.checkboxes.length) > 0)
            self.checkbox(:index, 1.adjust_index).document.scrollintoview
          end
        end # checkbox
        
        when "file_field"
        if(bScrollDown)
          # Scroll the last file_field on web page into view
          if((self.file_fields.length) > 0)
            self.file_field(:index, self.file_fields.length.adjust_index).document.scrollintoview
          end
        else
          # Scroll the first file_field on web page into view
          if((self.file_fields.length) > 0)
            self.file_field(:index, 1.adjust_index).document.scrollintoview
          end
        end # file_field
        
        when "image"
        if(bScrollDown)
          # Scroll the last link on web page into view
          if((self.images.length) > 0)
            self.image(:index, self.images.length.adjust_index).document.scrollintoview
          end
        else
          # Scroll the first link on web page into view
          if((self.images.length) > 0)
            self.image(:index, 1.adjust_index).document.scrollintoview
          end
        end # image
        
        when  "link"
        if(bScrollDown)
          # Scroll the last link on web page into view
          if((self.links.length) > 0)
            self.link(:index, self.links.length.adjust_index).document.scrollintoview
          end
        else
          # Scroll the first link on web page into view
          if((self.links.length) > 0)
            self.link(:index, 1.adjust_index).document.scrollintoview
          end
        end # link
        
        when "map"
        if(bScrollDown)
          # Scroll the last map on web page into view
          if((self.maps.length) > 0)
            self.map(:index, self.maps.length.adjust_index).document.scrollintoview
          end
        else
          # Scroll the first map on web page into view
          if((self.maps.length) > 0)
            self.map(:index, 1.adjust_index).document.scrollintoview
          end
        end # map
        
        when "radio"
        if(bScrollDown)
          # Scroll the last radio on web page into view
          if((self.radios.length) > 0)
            self.radio(:index, self.radios.length.adjust_index).document.scrollintoview
          end
        else
          # Scroll the first radio on web page into view
          if((self.radios.length) > 0)
            self.radio(:index, 1.adjust_index).document.scrollintoview
          end
        end # select_list
        
        when "select_list"
        if(bScrollDown)
          # Scroll the last select_list on web page into view
          if((self.select_lists.length) > 0)
            self.select_list(:index, self.select_lists.length.adjust_index).document.scrollintoview
          end
        else
          # Scroll the first select_list on web page into view
          if((self.select_lists.length) > 0)
            self.select_list(:index, 1.adjust_index).document.scrollintoview
          end
        end # select_list
        
        when "text_field"
        
        if(bScrollDown)
          # Scroll the last text_field on web page into view
          if((self.text_fields.length) > 0)
            self.text_field(:index, self.text_fields.length.adjust_index).document.scrollintoview
          end
        else
          # Scroll the first text_field on web page into view
          if((self.text_fields.length) > 0)
            self.text_field(:index, 1.adjust_index).document.scrollintoview
          end
        end # text_field
        
      else # Not one of the support element types
        return false
      end # Case
      
      return true
      
    elsif(self.is_firefox?)
      return false
    end # Only works with IE, not Firefox
    
    
    
  end # Method - scroll_element_intoview()
  
  #=============================================================================#
  #--
  # Method: set_multiselect_list_by_name?(...)
  #++
  #
  # Description: Multi-selects the specified items from the specified select_list
  #              Verifies that the list exists
  #              Verifies that the item in the list exists
  #              Provides ability to clear the current selection
  #
  # Syntax: sMultiSelectListName = STRING - Case sensitive string of the multi select_list(:name, sMultiSelectListName)
  #         aSelectValue = ARRAY - Contains case sensitive STRINGs for the values to multi-select
  #                                Values of "CLEAR" or "" will clear the current multi-select list's selection set
  #
  #  Returns: BOOLEAN - true if successful, otherwise returns false
  #
  # Usage Examples:
  #            # Set a few specific:
  #                 aMyStates = [ "AK", "CA", "WY"]
  #                 assert(browser.set_multiselect_list_by_name?("state", aMyStates))
  #            # Set all values:
  #                 aAllStates = browser.select_list(:name, "state").options
  #                 assert(browser.set_multiselect_list_by_name?("state", aAllStates))
  #
  #=============================================================================#
  def set_multiselect_list_by_name?(sMultiSelectListName = nil, aSelectValues = [])
    
    if($VERBOSE == true)
      puts2("Parameters - set_multiselect_list_by_name?:")
      puts2("  sMultiSelectListName: " + sMultiSelectListName)
      puts2("  aSelectValues: " + aSelectValues.to_s)
    end
    
    # Set return value
    bReturnValue = true
    
    # Cast value to a string
    sMultiSelectListName = sMultiSelectListName.to_s
    
    if($VERBOSE == true)
      puts2("Multi-select list name: \"#{sMultiSelectListName.to_s}\"")
      puts2(" Multi-select values:")
      puts2(aSelectValues)
    end
    
    # Only continue of select list exists
    if !(self.select_list(:name, sMultiSelectListName).exists?)
      puts2("*** WARNING - Unable to access multi select_list \"#{sMultiSelectListName.to_s}\"", "WARN")
      return false
    end
    
    # Only continue of select list value is not nil
    if(aSelectValues == [])
      puts2("*** WARNING - Unable to access multi select_list \"#{sMultiSelectListName.to_s}\", values \"[]\"", "WARN")
      return false
    end
    
    # Loop - selections
    aSelectValues.each do |sSelection|
      
      # Call method to set the current value
      if((self.set_select_list_by_name?(sMultiSelectListName, sSelection)) == false)
        bReturnValue = false
      end
      
    end # Loop trough selections
    
    return bReturnValue
    
  end # end of method set_multiselect_list_by_name?()
  
  
  #=============================================================================#
  #--
  # Method: set_multiselect_list_by_id?(...)
  #++
  #
  # Description: Multi-selects the specified items from the specified select_list
  #              Verifies that the list exists
  #              Verifies that the item in the list exists
  #              Provides ability to clear the current selection
  #
  # Syntax: sMultiSelectListID = STRING - Case sensitive string of the multi select_list(:id, sMultiSelectListID)
  #         aSelectValue = ARRAY - Contains case sensitive STRINGs for the values to multi-select
  #                                Values of "CLEAR" or "" will clear the current multi-select list's selection set
  #
  #  Returns: BOOLEAN - true if successful, otherwise returns false
  #
  # Usage Examples:
  #            # Set a few specific:
  #                 aMyStates = [ "AK", "CA", "WY"]
  #                 assert(browser.set_multiselect_list_by_id?("state_id", aMyStates))
  #            # Set all values:
  #                 aAllStates = browser.select_list(:id, "state_id").options
  #                 assert(browser.set_multiselect_list_by_id?("state_id", aAllStates))
  #
  #=============================================================================#
  def set_multiselect_list_by_id?(sMultiSelectListID = nil, aSelectValues = [])
    
    if($VERBOSE == true)
      puts2("Parameters - set_multiselect_list_by_id?:")
      puts2("  sMultiSelectListID: " + sMultiSelectListID.to_s)
      puts2("  aSelectValues: " + aSelectValues.to_s)
    end
    
    # Set return value
    bReturnValue = true
    
    # Cast value to a string
    sMultiSelectListID = sMultiSelectListID.to_s
    
    if($VERBOSE == true)
      puts2("Multi-select list name: \"#{sMultiSelectListID.to_s}\"")
      puts2(" Multi-select values:")
      puts2(aSelectValues)
    end
    
    # Only continue of select list exists
    if !(self.select_list(:id, sMultiSelectListID).exists?)
      puts2("*** WARNING - Unable to access multi select_list \"#{sMultiSelectListID.to_s}\"", "WARN")
      return false
    end
    
    # Only continue of select list value is not nil
    if(aSelectValues == [])
      puts2("*** WARNING - Unable to access multi select_list \"#{sMultiSelectListID.to_s}\", values \"[]\"", "WARN")
      return false
    end
    
    # Loop - selections
    aSelectValues.each do |sSelection|
      
      # Call method to set the current value
      if((self.set_select_list_by_id?(sMultiSelectListID, sSelection)) == false)
        bReturnValue = false
      end
      
    end # Loop trough selections
    
    return bReturnValue
    
  end # end of method set_multiselect_list_by_id?()
  
  
  
  #=============================================================================#
  #--
  # Method: set_multiselect_list_by_index?(...)
  #++
  #
  # Description:  Multi-selects the specified items from the specified select_list
  #               Verifies that the list exists
  #               Verifies that the item in the list exists
  #               Provides ability to clear the current selection
  #
  # Syntax: iMultiSelectListIndex = INTEGER - The index of the multi select_list(:index, iMultiSelectListIndex)
  #                                            This is zero indexed, the first select_list is select_list(:index 0)
  #         aSelectValue = ARRAY - Contains case sensitive STRINGs for the values to multi-select
  #                                Values of "CLEAR" or "" will clear the current multi-select list's selection set
  #
  #  Returns: BOOLEAN - true if successful, otherwise returns false
  #
  # Usage Examples:
  #            # Set a few specific:
  #                 aMyStates = [ "AK", "CA", "WY"]
  #                 assert(browser.set_multiselect_list_by_index?(2, aMyStates))
  #            # Set all values:
  #                 aAllStates = browser.select_list(:index, 2).options
  #                 assert(browser.set_multiselect_list_by_index?(2, aAllStates))
  #
  #=============================================================================#
  def set_multiselect_list_by_index?(iMultiSelectListIndex = 0, aSelectValues = [])
    
    if($VERBOSE == true)
      puts2("Parameters - set_multiselect_list_by_index?:")
      puts2("  iMultiSelectListIndex: " + iMultiSelectListIndex.to_s)
      puts2("  aSelectValues: " + aSelectValues.to_s)
    end
    
    # Set return value
    bReturnValue = true
    
    # Disallow negative index values
    if(iMultiSelectListIndex < 0)  # Should this be one indexed?
      iMultiSelectListIndex = 0
    end
    
    if($VERBOSE == true)
      puts2("Multi-select list name: \"#{iMultiSelectListIndex.to_s}\"")
      puts2(" Multi-select values:")
      puts2(aSelectValues)
    end
    
    # Only continue of select list exists
    if !(self.select_list(:index, iMultiSelectListIndex.adjust_index).exists?)
      puts2("*** WARNING - Unable to access multi select_list \"#{iMultiSelectListIndex.to_s}\"", "WARN")
      return false
    end
    
    # Only continue of select list value is not nil
    if(aSelectValues == [])
      puts2("*** WARNING - Unable to access multi select_list \"#{iMultiSelectListIndex.to_s}\", values \"[]\"", "WARN")
      return false
    end
    
    # Loop - selections
    aSelectValues.each do | sSelection |
      
      # Call method to set the current value
      if((self.set_select_list_by_index?(iMultiSelectListIndex, sSelection)) == false)
        bReturnValue = false
      end
      
    end # Loop trough selections
    
    return bReturnValue
    
  end # end of method set_multiselect_list_by_index?()
  
  #=============================================================================#
  #--
  # Method: set_select_list_by_name?(...)
  #
  #++
  #
  # Description: Selects the specified item from the specified select_list
  #              Verifies that the list exists
  #              Verifies that the item in the list exists
  #              Provides ability to clear the current selection
  #
  # Syntax: sSelectListName = STRING - Case sensitive string of the select_list(:name, sSelectListName)
  #         sSelectValue = STRING - Case sensitive string of the value to select
  #                                 Values of "CLEAR" or "" will clear the current multi-select list's selection
  #
  # Returns: BOOLEAN - true if successful, otherwise returns false
  #
  # Usage Examples:
  #          assert(browser.set_select_list_by_name?("state", "Alaska"))
  #
  #=============================================================================#
  def set_select_list_by_name?(sSelectListName = nil, sSelectValue = nil)
    
    if($VERBOSE == true)
      puts2("Parameters - set_select_list_by_name?:")
      puts2("  sSelectListName: " + sSelectListName)
      puts2("  sSelectValue: " + sSelectValue)
    end
    
    # Set return value
    bReturnValue = true
    
    if($VERBOSE == true)
      puts2("Select list name: \"#{sSelectListName.to_s}\"")
      puts2(" Select value: \"#{sSelectValue.to_s}\"")
    end
    
    # Cast the value to a string
    sSelectListName = sSelectListName.to_s
    sSelectValue =sSelectValue.to_s
    
    # Only continue of select list name and value are not nil
    if((sSelectListName.to_s.upcase == "NIL") || (sSelectValue.to_s.upcase == "NIL"))
      
      puts2("*** WARNING - Unable to access select_list \"#{sSelectListName.to_s}\", value \"#{sSelectValue.to_s}\"", "WARN")
      return false
      
    end # Only continue of select list name and value are not nil
    
    
    # Only continue if the select list exists
    if((self.select_list(:name, sSelectListName).exists?) == false)
      
      puts2("*** WARNING - Unable to access select_list #{sSelectListName}", "WARN")
      return false
      
    end # Only continue if the select list exists
    
    
    # Clear or set the current selection
    if((sSelectValue.to_s.upcase == "CLEAR") || (sSelectValue.to_s.upcase == ""))
      
      if($VERBOSE == true)
        puts2("Clearing multi-select list")
      end
      
      # Clear the current selection
      # WatirWebDriver issue - #select.clear is only supported for multi-select lists
      # So skip if clearing a list object that is not a multi-select list
      if(self.select_list(:name, sSelectListName).type == "select-multiple" )
        self.select_list(:name, sSelectListName).clear
      end
      
      return bReturnValue
      
    end
    
    # Only continue if the select list value exists
    if (self.select_list(:name, sSelectListName).include?(sSelectValue))
      #if (self.select_list(:name, sSelectListName).includes?(sSelectValue))
      # Only set value if not nil
      if((sSelectValue != nil) &&  (sSelectValue != "nil"))
        
        # Select choice by name in dropdown list
        self.select_list(:name, sSelectListName).select(sSelectValue)
        
      end  # Only set value if not nil
      
    else #  Select list value does NOT exist
      bReturnValue = false
      puts2("*** WARNING - Unable to access value #{sSelectValue}", "WARN")
    end # Only continue if the select list value exists
    
    return bReturnValue
    
  end # end of method set_select_list_by_name?()
  
  
  #=============================================================================#
  #--
  # Method: set_select_list_by_id?(...)
  #
  #++
  #
  # Description: Selects the specified item from the specified select_list
  #              Verifies that the list exists
  #              Verifies that the item in the list exists
  #              Provides ability to clear the current selection
  #
  # Syntax: sSelectListID = STRING - Case sensitive string of the select_list(:id, sSelectListID)
  #         sSelectValue = STRING - Case sensitive string of the value to select
  #                                 Values of "CLEAR" or "" will clear the current select list's selection
  #
  #  Returns: BOOLEAN - true if successful, otherwise returns false
  #
  # Usage Examples:
  #          assert(browser.set_select_list_by_id?("state_id", "Alaska"))
  #
  #=============================================================================#
  def set_select_list_by_id?(sSelectListID = nil, sSelectValue = nil)
    
    if($VERBOSE == true)
      puts2("Parameters - set_select_list_by_id?:")
      puts2("  sSelectListID: " + sSelectListID)
      puts2("  sSelectValue: " + sSelectValue)
    end
    
    # Set return value
    bReturnValue = true
    
    if($VERBOSE == true)
      puts2("Select list name: \"#{sSelectListID.to_s}\"")
      puts2(" Select value: \"#{sSelectValue.to_s}\"")
    end
    
    # Cast the value to a string
    sSelectListID = sSelectListID.to_s
    sSelectValue =sSelectValue.to_s
    
    # Only continue of select list name and value are not nil
    if((sSelectListID.to_s.upcase == "NIL") || (sSelectValue.to_s.upcase == "NIL"))
      
      puts2("*** WARNING - Unable to access select_list \"#{sSelectListID.to_s}\", value \"#{sSelectValue.to_s}\"", "WARN")
      return false
      
    end # Only continue of select list name and value are not nil
    
    
    # Only continue if the select list exists
    if((self.select_list(:id, sSelectListID).exists?) == false)
      
      puts2("*** WARNING - Unable to access select_list #{sSelectListID}", "WARN")
      return false
      
    end # Only continue if the select list exists
    
    
    # Clear or set the current selection
    if((sSelectValue.to_s.upcase == "CLEAR") || (sSelectValue.to_s.upcase == ""))
      
      if($VERBOSE == true)
        puts2("Clearing select list")
      end
      
      # Clear the current selection
      # WatirWebDriver issue - #select.clear is only supported for multi-select lists
      # So skip if clearing a list object that is not a multi-select list
      if(self.select_list(:id, sSelectListID).type == "select-multiple" )
        self.select_list(:id, sSelectListID).clear
      end
      
      return bReturnValue
      
    end
    
    # Only continue if the select list value exists
    
    if (self.select_list(:id, sSelectListID).include?(sSelectValue))
      #if (self.select_list(:id, sSelectListID).includes?(sSelectValue))
      
      # Only set value if not nil
      if((sSelectValue != nil) &&  (sSelectValue != "nil"))
        
        # Select choice by name in dropdown list
        self.select_list(:id, sSelectListID).select(sSelectValue)
        
      end  # Only set value if not nil
      
    else #  Select list value does NOT exist
      bReturnValue = false
      puts2("*** WARNING - Unable to access value #{sSelectValue}", "WARN")
    end # Only continue if the select list value exists
    
    return bReturnValue
    
  end # end of method set_select_list_by_id?()
  
  
  
  #=============================================================================#
  #--
  # Method: set_select_list_by_index?(...)
  #
  #++
  #
  # Description: Selects the specified item from the specified select_list
  #              Verifies that the list exists
  #              Verifies that the item in the list exists
  #              Provides ability to clear the current selection
  #
  # Syntax: iSelectListIndex = STRING - Case sensitive string of the select_list(:index, iSelectListIndex)
  #                                     This is zero indexed, the first select_list is select_list(:index 0)
  #         sSelectValue = STRING - Case sensitive string of the value to select
  #                                 Values of "CLEAR" or "" will clear the current select list's selection
  #
  # Returns: BOOLEAN - true if successful, otherwise returns false
  #
  # Usage Examples:
  #          assert(browser.set_select_list_by_index?("state_id", "Alaska"))
  #
  #=============================================================================#
  def set_select_list_by_index?(iSelectListIndex = 0, sSelectValue = nil)
    
    if($VERBOSE == true)
      puts2("Parameters - set_select_list_by_index?:")
      puts2("  iSelectListIndex: " + iSelectListIndex.to_s)
      puts2("  sSelectValue: " + sSelectValue)
    end
    
    # Set return value
    bReturnValue = true
    
    if($VERBOSE == true)
      puts2("Select list name: \"#{iSelectListIndex.to_s}\"")
      puts2(" Select value: \"#{sSelectValue.to_s}\"")
    end
    
    # Disallow negative index values
    if(iSelectListIndex < 0)
      iSelectListIndex = 0
    end
    
    # Only continue of select list name and value are not nil
    if((iSelectListIndex.to_s.upcase == "NIL") || (sSelectValue.to_s.upcase == "NIL"))
      
      puts2("*** WARNING - Unable to access select_list \"#{iSelectListIndex.to_s}\", value \"#{sSelectValue.to_s}\"", "WARN")
      return false
      
    end # Only continue of select list name and value are not nil
    
    
    # Only continue if the select list exists
    if((self.select_list(:index, iSelectListIndex.adjust_index).exists?) == false)
      
      puts2("*** WARNING - Unable to access select_list #{iSelectListIndex}", "WARN")
      return false
      
    end # Only continue if the select list exists
    
    
    # Clear or set the current selection
    if((sSelectValue.to_s.upcase == "CLEAR") || (sSelectValue.to_s.upcase == ""))
      
      if($VERBOSE == true)
        puts2("Clearing select list")
      end
      
      # Clear the current selection
      # WatirWebDriver issue - #select.clear is only supported for multi-select lists
      # So skip if clearing a list object that is not a multi-select list
      if(self.select_list(:index, iSelectListIndex.adjust_index).type == "select-multiple" )
        self.select_list(:index, iSelectListIndex.adjust_index).clear
      end
      
      return bReturnValue
      
    end
    
    # Only continue if the select list value exists
    if (self.select_list(:index, iSelectListIndex.adjust_index).include?(sSelectValue))
      #if (self.select_list(:index, iSelectListIndex.adjust_index).includes?(sSelectValue))
      
      # Only set value if not nil
      if((sSelectValue != nil) &&  (sSelectValue != "nil"))
        
        # Select choice by name in dropdown list
        self.select_list(:index, iSelectListIndex.adjust_index).select(sSelectValue)
        
      end  # Only set value if not nil
      
    else #  Select list value does NOT exist
      bReturnValue = false
      puts2("*** WARNING - Unable to access value #{sSelectValue}", "WARN")
    end # Only continue if the select list value exists
    
    return bReturnValue
    
  end # end of method set_select_list_by_index?()
  
  
  
  #=============================================================================#
  #--
  # Method: show_html_tag_attributes(...)
  #
  #++
  #
  # Description: Outputs the settings of all Watir HTML Tag Element attributes against the specified Elements.
  #              Some of the attributes may NOT pertain to an Element but are displayed anyway.
  #              This allows you the choice to try that element/attribute combination.
  #
  #              Example partial output:
  #
  #                  #-------------------------#
  #                  # Attributes of image 1
  #                  #-------------------------#
  #                  action  = ""
  #                  alt  = "Search Google"
  #                  class  = FireWatir::Image
  #                  class_name  = ""
  #                  enabled?  = ""
  #                  exists?  = true
  #                  file_size  = ""
  #                  options  = ""
  #                  text  = ""
  #                  selected_options  = ""
  #                  loaded?  = "SyntaxError: syntax error"
  #                  height  = "32"
  #                  href  = ""
  #                  id  = ""
  #                  text  = ""
  #                  set?  = "SyntaxError: syntax error"
  #                  maxLength  = ""
  #                  name  = ""
  #                  row_count_excluding_nested_tables  = ""
  #                  size  = ""
  #                  src  = "logo_25wht.gif"
  #                  title  = "Search Google"
  #                  type  = ""
  #                  value  = ""
  #                  width  = "75"
  #
  #              Supported HTML Tag Elements are:
  #                 area, button, checkbox, dd, div, dl, dt, em, file_field,
  #                 hidden, image, label, link, li, map, pre, p, radio,
  #                 select_list, strong, span, table, text_field
  #
  #               The form method is NOT supported.
  #
  # HINT: Run this once against a web page to display information you can use to subsequently test the web page.
  #
  #       Determine if you need to show the attributes for all the HTML Tag Elements,
  #       or only a subset, and set the parameter values passed to this method accordingly.
  #
  # Returns: BOOLEAN - true on success, otherwise false
  #
  # Syntax: oElementsToShow = OBJECT - One of the following object types:
  #
  #                                    nil - Show all HTML Element attributes
  #
  #                                    STRING - Name of any single HTML Element attribute to show
  #                                                 i.e. "link"
  #                                               Or "all" to show them all.
  #
  #                                    ARRAY of STRINGS - A single or a set of multiple HTML elements to show
  #                                                           i.e ["link"] or ["button", "checkbox"]
  #                                                         Or if ["all"] show all the Element's attributes.
  #
  # Usage Examples:
  #                 1) To show HTML Element attributes for ALL of the HTML Elements on the page:
  #                        browser = Watir::Browser.start("http://google.com")
  #                        browser.show_html_tag_attributes()   #  Also works using: show_html_tag_attributes("all")
  #
  #
  #                 2) To show HTML Element attributes for ONLY of the link HTML Elements on the page:
  #                        browser = Watir::Browser.start("http://google.com")
  #                        browser.show_html_tag_attributes("link")
  #
  #                 3) To show HTML Element attributes for ONLY the image and button HTML Elements on the page:
  #                        aObjects = ["image", "button"]
  #                        my_browser = Watir::Browser.start("http://google.com")
  #                        my_browser.show_html_tag_attributes(aObjects)
  #
  #=======================================================================#
  def show_html_tag_attributes(oElementsToShow="all")
    
    if($VERBOSE == true)
      puts2("Parameters - show_html_tag_attributes:")
      puts2("  oElementsToShow: ")
      puts2(     oElementsToShow.to_s)
    end
    
    # Define the elements to check
    aSupportedHTMLElementNames = ["area", "button",
        "checkbox", "dd", "div", "dl", "dt", "em", "form",
        "file_field", "hidden", "image", "label",
		    "link",  "li", "map", "pre", "p",
        "radio", "select_list", "strong",  "span",
		    "table", "text_field" ]
    
    # Define the element attributes to collect
    aAttributes = ["exists?", "type", "id", "name", "title",
      "value", "enabled?", "visible?", "loaded?", "src",
		  "height", "width", "file_size", "alt", "class",
		  "action", "method", "set?", "text",
		  "href", "selected_options", "options",
		  "class_name", "row_count_excluding_nested_tables",
		  "size", "maxLength"]
    
    # Sort the attributes
    aAttributes = aAttributes.sort!
    
    # Determine the object type
    case
      
      when oElementsToShow.class.to_s == "String"
      
      # Populate array with the string of the single HTML element to count
      aElements = [oElementsToShow]
      
      when oElementsToShow.class.to_s == "Array"
      
      # Populate array with the array of the single or multiple HTML elements to count
      aElements = oElementsToShow
      
      when oElementsToShow.class.to_s == "NilClass"
      
      # Populate array with the array of the string "All" to count all HTML elements
      aElements = aSupportedHTMLElementNames
      
    else
      puts2(oElementsToShow.class.to_s + " class objects are NOT supported. Please use a nil, String or Array of Strings.", "WARN")
      return  false
      
    end # Determine the object type
    
    # If the first string in the array is "All" populate the array with all the supported HTML tags
    if(aElements[0].to_s.downcase == "all")
      aElements = aSupportedHTMLElementNames
    end
    
    # Remove any Elements that are NOT supported by Firewatir
    if(self.is_firefox?)
      #puts2("*** Skipping HTML Element that is NOT supported by Firewatir - form", "WARN")
      aElements.delete("form")
    end
    
    # Remove any Elements that are NOT supported by IE
    if(self.is_ie?)
      #puts2("WARNING: Skipping HTML Element that has issues with IE - form", "WARN")
      aElements.delete("form")
    end
    
    # Validate that the current element is valid
    aElements.each do | sElement |
      if((aSupportedHTMLElementNames.include?(sElement)) == false)
        puts2("WARNING: HTML Element  " +  sElement + "  is NOT supported.", "WARN")
        return false
      end
      
    end # Validate
    
    # Show information on Page title
    puts2("\n###############")
    puts2("# Page title: \"" + self.title + "\"")
    puts2("###############")
    
    
    # Loop for HTML Element types
    aElements.each do | sElement|
      
      puts2("\n###############")
      puts2("# Checking - #{sElement}")
      
      # Compose the plural version for the current elements so we can get the count of each element type
      if(sElement == "checkbox")
        sElementPlural = "checkboxes"
      else
        sElementPlural = sElement + "s"
      end
      
      #oCurrentElementSet = self.send(sElementPlural)
      
      # Determine the total number of the current Element type
      iElementCount = self.send(sElementPlural).length
      
      puts2("# Found a total of #{iElementCount.to_s} #{sElementPlural}")
      puts2("###############")
      
      # Only check existing elements
      if(iElementCount > 0)
        
        iIndex = 1
        
        while iIndex <= iElementCount
          
          puts2("\n#-------------------------#")
          puts2("# Attributes of #{sElement} #{iIndex}")
          puts2("#-------------------------#")
          
          aAttributes.each do | sAttribute |
            
            # Catcher
            #
            # Wrap the checks for the attributes in a begin/rescue/end block
            # Any error for an attribute that is unsupported for the current
            # Element type will be caught and not stop the test
            begin
              
              # Collect the setting of the current HTML element
              mySetting = self.send(sElement, :index => iIndex.adjust_index).send(sAttribute)
              
              # To make strings more human readable put parenthesis around the string
              if(mySetting.class.to_s == "String")
                mySetting = "\"" + mySetting + "\""
              end
              
              puts2("#{sAttribute}  = " + mySetting.to_s)
              
            rescue
              # Element doe snot support the current attribute
              # no harm no foul
            ensure
            end # Catcher
            
          end # Loop for Attribute
          
          iIndex = iIndex +1
        end # while
        
      end # Only check existing elements
      
    end # Loop for HTML Element types
    
  end # Method show_html_tag_attributes()
  
  #=============================================================================#
  #--
  # Method: start_browser(...)
  #++
  #
  # Description: Starts and returns a browser object. Can Create a local or Global Browser Object.
  #
  #              Only one Global Browser Object named $browser may exist,  but
  #              multiple local browser objects with different names can coexist.
  #
  #              Once the Global Browser Object named $browser exists, no other Global or local browsers
  #              can be started.  In that case remove the GBO (e.g. $browser = nil) prior to calling this
  #              function, so  a new local or Global Browser Object can be created.
  #
  #              No Global Browser Object is created if the Global Browser Object named $browser pre-exists.
  #
  #              The type of browser object started (e.g. IE, FF, etc.) is determined by Watir.
  #
  # Returns: Browser object
  #
  # Syntax: sBrowserType = STRING - For watir-webdriver one of the following: android, chrome, firefox (default) ,ie, iphone, opera, remote, safari
  #                                                   For Watir and Firewatir one of the following: firefox, ie
  #
  #             sURL = STRING - A URL for the browser to load. Default is to open a blank browser page "about:blank"
  #
  #            sBrowserProfile = STRING - For watir-webdriver use to specify the Firefox profile to use
  #
  #    There are two ways to select which browser will be started (IE or FF):
  #
  #
  # Prerequisites: The Global Browser Object must be named $browser
  #                     Watir 1.6.5 or later must be installed
  #                             or
  #                     WatirWebDriver must be installed
  #
  # Usage Examples: To create a pair of local browser objects:
  #                                          myFirstLocalBrowser = start_browser()
  #                                           mySecondLocalBrowser = start_browser()
  #
  #                              To create a single Global Browser Object:
  #                                          $browser = start_browser()
  #
  #                              To create a single Global Browser Object: fro watir-webdriver
  #                                          $browser = start_browser("firefox")
  #
  #=============================================================================#
  def start_browser(sBrowserType = "firefox", sURL="about:blank", sBrowserProfile = nil)
    
    if($VERBOSE == true)
      puts2("Parameters - start_browser:")
      puts2("  sURL: " + sURL)
      puts2("  sBrowserType: " + sBrowserType.to_s)
      puts2("  sBrowserProfile: " + sBrowserProfile.to_s)
    end
    
    # Define a browser to use when the one specified  is incompatible
    sFallbackBrowser = "firefox"
    
    # Cleanup the specified value
    sBrowserType = sBrowserType.to_s.downcase
    
    if($browser != nil) # If current Browser object is a Global Browser Object don't start an new one
      puts2(" Global browser object already started.")
      return $browser
    end
    
    # aSupportedBrowsers = ["ie", "firefox", "chrome", "safari"]    # new[:firefox, :ie, :chrome, :remote, Selenium::WebDriver]
    
    # Determine if a specified browser type is supported on current OS
    if(sBrowserType == "ie" and is_win? == false)
      puts2(" Internet Explorer not supported on this platform. Switching to the Firefox browser")
      sBrowserType = sFallbackBrowser
    end
    
    # Determine if a specified browser type is supported on current OS
    if(sBrowserType == "safari" and is_osx? == false)
      puts2(" Safari not supported on this platform. Switching to the Firefox browser")
      sBrowserType = sFallbackBrowser
    end
    
    
    # Run with WatirWebDriver or Watir / Firewatir
    if(is_webdriver? == true)
      case sBrowserType
        
        when /android/
        
        puts2("Starting Android browser")
        oBrowser = Watir::Browser.new(:android)
        $bStartedBrowser = true
        
        when /chrome/
        
        puts2("Starting Chrome browser")
        
        sChromePath = ENV["CHROMEDRIVER_HOME"]
        sChromePath = sChromePath.gsub(/\\/, "/")
        puts2("\t Chrome driver = " + sChromePath)
        setenv("PATH", sChromePath)
        
        oBrowser = Watir::Browser.new(:chrome)
        $bStartedBrowser = true
        
        when /ie| internet_explorer | internet explorer/
        
        puts2("Starting Internet Explorer browser")
        oBrowser = Watir::Browser.new(:ie)
        $bStartedBrowser = true
        
        when /iphone/
        
        puts2("Starting iphone browser")
        oBrowser = Watir::Browser.new(:iphone)
        $bStartedBrowser = true
        when /opera/
        
        puts2("Starting Opera browser")
        oBrowser = Watir::Browser.new(:opera)
        $bStartedBrowser = true
        
        when /remote/
        
        puts2("Starting Remote browser")
        oBrowser = Watir::Browser.new(:remote)
        $bStartedBrowser = true
        
        when /safari/
        
        puts2("Starting Safari browser")
        oBrowser = Watir::Browser.new(:safari)
        $bStartedBrowser = true
        
      else
        if(sBrowserProfile != nil)
          puts2("Starting Firefox browser with profile: " + sBrowserProfile.to_s)
          oBrowser = Watir::Browser.new(:firefox, :profile => sBrowserProfile.to_s)
        else
          puts2("Starting Firefox browser without profile")
          oBrowser = Watir::Browser.new(:firefox)
          $bStartedBrowser = true
        end # default to firefox
        
      end # Case
      
    else # Only run with Watir / Firewatir / SafariWatir
      
      case sBrowserType.downcase.strip
        when /ie| internet_explorer | internet explorer/
        oBrowser =  Watir::IE.new
        $bStartedBrowser = true
        when /firefox/
        oBrowser =  FireWatir::Firefox.new
        $bStartedBrowser = true
        when /safari/
        oBrowser =  Watir::Safari.new
        $bStartedBrowser = true
      end
=begin
      # Determine which type of browser is set as the current default
      #sBrowserType = Watir.options[:browser]

      puts2(" Starting a new " + sBrowserType + " browser object.")
      oBrowser = Watir::Browser.new # Create new local browser object
      $bStartedBrowser = true
=end
      
    end # Run with WatirWebDriver or Watir / Firewatir
    
    
    oBrowser.goto(sURL) # Load the URL
    
    # Allow time to celebrate the birth of the new browser.
    sleep 2  # That's long enough to celebrate
    
    # Set global flag for use in various methods or tests to determine if a browser was started
    $bBrowserStarted = true
    
    return oBrowser  # Return the browse object and let the caller decide it to assign it to local or Global Object
    
  end # END Method - start_browser()
  
  
  #=============================================================================#
  #--
  # Method: wait_until_status(...)
  #
  #++
  #
  # Description: Checks the Browser's status text for a match with the specified text.
  #              Loops once each Interval, until a specified Timeout is reached.
  #
  # NOTE: In Firefox 1.6.5 the  method 'status' is incorrectly using #{WINDOW_VAR}instead of #{window_var}
  #       For details see:  http://jira.openqa.org/browse/WTR-441
  #
  #       SafariWatir does not support browser.status()
  #       Calling this method will return true if run under Safari.
  #
  # Returns: BOOLEAN - true if the specified Browser's status text is found, otherwise false
  #
  # Syntax: sStatusText = STRING - The Browser's status text to check for
  #         iTimeout = INTEGER - The number of seconds to wait for the specified status text
  #         iInterval = INTEGER - The number of second to wait between loops
  #
  # Usage Examples: To verify the Browser's status is "Done" for up to 20 seconds, checking every 4 seconds
  #                         if(browser.wait_until_status("Done", 20, 4) == true)
  #                              puts2("Found expected Browser's status text = " + browser.status)
  #                         else
  #                              puts2("Found unexpected Browser's status text = " + browser.status)
  #                         end
  #
  #=============================================================================#
  def wait_until_status(sStatusText = "Done", iTimeout=10, iInterval=0.1)
    
    if($VERBOSE == true)
      puts2("Parameters - wait_until_status:")
      puts2("  sStatusText: " + sStatusText.to_s)
      puts2("  iTimeout: " + iTimeout.to_s)
      puts2("  iInterval: " + iInterval.to_s)
    end
    
    # Status not supported with Safariwatir
    #if(self.is_safari?() == true)
    #  return true
    #end
    
    # Disallow values less that one
    if(iTimeout <= 1)
      iTimeout = 1
    end
    
    if(iInterval <= 0.1)
      iInterval = 0.1
    end
    
    if($VERBOSE == true)
      puts2("Browser's status text: " +	self.status)
    end
    
    tStartTime = Time.now
    tElapsedTime = 0
    
    # Loop until the status bar text to changes back to "Done" or the timeout is exceeded
    while((self.status != sStatusText) && (tElapsedTime <= iTimeout)) do
        if($VERBOSE == true)
          puts2("Browser's status text: " +	self.status)
        end
        
        sleep iInterval
        tElapsedTime = calc_elapsed_time(tStartTime).to_f
        
      end
      
      # In case the timeout was reached need to check once more to set the return status
      if(self.status == sStatusText)
        return true
      else
        return false
      end
      
      
    end # Method - wait_until_status()
    
    
  end # END Module - WatirWorks_WebUtilities
  
  # Skip if using webdriver
  if(is_webdriver? != true)
    #=============================================================================#
    # Class: FireWatir::Firefox
    #
    # Description: Extends the FireWatir::Firefox class with additional methods
    #              This class is is NOT supported if using Watir_WebDriver
    #
    #--
    # Methods:
    #          moveBy(...)
    #          moveTo(...)
    #          resizeBy(...)
    #          resizeTo(...)
    #          restart(...)
    #          scrollBy(...)
    #++
    #=============================================================================#
    class FireWatir::Firefox
      
      
      #=============================================================================#
      #--
      # Method: brand()
      #
      #++
      #
      # Description: Returns the brand of the current browser (IE, Firefox, Chrome, Safari)
      #              Uses a JavaScript object method that is recognized by most browsers.
      #              Based on info at: http://www.w3schools.com/js/js_browser.asp
      #              To debug browse this URL: javascript:alert(window.navigator.userAgent);
      #
      # Usage Examples: To verify that the current browser is a Firefox browser:
      #                    sBrand = browser.brand()
      #                    assert(sBrand == "Firefox")
      #
      #=============================================================================#
      def brand()
        
        if($bUseWebDriver == false)
          sRawType = self.execute_script("window.navigator.userAgent")
        else
          sRawType = self.execute_script("return window.navigator.userAgent")
        end
        
        if($VERBOSE == true)
          puts2(sRawType)
        end
        
        if(sRawType =~ /MSIE \d/)
          sBrand = "IE"
        elsif(sRawType =~ /Firefox\//)
          sBrand = "Firefox"
        elsif(sRawType =~ /Chrome\//)
          sBrand = "Chrome"
        elsif(sRawType =~ /Safari\/\d\.\d/)
          sBrand = "Safari"
        elsif(sRawType =~ /Opera\//)
          sBrand = "Opera"
        else
          sBrand = "Unknown"
        end
        
        # puts2(sBrand)
        
        return sBrand
        
      end # Method - brand()
      
      #=============================================================================#
      #--
      # Method: moveBy(...)
      #
      #++
      #
      # Description: Move the Browser window relative to its current location
      #              Per: http://www.w3schools.com/jsref/obj_window.asp
      #                   The moveBy() method is supported in all major browsers,
      #
      # Returns: BOOLEAN - true if successful, otherwise false
      #
      # Syntax: iXPos = INTEGER - The X-coordinate in pixels to re-position the top left
      #                           corner of the browser window
      #                           Default value = 0
      #
      #         iYPos = INTEGER - The Y-coordinate  in pixels to re-position the top left
      #                           corner of the browser window
      #                           Default value = 0
      #
      # Usage Examples:
      #                To reposition the browser relative to its current location by 10, -20
      #                     browser.moveBY(10, -20)
      #
      #=============================================================================#
      def moveBy(iXPos=0, iYPos=0)
        
        self.goto("javascript:window.moveBy(#{iXPos},#{iYPos})")
      end # moveBy()
      
      
      #=============================================================================#
      #--
      # Method: moveTo(...)
      #
      #++
      #
      # Description: Move the current Browser window to the specified location
      #                    Per: http://www.w3schools.com/jsref/obj_window.asp
      #                   The moveTo() method is supported in all major browsers.
      #
      # Returns: BOOLEAN - true if successful, otherwise false
      #
      # Syntax: iXPos = INTEGER - The X-coordinate in pixels to position the top left
      #                           corner of the browser window
      #                           Default value = 0
      #
      #         iYPos = INTEGER - The Y-coordinate  in pixels to position the top left
      #                           corner of the browser window
      #                           Default value = 0
      #
      # Usage Examples:
      #                To move the browser to 100, 200
      #                     browser.moveTo(100,200)
      #
      #=============================================================================#
      def moveTo(iXPos=0, iYPos=0)
        
        if(iXPos <0)
          iXPos = 0
        end
        if(iYPos <0)
          iYPos = 0
        end
        
        self.goto("javascript:window.moveTo(#{iXPos},#{iYPos})")
      end # moveTo()
      
      
      #=============================================================================#
      #--
      # Method: resizeBy(...)
      #
      #++
      #
      # Description: Resize the Browser window relative to its current size (in pixels)
      #              Per: http://www.w3schools.com/jsref/obj_window.asp
      #                   The resizeBy() method is supported in all major browsers, except Opera and Chrome.
      #
      # Returns: BOOLEAN - true if successful, otherwise false
      #
      # Syntax: iHeight = INTEGER - The width in pixels to resize the browser window
      #                             Default value = 0
      #
      #         iWidth = INTEGER - The height in pixels to resize the browser window
      #                            Default value = 0
      #
      # Usage Examples:
      #                To size the browser by an additional 100, 200
      #                     browser.resizeTo(100, 200)
      #
      #=============================================================================#
      def resizeBy(iHeight=0, iWidth=0)
        
        self.goto("javascript:window.resizeBy(#{iHeight},#{iWidth})")
      end # resizeTo()
      
      
      #=============================================================================#
      #--
      # Method: resizeTo(...)
      #
      #++
      #
      # Description: Move the Browser window to the specified location (in pixels)
      #              Per: http://www.w3schools.com/jsref/obj_window.asp
      #                   The resizeTo() method is supported in all major browsers, except Opera and Chrome
      #
      # Returns: BOOLEAN - true if successful, otherwise false
      #
      # Syntax: iHeight = INTEGER - The width in pixels to resize the browser window
      #                             Default value = 640
      #
      #         iWidth = INTEGER - The height in pixels to resize the browser window
      #                            Default value = 480
      #
      # Usage Examples:
      #                To size the browser to 100, 200
      #                     browser.resizeTo(1024,756)
      #
      #=============================================================================#
      def resizeTo(iHeight=640, iWidth=480)
        
        if(iHeight <1)
          iHeight = 1
        end
        if(iWidth <1)
          iWidth = 1
        end
        
        self.goto("javascript:window.resizeTo(#{iHeight},#{iWidth})")
      end # resizeTo()
      
      
      #=============================================================================#
      #--
      # Method: restart(...)
      #
      #++
      #
      # Description: Close the current Firefox browser object, pause,
      #              then create and return a new Firefox browser object.
      #
      # Returns: BROWSER object
      #
      # Syntax: sURL = STRING - The URL to load in the new browser, defaults to the currently loaded URL
      #         bClearCache = BOOLEAN - true - clear the cache and cookies after the old browser closes, but before the new browser starts
      #                                 false - don't clear the cache & cookies
      #
      # Usage Examples:
      #            To restart Global Browser Object with the same URL loaded:
      #                $browser = $browser.restart()
      #
      #            To restart local browser object (e.g. myCurrentBrowser) with a different url:
      #                myRestartedBrowser = myCurrentBrowser.restart("www.myNewURL.com")
      #
      #=============================================================================#
      def restart(sURL="", bClearCache=false)
        
        if($VERBOSE == true)
          puts2("Parameters - restart:")
          puts2("  sURL: " + sURL)
          puts2("  bClearCache: " + bClearCache.to_s)
        end
        
        puts2("Closing the Firefox browser...")
        
        if(sURL=="")
          sURL = self.url
        end
        
        self.close
        
        if($browser == self) # If a Global Browser Object exists remove it
          $browser = nil
        end
        
        # Allow time to mourn the passing of the old browser.
        sleep 3  # That's long enough to mourn
        
        if(bClearCache == true)
          clear_cache()
        end
        
        puts2("Starting a new Firefox browser object...")
        
        # Create a new browser object using Watir's method directly
        # Can't use start_Browser() as both local and Global Browser's may coexist
        oBrowser = FireWatir::Firefox.new()
        oBrowser.goto(sURL)
        
        # Allow time to celebrate the birth of the new browser.
        sleep 2  # That's long enough to celebrate
        
        return oBrowser  # Return the new browser.
        
      end # END Method - restart_browser()
      
      
      #=============================================================================#
      #--
      # Method: scrollBy(...)
      #
      #++
      #
      # Description: Scroll the current Browser window (in pixels)
      #              Per: http://www.w3schools.com/jsref/obj_window.asp
      #                   The ScrollBy() method is supported in all major browsers.
      #
      # Returns: BOOLEAN - true if successful, otherwise false
      #
      # Syntax: iHorizontal = INTEGER - How many pixels to scroll by, along the x-axis (horizontal)
      #                                 Positive values move scroll left, Negative values move scroll right
      #                                 Default value = 0
      #
      #         iVertical= INTEGER - How many pixels to scroll by, along the y-axis (vertical)
      #                              Positive values move scroll down, Negative values move scroll up
      #                              Default value = 0
      #
      # Usage Examples:
      #                To scroll the browser vertically by  100 pixels
      #                     browser.scrollBy(0, 100)
      #
      #=============================================================================#
      def scrollBy(iHorizontal=0, iVertical=0)
        
        self.goto("javascript:window.scrollBy(#{iHorizontal},#{iVertical})")
      end # scrollBy()
      
      
      #=============================================================================#
      #--
      # Method: version()
      #
      #++
      #
      # Description: Returns the version of the current browser.
      #              Uses a JavaScript object method that is recognized by most browsers.
      #              Based on info at: http://www.w3schools.com/js/js_browser.asp
      #              To debug browse this URL: javascript:alert(window.navigator.userAgent);
      #
      # Usage Examples: To verify that the current Firefox browser's version is > 9:
      #                    sVersion = browser.version()
      #                    assert(sVersion >= "9")
      #
      #=============================================================================#
      def version()
        
        if($bUseWebDriver == false)
          sRawType = self.execute_script("window.navigator.userAgent")
        else
          sRawType = self.execute_script("return window.navigator.userAgent")
        end
        
        if($VERBOSE == true)
          puts2(sRawType)
        end
        
        if(sRawType =~ /MSIE \d/)
          # IE 8.0 returns this:
          #   Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 6.0; WOW64; Trident/4.0; SLCC1; .NET CLR 2.0.50727; Media Center PC 5.0; .NET CLR 3.5.30729; .NET CLR 3.0.30729; .NET4.0C; MS-RTC LM 8)
          sVersion = sRawType.remove_prefix(";").prefix(";").remove_prefix(" ")
        elsif(sRawType =~ /Firefox\//)
          # Firefox 3.6.28 returns this:
          #   Mozilla/5.0 (Windows; U; Windows NT 6.0; en-US; rv:1.9.2.28) Gecko/20120306 Firefox/3.6.28
          sVersion = sRawType.suffix("/").prefix(" ")
        elsif(sRawType =~ /Chrome\//)
          # Chrome 17.0.963.79 returns this:
          #   Mozilla/5.0 (Windows NT 6.0; WOW64) AppleWebKit/535.11 (KHTML, like Gecko) Chrome/17.0.963.79 Safari/535.11
          sVersion = sRawType.suffix(")").remove_prefix("/").prefix(" ")
        elsif(sRawType =~ /Safari\/\d\.\d/)
          # Safari 5.1.4 returns this:
          #   Mozilla/5.0 (Windows NT 6.0; WOW64) AppleWebKit/534.54.16 (KHTML, like Gecko) Version/5.1.4 Safari/5.3.4.54.16
          sVersion = sRawType.suffix(")").remove_prefix("/").prefix(" ")
        elsif(sRawType =~ /Opera\//)
          # Opera 11.61 returns this:
          #   Opera/9.80 (Windows NT 6.0; U; en) Presto/2.10.229 Version/11.61
          sVersion = sRawType.suffix("/")
        else
          sVersion = "-1"
        end
        
        # puts2(sVersion)
        
        return sVersion
      end # Method - version()
      
    end  # END Class - FireWatir::Firefox
  end # Skip if using webdriver
  
  
  # Include if using webdriver
  if(is_webdriver? == true)
    #=============================================================================#
    # Class: Watir::Browser
    #
    # Description: Extends the Watir::Browser class in Watir-WebDriver with additional methods
    #              This class is is supported if using Watir_WebDriver
    #
    #--
    # Methods:
    #          moveBy(...)
    #          moveTo(...)
    #          resizeBy(...)
    #          resizeTo(...)
    #          restart(...)
    #          scrollBy(...)
    #++
    #=============================================================================#
    class Watir::Browser
      
      
      #=============================================================================#
      #--
      # Method: brand()
      #
      #++
      #
      # Description: Returns the brand of the current browser (IE, Firefox, Chrome, Safari)
      #              Uses a JavaScript object method that is recognized by most browsers.
      #              Based on info at: http://www.w3schools.com/js/js_browser.asp
      #              To debug browse this URL: javascript:alert(window.navigator.userAgent);
      #
      # Usage Examples: To verify that the current browser is a Firefox browser:
      #                    sBrand = browser.brand()
      #                    assert(sBrand == "Firefox")
      #
      #=============================================================================#
      def brand()
        
        if($bUseWebDriver == false)
          sRawType = self.execute_script("window.navigator.userAgent")
        else
          sRawType = self.execute_script("return window.navigator.userAgent")
        end
        
        if($VERBOSE == true)
          puts2(sRawType)
        end
        
        if(sRawType =~ /MSIE \d/)
          sBrand = "IE"
        elsif(sRawType =~ /Firefox\//)
          sBrand = "Firefox"
        elsif(sRawType =~ /Chrome\//)
          sBrand = "Chrome"
        elsif(sRawType =~ /Safari\/\d\.\d/)
          sBrand = "Safari"
        elsif(sRawType =~ /Opera\//)
          sBrand = "Opera"
        else
          sBrand = "Unknown"
        end
        
        # puts2(sBrand)
        
        return sBrand
        
      end # Method - brand()
      
      
      #=============================================================================#
      #--
      # Method: moveBy(...)
      #
      #++
      #
      # Description: Move the Browser window relative to its current location
      #              Per: http://www.w3schools.com/jsref/obj_window.asp
      #                   The moveBy() method is supported in all major browsers,
      #
      # Returns: BOOLEAN - true if successful, otherwise false
      #
      # Syntax: iXPos = INTEGER - The X-coordinate in pixels to re-position the top left
      #                           corner of the browser window
      #                           Default value = 0
      #
      #         iYPos = INTEGER - The Y-coordinate  in pixels to re-position the top left
      #                           corner of the browser window
      #                           Default value = 0
      #
      # Usage Examples:
      #                To reposition the browser relative to its current location by 10, -20
      #                     browser.moveBY(10, -20)
      #
      #=============================================================================#
      def moveBy(iXPos=0, iYPos=0)
        
        self.execute_script("window.moveBy(#{iXPos},#{iYPos})")
      end # moveBy()
      
      
      #=============================================================================#
      #--
      # Method: moveTo(...)
      #
      #++
      #
      # Description: Move the current Browser window to the specified location
      #                    Per: http://www.w3schools.com/jsref/obj_window.asp
      #                   The moveTo() method is supported in all major browsers.
      #
      # Returns: BOOLEAN - true if successful, otherwise false
      #
      # Syntax: iXPos = INTEGER - The X-coordinate in pixels to position the top left
      #                           corner of the browser window
      #                           Default value = 0
      #
      #         iYPos = INTEGER - The Y-coordinate  in pixels to position the top left
      #                           corner of the browser window
      #                           Default value = 0
      #
      # Usage Examples:
      #                To move the browser to 100, 200
      #                     browser.moveTo(100,200)
      #
      #=============================================================================#
      def moveTo(iXPos=0, iYPos=0)
        
        if(iXPos <0)
          iXPos = 0
        end
        if(iYPos <0)
          iYPos = 0
        end
        
        self.execute_script("window.moveTo(#{iXPos},#{iYPos})")
      end # moveTo()
      
      
      #=============================================================================#
      #--
      # Method: resizeBy(...)
      #
      #++
      #
      # Description: Resize the Browser window relative to its current size (in pixels)
      #              Per: http://www.w3schools.com/jsref/obj_window.asp
      #                   The resizeBy() method is supported in all major browsers, except Opera and Chrome.
      #
      # Returns: BOOLEAN - true if successful, otherwise false
      #
      # Syntax: iHeight = INTEGER - The width in pixels to resize the browser window
      #                             Default value = 0
      #
      #         iWidth = INTEGER - The height in pixels to resize the browser window
      #                            Default value = 0
      #
      # Usage Examples:
      #                To size the browser by an additional 100, 200
      #                     browser.resizeTo(100, 200)
      #
      #=============================================================================#
      def resizeBy(iHeight=0, iWidth=0)
        
        self.execute_script("window.resizeBy(#{iHeight},#{iWidth})")
      end # resizeTo()
      
      
      #=============================================================================#
      #--
      # Method: resizeTo(...)
      #
      #++
      #
      # Description: Move the Browser window to the specified location (in pixels)
      #              Per: http://www.w3schools.com/jsref/obj_window.asp
      #                   The resizeTo() method is supported in all major browsers, except Opera and Chrome
      #
      # Returns: BOOLEAN - true if successful, otherwise false
      #
      # Syntax: iHeight = INTEGER - The width in pixels to resize the browser window
      #                             Default value = 640
      #
      #         iWidth = INTEGER - The height in pixels to resize the browser window
      #                            Default value = 480
      #
      # Usage Examples:
      #                To size the browser to 100, 200
      #                     browser.resizeTo(1024,756)
      #
      #=============================================================================#
      def resizeTo(iHeight=640, iWidth=480)
        
        if(iHeight <1)
          iHeight = 1
        end
        if(iWidth <1)
          iWidth = 1
        end
        
        self.execute_script("window.resizeTo(#{iHeight},#{iWidth})")
      end # resizeTo()
      
      
      #=============================================================================#
      #--
      # Method: restart(...)
      #
      #++
      #
      # Description: Close the current Firefox browser object, pause,
      #              then create and return a new Firefox browser object.
      #
      # Returns: BROWSER object
      #
      # Syntax: sURL = STRING - The URL to load in the new browser, defaults to the currently loaded URL
      #         bClearCache = BOOLEAN - true - clear the cache and cookies after the old browser closes, but before the new browser starts
      #                                 false - don't clear the cache & cookies
      #
      # Usage Examples:
      #            To restart Global Browser Object with the same URL loaded:
      #                $browser = $browser.restart()
      #
      #            To restart local browser object (e.g. myCurrentBrowser) with a different url:
      #                myRestartedBrowser = myCurrentBrowser.restart("www.myNewURL.com")
      #
      #=============================================================================#
      def restart(sURL="", bClearCache=false)
        
        if($VERBOSE == true)
          puts2("Parameters - restart:")
          puts2("  sURL: " + sURL)
          puts2("  bClearCache: " + bClearCache.to_s)
        end
        
        puts2("Closing the Firefox browser...")
        
        if(sURL=="")
          sURL = self.url
        end
        
        self.close
        
        if($browser == self) # If a Global Browser Object exists remove it
          $browser = nil
        end
        
        # Allow time to mourn the passing of the old browser.
        sleep 3  # That's long enough to mourn
        
        if(bClearCache == true)
          clear_cache()
        end
        
        puts2("Starting a new Firefox browser object...")
        
        # Create a new browser object using Watir's method directly
        # Can't use start_Browser() as both local and Global Browser's may coexist
        oBrowser = FireWatir::Firefox.new()
        oBrowser.goto(sURL)
        
        # Allow time to celebrate the birth of the new browser.
        sleep 2  # That's long enough to celebrate
        
        return oBrowser  # Return the new browser.
        
      end # END Method - restart_browser()
      
      
      #=============================================================================#
      #--
      # Method: scrollBy(...)
      #
      #++
      #
      # Description: Scroll the current Browser window (in pixels)
      #              Per: http://www.w3schools.com/jsref/obj_window.asp
      #                   The ScrollBy() method is supported in all major browsers.
      #
      # Returns: BOOLEAN - true if successful, otherwise false
      #
      # Syntax: iHorizontal = INTEGER - How many pixels to scroll by, along the x-axis (horizontal)
      #                                 Positive values move scroll left, Negative values move scroll right
      #                                 Default value = 0
      #
      #         iVertical= INTEGER - How many pixels to scroll by, along the y-axis (vertical)
      #                              Positive values move scroll down, Negative values move scroll up
      #                              Default value = 0
      #
      # Usage Examples:
      #                To scroll the browser vertically by  100 pixels
      #                     browser.scrollBy(0, 100)
      #
      #=============================================================================#
      def scrollBy(iHorizontal=0, iVertical=0)
        
        self.execute_script("window.scrollBy(#{iHorizontal},#{iVertical})")
      end # scrollBy()
      
      
      #=============================================================================#
      #--
      # Method: version()
      #
      #++
      #
      # Description: Returns the version of the current browser.
      #              Uses a JavaScript object method that is recognized by most browsers.
      #              Based on info at: http://www.w3schools.com/js/js_browser.asp
      #              To debug browse this URL: javascript:alert(window.navigator.userAgent);
      #
      # Usage Examples: To verify that the current Firefox browser's version is > 9:
      #                    sVersion = browser.version()
      #                    assert(sVersion >= "9")
      #
      #=============================================================================#
      def version()
        
        if($bUseWebDriver == false)
          sRawType = self.execute_script("window.navigator.userAgent")
        else
          sRawType = self.execute_script("return window.navigator.userAgent")
        end
        
        if($VERBOSE == true)
          puts2(sRawType)
        end
        
        if(sRawType =~ /MSIE \d/)
          # IE 8.0 returns this:
          #   Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 6.0; WOW64; Trident/4.0; SLCC1; .NET CLR 2.0.50727; Media Center PC 5.0; .NET CLR 3.5.30729; .NET CLR 3.0.30729; .NET4.0C; MS-RTC LM 8)
          sVersion = sRawType.remove_prefix(";").prefix(";").remove_prefix(" ")
        elsif(sRawType =~ /Firefox\//)
          # Firefox 3.6.28 returns this:
          #   Mozilla/5.0 (Windows; U; Windows NT 6.0; en-US; rv:1.9.2.28) Gecko/20120306 Firefox/3.6.28
          sVersion = sRawType.suffix("/").prefix(" ")
        elsif(sRawType =~ /Chrome\//)
          # Chrome 17.0.963.79 returns this:
          #   Mozilla/5.0 (Windows NT 6.0; WOW64) AppleWebKit/535.11 (KHTML, like Gecko) Chrome/17.0.963.79 Safari/535.11
          sVersion = sRawType.suffix(")").remove_prefix("/").prefix(" ")
        elsif(sRawType =~ /Safari\/\d\.\d/)
          # Safari 5.1.4 returns this:
          #   Mozilla/5.0 (Windows NT 6.0; WOW64) AppleWebKit/534.54.16 (KHTML, like Gecko) Version/5.1.4 Safari/5.3.4.54.16
          sVersion = sRawType.suffix(")").remove_prefix("/").prefix(" ")
        elsif(sRawType =~ /Opera\//)
          # Opera 11.61 returns this:
          #   Opera/9.80 (Windows NT 6.0; U; en) Presto/2.10.229 Version/11.61
          sVersion = sRawType.suffix("/")
        else
          sVersion = "-1"
        end
        
        # puts2(sVersion)
        
        return sVersion
      end # Method - version()
      
    end  # END Class - Watir::Browser
  end # Include if using Watir WebDriver
  
  
  
  # Skip if using webdriver
  if(is_webdriver? != true)
    #=============================================================================#
    # Class: FireWatir::SelectList
    #
    # Description: Extends the FireWatir::SelectList class with additional methods
    #              This class is is NOT supported if using Watir_WebDriver
    #
    #--
    # Methods: wait_until_count()
    #          wait_until_text()
    #++
    #=============================================================================#
    class FireWatir::SelectList
      
      
      #=============================================================================#
      #--
      # Method: wait_until_count(...)
      #
      #
      #++
      #
      # Description: Checks a select list to verify that it contains the specified number of items.
      #              If the select list does not contain the specified number of items it loops and
      #              continues to loops once each specified Interval until the Timeout is exceeded.
      #
      # HINT: Use with auto-populated select lists that take a period of time before they are complete
      #
      #
      # Returns: BOOLEAN - true if number of items in select list meets or exceeds the specific minimum
      #                    otherwise false if timed out
      #
      # Syntax: iMin = INTEGER - The Minimum number of items in the select list
      #         iInterval = INTEGER - The number of second to wait between loops
      #         iTimeout = INTEGER -  Number of seconds to wait for the event to occur
      #
      # Usage Examples:
      #                To verify the the select list is populated with as least 4 items,
      #                waiting up to 10 seconds checking every 2 seconds:
      #                     browser.select_list(:how, what).wait_until_count(4, 10, 1)
      #
      #=============================================================================#
      def wait_until_count(iMin, iTimeout=10, iInterval=0.1)
        
        if($VERBOSE == true)
          puts2("Parameters - wait_until_count:")
          puts2("  iMin: " + iMin.to_s)
          puts2("  iTimeout: " + iTimeout.to_s)
          puts2("  iInterval: " + iInterval.to_s)
        end
        
        # Disallow values less that one
        if(iTimeout <= 1)
          iTimeout = 1
        end
        
        if(iInterval <= 0.1)
          iInterval = 0.1
        end
        
        if(iMin <= 0)
          iMin = 0
        end
        
        if($VERBOSE == true)
          puts2("Number of select list items: " +     self.options.length.to_s)
        end
        
        tStartTime = Time.now
        tElapsedTime = 0
        
        # Loop until the select list's item count is
        # reached the specified timeout is exceeded
        while ((self.options.length < iMin) && (tElapsedTime <= iTimeout)) do
          
          if($VERBOSE == true)
            puts2("Number of select list items: " +     self.options.length.to_s)
          end
          
          sleep iInterval
          tElapsedTime = calc_elapsed_time(tStartTime).to_f
          
        end # Loop
        
        # In case the timeout was reached need to check once more to set the return status
        return (self.options.length >= iMin)
        
      end # Method - wait_until_count(...)
      
      
      #=============================================================================#
      #--
      # Method: wait_until_text(...)
      #
      #++
      #
      # Description: Checks a select list to verify that it contains the specified text.
      #              If the select list does not contain the specified text it loops and
      #              continues to loops once each specified Interval until the Timeout is exceeded.
      #
      # HINT: Use with auto-populated select lists that take a period of time before they are complete
      #
      #
      # Returns: BOOLEAN - true if text in select list it found
      #                    otherwise false if timed out
      #
      # Syntax: sString = STRING - The text to find in the select list's contents
      #         iInterval = INTEGER - The number of second to wait between loops
      #         iTimeout = INTEGER -  Number of seconds to wait for the event to occur
      #
      # Usage Examples:
      #                To verify the the select list is populated with a value of "All the above",
      #                waiting up to 10 seconds checking every 2 seconds:
      #                     browser.select_list(:how, what).wait_until_text("All the above", 10, 1)
      #
      #=============================================================================#
      def wait_until_text(sString="", iTimeout=10, iInterval=0.1)
        
        if($VERBOSE == true)
          puts2("Parameters - wait_until_text:")
          puts2("  sString: " + sString.to_s)
          puts2("  iTimeout: " + iTimeout.to_s)
          puts2("  iInterval: " + iInterval.to_s)
        end
        
        # Define a starting values
        aContents = []
        
        # Disallow values less that one
        if(iTimeout <= 1)
          iTimeout = 1
        end
        
        if(iInterval <= 0.1)
          iInterval = 0.1
        end
        
        tStartTime = Time.now
        tElapsedTime = 0
        
        # Loop until the select list contains the specified text
        # or timeout is exceeded
        while ((aContents.to_s !~ /#{sString}/) && (tElapsedTime <= iTimeout)) do
          
          aContents = self.options.to_s
          
          if($VERBOSE == true)
            puts2("Select list text: " + aContents.to_s)
          end
          
          sleep iInterval
          tElapsedTime = calc_elapsed_time(tStartTime).to_f
          
        end # Loop
        
        # In case the timeout was reached need to check once more to set the return status
        return(self.options.to_s =~ /#{sString}/)
        
      end # Method - wait_until_text(...)
      
    end # Class FireWatir::SelectList
    
  end # Skip if using webdriver
  
  
  #=============================================================================#
  # Class: Fixnum
  #
  # Description: Extends the Ruby Fixnum class with additional methods
  #
  #              For backwards compatibility with Watir/WatirWorks
  #
  #      Based on info at: http://stackoverflow.com/questions/6550179/does-watir-webdriver-resolve-the-difference-in-indexing-bases-between-watir-and-f   #--
  # Methods: adjust_index()
  #++
  #=============================================================================#
  class Fixnum
    
    #=============================================================================#
    #--
    # Method: adjust_index()
    #
    #++
    #
    # Description: Provide compatibility between Watir-Webdriver and Watir
    #              Watir supports one based indexing, while
    #              Watir-WebDriver supports zero based indexing
    #
    #             This allows the specification all indexes as 1 based.
    #             Which is also used with self.length values in Watir-WebDriver.
    #
    # Returns: INT - The adjusted index
    #
    # Syntax: N/A
    #
    # Usage Examples:
    #                To adjust the index number if running under WatirWebDriver
    #                    The first div:
    #                     browser.div(:index => 1.adjust_index)
    #                    The last div:
    #                     browser.div(:index => divs.length.adjust_index)
    #
    #=============================================================================#
    def adjust_index()
      #Config.webdriver? ? self - 1 : self
      if(is_webdriver? == true)
        return self - 1
      else
        return self
      end
      
    end # adjust_index
  end # Class Fixnum
  
  
  
  
  #=============================================================================#
  # Class: String
  #
  # Description: Extends the Ruby String class with additional methods
  #
  #              For backwards compatibility with Watir/WatirWorks
  #
  #
  # Methods: xx()
  #++
  #=============================================================================#
  class String
    
  end # Class String
  
  
  
  
  
  # Include if using webdriver
  if(is_webdriver? == true)
    
    #=============================================================================#
    # Class: Watir::Table
    #
    # Description: Extends the Watir::Table class in Watir-WebDriver with additional methods
    #              This class is is only supported if using Watir_WebDriver
    #
    #              For backwards compatibility with Watir/WatirWorks
    #
    #      Based on info at: http://stackoverflow.com/questions/5963606/watir-webdriver-checking-table-size-rows-and-columns-count
    #--
    # Methods: row_count()
    #++
    #=============================================================================#
    class Watir::Table
      
      #=============================================================================#
      #--
      # Method: column_count()
      #
      #++
      #
      # Description: Provide backwards compatibility in Watir-Webdriver to Watir
      #
      #
      # Returns: INT - Number of columns in a table's first row
      #
      # Syntax: N/A
      #
      # Usage Examples:
      #                To count the number of columns
      #                     iNumber_of_columns = browser.table(:how, what).row(:how, what).column_count
      #
      #=============================================================================#
      def column_count()
        return self.row.cells.length
      end
      
      #=============================================================================#
      #--
      # Method: row_count()
      #
      #++
      #
      # Description: Provide backwards compatibility in Watir-Webdriver to Watir
      #
      #
      # Returns: INT - Number of rows in a table
      #
      # Syntax: N/A
      #
      # Usage Examples:
      #                To count the number of rows:
      #                     iNumber_of_rows = browser.table(:how, what).row_count
      #
      #=============================================================================#
      def row_count()
        return self.rows.length
      end
      
      
      #=============================================================================#
      #--
      # Method: row_values()
      #
      #++
      #
      # Description: Provide backwards compatibility in Watir-Webdriver to Watir
      #
      #
      # Returns: ARRAY of STRINGS - All the strings in the specified row.
      #          Raises an UnknownObjectException if the table doesn�t exist
      #
      # Syntax: iRowNumber = INTEGER - Index of the Row
      #
      # Usage Examples:
      #                To get all the strings within row 2:
      #                     aText_in_rows = browser.table(:how, what).row_values(2)
      #
      #=============================================================================#
      def row_values(iRowNumber)
        
        #return self.row(:index => iRowNumber.adjust_index).to_a
        
        #return (1..column_count()).collect {|i| self.row[iRowNumber][i].text}
        #return (1..column_count(iRowNumber)).collect {|i| self.row[iRowNumber][i].text}
        
        aStrings = []
        iColumnCount = self.row(:index => iRowNumber.adjust_index).column_count
        iLast_column = iColumnCount -1
        iCurrent_column = 0
        
        while iCurrent_column < iLast_column do
          aStrings << self.row(:index => iRowNumber.adjust_index).cell(:index => iCurrent_column.adjust_index).text
          iCurrent_column = iCurrent_column + 1
        end
        
        return aStrings
        
      end # Method row_values
      
    end # Class Watir::Table
    
    #=============================================================================#
    # Class: Watir::TableRow
    #
    # Description: Extends the Watir::TableRow class in Watir-WebDriver with additional methods
    #              This class is is only supported if using Watir_WebDriver
    #
    #              For backwards compatibility with Watir/WatirWorks
    #
    #      Based on info at: http://stackoverflow.com/questions/5963606/watir-webdriver-checking-table-size-rows-and-columns-count
    #--
    # Methods: column_count()
    #++
    #=============================================================================#
    class Watir::TableRow
      
      #=============================================================================#
      #--
      # Method: column_count()
      #
      #++
      #
      # Description: Provide backwards compatibility in Watir-Webdriver to Watir
      #
      #
      # Returns: INT - Number of columns in a table's row
      #
      # Syntax: N/A
      #
      # Usage Examples:
      #                To count the number of columns
      #                     iNumber_of_columns = browser.table(:how, what).row(:how, what).column_count
      #
      #=============================================================================#
      def column_count()
        return self.cells.length
      end
      
    end # Class Watir::Table
    
    
    #=============================================================================#
    # Class: Watir::Select
    #
    # Description: Extends the Watir::Select class in Watir-WebDriver with additional methods
    #              This class is is only supported if using Watir_WebDriver
    #
    #--
    # Methods: wait_until_count()
    #          wait_until_text()
    #++
    #=============================================================================#
    class Watir::Select
      
      #=============================================================================#
      #--
      # Method: wait_until_count(...)
      #
      #++
      #
      # Description: Checks a select list to verify that it contains the specified number of items.
      #              If the select list does not contain the specified number of items it loops and
      #              continues to loops once each specified Interval until the Timeout is exceeded.
      #
      # HINT: Use with auto-populated select lists that take a period of time before they are complete
      #
      #
      # Returns: BOOLEAN - true if number of items in select list meets or exceeds the specific minimum
      #                    otherwise false if timed out
      #
      # Syntax: iMin = INTEGER - The Minimum number of items in the select list
      #         iInterval = INTEGER - The number of second to wait between loops
      #         iTimeout = INTEGER -  Number of seconds to wait for the event to occur
      #
      # Usage Examples:
      #                To verify the the select list is populated with as least 4 items,
      #                waiting up to 10 seconds checking every 2 seconds:
      #                     browser.select_list(:how, what).wait_until_count(4, 10, 1)
      #
      #=============================================================================#
      def wait_until_count(iMin, iTimeout=10, iInterval=0.1)
        
        if($VERBOSE == true)
          puts2("Parameters - wait_until_count:")
          puts2("  iMin: " + iMin.to_s)
          puts2("  iTimeout: " + iTimeout.to_s)
          puts2("  iInterval: " + iInterval.to_s)
        end
        
        # Disallow values less that one
        if(iTimeout <= 1)
          iTimeout = 1
        end
        
        if(iInterval <= 0.1)
          iInterval = 0.1
        end
        
        if(iMin <= 0)
          iMin = 0
        end
        
        tStartTime = Time.now
        tElapsedTime = 0
        
        if($VERBOSE == true)
          puts2("Number of select list items: " +     self.options.length.to_s)
        end
        
        # Loop until the select lists's item count
        # reached the specified minimum or timeout is exceeded
        while ((self.options.length < iMin) && (tElapsedTime <= iTimeout)) do
          
          if($VERBOSE == true)
            puts2("Number of select list items: " +     self.options.length.to_s)
          end
          
          sleep iInterval
          tElapsedTime = calc_elapsed_time(tStartTime).to_f
          
        end # Loop
        
        # In case the timeout was reached need to check once more to set the return status
        return(self.options.length >= iMin)
        
      end # Method - wait_until_count(...)
      
      #=============================================================================#
      #--
      # Method: wait_until_text(...)
      #
      #++
      #
      # Description: Checks a select list to verify that it contains the specified text.
      #              If the select list does not contain the specified text it loops and
      #              continues to loops once each specified Interval until the Timeout is exceeded.
      #
      # HINT: Use with auto-populated select lists that take a period of time before they are complete
      #
      #
      # Returns: BOOLEAN - true if text in select list it found
      #                    otherwise false if timed out
      #
      # Syntax: sString = STRING - The text to find in the select list's contents
      #         iInterval = INTEGER - The number of second to wait between loops
      #         iTimeout = INTEGER -  Number of seconds to wait for the event to occur
      #
      # Usage Examples:
      #                To verify the the select list is populated with a value of "All the above",
      #                waiting up to 10 seconds checking every 2 seconds:
      #                     browser.select_list(:how, what).wait_until_text("All the above", 10, 1)
      #
      #=============================================================================#
      def wait_until_text(sString="", iTimeout=10, iInterval=0.1)
        
        if($VERBOSE == true)
          puts2("Parameters - wait_until_text:")
          puts2("  sString: " + sString.to_s)
          puts2("  iTimeout: " + iTimeout.to_s)
          puts2("  iInterval: " + iInterval.to_s)
        end
        
        # Disallow values less that one
        if(iTimeout <= 1)
          iTimeout = 1
        end
        
        if(iInterval <= 0.1)
          iInterval = 0.1
        end
        
        tStartTime = Time.now
        tElapsedTime = 0
        
        # Loop until the select list contains the specified text
        # or timeout is exceeded
        while ((self.include?(/#{sString}/) == false) && (tElapsedTime <= iTimeout)) do
          
          if($VERBOSE == true)
            puts2("Select list text: " + self.options.to_s)
          end
          
          sleep iInterval
          tElapsedTime = calc_elapsed_time(tStartTime).to_f
          
        end # Loop
        
        # In case the timeout was reached need to check once more to set the return status
        return (self.include?(/#{sString}/))
        
      end # Method - wait_until_text(...)
      
    end # Class Watir::Select
    
  end  #  Include if using webdriver
  
  # END File: watirworks_web-utilities.rb
