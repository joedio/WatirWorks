=begin rdoc

:title:WatirWorks Users Guide

Copyright (c) 2008-2012, Joe DiMauro
All rights reserved.

= Introduction

Welcome to WatirWorks. I'm presuming that you are a QA Tester trying to use
Ruby/Watir to automate a Web application, and that you're relatively new to the
use of Ruby/Watir. While this is not a tutorial, it will help you to get
rolling, how to avoid some pitfalls, and show you how to use many of the
features in WatirWorks, Watir, FireWatir, and Ruby. Sorry if this is a bit wordy,
much of it may seems to become common sense once you've been doing this awhile,
but hopefully it all helps.

I've been testing software for a very long time, and have used many of the leading
Commercial testing tools on the market for years. I've used Ruby/Watir extensively
for automated testing on a number of web applications while on various contract
assignments. In doing so I've continued to refine it in the crucible of fast-paced,
results oriented, real world, day to day usage. Continuing to add, adjust and
improve WatirWorks in the process. Some of what I'll say may or may not work
for you, that's OK, few solutions works everywhere. I'm not preaching here, only
trying to assist you and save you some time and grief.

And of course read up on the various Ruby and Watir documentation that's freely available
both as RDocs in your installation directory, or on the Internet. And follow the various
User Forums for additional tips, and to pose questions.

* Ruby RDoc:     http://ruby-doc.org/core/
* Watir RDoc:    http://wtr.rubyforge.org/rdoc/1.6.5/
* Google Group:  http://groups.google.com/group/watir-general
* StackOverflow: http://stackoverflow.com/questions/tagged/ruby
* StackOverflow: http://stackoverflow.com/questions/tagged/watir
* Watir Bugs:    http://jira.openqa.org/browse/WTR

Enjoy,

Joe

= Naming scheme

Before you write your first test its a good idea, a best practice if you will,
to follow a consistent naming scheme.

The code you write makes sense to you now, but come back to it in a few months,
or perhaps your not the only one sharing the testing duties. You'll appreciate
spending little time up front on planning and setting up your standards , versus
the longer time  spent down the road, not to mention the confusion that will most
likely occur.

===  Variable Names

* Names must be unique
* Contain no spaces, or reserved words
* Use a mix of Case or under_scores to distinguish individual words in a long name
* Names are self-descriptive of their purpose. Don't scrimp on their length,
  its easier to cut-n-paste a long name used over and over, than to spend time
  trying to figure out what short names like "i" means in every instance.

* Use a systematic naming scheme to identify the object types:
    * s* is a STRING            e.g. sMyString = "Hello"
    * t* is a TIME/DATE         e.g. tThisTime = Time.now
    * a* is an ARRAY            e.g. aMyArrayofStuff = ["A", "b", 1, 2, true, false]
    * h* is a HASH              e.g. hMyHashOfStuff  = { "a" => 1, "b" => 2}
    * i* is an INTEGER          e.g. iCount = 1
    * f* is a FLOATING POINT    e.g. fMyAmmount = 1.0
    * b* is a BOOLEAN           e.g. bFileExists = false
    * o* is any general OBJECT  e.g. oBrowser

* Constants:  Must start with a capital letter, but recommend using only CAPITALS.
     e.g. THIS_YEAR = Time.new.year.to_s

* Global variables: Start with a $
    e.g. $bLoggerStarted = true

* Instance variables: Start with single @
     e.g. @tOneShot = Time.now

* Class variables:  Start with dual @@
     e.g. @@sClassName = "MyClass"

* Local variables:  Start with a lower case letter or underscore.
     e.g. sMyString = "Hello"

=== File Names

* Names must be unique
* Contain reserved characters. Prefer to not use spaces as well
* Use a mix of Case or underscores to distinguish individual words in a long name
* Names should be self-descriptive of their purpose.
* Test Suite files should end with _testsuite.rb
* Test files should end with _test.rb
  This allows them to be found and run by the WatirWorks test suite.
* The first part of the test's filename can indicate its test type. For example:
    ACX = access, WF = work-flow, NEG = negative, etc., whatever meets your needs.
  You may also want to include an indicator for the name of the application.

  Remember that WatirWorks Test Suite will run test files in alphabetical
  order so keep that in mind when you name them. For example:
     WF-MyApp-001_test.rb  will be run before  WF-MyApp-002_test.rb
* Any other support files or libraries should NOT use the _test.rb or _testsuite.rb ending.

=== Test Class and Test Case Names

When the Ruby/Watir Test::Unit::TestCase  method is used, (especially when running
a multitude of test files as a test suite), its important to name each test class
and test case properly.

* Associate the name of the test class with the name of its test file.
  Thus when a test case within that class fails you can identify which file it
  was run from. For example in the file WF_MyApp_test.rb you can name the
  test class:
      class WF_MyApp_AddUser < Test::Unit::TestCase
        # Your Code
      end # END of Class - WF_MyApp_AddUser
  When running multiple test files from a test suite, the names of the classes
  does not impact the running order, but the test case name does!

* The names of test cases within a Ruby/Watir Test::Unit::TestCase class MUST
  begin with "test". Again associate the name each test case with the class
  containing it. The individual test cases are run in alphabetical order.
  When running multiple test files from a test suite the names of the test cases
  does impact the running order. The Ruby/Watir Test::Unit::TestCase runs them
  in alphabetical order. So test cases in separate test classes and separate
  files can become intermingled in their running order if you don't name them
  properly. For example: test_MyApp_WF_001_AddUser_NewUser


=== Method Names

As you write you own methods stick to a naming scheme. WatirWorks has tried to
follow those used by Ruby and Watir, namely:
* Names must be unique
* Contain no spaces, or reserved words
* Start with a lower case character or an underscore
* Use a mix of Case or underscores to distinguish individual words in a long name
  While both mixed case and underscores are used in both Ruby and Watir there appears
  to be an effort underway to avoid the mixed case and stick with only lowercase
  and underscores.
* Names should be self-descriptive of their purpose.
* Method names start with a verb (find_, get_, show_, is_, read_, etc)
* Methods that return a BOOLEAN end with a question mark ?

== Comment and File layout

When writing comments, as with any written document, keep your audience in mind.
In this case my audience is the nubbie to Ruby/Watir as well as myself when I
have to go back months later an figure out what I was trying to do!

Don't skimp on comments in you code or in the use of print statements.
When creating methods make use of the Ruby $VERBOSE switch to display additional info
to assist in trouble shooting should and error occur.

Look through the Methods in the WatirWorks libraries, the unittests and examples.
Notice that there is a consistent layout to each type of file and heavy comments.

* Each file has a comment header that includes:
  * The file name
  * An overall description of the file's purpose
  * Any additional Instructions, or Information on the use of the file

* Following the File Header Comment block there are commented sections for:
  * Require and Include of other files/methods
  * Global variables
  * Table of Contents
  * Individual Methods (in alphabetical order)

* Each Method has a comment header that includes:
  * A description of the method
  * What it returns (BOOLEAN, STRING, ARRAY, etc.)
  * The syntax of any parameters
  * Usage examples if warranted
  * A Prerequisites, or Restriction where necessary and useful
  * If the code was based on, or found at some Open Source location,
    give credit to the author, as well as the URL it was found at.

Some lines in the methods might have been re-written, combining multiple lines into one line,
but by using multiple lines they are easier to trouble shoot, comment, and understand.

Use print statements (either to STDOUT via puts()) or to a log file (via $logger.log)
as much as necessary. Its a good idea to record what you're about to do, then do
it, the validate that is was done correctly, and record that fact. This way when
the test hits an unexpected fault condition you can more easily know what was going
on up to the point of failure.


== WatirWorks Test Suite and Test File Execution

When using WatirWorks you can run any Test File individually, or aggregated into
set of tests run as a Test Suite.

As there are no hard coded paths in WatirWorks, it allows you the ability to place your
test files at a location on the filesystem that is convenient to you. So for example
you can check them out from your source control system and run them, no need to move them
to another location. The default location for output files generated by the test is to
save output files (logs, screen captures, etc.) to the file system's TEMP location. On Linux
WatirWorks uses the /tmp directory as the default location for saving output files, on Windows
it defaults to the %TEMP% directory. Of course you can specify other locations if you wish.

=== Layout

Its suggested that you combine similar tests into separate folders. Store all Workflow tests
into a "Workflow" folder under your test folder for that application. Put Access tests into
an "Access" folder, Negative tests into a Negative folder etc. 
You can store the WatirWorks TestSuite file within the parent folder of all those test folders.

For example:

     /Some Folder on your local filesystem
			         |
     ------------------------
     |                      |
    /MyApp               /MyOtherApp
    MyApp_tessuite.rb    MyOtherApp_tessuite.rb
      |
    -----------------------------------------------------------------
    |                        |                       |               |
   /Workflow              /Access                  /Data          /Negative
   MyApp_WF_TC1_test.rb   MyApp_ACX_TC1_test.rb    MyData.xls     MyApp_NEG_TC1_test.rb
   MyApp_WF_TC2_test.rb


=== Test Suite Execution

Run any individual test directly from its folder, or run a set of tests as a suite by
running the testsuite.rb file, which will collect a list of all *_test.rb files located
beneath it in the filesystem. You can provide additional control over which tests to run in
the testsuite by setting "sRun_TestType" and "iRun_TestLevel" values in each test.rb file and
setting it in the testsuite.rb file.

* In each of the *_test.rb files for you Access tests set sRun_TestType = "ACX"
* In each of the *_test.rb files for you Workflow tests set sRun_TestType = "WF"
* In each of the *_test.rb files for you Negative tests set sRun_TestType = "NEG"

Make up and set whatever values make sense to your situation.

Set the iRun_TestLevel to a value between 1 and 5 in each *_test.rb file if you need to further sub-divide
the tests. Perhaps the level 1 tests are run daily, but the level 3 tests are run weekly, and level 5
tests are run on an "as needed" basis".  

With that done you can now control running all or only some of the tests from the *_testsuite.rb file.
* To run all the test files, edit the *_testsuite.rb file and set sRun_TestType="" iRun_TestLevel = 0
* To run ONLY the Workflow test files, edit the *_testsuite.rb file and set sRun_TestType="WF" iRun_TestLevel = 0
* To run ONLY the Access test files, edit the *_testsuite.rb file and set sRun_TestType="ACX" iRun_TestLevel = 0
* To run ONLY the Level 1 test files, edit the *_testsuite.rb file and set sRun_TestType="" iRun_TestLevel = 1


Upon launch the *_testsuite.rb file it will:
* Search the folders beneath it in the file system, making a list of all *_test.rb files
* Pare down that list based on the "sRun_TestType" and "iRun_TestLevel" values
* Parse the remaining file in the list for their test cases
* Pass the collected test cases to Ruby for execution.

Ruby executes test cases in alphabetical order! So you need to plan the names of your test cases
with care so that they are run in the order you expect. Remember that the test cases from ALL
the test cases provided by parsing the test suite's file list will be run, and they are NOT sub-divided
by which file they were read from. So take care in naming them to help in controlling the test flow.

Suggest naming the test cases 
    test_<AppName>_<TestType>_<nnn>_<MajorStep>_<MinorStep>
  where:
    <AppName> = A shortened name for the application being tested
    <TestType> = A short name for the tset type (i.e. ACX, WF, NEG)
    <nnn> = A number (000 to 999)
    <MajorStep> - A brief description of what's being tested
    <MinorStep> - Any optional descriptions you may need to identify and differentiate your test cases
  
For example, with the Test Cases parsed from your *_test.rb files being named:
  test_MyApp_WF_001_AddUsers
  test_MyApp_WF_002_AddUsers_Special
  test_MyApp_WF_003_RemoveUser
  test_MyApp_WF_004_RemoveAllUsers
  test_MyApp_ACX_001_LoginPage
  test_MyApp_ACX_002_HomePage
Assures that the "ACX" test cases will run before the "WF" test cases.
Assures that the "RemoveUser" test case will run before the "RemoveAllUsers" test case.
Even though "RemoveAllUsers" is alphabetically before "RemoveUsers", since "003_RemoveUser" is 
alphabetically before "004_RemoveAllUsers".



== Test Flow Control

=== WatirWorks Test Suite Control
From time to time you may need to exclude a test file, or test case from
execution. Here are a few ways to do that.

* Remove the file from the directory tree under the WatirWorks Test Suite.

  If the file isn't under the test suite's folders, it can't be found by the
  test suite file, and thus not executed as part of the suite.

* Change the test file name

  Since a WatirWorks test suite locates the individual test files based on their
  filename ending with _test.rb you can exclude a test by changing its name.
  Changing MyFile_test.rb to MyFile_te_st.rb will exclude it from the test
  suite, of course you can still run it by itself, no matter what its name is.

* Use the variables sRun_TestType and iRun_TestLevel

  If you set the variables sRun_TestType and iRun_TestLevel in each
  of your test files, you can edit the WatirWorks Test Suite file to control
  which test files to run, based on a specific type or level.

  For example:
    You have WF - Work-flow and ACX- Access tests that your WatirWorks Test Suite
    would normally run, but you only want to run the Access tests. If you set
    sRun_TestType = "ACX" in each of your Access test files, and set
    sRun_TestType = "WF", or whatever in all of your other test files, then
    by setting sRun_TestType = "ACX" in your WatirWorks Test Suite file, only
    the Access test files will be run.

  You can also set a iRun_TestLevel in each test file and then set a level in
  your WatirWorks Test Suite to only run tests based on their settings. Perhaps
  for a quick "Warm Fuzzy" or "Smoke Test" you only run your level 1 tests. But
  for the longer more in depth testing you run at level 4, and only run the
  level 5 tests occasionally.

=== Test Case Control

To control the execution of individual test cases you have a few options.

* Rename the Test Case

  As Ruby/Watir's Test::Unit::TestCase will only run test cases if their names
  start with  test_   you can edit each test file and change the names of the test
  cases you wish to exclude. For example change:
      test_WF_001_MyApp_AddUser_NewUser   to   te_st_WF_001_MyApp_AddUser_NewUser
  Of course this is vary tedious and time consuming.

* Use Comment Blocks

  Edit each test file and put a Ruby Comment block (=begin  =end) around each
test case to exclude. For example:
     =begin
     def test_WF_001_MyApp_AddUser_NewUser
       # Your test case code here
     end End of test case - test_WF_001_MyApp_AddUser_NewUser
     =end

  Once again this is vary tedious and time consuming.

* Conditional Test Case Execution

  Put a conditional statement in each test case and skip the test case if the condition is NOT met.

        def test_WF_001_MyApp_AddUser_NewUser
          if($bRunTest_test_WF_001_MyApp_AddUser_NewUser == false)
            raise("Skipping test case - test_WF_001_MyApp_AddUser_NewUser")
          else
            # Your test case code here
          end
        end End of test case - test_WF_001_MyApp_AddUser_NewUser

  Of course you will still need to edit each test file to set all the Global
  variables. Again a bit tedious.

* Data Driven Conditional Test Case Execution

  Setup your test files to read data from an external file (Spreadsheet in an Excel Workbook, CSV file or ASCII Text file.

  You would still add a conditional statement to each test case, but as the first
  test case in each test file, write code to read the data from the
  external data file and set the test case execution variables that each
  test case can then access and either run or skip execution.

  The initial setup of this process is more involved, but it saves a lot of
  time in the log run. Remember to keep the data file under source control

=== Test Trial Control

  An individual test case can be coded to try several different but associated sets
  of data as a single trial. For example try a variety of First and Last names when adding users.

* Linear Hard Coded Data

  Don't even think about going down this route!

  The data for each trial is hard coded in to the test code, with no looping.
  Just a very long piece of linear code, similar to what you get when you use a
  basic record/playback tool.
  I've observed people start this way and while they appeared to get a fast start,
  in the longer run, the time spent on maintenance and overcoming it's inherent
  inflexibility, more than offset any early gains by a very wide margin!

* Array or Hash based Trial Data

  Set up an Array or Hash with each of the data sets and loop to access each and
  assign them to variables which are used to enter the values in the proper fields,
  of set the proper checkbox, radio button, select list or whatever.
  You will need to edit that hash and then pass it to the test case. The main
  issue with this approach is the need to edit each test file to update the
  contents of each data set in the hash or array.

* Data Driven Trial Data

  Just as with the Data Driven Conditional Test Case Execution, setup your test
  files to read data from an external file (Spreadsheet in an Excel Workbook, CSV
  file or ASCII Text file. Then within the first test case in each file, or in the
  individual test cases, but prior to their use, assign the data to the Array or
  Hash that is still read from and looped for the individual trials.

  Again the initial setup of this process is more involved, but it saves a lot of
  time in the log run. WatirWorks has examples of a test using this concept and
  has methods to support reading data from CSV and XLS files for just this purpose.
  Another advantage of this process is that for examples you provide access
  to non-technical personal to the data file, or you may get a spreadsheet from
  someone with the data you need. So instead of spending time coding all the
  trial data into the test, and the amount of time spent maintaining that code,
  you can format the spreadsheet as necessary and read it in.
  Remember to keep the data file under source control.

== Best Practices

Here some additional info for you.

* Don't re-invent the wheel, leverage code from other scripts where possible, but
  always give credit where credit is due, Don't repackage others code as you own.
* Anticipate failure and code for it. The mark of a good test is how it handles
  failures, not just that it runs to completion!
* Code to capture failures, and to assist in identifying the failing conditions.
* Each test in a Test Suite needs to be able to run even if the prior test failed.
* Develop Error Recovery scenarios for your tests, so that when one test in a Suite
  fails the AUT can be returned to a "Clean State" for the next test.
* Don't blindly accept default values in the AUT that affect the flow of the test.
  They can have the nasty habit of changing from release to release.  So have
  the test validate their setting, or always set them as your test requires.
* Run your test from the local filesystem, but save them on a server
* Use Source Control for you tests and all support files (e.g. spreadsheets, data files, etc.)
* Work and run from a copy of the original file, don't work or run directly from the original file.
* Design test so that they can also be executed across application environments,
  (i.e. Production, Development, QA)
* For AUT's that require a login, don't use you own account's credentials.
  Set up an account explicitly for the test to use.
    * Make test account independent, use variables and wildcards where possible
    * Combine commonly used tasks into methods where possible
    * Distinguish between application independent and application specific code
    * Create and use application specific libraries for tasks, classes, and methods
      unique to each of your AUT's
* Create and use a company specific library for tasks tasks, classes, and methods
  common among your AUT's
    * Isolate input data from the test files. Read inputs for a test, such as
      Spreadsheets, textual data files, etc. from a common location that is separate
      from the test files.
    * Don't write output from your tests into the same directory as the test files.
    * Save results from a test, such as log files, screen captures, output files,
      etc. into a common location that is separate from the test files.

=end
