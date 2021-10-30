@echo off
:: Developed By:
:: mitchv2020 and lordnikon

set version=v1.4.0

::::
:::: FILE CHECKS
::::
if not exist ".\Requirements" goto noRequirements

if not exist ".\Requirements\cmdmenusel.exe" goto noCmdMenuSel

if not exist ".\Requirements\adb.exe" goto noADB

if not exist ".\Requirements\scrcpy.exe" goto noScrcpy

if not exist ".\Requirements\keepalive.bat" goto noKeepAliveBat

if not exist ".\Requirements\packages.bat" goto noPackagesBat

if not exist ".\Requirements\wiredalvr.bat" goto noWiredALVRBat
::::
::::
::::

:: Sets the window size
mode con: cols=72 lines=20 
cd Requirements
goto MainMenu

:MainMenu
cls
title Quest Toolbox
echo               [7mQuest Toolbox[0m			      Version: [7m%version%[0m
echo ==========================================
echo Which would you like to do?
echo ==========================================

:: Options
cmdMenuSel f870 "Change Recording Res/FPS" "Stream Quest screen to PC" "Sideload an APK File" "Uninstall an App" "Enable Wired ALVR" "Keep Alive (keep the screen on)" "Change Refresh Rate" "ADB Options" "Change Quest Resolution" "Update QuestToolbox" "==========================================" "Developer Credits"
if "%errorlevel%"=="1" goto capture
if "%errorlevel%"=="2" goto mirrorScreen
if "%errorlevel%"=="3" goto sideloadPrompt
if "%errorlevel%"=="4" goto uninstallAPKPrompt
if "%errorlevel%"=="5" goto wiredALVR
if "%errorlevel%"=="6" goto keepalive
if "%errorlevel%"=="7" goto refreshrate
if "%errorlevel%"=="8" goto adbmenu
if "%errorlevel%"=="9" goto changeResPrompt
if "%errorlevel%"=="10" goto update
if "%errorlevel%"=="11" goto MainMenu
if "%errorlevel%"=="12" goto devcredits



:capture
cls
echo            [7mChange Recording Res/FPS[0m
echo ==========================================
echo Which capture commands do you want to run?
echo ==========================================

::Options
cmdMenuSel f870 "1920x1080 60fps (Widescreen)" "1280x1280 60fps (Square)" "1080x1920 60fps (Youtube Shorts)" "Custom res/fps" "==Back=="
if "%errorlevel%"=="1" goto wide
if "%errorlevel%"=="2" goto square
if "%errorlevel%"=="3" goto shorts
if "%errorlevel%"=="4" goto custom
if "%errorlevel%"=="5" goto MainMenu
goto capture

:wide
cls
adb shell setprop debug.oculus.capture.width 1920
adb shell setprop debug.oculus.capture.height 1080
adb shell setprop debug.oculus.capture.bitrate 10000000
adb shell setprop debug.oculus.foveation.level 0
adb shell setprop debug.oculus.capture.fps 60

if "%errorlevel%"=="-1" goto noDevices

if "%errorlevel%"=="0" (
cls
echo Successfully Changed Resolution and FPS!
pause
goto MainMenu
)

pause
goto MainMenu

:square
cls
adb shell setprop debug.oculus.capture.width 1280
adb shell setprop debug.oculus.capture.height 1280
adb shell setprop debug.oculus.capture.bitrate 10000000
adb shell setprop debug.oculus.foveation.level 0
adb shell setprop debug.oculus.capture.fps 60

if "%errorlevel%"=="-1" goto noDevices

if "%errorlevel%"=="0" (
cls
echo Successfully Changed Resolution and FPS!
pause
goto MainMenu
)

pause
goto MainMenu

:shorts
cls
adb shell setprop debug.oculus.capture.width 1080
adb shell setprop debug.oculus.capture.height 1920
adb shell setprop debug.oculus.capture.bitrate 10000000
adb shell setprop debug.oculus.foveation.level 0
adb shell setprop debug.oculus.capture.fps 60

if "%errorlevel%"=="-1" goto noDevices

if "%errorlevel%"=="0" (
cls
echo Successfully Changed Resolution and FPS!
pause
goto MainMenu
)

pause
goto MainMenu

:custom
cls

:: Clears all the variables
set width=
set height=
set fps=

set /p width=Custom Width: 
set /p height=Custom Height: 

echo [7mDue to oculus capping FPS, min is 30 and max is 90![0m
set /p fps=Custom FPS: 

adb shell setprop debug.oculus.capture.width %width%
adb shell setprop debug.oculus.capture.height %height%
adb shell setprop debug.oculus.capture.bitrate 10000000
adb shell setprop debug.oculus.foveation.level 0
adb shell setprop debug.oculus.capture.fps %fps%

if "%errorlevel%"=="-1" goto noDevices

if "%errorlevel%"=="0" (
cls
echo Successfully Changed Resolution and FPS!
pause
goto MainMenu
)

pause
goto MainMenu



:mirrorScreen
cls
echo            [7mStream Quest Screen[0m
echo ==========================================
echo Do you have a Quest 1 or 2?
echo ==========================================

::Options
cmdMenuSel f870 "Quest 1" "Quest 2" "==Back=="
if "%errorlevel%"=="1" goto Q1mirror
if "%errorlevel%"=="2" goto Q2mirror
if "%errorlevel%"=="3" goto MainMenu

:Q1mirror
cls
echo ==========================================
echo What FPS would you like the stream to be?
echo ==========================================
cmdMenuSel f870 "60 FPS" "30 FPS" "Custom" "==back=="
if "%errorlevel%"=="1" goto 60Q1
if "%errorlevel%"=="2" goto 30Q1
if "%errorlevel%"=="3" goto customQ2
if "%errorlevel%"=="4" goto mirrorScreen

:60Q1
:: Clears the FPS variable
set Q1streamFPS=
:: Sets the FPS of stream to 60
set Q1streamFPS=60
goto Q1bitrate

:30Q1
:: Clears the FPS variable
set Q1streamFPS=
:: Sets the FPS of stream to 30
set Q1streamFPS=30
goto Q1bitrate

:customQ1
cls
:: Clears the FPS variable
set Q1streamFPS=
:: Input for custom FPS
set /p Q1streamFPS=Custom FPS:
goto Q1bitrate

:Q1bitrate
cls
echo ==========================================
echo What bitrate would you like the stream to be (MB)?
echo ==========================================
:: Clears the Bitrate Variable
set Q1bitrate=
:: Input for bitrate of stream
set /p Q1bitrate=Answer:
goto Q1streaming

:Q1streaming
cls
echo Starting stream at %Q1streamFPS% FPS....
:: Starts a stream to the quest at a custom fps and bitrate with a crop set
scrcpy --max-fps %Q1streamFPS% --crop 1280:720:1500:350 --bit-rate %Q1bitrate%M

if "%errorlevel%"=="1" goto noDevices

pause
goto MainMenu

:Q2mirror
cls
echo ==========================================
echo What FPS would you like the stream to be?
echo ==========================================

::Options
cmdMenuSel f870 "60 FPS" "30 FPS" "Custom" "==back=="
if "%errorlevel%"=="1" goto 60Q2
if "%errorlevel%"=="2" goto 30Q2
if "%errorlevel%"=="3" goto customQ2
if "%errorlevel%"=="4" goto mirrorScreen

:60Q2
:: Clears the FPS variable
set Q2streamFPS=
:: Sets the FPS of stream to 60
set Q2streamFPS=60
goto Q2bitrate

:30Q2
:: Clears the FPS variable
set Q2streamFPS=
:: Sets the FPS of stream to 30
set Q2streamFPS=30
goto Q2bitrate

:customQ2
cls
:: Clears the FPS variable
set Q2streamFPS=
:: Input for custom FPS
set /p Q2StreamFPS=Custom FPS:
goto Q2bitrate

:Q2bitrate
cls
echo ==========================================
echo What bitrate would you like the stream to be (MB)?
echo ==========================================
:: Clears the Bitrate Variable
set Q2bitrate=
:: Input for bitrate of stream
set /p Q2bitrate=Answer:
goto Q2streaming

:Q2streaming
cls
echo Starting stream at %Q2streamFPS% FPS....
:: Starts a stream to the quest at a custom fps with a crop set
scrcpy --max-fps %Q2streamFPS% --crop 1600:900:2017:510 --bit-rate %Q2bitrate%M

if "%errorlevel%"=="1" goto noDevices

pause
goto MainMenu



:sideloadPrompt
cls
echo ==========================================
echo      [7mDo you want to sideload an APK?[0m
echo ==========================================

:: Options
cmdMenuSel f870 "Yes" "No"
if "%errorlevel%"=="1" goto sideload
if "%errorlevel%"=="2" goto MainMenu
goto sideloadPrompt

:sideload
cls
echo ==========================================
echo Type in the directory of the file (including file name)
echo ==========================================
echo [7mType "exit" to cancel.[0m
:: Resets the APK directory selected
set APKdir=
:: Input
set /p APKdir=Answer:
if "%APKdir%"=="exit" goto MainMenu
if "%APKdir%"=="" goto sideloadIncorrect
cls
echo Sideloading APK.... Please wait
adb install %APKdir%

if "%errorlevel%"=="1" goto noDevices

if "%errorlevel%"=="0" (
cls
echo Successfully Sideloaded APK!
pause
goto MainMenu
)

pause
goto MainMenu

:sideloadIncorrect
cls
echo Please Enter a directory
pause
goto sideload



:uninstallAPKPrompt
cls
echo ==========================================
echo [7mAre you sure you want to uninstall an App?[0m
echo ==========================================
cmdMenuSel f870 "Yes" "No"
if "%errorlevel%"=="1" goto uninstallAPK
if "%errorlevel%"=="2" goto MainMenu

:uninstallAPK
cls
echo ==========================================
echo [7mA new window will open with all the apps installed.[0m
echo ==========================================
pause
start packages.bat
goto uninstalling

:uninstalling
cls
echo ==========================================
echo Please Enter the package name of 
echo the app you would like to uninstall (Without the "package:")
echo ==========================================
echo [7mType "exit" to cancel.[0m
set APKuninst=
set /p APKuninst=Answer:
if "%APKuninst%"=="" goto wrongInputAPK
if "%APKuninst%"=="exit" goto MainMenu
cls
echo Uninstalling APK....
adb uninstall %APKuninst%

if "%errorlevel%"=="-1" goto noDevices

if "%errorlevel%"=="0" (
echo Successfully Uninstalled APK!
pause
goto MainMenu
)

pause
goto MainMenu

:wrongInputAPK
cls
echo Please enter a package name!
pause
goto uninstalling



:wiredALVR
cls
echo ==========================================
echo [7mA new window will open, do NOT close it 
echo otherwise wired ALVR will stop working.[0m
echo ==========================================
pause
echo Starting bat...
start wiredalvr.bat
goto MainMenu



:keepalive
cls
echo Starting KeepAlive...
start keepalive.bat
goto MainMenu



:refreshrate
cls
echo               [7mRefresh Rate[0m
echo ==========================================
echo Which Refresh Rate do you want to use?
echo ==========================================

::Options
cmdMenuSel f870 "60Hz" "72Hz" "90Hz (Quest 2 ONLY)" "120Hz (Quest 2 ONLY)" "==Back=="
if "%errorlevel%"=="1" goto 60
if "%errorlevel%"=="2" goto 72
if "%errorlevel%"=="3" goto 90
if "%errorlevel%"=="4" goto 120
if "%errorlevel%"=="5" goto MainMenu
goto refreshrate

:60
cls
echo Updating Refresh Rate...
adb shell setprop debug.oculus.refreshRate 60

if "%errorlevel%"=="-1" goto noDevices

if "%errorlevel%"=="0" (
cls
echo Successfully Applied Refresh Rate!
pause
goto MainMenu
)

pause
goto MainMenu

:72
cls
echo Updating Refresh Rate...
adb shell setprop debug.oculus.refreshRate 72

if "%errorlevel%"=="-1" goto noDevices

if "%errorlevel%"=="0" (
cls
echo Successfully Applied Refresh Rate!
pause
goto MainMenu
)

pause
goto MainMenu

:90
cls
echo Updating Refresh Rate...
adb shell setprop debug.oculus.refreshRate 90

if "%errorlevel%"=="-1" goto noDevices

if "%errorlevel%"=="0" (
cls
echo Successfully Applied Refresh Rate!
pause
goto MainMenu
)

pause
goto MainMenu

:120
cls
echo Updating Refresh Rate...
adb shell setprop debug.oculus.refreshRate 120

if "%errorlevel%"=="-1" goto noDevices

if "%errorlevel%"=="0" (
cls
echo Successfully Applied Refresh Rate!
pause
goto MainMenu
)

pause
goto MainMenu

:ADBMenu
cls
echo               [7mADB Options[0m
echo ==========================================
echo Which would you like to do?
echo ==========================================
cmdMenuSel f870 "Setup Wireless ADB" "Change Wireless ADB IP" "Disconnect Wireless ADB" "Custom ADB Command" "==Back=="

:: Options
if "%errorlevel%"=="1" goto wirelesssetup
if "%errorlevel%"=="2" goto changeip
if "%errorlevel%"=="3" goto disconnect
if "%errorlevel%"=="4" goto customADB
if "%errorlevel%"=="5" goto MainMenu

:wirelesssetup
cls
echo ==========================================
echo     [7mDo you want to setup wireless adb?[0m
echo ==========================================

:: Options
cmdMenuSel f870 "Yes" "No"
if "%errorlevel%"=="1" goto wirelessIP
if "%errorlevel%"=="2" goto MainMenu
goto wirelesssetup

:wirelessIP
cls
echo ==========================================
echo [41mPlease plug in your Quest / Quest 2![0m
echo ==========================================
echo [7mType "exit" to cancel.[0m
:: Resets the local ip
set localip=
:: Prompts for the local IP
set /p localip=Quest / Quest 2 local IP: 
if "%localip%"=="exit" goto MainMenu
if "%localip%"=="" goto IncorrectInputIP

cls
echo ==========================================
echo You set your Quest / Quest 2 local ip to [7m%localip%[0m. is that correct?
echo ==========================================

:: Options
cmdMenuSel f870 "Yes" "No"
if "%errorlevel%"=="1" goto connecting
if "%errorlevel%"=="2" goto wirelessIP
goto WirelessIP

:connecting
cls
:: Sets the quest up for wireless
adb tcpip 5555

if "%errorlevel%"=="1" goto noDevices

:: Connects to the quest wirelessly
adb connect %localip%:5555
pause
goto MainMenu

:IncorrectInputIP
cls
echo Please enter an IP
pause
goto wirelessIP

:changeIP
cls
echo ==========================================
echo [7mDo you want to change your Wireless ADB IP?[0m
echo ==========================================

:: Options
cmdMenuSel f870 "Yes" "No"
if "%errorlevel%"=="1" goto changingIP
if "%errorlevel%"=="2" goto MainMenu
goto ChangeIP

:changingip
cls
echo ==========================================
echo [41mIf not done yet, please setup Wireless ADB First![0m
echo ==========================================
echo [7mType "exit" to cancel.[0m
:: Resets the local IP
set changedip=
:: Prompts for local IP
set /p changedip=Quest / Quest 2 local IP: 
if "%changedip%"=="" goto IncorrectInputChangeIP
if "%changedip%"=="exit" goto MainMenu

:changingIPconfirm
cls
echo ==========================================
echo You set your Quest / Quest 2 local ip to [7m%changedip%[0m. is that correct?.
echo ==========================================

:: Options
cmdMenuSel f870 "Yes" "No"
if "%errorlevel%"=="1" goto changingadb
if "%errorlevel%"=="2" goto changingip
goto changingip

:changingadb
cls
echo connecting...
:: Connects to the new local IP
adb connect %changedip%:5555
pause
goto MainMenu

:IncorrectInputChangeIP
cls
echo Please enter an IP
pause
goto changingIP

:customADB
cls
echo ==========================================
echo [41mMake sure you know what you are doing
echo before typing in adb commands.[0m
echo ==========================================
echo [7mType "[1mexit[0m[7m" to cancel.[0m
set adbCom=
set /p adbCom=adb 
if "%adbCom%"=="exit" goto MainMenu
if "%adbCom%"=="" goto IncorrectCustomCommand
cls
echo Running ADB Command
echo ==========================================
adb %adbCom%
echo ==========================================
if "%errorlevel%"=="0" echo Successfully executed command.
pause
goto ADBMenu

:IncorrectCustomCommand
cls
echo Please input a command.
pause
goto customADB

:disconnect
cls
echo ==========================================
echo [7mDo you want to disconnect wireless ADB?[0m
echo ==========================================

cmdMenuSel f870 "Yes" "No"
if "%errorlevel%"=="1" goto disconnecting
if "%errorlevel%"=="2" goto MainMenu

:disconnecting
cls
adb disconnect

if "%errorlevel%"=="0" (
cls
echo Successfully Disconnected
pause
goto MainMenu
)

pause
goto MainMenu



:changeResPrompt
cls
echo ==========================================
echo         [7mChange Quest Resolution[0m
echo ==========================================

::Options
cmdMenuSel f870 "Default Resolution (1832x1920)" "Custom Resolution" "==Back=="
if "%errorlevel%"=="1" goto defaultRes
if "%errorlevel%"=="2" goto changeCustomRes
if "%errorlevel%"=="3" goto MainMenu

:defaultRes
cls
echo ==========================================
echo [7mAre you sure you want to change resolution?[0m
echo ==========================================

::Options
cmdMenuSel f870 "Yes" "No"
if "%errorlevel%"=="1" goto changingToDefault
if "%errorlevel%"=="2" goto MainMenu

:changingToDefault
cls
echo Changing Resolution...
adb shell setprop debug.oculus.textureHeight 1832
adb shell setprop debug.oculus.textureWidth 1920

if "%errorlevel%"=="-1" goto noDevices

if "%errorlevel%"=="0" (
cls
echo Successfully Changed Resolution!
pause
goto MainMenu
)



:changeCustomRes
cls
echo ==========================================
echo [7mAre you sure you want to change resolution?[0m
echo ==========================================

::Options
cmdMenuSel f870 "Yes" "No"
if "%errorlevel%"=="1" goto customRes
if "%errorlevel%"=="2" goto MainMenu

:customRes
cls
echo ==========================================
echo [7mBe careful because if you do something wrong it can break.[0m
echo If something does go wrong, a reboot usually fixes it.
echo ==========================================
echo [7mType "exit" to cancel.[0m
set resHeight=
set resWidth=
set /p resHeight=Custom Height: 
if "%resHeight%"=="exit" goto MainMenu
set /p resWidth=Custom Width: 
if "%resWidth%"=="exit" goto MainMenu

cls
echo Changing resolution...
adb shell setprop debug.oculus.textureHeight %resHeight%
adb shell setprop debug.oculus.textureWidth %resWidth%

if "%errorlevel%"=="-1" goto noDevices

if "%errorlevel%"=="0" (
cls
echo Successfully Changed Resolution!
pause
goto MainMenu
)



:update
cls
echo Opening GitHub page...
:: Opens a browser tab with the latest release
start https://www.github.com/mitchv2020/QuestToolbox/releases/latest
goto MainMenu



:devcredits
cls
echo ==========================================
echo Developed by:
echo ==========================================

:: Options
cmdMenuSel f870 "mitchv2020" "LordNikonYT" "==Back=="
if "%errorlevel%"=="1" goto dev1
if "%errorlevel%"=="2" goto dev2
if "%errorlevel%"=="3" goto MainMenu
goto devcredits

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









::::::::::::::::::::::::::::::::::::::::
:::::::::::::ERROR MESSAGES:::::::::::::
::::::::::::::::::::::::::::::::::::::::

:noDevices
cls
echo [7mYou have either more than 1 or no Android devices connected!
echo Please disconnect any other devices or connect your Quest.[0m
pause
goto MainMenu

:noRequirements
mode con: cols=90 lines=20 
cls
echo [41mThe requirements folder does not exist, please redownload![0m
pause
start https://github.com/mitchv2020/QuestToolbox/releases/latest
exit

:noCmdMenuSel
mode con: cols=90 lines=20 
cls
echo [41mcmdmenusel.exe was not found in the requirements folder,
echo which is required for UI. Please redownload![0m
pause
start https://github.com/mitchv2020/QuestTool.box/releases/latest
exit

:noADB
mode con: cols=90 lines=20 
cls
echo [41madb.exe was not found in the requirements folder,
echo which is required for basically everything. Please redownload![0m
pause
start https://github.com/mitchv2020/QuestToolbox/releases/latest
exit

:noScrcpy
mode con: cols=90 lines=20 
cls
echo [41mscrcpy.exe was not found in the requirements folder. Please redownload![0m
pause
start https://github.com/mitchv2020/QuestToolbox/releases/latest
exit

:noKeepAliveBat
mode con: cols=90 lines=20 
cls
echo [41mkeepalive.bat was not found in the requirements folder. Please redownload![0m
pause
start https://github.com/mitchv2020/QuestToolbox/releases/latest
exit

:noPackagesBat
mode con: cols=90 lines=20 
cls
echo [41mpackages.bat was not found in the requirements folder. Please redownload![0m
pause
start https://github.com/mitchv2020/QuestToolbox/releases/latest
exit

:noWiredALVRBat
mode con: cols=90 lines=20 
cls
echo [41mwiredalvr.bat was not found in the requirements folder. Please redownload![0m
pause
start https://github.com/mitchv2020/QuestToolbox/releases/latest
exit