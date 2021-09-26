@echo off
cd Requirements
SetLocal EnableDelayedExpansion

setlocal

:MainMenu
cls
title Quest Toolbox
echo [7mIf not done yet, please install ADB drivers[0m
echo ==========================================
echo               [7mQuest Toolbox[0m
echo ==========================================
echo Which would you like to do?
echo ==========================================
cmdMenuSel f870 "Change Recording Res/FPS" "Keep Alive (keep the screen on)" "Change Refresh Rate" "ADB Options"

if "%ERRORLEVEL%"=="1" goto capture
if "%ERRORLEVEL%"=="2" goto keepalive
if "%ERRORLEVEL%"=="3" goto refreshrate
if "%ERRORLEVEL%"=="4" goto adbmenu
goto MainMenu

:ADBMenu
cls
echo               [7mADB Options[0m
echo ==========================================
echo Which would you like to do?
echo ==========================================
cmdMenuSel f870 "Setup Wireless ADB" "Change Wireless ADB IP" "Disconnect Wireless ADB" "Sideload an APK File" "Install ADB Drivers" "==Back=="

if "%ERRORLEVEL%"=="1" goto wirelesssetup
if "%ERRORLEVEL%"=="2" goto changeip
if "%ERRORLEVEL%"=="3" goto disconnect
if "%ERRORLEVEL%"=="4" goto sideloadPrompt
if "%ERRORLEVEL%"=="5" goto installadb
if "%ERRORLEVEL%"=="6" goto MainMenu
goto ADBMenuOptions

:sideloadPrompt
cls
title Do you want to sideload an APK?
echo ==========================================
echo Do you want to sideload an APK?
echo ==========================================
cmdMenuSel f870 "Yes" "No"

if "%ERRORLEVEL%"=="1" goto sideload
if "%ERRORLEVEL%"=="2" goto ADBMenu

:sideload
cls
title Sideload an APK
echo ==========================================
echo What is the directory of the APK? (include the file name)
echo ==========================================
set APKdir=
set /p APKdir=Answer:
if "%APKdir%"=="" goto sideloadIncorrect
cls
title Sideloading...
echo Sideloading APK.... Please wait
adb install %APKdir%
pause
goto ADBMenu

:sideloadIncorrect
cls
echo Please Enter a directory
pause
goto sideload

:installadb
cls
start https://forum.xda-developers.com/attachment.php?attachmentid=4623157
echo [7mInstall these ADB Drivers and re-open this.[0m
pause
exit

:wirelesssetup
cls
title Do you want to setup wireless adb?
echo ==========================================
echo     [7mDo you want to setup wireless adb?[0m
echo ==========================================

:wirelessinput
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
set localip=
set /p localip=Quest / Quest 2 local IP: 

cls
title is that correct?
echo ==========================================
echo You set your Quest / Quest 2 local ip to [7m%localip%[0m. is that correct?
echo ==========================================

cmdMenuSel f870 "Yes" "No"
if "%ERRORLEVEL%"=="1" goto connecting
if "%ERRORLEVEL%"=="2" goto wirelessIP
goto WirelessIP

:connecting
cls
title Connecting...
adb tcpip 5555
adb connect %localip%:5555
echo You can now unplug your Quest / Quest 2 if it connected!
title Connected!
pause
goto MainMenu

:changeIP
cls
echo ==========================================
echo [7mDo you want to change your Wireless ADB IP?[0m
echo ==========================================

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
set changedip=
set /p changedip=Quest / Quest 2 local IP: 

cls
title is that correct?
echo ==========================================
echo You set your Quest / Quest 2 local ip to [7m%changedip%[0m. is that correct?.
echo ==========================================

cmdMenuSel f870 "Yes" "No"
if "%ERRORLEVEL%"=="1" goto changingadb
if "%ERRORLEVEL%"=="2" goto changingip
goto changingip

:changingadb
cls
title Connecting...
adb connect %changedip%:5555
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
