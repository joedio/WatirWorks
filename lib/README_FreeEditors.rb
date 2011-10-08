=begin rdoc

:title:WatirWorks Free Editors Rdoc

Copyright (c) 2008-2011, Joe DiMauro
All rights reserved.

= Selecting an Editor / IDE

You can use any text editor, be it notepad, vi, or whatever to write ruby code. And once written you can
run that Ruby code from a Console window, But there are some free (and safe),
Editors and Integrated Development Environments (IDE's), that can really help. Editors/IDE's that include
lots of useful features, (help, spell checker, project support, code formatter, etc) and some even had integrated execution / debugging environments as well.

If you've already using Ruby or Watir you've probably found an Editor/IDE you like, but if you're a
newbie, here's some information on a few that you may wish to consider. Information is provided to
help you choose one that fits your needs. This is by no means a complete list. I'm not trying
to push any of them, just tying provide some assistance.

OpenSource and Free Editors/IDE's:
* Aptana RadRails - Aptana's Ruby on Rails Development Environment
* RDE - The Ruby Development Environment
* FreeRIDE - A Free Ruby IDE written in Ruby
* TestWise (Community Edition) - A Watir Development Environment with a Recorder
* SciTE - The Scintilla Text Editor

== Aptana RadRails
* Aptana Studio is a Free IDE based on Eclipse
* Available as a Standalone (Aptana Studio) or as a plug-in for Eclipse
* Web site:	http://www.aptana.com/
* Supports editing of HTML, Java, Java Script, Ruby, Python, Jython, and a many others
* Includes Eclipse's execution and debugging environments
* Customizable via Eclipse GUI's configuration page
* Help provided both locally and via the Web
* Large user base and support groups	http://www.aptana.com/support
* Supports plug-in to integrate with Source Control systems
* Supports projects
* Include capability to format (tidy) your code (Source -> Format)
* Includes a Spell Checker with ability to add user defined dictionary.
Downside:
* A larger footprint that SciTe or RDE so it takes longer to open and load

Notes:
* Once downloaded and installed Aptana Studio still needs the Ruby plug-in:
  * From Aptana Studio (v2.0.4) select: Help -> Install Aptana Features...
  * Select: RadRails
  * Follow the prompts and restart Aptana
  * Upon restart Aptana will raise a prompt to install a list of additional gems for Ruby on Rails development. While they are not necessary for testing, you can elect to install or NOT install them and Ruby, Watir, and WatirWorks runs fine. If you are also performing Rails development feel free to install them.

== FreeRIDE - A Free Ruby IDE written in Ruby
* FreeRIDE is Open Source
* Web site:	http://freeride.rubyforge.org/wiki/wiki.pl
* Is a more robust editor than SciTE, but not a robust an IDE as AptanaStudio
* At a Beta stage of development (when this was written)
* Available for Windows, Linux, OSx
* Does NOT support multiple languages, only Ruby
* Has a medium footprint, so it opens and loads not quite as fast as SciTE or RDE, but faster than AptanaStudio
* Customizable via GUI configuration page
* Help provided by local html files
* Small user base, no support group   http://rubyforge.org/projects/freeride/
* Execution and debugging windows for your Ruby tests
* Includes support for projects
Downside:
* Lacks drill-down capabilities for errors from a run
* Does NOT include integration with Source Control
* Does NOT include support for breakpoints and variable monitoring capabilities
* Does NOT include capability to format (tidy) your code
* Does NOT include Spell Checker
* When running test files (like those in the WatirWorks unittests), which have multiple test cases, it only runs the first test case.

== RDE - The Ruby Development Environment
* RDE is Open Source
* Web site:	http://homepage2.nifty.com/sakazuki/rde_en/index.html
* Is a more robust editor than SciTE
* Only available for Windows
* Only supports editing of a Ruby
* Has a small footprint, so it opens and loads fast
* Customizable via GUI configuration page
* Help provides both locally and via the Web. Local help requires a separate download of rubymanen_20070805.zip)
* Smaller user base and support groups	http://rubyforge.org/forum/?group_id=3959
* Execution and debugging windows for your Ruby tests
* Includes support for breakpoints and variable monitoring capabilities
Downside:
* Lacks drill-down capabilities for errors from a run
* Does NOT include integration with Source Control
* Does NOT include capability to format (tidy) your code
* Does NOT support projects
* Include Spell Checker with ability to add user defined dictionary.
Notes:
* To use Spell Checker create a text file to act as your dictionary, then point to it from RDE's GUI configuration page.
* To use local help, Download and Unzip rubymanen_20070805.zip to get rubymanen.chm, and then point to it via RDE's GUI configuration page. Recommend saving at C:\Program Files\RDE\doc\rubymanen.chm
* The local help may not work with Vista or Windows7 as MS no longer supports WinHlp32.exe. For details see: http://support.microsoft.com/kb/917607

== SciTE - The Scintilla Text Editor
* SciTE is Open Source
* Web Site:	http://www.scintilla.org/SciTE.html
* A good start as a first editor if you are a newbie
* It was included with the Windows Ruby1.8.6  one-click-installer (however its down rev.)
* Available for Windows, Linux, MacOSX
* Available as a windows installer, and as zips for other OS's
* Supports editing in a variety of languages (HTML, VB, Java, Perl, Python, etc.)
* Has a small footprint, so it opens and loads fast
* Customizable via manual editing of its various property files
* Help provides both locally and via the Web
* Large user base and support groups	http://groups.google.com/group/scite-interest
* Execution and debugging windows for your Ruby tests
* Limited drill-down capabilities for errors from a run
* Supports projects (File -> Save Session)
Downside:
* Does NOT include integration with Source Control
* Does NOT include breakpoint or variable monitoring capabilities
* Does NOT include Spell Checker
* Does NOT include capability to format (tidy) your code
Notes:
* Recommend you skip installing the version of SciTE bundled with the Ruby1.8.6 One-click-installer on windows and then download and use the current SciTE version instead.

== TestWise (Community Edition)

If you're looking for an Free Ruby Testing IDE with a recorder for Watir, check out TestWise.
Haven't had much time to look at it but appears to be rich, well built, an of interest.
* Web Site:	    http://itest2.com/
* Available for Windows only
* Available as a windows installer
* Includes record tool
* Runs test with either IE or Firefox
* Source Control integration with Subversion or GIT
* Support for Projects
* Includes both Help and Online documentation
* Feature rich GUI
* GUI access to Test Suite creation and launching
* Includes a Library of some very basic methods/tools to assist in test development
* Includes templates to speed development of TestWise test files / test cases
* Ability to export TestWise test reports to Excel
* Includes capability to format (tidy) your code
Downside:
* Locked to the rwebspec testing framework. Perhaps a benefit if your already using rwebspec!
* Difficult to control execution of tests NOT developed in the TestWise framework
* Ruby output to STDOUT does NOT appear in the TestWise Console for test NOT developed in TestWise

== SciTE Customization

Here are some customization to SciTE's property files you may wish to consider in order to access additional capabilities from within SciTE. There are many more that the ones noted here.
SciTE's property files are accessible under SciTE's Options menu.
* A good place to find out more is the Web site:	http://www.scintilla.org/SciTEDoc.html

=== SciTEGlobal.properties - Apply these settings to the proper locations within the file:

   # Globals
   toolbar.visible=1

   # Window sizes and visibility
   position.left=100  # Set the default screen position
   position.top=10    # Set the default screen position

   # Checking
   strip.trailing.spaces=1    # Strip off any trailing whitespace
   ensure.final.line.end=1    # Add a EOL after the last line in the file

   # Find and Replace
   find.replace.advanced=1     # Enable Replace across multiple open files

   # Behavior
   autocompleteword.automatic=1    # Activate the auto-complete feature

=== ruby.properties - Add the following lines to the bottom of the file:

   ####################################
   # BEGIN - WatirWorks additions to tools menu for Ruby files
   #####################################

   # Perform a syntax check without running the file
   #
   command.name.1.$(file.patterns.rb)=Check Syntax
   command.1.$(file.patterns.rb)=ruby -cw $(FileNameExt)

   # Access Ruby Debugger
   #
   command.name.2.$(file.patterns.rb)=Debug ...
   # Command to run
   command.2.$(file.patterns.rb)=ruby -r debug $(FileNameExt)

   # Access irb
   #
   command.name.3.$(file.patterns.rb)=irb ...
   command.3.$(file.patterns.rb)=irb.bat

   # Watir Console
   #
   command.name.4.$(file.patterns.rb)=Watir Console ...
   command.4.$(file.patterns.rb)=watir-console.bat

   # Spell Check - SORRY, THIS IS NOT WORKING
   #
   command.name.5.$(file.patterns.rb)=Spell Check ...
   # Command to run (Sorry This is NOT working)
   #command.5.$(file.patterns.rb)=ruby $(FileNameExt)
   # Reload file in SciTE after command
   command.is.filter.5.$(file.patterns.rb)=1
   # Windows = 2
   command.5.subsystem.$(file.patterns.rb)=2

   # Open current file in a separate Editor (Aptana),
   # and reload in SciTe after saving the file in that Editor
   #
   command.name.6.$(file.patterns.rb)=Aptana ...
   # Command to run   # Uncomment the proper line after modifying for your OS's installation
   #command.6.$(file.patterns.rb)=C:\Program Files\Aptana Studio 3.0\Aptana\AptanaStudio.exe $(FileNameExt)  # Win2k, WinXP
   #command.6.$(file.patterns.rb)=C:\Users\<USER>\AppData\Local\Aptana Studio 3.0\Aptana\AptanaStudio.exe $(FileNameExt)  # Vista, Win7
   # Reload the modified file in SciTE
   command.is.filter.6.$(file.patterns.rb)=1
   # Windows = 2
   command.6.subsystem.$(file.patterns.rb)=2

   # Display Code Profile info
   #
   command.name.7.$(file.patterns.rb)=Profile
   command.7.$(file.patterns.rb)=ruby -r profile $(FileNameExt)


   # Display information on the Gem environment
   #
   command.name.8.$(file.patterns.rb)=Gem Info
   command.8.$(file.patterns.rb)=gem.bat env
   #command.8.$(file.patterns.rb)=ruby --version


   #####################################
   # END - WatirWorks additions
   #####################################

=end
