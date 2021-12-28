@echo off
mode con: cols=70 lines=20

:start
cls
title Quest KeepAlive
echo ==========================================
echo [7mMake sure your quest is plugged in![0m
echo ==========================================

cmdMenuSel f870 "Enable Keep Alive" "Disable Keep Alive" "==Exit=="

if "%errorlevel%"=="1" (
cls
echo Enabling...
adb shell am broadcast -a com.oculus.vrpowermanager.prox_close
adb shell svc power stayon true
start keepaliveReplay.bat
if "%errorlevel%"=="1" goto error
echo Enabled!
pause
goto start
)

if "%errorlevel%"=="2" (
cls
echo Disabling...
shell am broadcast -a com.oculus.vrpowermanager.automation_disable
adb shell svc power stayon false
if "%errorlevel%"=="2" goto error
echo Disabled!
pause
goto start
)

if "%errorlevel%"=="3" exit

:error
cls
echo [7mYou have either more than 1 or no Android devices connected!
echo Please disconnect any other devices or connect your Quest.[0m
pause
goto start