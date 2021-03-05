@echo off

:MainMenu
cls
echo ==========================================
echo Which would you like to do?
echo ==========================================
echo 1) Change Recording Res/FPS
echo 2) Coming soon!
echo ==========================================

:MainMenuInput
set INPUT=
set /p INPUT=Answer: 
if "%INPUT%"=="1" goto wirelesssetup
if "%INPUT%"=="2" goto Option2
Echo Please enter a valid answer!
goto MainMenuInput

:wirelesssetup
cls
title Do you need to setup wireless adb?
echo ==========================================
echo Do you need to setup wireless adb?
echo ==========================================
echo A) Yes
echo B) No
echo ==========================================

:wirelessinput
set INPUT=
set /p INPUT=Answer: 
if "%INPUT%"=="A" goto wirelessIP
if "%INPUT%"=="B" goto capture
if "%INPUT%"=="a" goto wirelessIP
if "%INPUT%"=="b" goto capture
Echo Please enter a valid answer!
goto wirelessinput

:wirelessIP
cls
title Please plug in your Quest
echo !!Please plug in your Quest / Quest 2!!
set localip=
set /p localip=Quest / Quest 2 local IP:

title is that correct?
echo ==========================================
echo You set your Quest / Quest 2 local ip to %localip%. is that correct?
echo ==========================================
echo A) Yes
echo B) No
echo ==========================================

set /p confirm=Answer: 
if "%confirm%"=="A" goto connecting
if "%confirm%"=="B" goto wirelessIP
if "%confirm%"=="a" goto connecting
if "%confirm%"=="b" goto wirelessIP

:connecting
cls
title Connecting...
adb tcpip 5555
adb connect %localip%:5555
echo Connected! You can now unplug your Quest / Quest 2
title Connected!
pause
goto capture

:capture
cls
Title Custom Capture Quest
echo ==========================================
echo Which capture commands do you want to run?
echo ==========================================
echo A) 1920x1080 90fps (Widescreen)
echo B) 1280x1280 90fps (Square)
echo C) 1080x1920 90fps (Youtube Shorts)
echo D) set custom res/fps
echo ==========================================
echo 1) Change Wireless ADB IP
echo 2) Disconnect wireless ADB
echo ==========================================
echo 9) Go to Main Menu

:captureInput
set INPUT=
set /p INPUT=Answer: 
if "%INPUT%"=="A" goto wide
if "%INPUT%"=="a" goto wide
if "%INPUT%"=="B" goto square
if "%INPUT%"=="b" goto square
if "%INPUT%"=="C" goto shorts
if "%INPUT%"=="c" goto shorts
if "%INPUT%"=="D" goto custom
if "%INPUT%"=="d" goto custom
if "%INPUT%"=="1" goto wirelessIP
if "%INPUT%"=="2" goto disconnect
if "%INPUT%"=="9" goto MainMenu
Echo Please enter a valid answer!
goto captureInput

:disconnect
cls
title Do you want to disconnect wireless ADB?
echo ==========================================
echo Do you want to disconnect wireless ADB?
echo ==========================================
echo A) Yes
echo B) No
echo ==========================================

set confirm2=
set /p confirm2=Answer: 
if "%confirm2%"=="A" goto disconnecting
if "%confirm2%"=="a" goto disconnecting
if "%confirm2%"=="B" goto capture
if "%confirm2%"=="b" goto capture

:disconnecting
cls
title Disconnecting...
adb disconnect

echo Disconnected!
title Disconnected!
pause
goto capture

:wide
cls
title Widescreen
adb shell setprop debug.oculus.capture.width 1920
adb shell setprop debug.oculus.capture.height 1080
adb shell setprop debug.oculus.capture.bitrate 10000000
adb shell setprop debug.oculus.foveation.level 0
adb shell setprop debug.oculus.fullRateCapture 1
adb shell setprop debug.oculus.capture.fps 90
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
adb shell setprop debug.oculus.capture.fps 90
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
adb shell setprop debug.oculus.capture.fps 90
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

echo !!Due to oculus capping FPS, min is 30 and max is 90.!!
set fps=
set /p fps=Custom FPS: 

adb shell setprop debug.oculus.capture.width %width%
adb shell setprop debug.oculus.capture.height %height%
adb shell setprop debug.oculus.capture.bitrate 10000000
adb shell setprop debug.oculus.foveation.level 0
adb shell setprop debug.oculus.fullRateCapture 1
adb shell setprop debug.oculus.capture.fps %fps%
Echo done.
pause
goto capture

:Option2
cls
echo This feature is not done yet!
pause
goto MainMenu