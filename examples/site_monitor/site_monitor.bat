@ECHO OFF
GOTO START

REM ########################################################
REM # File: BUild_ICAT_Rdoc.bat
REM
REM # Description: 
REM #    Batch file to launch a Ruby process to monitor web sites
REM #    Runs and re-direct stdout (1) & stderr (2) to a text file
REM #
REM # Author: Joe DiMauro
REM #
REM # Date: 05/28/2008
REM #
REM ########################################################

:START
ruby SiteMonitor_tool.rb -b >> stdout.txt 2>&1