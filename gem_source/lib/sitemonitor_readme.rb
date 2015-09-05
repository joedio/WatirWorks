=begin rdoc

= WatirWorks Site Monitor

  Copyright (c) 2008-2012, Joe DiMauro
  All rights reserved.

  Date: 7/01/2010

== Summary:

The Site Monitor is a data driven program that can be user configured to monitor
multiple Web sites for accessibility, and send an email notifications if any of
the specified sites is inaccessible.

It uses WatirWorks methods to determine if each site is accessible, and records results to a log file.
If a site is not accessible an email is generated and sent to the specified email accounts associated with that site, via the user specified SMTP server.
Data for the script is read from an Excel workbook which the user updated with information for:
* The Web sites to monitor
* The email server's access information
* The email accounts to contact when a web site is inaccessible

=== Files:

* site_monitor.rb      - The main program that reads the configuration file,
  performs the web site monitoring, and sends email's when a monitored site is down.
* site_monitor.bat     - A Windows batch file you can use to launch the site_monitor.rb
  script manually or as a Scheduled Task
* age_site_monitor_logs.bat - A Windows batch file to prune the log files
* stdout.txt           - An auto-generated output file containing the text normally sent to STDOUT and STDERR
* SiteMonitor.log      - An auto-generated output file containing information recorded by the script.
* site_monitor_data.xls - A Microsoft Excel workbook containing the data (URL's, Email info), for the site monitor
* example_stdout.txt       -  Example stdout.txt file from a run with Google & Yahoo passing & 1 failure
* example_site_monitor.log -  Example of the site_monitor.log file from a run with Google & Yahoo passing & 1 failure
* example_email.txt        -  Example email sent from that failure

=== Setup:

1. The system running the Site Monitor needs Ruby, Watir and WatirWorks properly installed
2. Copy the files in WatirWork's site_monitor folder to a writable directory on the local file system. For example:
           C:\WINDOWS\temp\SiteMonitor\
3. Modify the site_monitor_data.xls with information specific to your environment:
   * The URL's of the Web Sites to monitor
   * The email addresses to notify if a monitored site is inaccessible
	* The information necessary for your SMTP server to send email.
4. (Optional) Create a Scheduled Tasks to run the batch file (see below).
5. Periodically prune the output files stdout.txt, and site_monitor.log, so that they don't fill up the file system!

=== Creating a Scheduled Task:

Note: These instructions were written for Windows XP but should be similar in other versions of Windows.

1. Open Scheduler
        Go to "Start > Programs > Accessories > System Tools > Scheduled Tasks"
2. Select "Add Scheduled Task"
3. The Scheduled Task Wizard will appear.
      Select Next.
4. Select the program to launch from the list. For example:
      C:\WINDOWS\temp\SiteMonitor\site_monitor.bat
      Select Next
5. Give the task a Name, such as "WatirWorks Site Monitor", and choose the
   Frequency with which to perform the task (e.g. Daily).
      Select Next
6. Choose specific date and time options (this step will vary, depending on the
   option selected in the previous step). For example Start at 7:30 AM
      When finished, Select Next.
7. Enter your password if prompted. Change the username if required
   For example:For security reasons you may prefer to run the task under a user with fewer privileges.
      Select Next
8. On the final page, select the checkbox:
      "Open advanced properties for this task when I click Finish".
      Select Finish.

=== Configuring the Scheduled task:

1. Go to the task's setting page either by; checking the checkbox at the end of
   the last step, or by Selecting on the task from
       "Start > Programs > Accessories > System Tools > Scheduled Tasks"

2. In the Task Tab, verify that the run and Start In settings are correct.

       For example:
         Run: C:\WINDOWS\temp\SiteMonitor\site_monitor.bat
         Start In: C:\WINDOWS\temp\SiteMonitor

      Note: Your paths may vary.

3. To set a frequency more often than Daily (for example, hourly), select the
   Schedule tab, then select Advanced.
      Set any options such as Repeat task, every 15 minutes.

4. Set the duration value. For example to only run during the workday set
      Duration to 10 hours (7:30 AM to 5:30 PM)
      Select OK when finished.

5. Decide if you want the task to run only when you are logged in, or not
   and set the checkbox.

6. When all settings have been configured to your liking, select OK
      Note: You may be prompted for your password.

=end
