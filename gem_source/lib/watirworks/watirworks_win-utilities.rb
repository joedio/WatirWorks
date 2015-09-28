#=============================================================================#
# File: watirworks_win-utilities.rb
#
#  Copyright (c) 2008-2015, Joe DiMauro
#  All rights reserved.
#
# Description:
#    Functions and methods for WatirWorks that are specific to the Windows platform.
#    but not specific to any particular Application Under Test, or Browser.
#
#    Extends some Ruby or Watir classes with additional, hopefully useful, methods.
#
#    Some methods and functions in this library rely upon free 3rd Party applications
#    to fulfill niches that Watir does not cover.
#    They are:
#        CCleaner
#
#    Please refer to the WatirWorks README page for information on their setup.
#
#    Some of these methods and functions have been collected from, or based upon
#    Open Source versions found on various sites in the Internet, and are noted.
#
#--
# Modules:
#    WatirWorks_WinUtilities
#
# Extends Classes:
#    Watir::IE
#    Watir::SelectList
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

# Watir-WebDriver
require 'watir-webdriver'

#============================================================================#
# Module: WatirWorks_WinUtilities
#============================================================================#
#
# Description:
#    Functions and methods for WatirWorks that are specific to the Windows platform.
#    but not specific to any particular Application Under Test, or Browser.
#
#    Extends some Ruby or Watir classes with additional, hopefully useful, methods.
#
#    Some of these methods and functions have been collected from, or based upon
#    Open Source versions found on various sites in the Internet, and are noted.
#
# Instructions: To use these methods in your scripts add these commands:
#                        require 'watirworks'
#                        include WatirWorks_WinUtilities
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
#    exit_browsers_win(...)
#    get_windows()
#    handle_win_dialog_confirm_saveas(...)
#    handle_win_dialog_download_complete(...)
#    handle_win_dialog_generic_modal(...)
#    handle_win_dialog_saveas(...)
#    is_minimized?(...)
#    is_maximized?(...)
#    open_messagebox_win(...)
#    pause(...
#    parse_spreadsheet()
#    parse_workbook()
#    save_screencapture_win(...)
#
# Pre-requisites:
# ++
#=============================================================================#
module WatirWorks_WinUtilities

  # Version of this module
  WW_WIN_UTILITIES_VERSION =  "1.0.3"

  #===============================
  # Button codes for Window's Message box
  #===============================
  BUTTONS_OK = 0
  BUTTONS_OK_CANCEL = 1
  BUTTONS_ABORT_RETRY_IGNORE = 2
  BUTTONS_YES_NO_CANCEL = 3
  BUTTONS_YES_NO = 4
  BUTTONS_RETRY_CANCEL = 5
  BUTTONS_CANCEL_TRYAGAIN_CONTINUE = 6

  #===================================
  #  Return codes for Window's Message box
  #===================================
  SELECTED_OK = 1
  SELECTED_CANCEL = 2
  SELECTED_ABORT = 3
  SELECTED_RETRY = 4
  SELECTED_IGNORE = 5
  SELECTED_YES = 6
  SELECTED_NO = 7

  #=============================================================================#
  #--
  # Method: exit_browsers_win()
  #++
  #
  # Description: Windows close all open Web Browser.
  #                    Will close Internet Explorer, Firefox, Safari, Chrome, Opera
  #
  # Deprecated: Please use exit_browsers(..)
  #
  # Returns: N/A
  #
  # Syntax:
  #         oBrowsersToClose = OBJECT - One of the following object types:
  #                                    nil - Close all browsers (IE, FF, Opera, Chrome, Safari)
  #
  #                                    STRING - Any single Browser type (IE, FF, Opera, Chrome, Safari) to close,
  #                                                i.e "firefox" to only close the Firefox browsers
  #                                              Or "all" to close all the Browsers (IE, FF Opera, Chrome, Safari)
  #
  #                                    ARRAY of STRINGS - A single or a set of multiple Browsers
  #                                                           i.e ["firefox"] or ["ie", "chrome"]
  #                                                         Or if ["all"] for all the browsers
  #
  #
  # Usage examples: Close IE and Firefox, but leave Safari, Chrome and Opera open
  #                    exit_all_browsers_win(false, true, false, false, false)
  #
  #=============================================================================#
  def exit_browsers_win(oBrowsersToClose=nil)

    return exit_browsers(oBrowsersToClose)

  end # End Function - exit_browsers_win

  #=============================================================================#
  #--
  # Method: handle_win_dialog_confirm_saveas(...)
  #
  #++
  #
  # Description: Handles Window's Confirm Save As dialog with the specified choices
  #              This dialog is opened form a Save As dialog if the specified file pre-exists.
  #
  # Restrictions: The selection of the object that opens the Dialog must be accessed with a
  #               "click_no_wait" method, NOT with a "click" method.
  #               For example if the selection  of a button could raise a Dialog use:
  #                     browser.button(:how, what).click_no_wait
  #               Then call this method with:
  #                     browser.handle_win_dialog_confirm_saveas(.......)
  #
  # Returns: N/A
  #
  # Syntax: iTimeout = INTEGER -  Number of seconds to wait for the event to occur
  #         sChoice = STRING - Valid choices  are "yes", or "no"
  #
  # Usage Examples:
  #                To confirm saving a file from a Confirm Save As dialog:
  #                     browser.handle_win_dialog_confirm_saveas("yes")
  #
  #=============================================================================#
  def handle_win_dialog_confirm_saveas(sChoice="yes", iTimeout=5)

    if($VERBOSE == true)
      puts2("Parameters - handle_win_dialog_confirm_saveas:")
      puts2("  sChoice: " + sChoice)
      puts2("  iTimeout: " + iTimeout.to_s)
    end

    require 'rautomation'

    if(is_win?) # Only run on Windows

      # Define the identifiers for the  Windows dialog
      sDialogTitle = "Confirm Save As"

      # Create an rAutomation object
      oDialog = RAutomation::Window.new(:title => sDialogTitle)

      # Determine if the dialog exists
      if(oDialog.exists?())

        if($VERBOSE == true)
          puts2("Found Dialog tittled: " + sDialogTitle)
        end

        # Bring dialog to the top
        oDialog.activate()

        # Determine which action to take
        case sChoice.downcase.strip
          when /yes/

          # Identify the control using its - text
          sControlID = "&Yes"

          if($VERBOSE == true)
            puts2("Selecting button: " + sControlID)
          end

          # Focus on and select the choice
          oDialog.button(:text => sControlID).click()

          when /no/

          # Identify the control using its - text
          sControlID = "&No"

          if($VERBOSE == true)
            puts2("Selecting button: " + sControlID)
          end

          # Focus on and select the choice
          oDialog.button(:text => sControlID).click()

        else # No action specified so close the dialog
          oDialog.close()
          if($VERBOSE == true)
            puts2("No specific action specified. Closing dialog...")
          end

        end # Determine which action to take

      end # Determine if the dialog exists

    end  # Only run on Windows

  end # Method - handle_win_dialog_confirm_saveas()


  #=============================================================================#
  #--
  # Method: handle_win_dialog_download_complete(...)
  #
  #++
  #
  # Description: Handles Window's Download Complete dialogs with the specified choices
  #
  #
  #
  # Restrictions: The selection of the object that opens the Dialog must be accessed with a
  #               "click_no_wait" method, NOT with a "click" method.
  #               For example if the selection  of a button could raise a Dialog use:
  #                    browser.button(:how, what).click_no_wait
  #               Then call this method with:
  #                    browser.handle_win_dialog_file_download(...)
  #
  # Returns: N/A
  #
  # Syntax: sChoice = STRING - Valid choices for IE are "close", "run", "open folder", or "open"
  #                                      Valid choices for Firefox are "clear"
  #                                      A value of nil will exit the dialog w/o selecting a choice
  #
  #         iTimeout = INTEGER -  Number of seconds to wait for an event to occur
  #
  # Usage Examples:
  #                To dismiss a Download Complete dialog spawned from IE:
  #                     browser.handle_win_dialog_download_complete("close")
  #                To dismiss a Download Complete dialog spawned from Firefox:
  #                     browser.handle_win_dialog_download_complete("clear")
  #
  #=============================================================================#
  def handle_win_dialog_download_complete(sChoice="", iTimeout=5)

    if($VERBOSE == true)
      puts2("Parameters - handle_win_dialog_download_complete:")
      puts2("  sChoice: " + sChoice.to_s)
      puts2("  iTimeout: " + iTimeout.to_s)
    end

    require 'rautomation'

    if(is_win?) # Only run on Windows

      # Deal with IE dialog
      if(self.is_ie?)

        sDialogTitle = "Download complete"

        # Create an rAutomation object
        oDialog = RAutomation::Window.new(:title => sDialogTitle)

        # Determine if the dialog exists
        if(oWindow.exists?())

          # Bring dialog to the top
          oDialog.activate()

          if($VERBOSE == true)
            puts2("Found Dialog tittled: " + sDialogTitle)
          end

          # Determine which action to take
          case sChoice.downcase.strip
            when /close/

            # Identify the control using its - text
            sControlID = "Close"

            if($VERBOSE == true)
              puts2("Selecting button: " + sControlID)
            end

            # Focus on and select the choice
            oDialog.button(:text => sControlID).click()

            when /run/

            # Identify the control using its - text
            sControlID = "Run"

            if($VERBOSE == true)
              puts2("Selecting button: " + sControlID)
            end

            # Focus on and select the choice
            oDialog.button(:text => sControlID).click()

            when /open folder/

            # Identify the control using its - text
            sControlID = "Open &Folder"

            if($VERBOSE == true)
              puts2("Selecting button: " + sControlID)
            end

            # Focus on and select the choice
            oDialog.button(:text => sControlID).click()

            when "open"

            # Identify the control using its - text
            sControlID = "&Open"

            if($VERBOSE == true)
              puts2("Selecting button: " + sControlID)
            end

            # Focus on and select the choice
            oDialog.button(:text => sControlID).click()

          else # No action specified so close the dialog
            if($VERBOSE == true)
              puts2("No specific action specified. Closing dialog...")
            end
            oDialog.close()

          end # Determine which action to take
        end # Determine if the dialog exists

      end # Deal with IE dialog

      # Deal with FF dialog
      if(self.is_firefox?)

        sDialogTitle = "Downloads"

        # Create an rAutomation object
        oDialog = RAutomation::Window.new(:title => sDialogTitle)

        # Determine if the dialog exists
        if(oDialog.exists?())

          # Bring dialog to the top
          oDialog.activate()

          if($VERBOSE == true)
            puts2("Found Dialog tittled: " + sDialogTitle)
          end

          # Determine which action to take
          case sChoice.downcase.strip

            when /clear/

            # Identify the control using its - text
            sControlID = "Clear List"

            if($VERBOSE == true)
              puts2("Selecting button: " + sControlID)
            end

            # Focus on and select the choice
            oDialog.button(:text => sControlID).click()

            # Close the dialog
            if($VERBOSE == true)
              puts2("Closing dialog...")
            end
            oDialog.close()

          else # No action specified so close the dialog
            if($VERBOSE == true)
              puts2("No specific action specified. Closing dialog...")
            end
            oDialog.close()
          end # Determine which action to take

        end # Determine if the dialog exists
      end # Deal with FF dialog
    end  # Only run on Windows

  end # Method - handle_win_dialog_download_complete

  #=============================================================================#
  #--
  # Method: handle_win_dialog_generic_modal(...)
  #
  #++
  #
  # Description: Handles a Window's Generic Modal dialogs with the specified choices
  #
  #              It can be used to dismiss Window's Modal dialogs like the following:
  #                  Title: Security Alert
  #                    Controls:  &Yes, &No, &View Certificate
  #                  Title: Security Information
  #                    Controls:  &Yes, &No, &More Info
  #                  Title: Internet Explorer Security
  #                     Controls:  &Allow, &Don't allow, D&tails
  #                  Title: Internet Explorer
  #                     Controls:  &OK, &Show Details
  #                  Title: File Download
  #                     Controls:  &Save, &Cancel
  #
  #               It is presumed that by selecting any of the Dialog's choice buttons that the dialog is automatically closed.
  #               If in doing so it spawns another Modal dialog, then that dialog will need to be addressed by calling the function
  #               again with different parameters, or with some other customized code.
  #
  #
  # Restrictions: The selection of the object that opens the Dialog must be accessed with a
  #               "click_no_wait" method, NOT with a "click" method.
  #               For example if the selection  of a button could raise a Dialog use:
  #                    browser.button(:how, what).click_no_wait
  #               Then call this method with:
  #                    browser.handle_win_dialog_generic_modal(.......)
  #
  # Returns: N/A
  #
  # Syntax: sDialogTitle = STRING - The title used to identify the Dialog (e.g. "File Download")
  #
  #         sButtonControlID = STRING - Identifier for the Dialog's button control.
  #                                     For example:
  #                                                               *  ID - The internal control ID. The Control ID is the internal numeric identifier that windows gives to each control.
  #                                                                          It is generally the best method of identifying controls. In addition to the AutoIt Window Info Tool, other
  #                                                                          applications such as screen readers for the blind and Microsoft tools/APIs may allow you to get this Control ID
  #                                                               * TEXT - The text on a control, for example "&Next" on a button
  #                                                               * CLASS - The internal control class name such as "Edit" or "Button"
  #                                                               * CLASSNN - The ClassnameNN value as used in previous versions of AutoIt, such as "Edit1"
  #                                                               * NAME - The internal .NET Framework WinForms name (if available)
  #                                                               * REGEXPCLASS - Control class name using a regular expression
  #                                                                * X \ Y \ W \ H - The position and size of a control.
  #                                                                * INSTANCE - The 1-based instance when all given properties match.
  #
  #
  #         sInputTextControlID = STRING - Identifier for the Dialog's Input Field control into which the Input Text would be entered
  #                                                          See AutoIt documentation for full details and syntax -   http://www.autoitscript.com/autoit3/docs/intro/controls.htm
  #
  #         sInputText = STRING = Any text needing to be entered into the dialog before the choice is applied
  #
  #         bCloseDialog = BOOLEAN = true to explictly close the dialog via the Window manager
  #                                 false to leave it open, when by the application of the choice it was NOT closed
  #
  #         iTimeout = INTEGER -  Number of seconds to wait for an event to occur
  #
  # Usage Examples:
  #               a)  To dismiss a Internet Explorer Security dialog:
  #                     sDialogTitle = "Internet Explorer Security"
  #                     sButtonControlID = "&Allow"
  #                     sInputTextControlID = ""
  #                     sInputText = ""
  #                     bCloseDialog = true
  #                     iTimeout = 5
  #                     browser.handle_win_dialog_generic_modal(sDialogTitle, sChoice, sInputText, bCloseDialog, iTimeout)
  #
  #                 b)  To view More info from a Security Information dialog, and NOT automatically close the dialog:
  #                     sDialogTitle = "Security Information"
  #                     sButtonControlID = "[CLASS:Button; TEXT:More Info]"
  #                     sInputTextControlID = ""
  #                     sInputText = ""
  #                     bCloseDialog = false
  #                     iTimeout = 5
  #                     browser.handle_win_dialog_generic_modal(sDialogTitle, sChoice, sInputText, bCloseDialog, iTimeout)
  #
  #                 c)   To dismiss a Informational modal dialog named "Untitled -- Attention" which contains no buttons, but displays text:
  #                     sDialogTitle = "Untitled "
  #                     sButtonControlID = ""
  #                     sInputTextControlID = ""
  #                     sInputText = ""
  #                     bCloseDialog = true
  #                     iTimeout = 5
  #                     browser.handle_win_dialog_generic_modal(sDialogTitle, sChoice, sInputText, bCloseDialog, iTimeout)
  #=============================================================================#
  def handle_win_dialog_generic_modal(sDialogTitle, sButtonControlID="", sInputTextControlID="Edit", sInputText="", bCloseDialog=true, iTimeout=5)

    if($VERBOSE == true)
      puts2("Parameters - handle_win_dialog_generic_modal:")
      puts2("  sDialogTitle: " + sDialogTitle)
      puts2("  sButtonControlID: " + sButtonControlID)
      puts2("  sInputTextControlID: " + sInputTextControlID)
      puts2("  sInputText: " + sInputText)
      puts2("  bCloseDialog: " + bCloseDialog.to_s)
      puts2("  iTimeout: " + iTimeout.to_s)
    end

    require 'rautomation'

    # Create an rAutomation object
    oDialog = RAutomation::Window.new(:title => sDialogTitle)

    if(is_win?) # Only run on Windows

      # Determine if the dialog exists
      if(oDialog.exists?())

        # Bring dialog to the top
        oDialog.activate()

        if($VERBOSE == true)
          puts2("Found Dialog tittled: " + sDialogTitle)
        end

        if((sInputTextControlID != "") && (sInputText != ""))

          if($VERBOSE == true)
            puts2("Entering text: " + sInputText)
            puts2(" into field: " + sInputTextControlID)
          end

          # Focus on and enter the text into the control
          oDialog.text_field(:class => sInputTextControlID).set(sInputText)
        end

        # Determine if a choice button should be selected
        if(sButtonControlID != "")

          if($VERBOSE == true)
            puts2("Selecting button: " + sButtonControlID)
          end

          # Focus on and select the choice
          oDialog.button(:text => sButtonControlID).click()

        end

        # Determine if the dialog should be closed if it is open
        if((bCloseDialog) && (oDialog.exists?()) && (sButtonControlID == ""))

          # Close the dialog via the window manager
          if($VERBOSE == true)
            puts2("No specific action specified. Closing dialog...")
          end
          oDialog.close()

        end # Determine if the dialog should be closed if it is open
      end # Determine if the dialog exists
    end  # Only run on Windows

  end # Method - handle_win_dialog_generic_modal


  #=============================================================================#
  #--
  # Method: handle_win_dialog_saveas(...)
  #
  #++
  #
  # Description: Handles Window's Save As dialog with the specified choices.
  #              This dialog is opened when the user selects to download a file from the browser.
  #              The Save As dialog contains a set of choice buttons and a text field to enter the filename
  #              If the specified file pre-exists a Confirm Save As dialog will subsequently be opened.
  #
  # Restrictions: The selection of the object that opens the Dialog must be accessed with a
  #               "click_no_wait" method, NOT with a "click" method.
  #               For example if the selection  of a button could raise a Dialog use:
  #                  browser.button(:how, what).click_no_wait
  #               Then call this method with:
  #                  browser.handle_win_dialog_saveas(.......)
  #
  # Returns: N/A
  #
  # Syntax: sChoice = STRING - Valid choices for IE are "run", "save", or "cancel"
  #                                     Valid choices for Firefox are "save", or "cancel"
  #
  #         sFullFilePath = STRING = The full path name and file name to save the IE download
  #                                              Firefox downloads use the FF default location which is saved
  #                                               as a FF setting, and NOT specifiable at download time.
  #
  #         bConfirmChioce = BOOLEAN - true = Select Yes for any Confirm Save AS dialog
  #                                                   false = Select No for any Confirm Save AS dialog
  #
  #         iTimeout = INTEGER -  Number of seconds to wait for the event to occur
  #
  # Usage Examples:
  #                To save a file from a Dialog spawned from IE:
  #                     browser.handle_win_dialog_saveas("File Download")
  #
  #=============================================================================#
  def handle_win_dialog_saveas(sChoice="", sFullFilePath="", bConfirmChioce=true, iTimeout=5)

    if($VERBOSE == true)
      puts2("Parameters - handle_win_dialog_saveas:")
      puts2("  sChoice: " + sChoice)
      puts2("  sFullFilePath: " + sFullFilePath)
      puts2("  bConfirmChioce: " + bConfirmChioce.to_s)
      puts2("  iTimeout: " + iTimeout.to_s)
    end

    require 'rautomation'

    if(bConfirmChioce)
      sConfirmChoice ="yes"
    else
      sConfirmChoice ="no"
    end

    if(is_win?) # Only run on Windows

      # Deal with IE dialog
      if(self.is_ie?)

        sDialogTitle = "Save As"

        # Create an rAutomation object
        oDialog = RAutomation::Window.new(:title => sDialogTitle)

        # Determine if the dialog exists
        if(oDialog.exists?())


          # Bring dialog to the top
          oDialog.activate()

          if($VERBOSE == true)
            puts2("Found Dialog tittled: " + sDialogTitle)
          end

          # Determine which action to take
          case sChoice.downcase.strip
            when /save/

            # Determine to use the default value or enter a user specified value
            if(sFullFilePath != "")

              # Identify the control using its - ClassnameNN
              sEditControlID = "Edit1"

              # Identify the control using its - text
              sControlID = "&Save"

              if($VERBOSE == true)
                puts2("Entering filename into : " + sEditControlID)
              end

              # Focus on and enter the pathname to save the file
              oDialog.text_field(:class => sInputTextControlID).set(sFullFilePath)

            end # Determine to use the default value or enter a user specified value

            # Identify the control using its - text
            sControlID = "&Save"

            if($VERBOSE == true)
              puts2("Selecting button: " + sControlID)
            end

            # Focus on and select the choice
            oDialog.button(:text => sControlID).click()

            when /cancel/

            # Identify the control using its - text
            sControlID = "Cancel"

            if($VERBOSE == true)
              puts2("Selecting button: " + sControlID)
            end

            # Focus on and select the choice
            oDialog.button(:text => sControlID).click()

          else # No action specified so close the dialog
            if($VERBOSE == true)
              puts2("No specific action specified. Closing dialog...")
            end
            oDialog.close()

          end # Determine which action to take
        end # Determine if the dialog exists
      end # Deal with IE dialog


      # Determine if the Confirm Save As dialog exists
      #  which only opens if the specified file pre-existed
      if(RAutomation::Window.new(:title => "Confirm Save As").exists?())
        self.handle_win_dialog_confirm_saveas(sConfirmChoice, 5)
      end


    end  # Only run on Windows

  end # Method - handle_win_dialog_saveas


  #=============================================================================#
  #--
  # Method: handle_win_dialog_security_alert(...)
  #
  #++
  #
  # Description: Handles Window's Security Alert dialog with the specified choices
  #              This dialog is opened form a Download Complete dialog if Open is selected.
  #
  #              This dialog is identified by following:
  #                 Title: Security Alert
  #                    Choices:  Yes, No, View Certificate
  #
  #
  # Restrictions: The selection of the object that opens the Dialog must be accessed with a
  #               "click_no_wait" method, NOT with a "click" method.
  #               For example if the selection  of a button could raise a Dialog use:
  #                  browser.button(:how, what).click_no_wait
  #               Then call this method with:
  #                  browser.handle_win_dialog_security_alert(.......)
  #
  # Returns: N/A
  #
  # Syntax: iTimeout = INTEGER -  Number of seconds to wait for the event to occur
  #
  #         sChoice = STRING - Valid choices  are "yes", "no", "view"
  #
  # Usage Examples:
  #                To dismiss the dialog:
  #                     browser.handle_win_dialog_security_alert("yes")
  #
  #=============================================================================#
  def handle_win_dialog_security_alert(sChoice="yes", iTimeout=5)

    if($VERBOSE == true)
      puts2("Parameters - handle_win_dialog_security_alert:")
      puts2("  sChoice: " + sChoice)
      puts2("  iTimeout: " + iTimeout.to_s)
    end

    require 'rautomation'

    if(is_win?) # Only run on Windows

      # Define the identifiers for the  Windows dialog
      sDialogTitle = "Security Alert"

      # Create an rAutomation object
      oDialog = RAutomation::Window.new(:title =>  sDialogTitle)

      # Determine if the dialog exists
      if(oDialog.exists?())

        # Bring dialog to the top
        oDialog.activate()

        if($VERBOSE == true)
          puts2("Found Dialog tittled: " + sDialogTitle)
        end

        # Determine which action to take
        case sChoice.downcase.strip
          when /yes/

          # Identify the control using its - text
          sControlID = "&Yes"

          if($VERBOSE == true)
            puts2("Selecting button: " + sControlID)
          end

          # Focus on and select the choice
          oDialog.button(:text => sControlID).click()

          when /no/

          # Identify the control using its - text
          sControlID = "&No"

          if($VERBOSE == true)
            puts2("Selecting button: " + sControlID)
          end

          # Focus on and select the choice
          oDialog.button(:text => sControlID).click()

          when /view/

          # Identify the control using its - text
          sControlID = "&View Certificate"

          if($VERBOSE == true)
            puts2("Selecting button: " + sControlID)
          end

          # Focus on and select the choice
          oDialog.button(:text => sControlID).click()

        else # No action specified so close the dialog
          if($VERBOSE == true)
            puts2("No specific action specified. Closing dialog...")
          end
          oDialog.close()

        end # Determine which action to take


      end # Determine if the dialog exists

    end  # Only run on Windows

  end # Method - handle_win_dialog_security_alert


  #=============================================================================#
  #--
  # Method: handle_win_dialog_security_information(...)
  #
  #++
  #
  # Description: Handles Window's Security Information dialog with the specified choices
  #              This dialog is opened form a Download Complete dialog if Open is selected.
  #
  #              This dialog is identified by following:
  #                 Title: Security Information
  #                    Choices:  Yes, No, More Info
  #
  # Restrictions: The selection of the object that opens the Dialog must be accessed with a
  #               "click_no_wait" method, NOT with a "click" method.
  #               For example if the selection  of a button could raise a Dialog use:
  #                  browser.button(:how, what).click_no_wait
  #               Then call this method with:
  #                  browser.handle_win_dialog_security_information(.......)
  #
  # Returns: N/A
  #
  # Syntax: iTimeout = INTEGER -  Number of seconds to wait for the event to occur
  #
  #         sChoice = STRING - Valid choices  are "yes", "no", "more info"
  #
  # Usage Examples:
  #                To dismiss the dialog:
  #                     browser.handle_win_dialog_security_information("yes")
  #
  #=============================================================================#
  def handle_win_dialog_security_information(sChoice="yes", iTimeout=5)

    if($VERBOSE == true)
      puts2("Parameters - handle_win_dialog_security_information:")
      puts2("  sChoice: " + sChoice)
      puts2("  iTimeout: " + iTimeout.to_s)
    end

    require 'rautomation'

    if(is_win?) # Only run on Windows

      require 'win32ole'

      # Define the identifiers for the  Windows dialog
      sDialogTitle = "Security Information"

      # Create an rAutomation object
      oDialog = RAutomation::Window.new(:title =>  sDialogTitle)

      # Determine if the dialog exists
      if(oDialog.exists?())

        # Bring dialog to the top
        oDialog.activate()

        if($VERBOSE == true)
          puts2("Found Dialog tittled: " + sDialogTitle)
        end

        # Determine which action to take
        case sChoice.downcase.strip
          when /yes/

          # Identify the control using its - text
          sControlID = "&Yes"

          if($VERBOSE == true)
            puts2("Selecting button: " + sControlID)
          end

          # Focus on and select the choice
          oDialog.button(:text => sControlID).click()

          when /no/

          # Identify the control using its - text
          sControlID = "&No"

          if($VERBOSE == true)
            puts2("Selecting button: " + sControlID)
          end

          # Focus on and select the choice
          oDialog.button(:text => sControlID).click()

          when /more info/

          # Identify the control using its - text
          sControlID = "&More Info"

          if($VERBOSE == true)
            puts2("Selecting button: " + sControlID)
          end

          # Focus on and select the choice
          oDialog.button(:text => sControlID).click()

        else # No action specified so close the dialog
          if($VERBOSE == true)
            puts2("No specific action specified. Closing dialog...")
          end
          oDialog.close()

        end # Determine which action to take


      end # Determine if the dialog exists

    end  # Only run on Windows

  end # Method - handle_win_dialog_security_information



  #=============================================================================#
  #--
  # Method: is_minimized?(...)
  #
  #++
  #
  # Description: Determines if the browser window is minimized by using AutoIt
  #
  # WARNING: This method uses an AutoIt3 function (WinGetState) that does NOT exist
  #          in the version of AutoIt bundled with Watir 1.6.5 or previous versions of Watir.
  #
  #
  # Returns: BOOLEAN - true if minimized, otherwise false
  #
  # Syntax: sWinTitle = STRING - The title used to identify the window (e.g. "My WebSite - Home")
  #
  #         sWinText = STRING - Any optional additional text within the window to help identify it
  #
  # Usage Examples:      assert(browser.is_minimized?)
  #
  #=============================================================================#
  def is_minimized?(sWinTitle=self.title, sWinText="")

    if($VERBOSE == true)
      puts2("Parameters - is_minimized?:")
      puts2("  sWinTitle: " + sWinTitle)
      puts2("  sWinText: " + sWinText)
    end

    if(is_win?) # Only run on Windows

      require 'win32ole'

      # Create an AutoIt object
      oAutoIt = WIN32OLE.new("AutoItX3.Control")

      # Use AutoIt to retrieve the list of all top level windows
      iStatus = oAutoIt.WinGetState(sWinTitle, sWinText)

      if(iStatus == 0)
        puts("Browser NOT found")
        return false
      end

      if((iStatus >= 16) && (iStatus < 32))
        return true
      else
        return false
      end

    end # Only run on Windows
  end # Method - is_minimized?()

  #=============================================================================#
  #--
  # Method: is_maximized?(...)
  #
  #++
  #
  # Description: Determines if the browser window is maximized by using AutoIt
  #
  # WARNING: This method uses an AutoIt3 function (WinGetState) that does NOT exist
  #          in the version of AutoIt bundled with Watir 1.6.5 or previous versions of Watir.
  #          AutoIt is a freeware scripting language designed for automating the Windows GUI
  #          Please refer to the WatirWorks README page for update setup information.
  #
  #
  # Returns: BOOLEAN - true if maximized, otherwise false
  #
  # Syntax: sWinTitle = STRING - The title used to identify the window (e.g. "My WebSite - Home")
  #
  #         sWinText = STRING - Any optional additional text within the window to help identify it
  #
  # Usage Examples:      assert(browser.is_maximized?)
  #
  #=============================================================================#
  def is_maximized?(sWinTitle=self.title, sWinText="")

    if($VERBOSE == true)
      puts2("Parameters - is_maximized:")
      puts2("  sWinTitle: " + sWinTitle)
      puts2("  sWinText: " + sWinText)
    end

    if(is_win?) # Only run on Windows

      require 'win32ole'

      # Create an AutoIt object
      oAutoIt = WIN32OLE.new("AutoItX3.Control")

      # Use AutoIt to retrieve the list of all top level windows
      iStatus = oAutoIt.WinGetState(sWinTitle, sWinText)

      if(iStatus == 0)
        puts2("Browser NOT found")
        return false
      end

      if(iStatus >= 32)
        return true
      else
        return false
      end
    end # Only run on Windows
  end  # Method - is_maximized?()


  #=============================================================================#
  #--
  # Method: open_messagebox_win(...)
  #++
  #
  # Description: Opens a Window's message box, reads the user response,
  #              and returns that response as an FIXNUM
  #
  # Returns: FIXNUM = Value of the user's response. Valid values are:
  #                          1 = SELECTED_OK
  #                          2 = SELECTED_CANCEL
  #                          3 = SELECTED_ABORT
  #                          4 = SELECTED_RETRY
  #                          5 = SELECTED_IGNORE
  #                          6 = SELECTED_YES
  #                          7 = SELECTED_NO
  #
  # Syntax:
  #         sPrompt = STRING - to display as the user prompt within the windows message box
  #         sTitle = STRING -  to display on the titlebar of the windows message box
  #         iButtons = FIXNUM - Value defining the buttons to display on the Windows Message box
  #                                  Valid values are:
  #                                          0 = BUTTONS_OK
  #                                          1 = BUTTONS_OK_CANCEL
  #                                          2 = BUTTONS_ABORT_RETRY_IGNORE
  #                                          3 = BUTTONS_YES_NO_CANCEL
  #                                          4 = BUTTONS_YES_NO
  #                                          5 = BUTTONS_RETRY_CANCEL
  #                                          6 = BUTTONS_CANCEL_TRYAGAIN_CONTINUE
  #
  # Usage examples:
  #                  1) Open a 1 button dialog:
  #                       sPrompt = "Select OK to continue"
  #                       sTitle = "Windows OK Dialog"
  #                       iButtons = BUTTONS_OK
  #                       iMyChoice = open_messagebox_win(sPrompt, sTitle, iButtons)
  #                       if(iMyChoice == SELECTED_OK)
  #                            puts2("You picked: OK")
  #                       else
  #                            puts2("  You picked button number: " + iMyChoice.to_s)
  #                       end
  #
  #                  2) Open a 2 button dialog:
  #                       sPrompt = "Are you OK?"
  #                       sTitle = "Windows Yes, No Dialog"
  #                       iButtons = BUTTONS_YES_NO
  #                       iMyChoice = open_messagebox_win(sPrompt, sTitle, iButtons)
  #                       case iMyChoice
  #                             when SELECTED_YES
  #                             puts2("You picked: YES")
  #
  #                             when SELECTED_NO
  #                             puts2("You picked: NO")
  #                       else
  #                            puts2("  You picked button number: " + iMyChoice.to_s)
  #                       end
  #
  #                  2) Open a 3 button dialog:
  #                       sPrompt = "Delete some useless stuff?"
  #                       sTitle = "Windows Yes, No, Cancel Dialog"
  #                       iButtons = BUTTONS_YES_NO_CANCEL
  #                       iMyChoice = open_messagebox_win(sPrompt, sTitle, iButtons)
  #                       case iMyChoice
  #                             when SELECTED_YES
  #                             puts2("You picked: YES")
  #
  #                             when SELECTED_NO
  #                             puts2("You picked: NO")
  #
  #                             when SELECTED_CANCEL
  #                             puts2("You picked: CANCEL")
  #                       else
  #                            puts2("  You picked button number: " + iMyChoice.to_s)
  #                       end
  #
  #=============================================================================#
  def open_messagebox_win(sPrompt, sTitle="Windows", iButtons=BUTTONS_OK)

    if($VERBOSE == true)
      puts2("Parameters - open_messagebox_win:")
      puts2("  sPrompt: " + sPrompt)
      puts2("  sTitle: " + sTitle)
      puts2("  iButtons: " + iButtons.to_s)
    end

    require 'dl'

    if(is_win?) # Only run on Windows

      # Disallow numbers outside the button index range (0-6)
      if((iButtons < 0) | (iButtons > 6))
        iButtons = BUTTONS_OK
      end

      # Access the Window's dynamic linked library user32.dll
      user32dll = DL.dlopen('user32')

      # Create a message box object from the dll
      oMsgbox = user32dll['MessageBoxA', 'ILSSI']

      # Open the  message box and read the response
      oResponse = oMsgbox.call(0, sPrompt, sTitle, iButtons)

      oMyChoice = oResponse[0,1].to_s  # Read the 1st character and convert to a STRING

      iMyChoice = oMyChoice.to_i  # Convert STRING to FIXNUM

      return iMyChoice

    else # Its NOT windows

      return -1 # Return error code as this was NOT executed on Windows


    end # Only run on Windows

  end # Method - open_messagebox_win()


  #=============================================================================#
  #--
  # Method: pause()
  #++
  #
  # Description: Pauses script execution by opening a Window's message box and waiting
  #              until the user manually selects the "OK" button to continue execution.
  #              You can optionally specify a custom user prompt.
  #
  # Syntax:
  #         sPrompt = String to display as the user prompt within the windows message box
  #         sTitle = String to display on the titlebar of the windows message box
  #
  # Usage examples:
  #                 pause()
  #
  #=============================================================================#
  def pause(sPrompt = "Execition paused. \n\nSelect OK to Continue", sTitle = "Watir Works")

    if($VERBOSE == true)
      puts2("Parameters - pause:")
      puts2("  sPrompt: " + sPrompt)
      puts2("  sTitle: " + sTitle)
    end

    if(is_win?) # Only run on Windows
      open_messagebox_win(sPrompt, sTitle, BUTTONS_OK)
    end # Only run on Windows
  end # Function - pause()


  #=============================================================================#
  #--
  # Method: popup_watchpoint(...)
  #++
  #
  # Description: Pauses script execution by opening a Window's message box and waiting
  #              until the user manually selects the "OK" button to continue execution.
  #              You can optionally specify a custom user prompt.
  #
  # Syntax:
  #         sPrompt = String to display as the user prompt within the windows message box
  #         sTitle = String to display on the titlebar of the windows message box
  #         aWatchList =  Array of variables to watch.
  #                                 If not specified all global variables are displayed
  #
  # Usage examples:
  #                 To display all Global variables
  #                            popup_watchpoint()
  #                 To display a single Global Variable:
  #                           popup_watchpoint(["$FASTSPEED"])
  #                 To display a specific set of Global and Class variables:
  #                           popup_watchpoint(["$DEBUG", "$FAST_SPEED", "$PROGRAM_NAME", "$0", "$.", "@sName"])
  #
  #=============================================================================#
  def popup_watchpoint(aWatchList = nil, sPrompt = "Watchpoint \n\nSelect Yes to record variables and continue execution \nSelect No to NOT record variables and continue execution \nSelect Cancel to record variables and exit", sTitle = "Ruby Framework")

    if(is_win?) # Only run on Windows

      # Display the IE Message box and read the user's response
      iUserResponse = open_messagebox_win(sPrompt, sTitle, BUTTONS_YES_NO_CANCEL)

      # Perform the operation specified by the user's response
      case iUserResponse

        when  SELECTED_YES       # Continue after recording the variables

        puts2("Continuing after recording the following variables")

        # Continue without recording the variables
        watchlist(aWatchList)
        puts2("")

        when SELECTED_NO   # Continue without recording the variables

        puts2("Continuing execution")


      else # Exit after Recording the variables

        puts2("Exiting after recording the following variables")

        # Record variables
        watchlist(aWatchList)
        puts2("")

        exit

      end # Case statement
    end # Only run on Windows
  end # Method - popup_watchpoint()


  #=============================================================================#
  #--
  # Method: save_screencapture_win(...)
  #++
  #
  # Description: Save a screen capture of the current web page or desktop to a file
  #              using the Watir method screen_capture()
  #
  #              The file name is based on the passed in parameters and the time (dd_mmm_yyyy_hhmmss).
  #              For example:
  #                          Bitmap file is saved as: ScreenShot_4_Jul_2007_123001.bmp
  #                          JPEG file is saved as: ScreenShot_4_Jul_2007_123001.jpg
  #
  # Returns: BOOLEAN = true on success, otherwise false
  #
  # Syntax: sFileNamePrefix = STRING - The left most part of the filename (Defaults to "ScreenShot")
  #
  #         bActiveWindowOnly = BOOLEAN - true  = save current window (default)
  #                                       false = save entire desktop
  #
  #         bSaveAsJpg = BOOLEAN - true  = save a JPEG file (default)
  #                                false = save a BMP file
  #
  #         sOutputDir = STRING -  sub-directory that the file is saved under (Defaults to the user account's temp directory)
  #
  #
  # Prerequisites: The Watir method screen_capture() requires:
  #                   a) MS Paint (mspaint.exe) is installed
  #                   b) Only one IE Browser is open
  #                   c) The IE Browser in focus
  #
  # IMPORTANT NOTE: The Watir method screen_capture() requires mspaint.exe to be installed.
  #                 Some systems MAY NOT have mspaint.exe installed!
  #                 Please install MS Paint if it is NOT already installed!
  #                 If you have MS Paint installed you will find it on your Windows Start menu under:
  #                    START > All Programs > Accessories > Paint
  #
  #                 If your system does NOT have MS Paint the Watir screen_capture()
  #                 method performs a File -> Save operation which will
  #                 save the current HTML page and its associated image files in a sub-directory.
  #                 It appears that this save operation can only occur once!
  #                 If you try to re-use screen_capture() it no longer connects to IE
  #                 which causes the active IE Browser to exit.
  #
  #=======================================================================#
  def save_screencapture_win(sFileNamePrefix="Image", bActiveWindowOnly=true, bSaveAsJpg=true, sOutputDir="")

    if($VERBOSE == true)
      puts2("Parameters - save_screencapture_win:")
      puts2("  sFileNamePrefix: " + sFileNamePrefix)
      puts2("  bActiveWindowOnly: " + bActiveWindowOnly.to_s)
      puts2("  bSaveAsJpg: " + bSaveAsJpg.to_s)
      puts2("  sOutputDir: " + sOutputDir)
    end

    if(is_win?) # Only run on Windows

      # Require the Watir screen capture method files
      require 'watir/screen_capture'

      # Save original Global variable's setting
      bHIDE_IE_ORIG = $HIDE_IE

      # Find a location on the local Windows filesystem that will allow this unit test to write a file
      if(sOutputDir == "")
        # Use the OS's default Temporary directory
        # sOutputDir = find_tmp_dir()

        # Save to the results directory if a logger is running
        if($sLoggerResultsDir.nil?)
          # Use the OS's default Temporary directory
          sOutputDir = find_tmp_dir()
        else
          # Correct path for windows (switch and / with \)
          sOutputDir = $sLoggerResultsDir.gsub('/', '\\')

        end

      end

      # Unable to capture the screen if the browser is hidden
      if(($HIDE_IE == true) & (self != nil))
        self.visible = true
      end

      # Define file extension
      if bSaveAsJpg
        sFileExt = ".jpg"
        bSaveAsBMP = false
      else
        sFileExt = ".bmp"
        bSaveAsBMP = true
      end


      # Define the region of the capture
      if bActiveWindowOnly
        sScreen_Region = "_window_"

        # Minimize the Ruby Console window so it doesn't block the browser window
        minimize_ruby_console()

      else
        sScreen_Region = "_desktop_"
      end

      # Combine the elements to make a unique file name prefix
      sFilename = sFileNamePrefix + sScreen_Region + Time.now.strftime(DATETIME_FILEFORMAT).to_s + sFileExt

      sFullPathToImageFile = sOutputDir + "\\" + sFilename
      #sFullPathToImageFile = File.join(sOutputDir, sFilename)

      # Perform the screen capture of the web page
      screen_capture( sFullPathToImageFile , bActiveWindowOnly, bSaveAsBMP )

      puts2("Saved image to: #{sFullPathToImageFile}")

      # Restore Global variable's original setting
      $HIDE_IE = bHIDE_IE_ORIG

      # Return the browser to its original state
      if(($HIDE_IE == true) & (self != nil))
        self.visible = false
      end

    end # Only run on Windows

  end # Method - save_screencapture_win()

end # END Module - WatirWorks_WinUtilities


#=begin

#=============================================================================#
# Class: Watir::Element
#
# Description: Extends the Watir::Element class with additional methods
#
#--
# Methods: set_no_wait()
#++
#=============================================================================#
class Watir::Element

  #=============================================================================#
  #--
  # Method: set_no_wait(...)
  #
  #++
  #
  # Description: For use with text fields, checkboxes or other elements that spawn Java script pop-up when set,
  #              and thus can't use the normal set() method. This is due to the JS dialog preventing
  #              the current web page from being ready until after the pop-up is dismissed. Which
  #              causes Watir to timeout as the web page that launched the pop-up was not ready in time.
  #
  #              Similar to Watir's click_no_wait() method which is used with buttons.
  #
  # NOTE: From the Watir General discussion group:  http://groups.google.com/group/watir-general
  #       This method is slated for inclusion into a future release of Watir, but is NOT part of Watir 1.6.5.
  #       See issues: http://jira.openqa.org/browse/WTR-182
  #                   http://jira.openqa.org/browse/WTR-185
  #                   http://jira.openqa.org/browse/WTR-278
  #
  # Returns: N/A
  #
  # Syntax: N/A
  #
  # Usage Examples: When setting a text filed, checkbox or radio button that will launch a
  #                 a JS pop-up, use this method instead of the normal set method.
  #
  #                     browser.text_field(:how, what).set_no_wait("my text to be entered")
  #                     browser.checkbox(:how, what).set_no_wait
  #                     browser.file_field(:how, what).set_no_wait(path_to_file)
  #                     browser.radio(:how, what).set_no_wait(my_chioce)
  #                     browser.select_list(:how, what).set_no_wait("my choice in list")
  #
  #=============================================================================#
  def set_no_wait()
    assert_enabled
    highlight(:set)
    object = "#{self.class}.new(self, :unique_number,#{self.unique_number})"
    @page_container.eval_in_spawned_process(object + ".set")
    highlight(:clear)
  end

end # Class Watir::Element


#=============================================================================#
# Class: Watir::IE
#
# Description: Extends the Watir::IE class with additional methods
#              This class is is NOT supported if using Watir_WebDriver
#
#--
# Methods:
#          moveBy(...)
#          moveTo(...)
#          resizeBy(...)
#          resizeTo(...)
#          restart()
#          scrollBy(...)
#          title()
#          title_from_url
#++
#=============================================================================#
class Watir::IE

  #=============================================================================#
  #--
  # Method: restart(...)
  #
  #++
  #
  # Description: Close the current browser object, pause,
  #              then create and return a new browser object.
  #              Any URL that the current browser is displaying is lost.
  #
  # Returns: BROWSER object
  #
  # Syntax: sURL = STRING - The URL to load in the new browser, defaults to the currently loaded URL
  #
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
  def restart(sURL ="", bClearCache = false)

    if($VERBOSE == true)
      puts2("Parameters - restart:")
      puts2("  sURL: " + sURL)
    end

    puts2("Closing the browser...")

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

    puts2("Starting a new browser object...")

    # Create a new browser object using Watir's method directly
    # Can't use start_Browser() as both local and Global Browser's may coexist
    oBrowser = Watir::IE.new
    oBrowser.goto(sURL)

    # Allow time to celebrate the birth of the new browser.
    sleep 2  # That's long enough to celebrate

    return oBrowser  # Return the new browser.

  end # END Method - restart()


  #=============================================================================#
  #--
  # Method: scrollBy(...)
  #
  #++
  #
  # Description: Scroll the current Browser window (in pixels)
  #              Per: http://www.w3schools.com/jsref/obj_window.asp
  #                    The ScrollBy() method is supported in all major browsers.
  #
  # Returns: BOOLEAN - true if successful, otherwise false
  #
  # Syntax: iHorizontal = INTEGER - How many pixels to scroll by, along the x-axis (horizontal)
  #                                 Positive values move scroll left, Negative values move scroll right
  #                                 Default value = 0
  #
  #         iVertical = INTEGER - How many pixels to scroll by, along the y-axis (vertical)
  #                               Positive values move scroll down, Negative values move scroll up
  #                               Default value = 0
  #
  # Usage Examples:
  #                To scroll the browser vertically by 100 pixels
  #                     browser.scrollBy(0, 100)
  #
  #=============================================================================#
  def scrollBy(iHorizontal=0, iVertical=0)

    self.goto("javascript:window.scrollBy(#{iHorizontal},#{iVertical})")
  end # scrollBy()

  #=============================================================================#
  #--
  # Method: title()
  #
  #++
  #
  # Description: Provides the Title of the IE Window
  #              which may not equal to <title> DOM value
  #              When <title></title> is empty OR does not exist in the DOM
  #              (for example when PDF is displayed in browser)
  #              Then return title_from_url string visible in the window
  #              Else return <title> DOM value
  #
  #
  #  From: http://gist.github.com/141738
  #
  #=============================================================================#
  def title
    myTitle = begin
      @ie.document.title
    rescue WIN32OLERuntimeError => e #unknown property 'title'
      log "WIN32OLERuntimeError: #{e}"
        "" #return empty string for title value empty
    end
     (myTitle == "")? title_from_url : myTitle
  end

  #=============================================================================#
  #--
  # Method: title_from_url()
  #
  #++
  #
  # Description:  When a file is loaded in browser served by file system in location "c:\data\file.html"
  #               And the title tag is empty ""
  #               Then url method returns file:/// format "file:///c:/data/file.html"
  #               But the window title displays "c:\data\file.html"
  #               this method massages the locationUrl and returns its representation in title bar
  #
  #  From: http://gist.github.com/141738
  #
  #=============================================================================#
  def title_from_url
    loc = url # relies on IE.url to return @ie.locationUrl and not @ie.document.url
     (loc[0,8] == "file:///") ? loc.split("file:///")[1].gsub("/", '\\') : loc
  end


end  # END Class - Watir::IE
#=end


# Skip if using webdriver
if(is_webdriver? == false)
  #=============================================================================#
  # Class: Watir::SelectList
  #
  # Description: Extends the Watir::SelectList class with additional methods
  #              This class is is NOT supported if using Watir_WebDriver
  #
  #--
  # Methods: wait_until_count()
  #          wait_until_text()
  #++
  #=============================================================================#
  class Watir::SelectList

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

  end # Class Watir::SelectList
end  # Skip if using webdriver

# END File - watirworks_win-utilities.rb
