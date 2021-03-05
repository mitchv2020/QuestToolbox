@echo off

setlocal
call :setESC

:MainMenu
cls
title Quest Toolbox
echo               %ESC%[7mQuest Toolbox%ESC%[0m
echo ==========================================
echo Which would you like to do?
echo ==========================================
echo 1) Change Recording Res/FPS
echo 2) Coming soon!
echo ==========================================
echo A) Setup Wireless ADB
echo B) Change Wireless ADB IP
echo C) Disconnect Wireless ADB
echo ==========================================

:MainMenuInput
set INPUT=
set /p INPUT=Answer: 
if "%INPUT%"=="1" goto capture
if "%INPUT%"=="2" goto Option2
if "%INPUT%"=="A" goto wirelesssetup
if "%INPUT%"=="a" goto wirelesssetup
if "%INPUT%"=="B" goto changeip
if "%INPUT%"=="b" goto changeip
if "%INPUT%"=="C" goto disconnect
if "%INPUT%"=="c" goto disconnect
Echo Please enter a valid answer!
pause
goto MainMenu

:wirelesssetup
cls
title Do you want to setup wireless adb?
echo ==========================================
echo     %ESC%[7mDo you want to setup wireless adb?%ESC%[0m
echo ==========================================
echo A) Yes
echo B) No
echo ==========================================

:wirelessinput
set INPUT=
set /p INPUT=Answer: 
if "%INPUT%"=="A" goto wirelessIP
if "%INPUT%"=="B" goto MainMenu
if "%INPUT%"=="a" goto wirelessIP
if "%INPUT%"=="b" goto MainMenu
Echo Please enter a valid answer!
pause
goto wirelesssetup

:wirelessIP
cls
title Please plug in your Quest
echo ==========================================
echo   %ESC%[41m!!Please plug in your Quest / Quest 2!!%ESC%[0m
echo ==========================================
set localip=
set /p localip=Quest / Quest 2 local IP: 

cls
title is that correct?
echo ==========================================
echo You set your Quest / Quest 2 local ip to %ESC%[7m%localip%%ESC%[0m. is that correct?
echo ==========================================
echo A) Yes
echo B) No
echo ==========================================

set /p confirm=Answer: 
if "%confirm%"=="A" goto connecting
if "%confirm%"=="B" goto wirelessIP
if "%confirm%"=="a" goto connecting
if "%confirm%"=="b" goto wirelessIP
echo Please enter a valid answer!
pause
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
echo %ESC%[7mDo you want to change your Wireless ADB IP?%ESC%[0m
echo ==========================================
echo 1) Yes
echo 2) No
echo ==========================================

set changeipInput=
set /p changeipInput=Answer: 
if "%changeipInput%"=="1" goto changingIP
if "%changeipInput%"=="2" goto MainMenu
echo Please enter a vaild answer!
pause
goto ChangeIP

:changingip
cls
title Changing Wireless ADB IP
echo ==========================================
echo %ESC%[41m!!If not done yet, please setup Wireless ADB First!!%ESC%[0m
echo ==========================================
set changedip=
set /p changedip=Quest / Quest 2 local IP: 

cls
title is that correct?
echo ==========================================
echo You set your Quest / Quest 2 local ip to %ESC%[7m%changedip%%ESC%[0m. is that correct?.
echo ==========================================
echo 1) Yes
echo 2) No
echo ==========================================

set /p confirm=Answer: 
if "%confirm%"=="1" goto changingadb
if "%confirm%"=="2" goto changingip
echo Please enter a valid answer!
pause
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
echo            %ESC%[7mCustom Capture Quest%ESC%[0m
echo ==========================================
echo Which capture commands do you want to run?
echo ==========================================
echo A) 1920x1080 90fps (Widescreen)
echo B) 1280x1280 90fps (Square)
echo C) 1080x1920 90fps (Youtube Shorts)
echo D) set custom res/fps
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
pause
goto capture

:disconnect
cls
title Do you want to disconnect wireless ADB?
echo ==========================================
echo %ESC%[7mDo you want to disconnect wireless ADB?%ESC%[0m
echo ==========================================
echo A) Yes
echo B) No
echo ==========================================

set confirm2=
set /p confirm2=Answer: 
if "%confirm2%"=="A" goto disconnecting
if "%confirm2%"=="a" goto disconnecting
if "%confirm2%"=="B" goto MainMenu
if "%confirm2%"=="b" goto MainMenu
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

echo %ESC%[41m!!Due to oculus capping FPS, min is 30 and max is 90!!%ESC%[0m
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


::IGNORE THIS LINE::
:setESC
for /F "tokens=1,2 delims=#" %%a in ('"prompt #$H#$E# & echo on & for %%b in (1) do rem"') do (
  set ESC=%%b
  exit /B 0
)
exit /B 0