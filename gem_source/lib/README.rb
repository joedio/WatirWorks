=begin rdoc

:title:WatirWorks Rdoc

Copyright (c) 2008-2015, Joe DiMauro. All rights reserved.

= Welcome to WatirWorks!

== Introduction

WatirWorks is a test toolkit for Ruby, Watir, FireWatir.

Its a collection of information and utilities written in Ruby and Watir for developing and executing automated tests.
Its focused at testers who are just starting to use Ruby/Watir. As such it is highly documented to help get folks on board. While
Ruby and Watir to some extent are more of a programming language than a toolkit WatirWorks aims to provide several tools for your
toolkit.

WatirWorks provides tools to support testing Web Application's at the GUI level, as well as tools to support testing of non-GUI based applications.
Additionally WatirWorks bundles a few Open Source Ruby libraries and functions that lacked their own gem installers. They're included to save time in locating and installing them. Some of those bundled libraries lacked RDocs, so WatirWorks has generated and included RDoc's for them as well.

WatirWorks contains the means to:
* Aggregate test files into test suites, while still retaining the ability to run any test individually
* Collect output generated from a test run (log files, screen captures, etc), into a common results directory
* Autoload commonly used modules
* Support Data Driven testing
* Utilize Reference data, and common methods to expedite test development

WatirWorks also contains:
* A Reference library ( watirworks_reflib.rb ) with many useful sets of data, such as:
  * United States Postal Service abbreviations (per http://usps.com)
  * Canadian province abbreviations (per http://canadaonline.about.com)
  * Mexico State abbreviations (per www.iowa.gov/tax/forms/84055.pdf)
  * Country Codes recognized by the United Nations
  * A list of Top-Level-Domains (per http://icann.org)
* A dictionary file (dictionary_en.txt) and methods to access it
* Web utilities for testing of GUI based applications via Watir's supported web browsers (Internet Explorer, FireFox)
* Full RDoc documentation
* Open Source libraries to access Microsoft Excel workbooks by liujunjun (Xls.rb, XlsEx.rb) http://code.google.com/p/wwatf/source/browse/#svn/trunk/util
  and David Brown   http://wiki.openqa.org/display/WTR/Excel+interface+class
* Methods that add or extend the abilities of Ruby and Watir:
  * General Utilities (watirworks_utilities.rb)
  * Web Application Utilities (watirworks_web-utilities.rb)
  * Windows Utilities (watirworks_win-utilities.rb)
  * Linux Utilities (watirworks_linux-utilities.rb)
  * OSX Utilities (watirworks_mac-utilities.rb)
* A Web Site Monitor tool that can be configured for multiple web sites and send email if a site is inaccessible
* Information on some OpenSource and Free Editors/IDE's that work well with Ruby/Watir:
  * SciTE - The Scintilla Text Editor
  * TestWise - A Watir Development Environment with a recorder
  * RDE - The Ruby Development Environment
  * FreeRIDE - A Ruby IDE written in Ruby
  * Aptana RadRails - Aptana Studio with a plug-in for the Ruby on Rails Development Environment
* Unit tests and Example files for WatirWorks

WatirWorks runs on the Windows platforms supported by Ruby and Watir, and under the IE and Firefox web browsers supported by Watir.
It has been tested on Linux using both Ubuntu 10.04 and Debian 5.04, with Firefox 3.6.x.
Sorry but it hasn't been tested on OSx, or with the SafariWatir, OperaWatir, ChormeWatir or FlashWatir gems.

= WatirWorks Examples

WatirWorks contains examples of tests, some of which are data driven. Those data driven examples read data from the spreadsheets of a MS Excel workbook.
Allowing the control of the test execution as well as the testing data from the workbook. Thus the test run can be customized by editing the workbook and not having to edit multiple test files.

Current examples include:
* Templates
  * A template file for creating your Test Suite (Example_testsuite.rb)
  * A template file for creating your Test (Example_test.rb)
* SiteMonitor
  * A Ruby/Watir utility to monitor a list of URL's
  * A data driven tool that reads input data from an MS Excel workbook
  * It then tries to access the URL's specified in that workbook
  * If any of the URL's are not accessible it sends an email to the users specified in the workbook
  * You will need to update the workbook (site_monitor_data.xls) with your specific data
* Example Web Browser Test Suite (Google_testsuite.rb)

The WatirWorks examples reside under the folder:
     <RubyInstallDir>\lib\ruby\gems\<ruby-version>\gems\WatirWorks-<version>\examples\

= WatirWorks Unit Tests

The Unit tests can be run using an IDE like SciTE, RDE or Aptana, or run from a cmd shell. They can be run individually, or run collectively as a WatriWorks testsuite.
To run them collectively as a testsuite run UnitTest_Testsuite.rb, otherwise run the individual test file (*.unittest.rb).

The unit tests are relatively well commented to help you understand what their intended purpose.
They contain information on how to run them in either SciTE or from a command prompt.

Some of the WatirWorks unit tests record output to a log file.

One of the features of the WatirWorks is that STDOUT and STDERR are captured in a log file. That log file is time-stamped and resides in the folder 'results'
Each time a unit test is run , or when multiple test are run as a testsuite, the results folder from the last run
is NOT overwritten. The pre-existing results folder's is re-named by appending a time-stamp to the folder name, and a new results folder is created.
This allows the output from multiple runs to be saved, and compared against other runs.
Be sure to manually clean-up the old results folders when you are done.

The unit tests for WatirWorks reside under the folder:
     <RubyInstallDir>\lib\ruby\gems\<ruby_version>\gems\WatirWorks-<version>\unittests


= SETUP

Prerequisites: Ruby1.8.7, Watir1.9.0

To use WatirWorks you will need to perform the following:
* Install Ruby
  * See information at:	http://ruby-lang.org
  * Note that Ruby 1.8.6 is the version recommended by Watir prior to Watir1.9.0.
  * Note there is no 64-bit version of Ruby1.8.x so if you are on a 64-bit system you may be out of luck, and will need to install the win32 versions.
  * Install from a user account with Administrative rights
  * On Windows install via the One-step-installer
  * IMPORTANT - On Vista and Windows 7 launch the installer by right clicking on it and selecting 'Run as Administrator'
  * On other platforms install from the Zip file
  * Verify the Ruby install by opening a Windows Command Shell and entering each of the following commands:
      ruby -v	# Launch the Ruby executable and display the version
      irb -v	# Launch the Interactive Ruby executable and display the version
      gem -v	# Launch the Gem executable and display the version
      gem env	# Launch the Gem executable and display various environmental settings
      gem list --local	# Launch the Gem executable and display the list of installed gems and their versions

  * Verify that Ruby's bin directory is in the System search path
      SET PATH
      PATH=C:\Ruby\bin;%PATH%
  * Verify that the Systems Env Var 'RUBYOPT' is set:
      SET RUBYOPT
      RUBYOPT=-rubygems

* Ruby is needs to be updated for Watir to install and run properly. On Vista or Windows 7 its necessary to open a command prompt by right clicking on Cmd.exe and selecting 'Run as Administrator'
From the Console type the following commands:
      gem update --system	# Updates the Gem installer

* Re-verify the Ruby install

* Install Watir 1.9.x

  Watir is packaged as a gem and installs over the Internet. See information at http://watir.com/
  * To install the latest version of Watir, )and it's RDocs) at a command prompt type:
      gem install watir -d

    Several prerequisites for Watir will also be installed

* If you are installing Watir 1.6.5 or earlier on a 64-bit system the AutoItX3.dll may not register properly. This will be apparent if your try to use Watir's methods that use AutoIt, (e.g. browser.minimize, browser.maximize, etc).
  To resolve this issue, after the Watir install is completed manually register AutoItX3.dll (which is installed with the Watir gem), by running this command:
    C:\Windows\SysWOW64\regsvr32.exe   C:\Ruby\lib\ruby\gems\1.8\gems\watir-1.6.5\lib\watir\AutoItX3.dll

  Be sure to open the Windows Console (CWINDOWS\sytem32\cnd.exe) by right clicking it and selecting "Run as administrator), and of course change the path if your install differs.

* If you will be using Firefox follow the instruction on the Watir download page: http://watir.com/installation/
  to install the proper jssh addon for the Windows and Firefox version, and modify the Firefox shortcuts by adding -jssh to Window's shortcut target.

* Set a Windows System Env Var for the browser of your choice:
     watir_browser = ie   or   watir_browser = firefox

* Verify the Watir install from a Console using the Interactive Ruby command:
	C:\>irb
	irb(main):001:0> require 'watir'
	=> true
	irb(main):002:0> browser=Watir::Browser.new
	=> #<Watir::IE:0x32e4750 url="about:blank" title="">
	irb(main):003:0> browser.goto "http://gogle.com"
	=> 6.531
	irb(main):004:0> browser.close
	=> nil
	irb(main):005:0> exit

* These Gem dependencies should Download and install with WatirWorks. THeya re listed her in case you want to manually install them:
     gem install roo -v 1.9.3
     gem install rubyzip -v 0.9.4
     gem install spreadsheet -v 0.6.5.4
     gem install google-spreadsheet-ruby -v 0.1.5

* Download and install WatirWorks

  If all is working up to this point proceed to the WatirWorks installation.
  From the Console type the following command:

   gem install <Path-to-WatirWorks_gem>

   (e.g. gem install C:\Windows\temp\watirworks-1.0.1.gem )

* Optionally on Windows you may want to update to the latest version of AutoIt3
  This is only necessary if using a Watir version prior to Watir 1.8.x

  AutoIt3 is a freeware scripting language designed for automating the Windows GUI.
  The AutoIt v3 ActiveX Control library (AutoItX3.dll) bundled with Watir1.6.5 is a
  very old version, (version 3.1.1.0), built back in 2005. As of 6/1/2010 the version
  of the library that is distributed with AutoIt's installer is version 3.3.6.1
  See AutoIt's change log for details on the changes (from 3.1.1.0 to the current version):
  http://www.autoitscript.com/autoit3/docs/history.htm

  Some methods in WatirWorks utilize AutoIt3 functions (e.g. WinList) that do NOT exist
  in the version of the AutoItX3.dll bundled with Watir 1.6.5 or previous versions of Watir.

  For more info on using AutoIt3 see: http://www.autoitscript.com/autoit3/docs/functions.htm

  The current version of AutoIt3 is available as a free download at: http://www.autoitscript.com/

  To upgrade Watir 1.6.5 to use the current version of the AutoItX.dll:
  * Download and install the current AutoIt3 from their web site: http://www.autoitscript.com
  * Replace the AutoItX3.dll library located in the Watir install tree with the version located
    in the AutoIt3 install tree (e.g. C:\Program Files (x86)\AutoIt3\AutoItX\AutoItX3.dll)

    On my WinXP x86 system this completed the steps, but on my Vista x64 system additional steps
    were required, which involved editing the Windows Registry.

  ### It is highly recommended to backup you registry prior to making any changes. ###

  * Search the Windows registry for 'AutoItX3.dll" and replace any entries that point to
    the Watir install tree with the location in the AutoIt3 install tree.
    For example on my Vista x64 system I had to edit the keys:
       [HKEY_CLASSES_ROOT\TypeLib\{F8937E53-D444-4E71-9275-35B64210CC3B}\1.0\0\win32]
    and
       [HKEY_CLASSES_ROOT\Wow6432Node\CLSID\{1A671297-FA74-4422-80FA-6C5D8CE4DE04}\InprocServer32]
    Replacing:
       C:\ruby\lib\ruby\gems\1.8\gems\watir-1.6.5\lib\watir\AutoItX3.dll
    with
       C:\Program Files (x86)\AutoIt3\AutoItX\AutoItX3.dll

* On Windows Vista or Windows 7, disable the User Account Control

  The Windows UAC will interfere with the ability to run Ruby, Watir, FireWatir and WatirWorks.
  Unless you always start your tests by launching them from a Windows Console that was
  opened with Administrative permissions, it is highly recommended that you disable the UAC.
  For Details see:
  http://windows.microsoft.com/en-US/windows-vista/Turn-User-Account-Control-on-or-off

* On Windows install CCleaner

  Per Watir1.6.5: The method "Watir::CookieManager::WatirHelper" has been deprecated, thus leaving no means
  to clear the browser cache or cookies this from Watir.
  By installing and using a 3rd party tool like CCleaner, the cache and cookies for IE, Firefox, and other Web browsers
  on the Windows platform can still be cleared.

  You can download CCleaner for free at : http://www.CCleaner.com

  * All cookies will be cleared unless you configure CCleaner to exclude specific cookies.
  * CCleaner only clears cookies if the browser is closed, so close the browser prior to invoking this method.
  * CCleaner only clears the cache if the browser is closed, so close the browser prior to invoking this method.
  * On Vista and Win7 if User Access Control is enabled, CCleaner will raise a Window's User Account Control
    pop-up window that will need to be manually dismissed. So consider disabling User Access Control on the system
    where the AUT is running, for the duration of the testing.
    See details at:   http://technet.microsoft.com/en-us/library/cc709691%28WS.10%29.aspx

* On Linux and OSx install ImageMagick
  ImageMagick should be pre-installed on Ubuntu 10.04, and Debian 5.04.
  * If it is not installed on your Linux platform perform the following command:
     sudo apt-get install imagemagick
  * If it is not installed on your OSx platform perform the following command:
     sudo port install ImageMagick
* Install an Editor or IDE of you choice. See information on selecting one in the WatirWorks file: README_FreeEditors.rb



Contacts:
   WatirWorks: watirworks@comcast.net
      Joe DiMauro

Contributors:
   Joe DiMauro
   David Brown (Xls.rb)

Acknowledgments:
      Bret Petticord - Thanks for Watir and for discussing testing frameworks with me when you visited me in Boulder
      Zeljko Filipin  - Thanks for assistance on how to pass methods as variables.

   Thanks for your ideas and support!

=end
