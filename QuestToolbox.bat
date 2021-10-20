@echo off
:: Developed By:
:: mitchv2020 and lordnikon

:: Sets the window size
mode con: cols=90 lines=20 

:: Checks if the requirements folder exists
if not exist ".\Requirements" (
echo [41m The requirements folder does not exist, please redownload! [0m
start https://github.com/mitchv2020/QuestToolbox/releases/latest
pause
exit
)

:: Checks if the requirements folder exists
if exist ".\Requirements" (
:: Sets the window size
mode con: cols=72 lines=20 
:: Changes directory into the requirements folder, which is needed for KeepAlive and the UI
cd Requirements
goto MainMenu
)

:MainMenu
cls
title Quest Toolbox
echo               [7mQuest Toolbox[0m			      Version: [7mv1.3.5[0m
echo ==========================================
echo Which would you like to do?
echo ==========================================

:: Options
cmdMenuSel f870 "Change Recording Res/FPS" "Stream Quest screen to PC" "Sideload an APK File" "Uninstall an App" "Enable Wired ALVR" "Keep Alive (keep the screen on)" "Change Refresh Rate" "ADB Options" "Change Quest Resolution" "Update QuestToolbox" "Developer Credits"
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
if "%errorlevel%"=="11" goto devcredits
goto MainMenu



:capture
cls
Title Change Recording Res/FPS
echo            [7mChange Recording Res/FPS[0m
echo ==========================================
echo Which capture commands do you want to run?
echo ==========================================

:captureInput
cmdMenuSel f870 "1920x1080 60fps (Widescreen)" "1280x1280 60fps (Square)" "1080x1920 60fps (Youtube Shorts)" "Custom res/fps" "==Back=="

if "%errorlevel%"=="1" goto wide
if "%errorlevel%"=="2" goto square
if "%errorlevel%"=="3" goto shorts
if "%errorlevel%"=="4" goto custom
if "%errorlevel%"=="5" goto MainMenu
goto capture

:wide
cls
title Widescreen
adb shell setprop debug.oculus.capture.width 1920
adb shell setprop debug.oculus.capture.height 1080
adb shell setprop debug.oculus.capture.bitrate 10000000
adb shell setprop debug.oculus.foveation.level 0
adb shell setprop debug.oculus.capture.fps 60
Echo done.
pause
goto MainMenu

:square
cls
title Square
adb shell setprop debug.oculus.capture.width 1280
adb shell setprop debug.oculus.capture.height 1280
adb shell setprop debug.oculus.capture.bitrate 10000000
adb shell setprop debug.oculus.foveation.level 0
adb shell setprop debug.oculus.capture.fps 60
Echo done.
pause
goto MainMenu

:shorts
cls
title Youtube Shorts
adb shell setprop debug.oculus.capture.width 1080
adb shell setprop debug.oculus.capture.height 1920
adb shell setprop debug.oculus.capture.bitrate 10000000
adb shell setprop debug.oculus.foveation.level 0
adb shell setprop debug.oculus.capture.fps 60
Echo done.
pause
goto MainMenu

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
goto MainMenu



:mirrorScreen
cls
title Stream Quest to PC
echo ==========================================
echo Do you have a Quest 1 or 2?
echo ==========================================

::Options
cmdMenuSel f870 "Quest 1" "Quest 2" "==Exit=="
if "%errorlevel%"=="1" goto Q1mirror
if "%errorlevel%"=="2" goto Q2mirror
if "%errorlevel%"=="3" goto MainMenu

:Q1mirror
cls
title Starting stream....
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
pause
goto MainMenu



:sideloadPrompt
cls
title Do you want to sideload an APK?
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
title Sideload an APK
echo ==========================================
echo Type in the directory of the file (including file name)
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
echo [7m Type "exit" to cancel!![0m
set APKuninst=
set /p APKuninst=Answer:
if "%APKuninst%"=="" goto wrongInputAPK
if "%APKuninst%"=="exit" goto MainMenu
cls
title Uninstalling APK....
echo Uninstalling APK....
adb uninstall %APKuninst%
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
echo [7mA new window will open, 
echo Do NOT close it otherwise wired ALVR will stop working.[0m
echo ==========================================
pause
echo Starting bat...
start wiredalvr.bat
goto MainMenu



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

if "%errorlevel%"=="1" goto 60
if "%errorlevel%"=="2" goto 72
if "%errorlevel%"=="3" goto 90
if "%errorlevel%"=="4" goto 120
if "%errorlevel%"=="5" goto MainMenu
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



:ADBMenu
cls
echo               [7mADB Options[0m
echo ==========================================
echo Which would you like to do?
echo ==========================================
cmdMenuSel f870 "Setup Wireless ADB" "Change Wireless ADB IP" "Disconnect Wireless ADB" "==Back=="

:: Options
if "%errorlevel%"=="1" goto wirelesssetup
if "%errorlevel%"=="2" goto changeip
if "%errorlevel%"=="3" goto disconnect
if "%errorlevel%"=="4" goto MainMenu
goto ADBMenuOptions

:wirelesssetup
cls
title Do you want to setup wireless adb?
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
if "%errorlevel%"=="1" goto connecting
if "%errorlevel%"=="2" goto wirelessIP
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
if "%errorlevel%"=="1" goto changingIP
if "%errorlevel%"=="2" goto MainMenu
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
if "%errorlevel%"=="1" goto changingadb
if "%errorlevel%"=="2" goto changingip
goto changingip

:changingadb
cls
title Connecting...
:: Connects to the new local IP
adb connect %changedip%:5037
title Connected!
pause
goto MainMenu

:disconnect
cls
title Do you want to disconnect wireless ADB?
echo ==========================================
echo [7mDo you want to disconnect wireless ADB?[0m
echo ==========================================

cmdMenuSel f870 "Yes" "No"
if "%errorlevel%"=="1" goto disconnecting
if "%errorlevel%"=="2" goto MainMenu
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



:changeResPrompt
cls
echo ==========================================
echo         [7mChange Quest Resolution[0m
echo ==========================================
cmdMenuSel f870 "Default Resolution (1832x1920)" "Custom Resolution" "==Back=="

if "%errorlevel%"=="1" goto defaultRes
if "%errorlevel%"=="2" goto changeCustomRes
if "%errorlevel%"=="3" goto MainMenu

:defaultRes
cls
echo ==========================================
echo [7mAre you sure you want to change resolution?[0m
echo ==========================================
cmdMenuSel f870 "Yes" "No"
if "%errorlevel%"=="1" goto changingToDefault
if "%errorlevel%"=="2" goto MainMenu

:changingToDefault
cls
echo Changing Height...
adb shell setprop debug.oculus.textureHeight 1832
echo Changing Width...
adb shell setprop debug.oculus.textureWidth 1920
pause
goto MainMenu

:changeCustomRes
cls
echo ==========================================
echo [7mAre you sure you want to change resolution?[0m
echo ==========================================
cmdMenuSel f870 "Yes" "No"
if "%errorlevel%"=="1" goto customRes
if "%errorlevel%"=="2" goto MainMenu

:customRes
cls
echo ==========================================
echo [41mBe careful because if you do something
echo wrong it can BREAK.[0m
echo ==========================================
echo [7mTYPE "[1mexit[0m[7m" TO CANCEL[0m
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
pause
goto MainMenu



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
