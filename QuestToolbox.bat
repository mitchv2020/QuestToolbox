@echo off
:: Sets the window size
mode con: cols=90 lines=20 
:: Checks if the requirements folder exists
if not exist ".\Requirements" goto noRequirements
if exist ".\Requirements" goto folderExist
:noRequirements
:: Tells the user to redownload if the requirements folder is missing
echo [41m The requirements folder does not exist, please redownload! [0m
pause
start https://github.com/mitchv2020/QuestToolbox/releases/latest
exit

:folderExist
:: Sets the window size
mode con: cols=72 lines=20 
:: Changes directory into the requirements folder, which is needed for KeepAlive and the UI
cd Requirements

SetLocal EnableDelayedExpansion

:MainMenu
cls
title Quest Toolbox
echo               [7mQuest Toolbox[0m
echo ==========================================
echo Which would you like to do?
echo ==========================================

:: Options
cmdMenuSel f870 "Change Recording Res/FPS" "Stream Quest screen to PC" "Sideload an APK File" "Keep Alive (keep the screen on)" "Change Refresh Rate" "ADB Options" "Developer Credits"
if "%ERRORLEVEL%"=="1" goto capture
if "%ERRORLEVEL%"=="2" goto mirrorScreen
if "%ERRORLEVEL%"=="3" goto sideloadPrompt
if "%ERRORLEVEL%"=="4" goto keepalive
if "%ERRORLEVEL%"=="5" goto refreshrate
if "%ERRORLEVEL%"=="6" goto adbmenu
if "%ERRORLEVEL%"=="7" goto devcredits
goto MainMenu

:mirrorScreen
cls
echo ==========================================
echo Do you have a Quest 1 or 2?
echo ==========================================

::Options
cmdMenuSel f870 "Quest 1" "Quest 2" "==Exit=="
if "%ERRORLEVEL%"=="1" goto Q1mirror
if "%ERRORLEVEL%"=="2" goto Q2mirror
if "%ERRORLEVEL%"=="3" goto MainMenu

:Q1mirror
cls
title Starting stream....
echo ==========================================
echo What FPS would you like the stream to be?
echo ==========================================
set Q1streamFPS=
cmdMenuSel f870 "60 FPS" "30 FPS" "Custom" "==back=="
if "%errorlevel%"=="1" goto 60Q1
if "%errorlevel%"=="2" goto 30Q1
if "%errorlevel%"=="3" goto customQ2
if "%errorlevel%"=="4" goto mirrorScreen

:60Q1
set Q1streamFPS=
set Q1streamFPS=60
goto Q1bitrate

:30Q1
set Q1streamFPS=
set Q1streamFPS=30
goto Q1bitrate

:customQ1
cls
set Q1streamFPS=
set /p Q1streamFPS=Custom FPS:
goto Q1bitrate

:Q1bitrate
cls
echo ==========================================
echo What bitrate would you like the stream to be (MB)?
echo ==========================================
set Q1bitrate=
set /p Q1bitrate=Answer:
goto Q1streaming

:Q1streaming
cls
echo Starting stream at %Q1streamFPS% FPS....
:: Starts a stream to the quest at a custom fps with a crop set
scrcpy --max-fps %Q1streamFPS% --crop 1280:720:1500:350 --bit-rate %Q1bitrate%M
pause
goto MainMenu

:Q2mirror
cls
title Starting stream....
echo ==========================================
echo What FPS would you like the stream to be?
echo ==========================================
cmdMenuSel f870 "60 FPS" "30 FPS" "Custom" "==back=="
if "%errorlevel%"=="1" goto 60Q2
if "%errorlevel%"=="2" goto 30Q2
if "%errorlevel%"=="3" goto customQ2
if "%errorlevel%"=="4" goto mirrorScreen

:60Q2
set Q2streamFPS=
set Q2streamFPS=60
goto Q2bitrate

:30Q2
set Q2streamFPS=
set Q2streamFPS=30
goto Q2bitrate

:customQ2
cls
set Q2streamFPS=
set /p Q2StreamFPS=Custom FPS:
goto Q2bitrate

:Q2bitrate
cls
echo ==========================================
echo What bitrate would you like the stream to be (MB)?
echo ==========================================
set Q2bitrate=
set /p Q2bitrate=Answer:
goto Q2streaming

:Q2streaming
cls
echo Starting stream at %Q2streamFPS% FPS....
:: Starts a stream to the quest at a custom fps with a crop set
scrcpy --max-fps %Q2streamFPS% --crop 1600:900:2017:510 --bit-rate %Q2bitrate%M
pause
goto MainMenu

:sideloadPrompt
cls
title Do you want to sideload an APK?
echo ==========================================
echo Do you want to sideload an APK?
echo ==========================================

:: Options
cmdMenuSel f870 "Yes" "No"
if "%ERRORLEVEL%"=="1" goto sideload
if "%ERRORLEVEL%"=="2" goto MainMenu
goto sideloadPrompt

:sideload
cls
title Sideload an APK
echo ==========================================
echo Type in the directory of the file or drag the file into the CMD window.
echo ==========================================
:: Resets the APK directory selected
set APKdir=
:: Input
set /p APKdir=Answer:
if "%APKdir%"=="" goto sideloadIncorrect
cls
title Sideloading...
echo Sideloading APK.... Please wait
adb install %APKdir%
pause
goto MainMenu

:sideloadIncorrect
cls
echo Please Enter a directory
pause
goto sideload

:devcredits
cls
echo ==========================================
echo Developed by:
echo ==========================================

:: Options
cmdMenuSel f870 "mitchv2020" "LordNikonYT" "==Back=="
if "%ERRORLEVEL%"=="1" goto dev1
if "%ERRORLEVEL%"=="2" goto dev2
if "%ERRORLEVEL%"=="3" goto MainMenu
goto MainMenuInput

:dev1
cls
:: Redirects the user to mitchv2020's youtube channel
start https://www.youtube.com/channel/UCZW2Nxa-fCm6V8bvDeF0Fyg
goto :devcredits

:dev2
cls
:: Redirects the user to lordnikon's youtube channel
start https://www.youtube.com/channel/UCTaoq74t_tMPA5jUITxB3lw
goto :devcredits

:ADBMenu
cls
echo               [7mADB Options[0m
echo ==========================================
echo Which would you like to do?
echo ==========================================
cmdMenuSel f870 "Setup Wireless ADB" "Change Wireless ADB IP" "Disconnect Wireless ADB" "==Back=="

:: Options
if "%ERRORLEVEL%"=="1" goto wirelesssetup
if "%ERRORLEVEL%"=="2" goto changeip
if "%ERRORLEVEL%"=="3" goto disconnect
if "%ERRORLEVEL%"=="4" goto MainMenu
goto ADBMenuOptions

:wirelesssetup
cls
title Do you want to setup wireless adb?
echo ==========================================
echo     [7mDo you want to setup wireless adb?[0m
echo ==========================================

:: Options
cmdMenuSel f870 "Yes" "No"
if "%ERRORLEVEL%"=="1" goto wirelessIP
if "%ERRORLEVEL%"=="2" goto MainMenu
goto wirelesssetup

:wirelessIP
cls
title Please plug in your Quest
echo ==========================================
echo [41mPlease plug in your Quest / Quest 2![0m
echo ==========================================
:: Resets the local ip
set localip=
:: Prompts for the local IP
set /p localip=Quest / Quest 2 local IP: 

cls
title is that correct?
echo ==========================================
echo You set your Quest / Quest 2 local ip to [7m%localip%[0m. is that correct?
echo ==========================================

:: Options
cmdMenuSel f870 "Yes" "No"
if "%ERRORLEVEL%"=="1" goto connecting
if "%ERRORLEVEL%"=="2" goto wirelessIP
goto WirelessIP

:connecting
cls
title Connecting...
:: Sets the quest up for wireless
adb tcpip 5037
:: Connects to the quest wirelessly
adb connect %localip%:5037
echo You can now unplug your Quest / Quest 2 if it connected!
title Connected!
pause
goto MainMenu

:changeIP
cls
echo ==========================================
echo [7mDo you want to change your Wireless ADB IP?[0m
echo ==========================================

:: Options
cmdMenuSel f870 "Yes" "No"
if "%ERRORLEVEL%"=="1" goto changingIP
if "%ERRORLEVEL%"=="2" goto MainMenu
goto ChangeIP

:changingip
cls
title Changing Wireless ADB IP
echo ==========================================
echo [41mIf not done yet, please setup Wireless ADB First![7m
echo ==========================================
:: Resets the local IP
set changedip=
:: Prompts for local IP
set /p changedip=Quest / Quest 2 local IP: 

:changingIPconfirm
cls
title is that correct?
echo ==========================================
echo You set your Quest / Quest 2 local ip to [7m%changedip%[0m. is that correct?.
echo ==========================================

:: Options
cmdMenuSel f870 "Yes" "No"
if "%ERRORLEVEL%"=="1" goto changingadb
if "%ERRORLEVEL%"=="2" goto changingip
goto changingip

:changingadb
cls
title Connecting...
:: Connects to the new local IP
adb connect %changedip%:5037
title Connected!
pause
goto MainMenu


:capture
cls
Title Custom Capture Quest
echo            [7mCustom Capture Quest[0m
echo ==========================================
echo Which capture commands do you want to run?
echo ==========================================

:captureInput
cmdMenuSel f870 "1920x1080 90fps (Widescreen)" "1280x1280 90fps (Square)" "1080x1920 90fps (Youtube Shorts)" "Set custom res/fps" "==Back=="

if "%ERRORLEVEL%"=="1" goto wide
if "%ERRORLEVEL%"=="2" goto square
if "%ERRORLEVEL%"=="3" goto shorts
if "%ERRORLEVEL%"=="4" goto custom
if "%ERRORLEVEL%"=="5" goto MainMenu
goto capture

:disconnect
cls
title Do you want to disconnect wireless ADB?
echo ==========================================
echo [7mDo you want to disconnect wireless ADB?[0m
echo ==========================================

cmdMenuSel f870 "Yes" "No"
if "%ERRORLEVEL%"=="1" goto disconnecting
if "%ERRORLEVEL%"=="2" goto MainMenu
echo Please enter a valid answer!
pause
goto disconnect

:disconnecting
cls
title Disconnecting...
adb disconnect
echo Disconnected!
title Disconnected!
pause
goto MainMenu

:wide
cls
title Widescreen
adb shell setprop debug.oculus.capture.width 1920
adb shell setprop debug.oculus.capture.height 1080
adb shell setprop debug.oculus.capture.bitrate 10000000
adb shell setprop debug.oculus.foveation.level 0
adb shell setprop debug.oculus.fullRateCapture 1
Echo done.
pause
goto capture

:square
cls
title Square
adb shell setprop debug.oculus.capture.width 1280
adb shell setprop debug.oculus.capture.height 1280
adb shell setprop debug.oculus.capture.bitrate 10000000
adb shell setprop debug.oculus.foveation.level 0
adb shell setprop debug.oculus.fullRateCapture 1
Echo done.
pause
goto capture

:shorts
cls
title Youtube Shorts
adb shell setprop debug.oculus.capture.width 1080
adb shell setprop debug.oculus.capture.height 1920
adb shell setprop debug.oculus.capture.bitrate 10000000
adb shell setprop debug.oculus.foveation.level 0
adb shell setprop debug.oculus.fullRateCapture 1
Echo done.
pause
goto capture

:custom
cls
title Custom Option

set width=
set /p width=Custom Width: 

set height=
set /p height=Custom Height: 

echo [41mDue to oculus capping FPS, min is 30 and max is 90![0m
set fps=
set /p fps=Custom FPS: 

adb shell setprop debug.oculus.capture.width %width%
adb shell setprop debug.oculus.capture.height %height%
adb shell setprop debug.oculus.capture.bitrate 10000000
adb shell setprop debug.oculus.foveation.level 0
adb shell setprop debug.oculus.capture.fps %fps%
Echo done.
pause
goto capture

:keepalive
cls
cd ./Requirements
start KeepAlive.bat
echo Started KeepAlive...
goto MainMenu

:refreshrate
cls
echo               [7mRefresh Rate[0m
title Which refresh rate do you want to use?
echo ==========================================
echo Which Refresh Rate do you want to use?
echo ==========================================

cmdMenuSel f870 "60Hz" "72Hz" "90Hz (Quest 2 ONLY)" "120Hz (Quest 2 ONLY)" "==Back=="

if "%ERRORLEVEL%"=="1" goto 60
if "%ERRORLEVEL%"=="2" goto 72
if "%ERRORLEVEL%"=="3" goto 90
if "%ERRORLEVEL%"=="4" goto 120
if "%ERRORLEVEL%"=="5" goto MainMenu
goto refreshrate

:60
cls
title Updating Refresh Rate...
echo Updating Refresh Rate...
adb shell setprop debug.oculus.refreshRate 60
title Done!
echo Done!
pause
goto refreshrate

:72
cls
title Updating Refresh Rate...
echo Updating Refresh Rate...
adb shell setprop debug.oculus.refreshRate 72
title Done!
echo Done!
pause
goto refreshrate

:90
cls
title Updating Refresh Rate...
echo Updating Refresh Rate...
adb shell setprop debug.oculus.refreshRate 90
title Done!
echo Done!
pause
goto refreshrate

:120
cls
title Updating Refresh Rate...
echo Updating Refresh Rate...
adb shell setprop debug.oculus.refreshRate 120
title Done!
echo Done!
pause
goto refreshrate
