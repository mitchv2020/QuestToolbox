@echo off
mode con: cols=70 lines=20

:start
cls
title Quest KeepAlive
echo ==========================================
echo [7mMake sure your quest is plugged in![0m
echo ==========================================

cmdMenuSel f870 "Enable Keep Alive" "Disable Keep Alive" "==Exit=="

if "%ERRORLEVEL%"=="1" goto enable
if "%ERRORLEVEL%"=="2" goto disable
if "%ERRORLEVEL%"=="3" goto exit
goto start

:enable
cls
echo Enabling...
adb shell svc power stayon true
echo Enabled!
pause
goto start

:disable
cls
echo Disabling...
adb shell svc power stayon false
echo Disabled!
pause
goto start

:exit
cls
echo Disabling...
adb shell svc power stayon false
Echo Exiting...
exit
