=begin rdoc

= WatirWorks 0.1.4   Sep. 2011

== New Features
  * Initial port for working with Watir-WebDriver or with Watir / Firewatir
  * WatirWorks_Utilites, and WatirWorks-RefLib work with JRuby.
    Due to Watir not being supported under JRuby, other WatirWorks modules are unable to be supported under JRuby.
  * Added methods for Firefox v6, v7 (such as is_ff6?(), and is_firefox6_installed?()
  * Added methods to WatiwWorks_Utilities:
      is_webdriver?()
      Fixnum#adjust_index()
      display_os_environment()
      display_ruby_loaded_files()
      display_ruby_global_variables()
  * Wrapped Classes and methods specific to: Watir, Firewatir, or WatirWebDriver in "if statements"
  * Methods to check the browser type now work with either Watir / Firewatir or Watir-WebDriver: is_ie?(), is_firefox?()
  * Added methods to check the browser type with Watir-WebDriver: is_chrome?(), is_android?(), is_opera?(), is_safari?()



== Fixes
  * Update several Watir command to v1.9.2 syntax (some were deprecated in Watir v1.6.x):
    Camel cased methods replaced:
      Container#checkBox  = checkbox
      Checkbox#isSet? = set?
      Image#hasLoaded?    = loaded?
      Image#fileSize      = file_size
      Image#fileCreatedDate = file_created_date
      Radio#isSet?          = set?
      SelectList#getSelectedItems  = selected_options
      SelectList#getAllContents    = options
      SelectList#clearSelection    = clear
      TextField#getContents        = text

  * Corrected typo in the file name of watirworks_calc_time_unittest.rb
  * Removed screen capture dependency from functions: is_TextIn_DivClass(), is_TextIn_DivID(),is_TextIn_DivIndex(),is_TextIn_DivXpath()
  * Removed screen capture dependency from functions: is_TextIn_SpanClass(), is_TextIn_SpanID(),is_TextIn_SpanIndex(),is_TextIn_SpanXpath()
  * Removed screen capture dependency from functions: is_TextIn_TableClass(), is_TextIn_TableID(),is_TextIn_TableIndex(),is_TextIn_TableXpath(), is_TextIn_TableName()

== Deprecated:
  * display_browser_env(), get_doc_app_version()
  * get_hwnd_js_dialog()
  * handle_js_dialog()
  * Deprecated library Xls.rb, and methods parse_spreadsheet_xls(), parse_workbook_xls()

== Known issues
  * Watir 1.9.2 has no equivalent for these deprecated Watir methods:
      Watir::Checkbox.getState # Removed its use in WatirWorks
      Watir::Radio.getState    # Removed its use in WatirWorks

  * SafariWatir has no equivalent for these Watir methods:
      Watir::Browser.status
      Watir::Browser.attach
      Watir::Element.hidden
      Watir::ScreenCapture
      Watir::Element.radios
      Watir::SelectList.options

  * Watir WebDriver has no equivalent for these Watir methods:
      Watir::Table.row_values
      Watir::Element tag attribute :name
      Watir::Select.clear   (Only supports Multi-select lists)
      Watir::ScreenCapture

  * WatirWorks
    * Function parse_table_by_row() returns an incomplete array of the text within the table, its skipping some rows and columns
    * methods that rely in parse_tabe_by_row() will also fail, this includes:
    * IE hangs when using methods: moveBy(), moveTo(), resizeBy(), resizeTo(), scrollBy()
    * parse_spreadsheet() - Reading to end of contents (not just to first row starting with a blank cell), is not working properly
    * Some unittests run OK from the command line, but fail when run from within the Eclipse IDE (watirworks_spreadsheet_unittest.rb, watirworks_xls_unittest.rb)
    * Methods wait_until_count() and wait_until_text() not supported for SafariWatir
    * Reliability issues connecting to Opera
    * SafariWatir can not access the Browser's Status bar, hard coded a 2 sec. sleep for Safari in wait_until_status() which is not reliable.

= WatirWorks 0.1.3   Aug. 2011

== New Features
  * Added support for determining if Firefox 4 or 5 is installed.
== Bug Fixes
  * Put all extensions of the classes Watir:Element and Watir:IE into watirworks_win-utilites.rb
  * Edited exit_browsers() to cover platforms currently not supported by RAutomation

== Known issues
  * IE hangs when using methods moveBy(), moveTo(), resizeBy(), resizeTo(), scrollBy()
  * parse_spreadsheet() - Reading to end of contents (not just to first row starting with a blank cell) is not working properly
  * Some unittests (watirworks_spreadsheet_unittest.rb, watirworks_xls_unittest.rb), run OK from the command line but will fail when run from within Eclipse.

= WatirWorks 0.1.2   July 2011

== New Features
  * None
== Bug Fixes
  * generate_testcode_html_tag_attributes(), display_watirworks_env(), capture_results(), minimize_ruby_console()

== Known issues
  * IE hangs when using methods moveBy(), moveTo(), resizeBy(), resizeTo(), scrollBy()
  * parse_spreadsheet() - Reading to end of contents (not just to first row starting with a blank cell) is not working properly

= WatirWorks 0.1.1

== New Features
  * Updated for Ruby1.8.7, and Watir 1.9.0
  * Switched to use of rAutomation instead of AutoIt
  * Added methods for use with roo.rb,  parse_spreadsheet(), parse_workbook(). Roo.rb is is a library for reading Excel (.xls, .xlsx) or OpenOffice(.ods) workbooks without Excel or OpenOffice installed.
  * Deprecated methods that requires XLS.rb, parse_spreadsheet_xls(), parse_workbook_xls()
  * Removed library XlsEx.rb, since it was not used by WatirWorks
  * Added installation dependencies for WatirWorks gem, including roo.rb and its sub-dependencies.

== Bug Fixes
  * RDoc cleanup, typos and such
  * Updated method display_watir_env() to use Waitr::VERSION as set in Commonwatir
  * Rearranged unittests. Moved tests form some methods to more logical files.

== Known issues
  * IE hangs when using methods moveBy(), moveTo(), resizeBy(), resizeTo(), scrollBy()
  * parse_spreadsheet() - Reading to end of contents (not just to first row starting with a blank cell) is not working properly

= WatirWorks 0.1.0

== New Features

This is the initial public release of WatirWorks so everything is a new feature including:

  * The WatirWorks Reference Library (watirworks_reflib.rb)
  * The WatirWorks Utilities Library (watirwork_utilites.rb)
  * The WatirWorks Web Utilities Library (watirwork_web-utilities.rb)
  * The WatirWorks Windows Utilities Library (watirwork_win-utils.rb)
  * The WatirWorks Linux Utilities Library (watirwork_linux-utils.rb)
  * The WatirWorks MacOSX Utilities Library (watirwork_mac-utils.rb)
  * The WatirWorks auto-loader (watirworks.rb)
  * The Open Source Excel Interface Library (Xls.rb)
  * The Open Source Excel Extras Library (XlsEx.rb)
  * The WatirWorks history file (history.rb)
  * The WatirWorks Read me file (README.rb)
  * The WatirWorks Users Guide (USER_GUIDE.rb)
  * The WatirWorks Dictionary (dictionary_en.txt)
  * Information on Open Source and Free Editors you can use. See README_FreeEditors.rb:
    * SciTE - Scintilla Text Editor
    * RDE - Ruby Development Environment
    * FreeRIDE - An IDE written in Ruby
    * TestWise - A IDE with recorder
    * Aptana RadRails -  The Aptana Studio IDE with the Ruby plug-in
  * Example files including:
    * Example test suite and test files
    * A user configurable, data driven tool to monitor a set of web sites (sitemonitor.rb)
    * Support files for the Site Monitor and the Example files
  * The WatirWorks Unit tests

== Bug Fixes

* N/A as this is the initial release

== Known issues

=== Watir/FireWatir
* click_no_wait - Issues with Ruby 1.8.7, Issues with JSDialogs on Vista -
  http://jira.openqa.org/browse/WTR-320
* Nested tables - http://jira.openqa.org/browse/WTR-26
* check_for_http_error - Not updated for IE8, only supports IE6, IE7 -
  http://jira.openqa.org/browse/WTR-434
* check_for_http_error - No comparable method for FireWatir1.6.5
* forms - Method NOT supported by FireWatir1.6.5
* restore - Method NOT supported by FireWatir1.6.5
* hwnd - Method NOT supported by FireWatir1.6.5
* enabled_popup - Method NOT supported by FireWatir1.6.5
* url - Method returns blank in Firefox1.6.5 -
  http://jira.openqa.org/browse/WTR-428
* set_no_wait - Method missing in Watir1.6.5 -
  http://jira.openqa.org/browse/WTR-182 -
  http://jira.openqa.org/browse/WTR-185 -
  http://jira.openqa.org/browse/WTR-278
* AutoIt ActiveX Control library (AutoItX3.dll) bundled with Watir1.6.5 is a very old version -
  http://jira.openqa.org/browse/WTR-440
* FireWatir method Firefox#status incorrectly using   #{WINDOW_VAR}  instead of   #{window_var} -
  http://jira.openqa.org/browse/WTR-441
* Error message on Ubuntu - "Gdk-WARNING **: XID collision, trouble ahead"
  http://ubuntuforums.org/showthread.php?p=7506398
=end
