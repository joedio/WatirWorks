@ECHO OFF
GOTO START

REM ########################################################
REM # File: age_site_monitor_logs.bat
REM #
REM # Description: 
REM #    Batch file to cleanup the output files that are
REM #    created by the Ruby SiteMonitor_tool.rb program.
REM #
REM #    The current files are renamed and any prior files
REM #    are removed.
REM #
REM #    This task should be run periodically so the files
REM #    don't grow too large. It can be run manually or
REM #    it can be set up as a Scheduled Task in Windows.
REM #
REM # Author: Joe DiMauro
REM #
REM # Date: 06/04/2008
REM #
REM ########################################################

:START
REM # Remove the old files
DEL /F /Q stdout_1.txt Site_Monitor_1.log

REM # Rename the current files
COPY /Y stdout.txt stdout_1.txt
COPY /Y Site_Monitor.log Site_Monitor_1.log

REM # Remove the origional files
DEL /F /Q stdout.txt Site_Monitor.log
