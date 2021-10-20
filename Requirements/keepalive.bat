@echo off
mode con: cols=70 lines=20

:start
cls
title Quest KeepAlive
echo ==========================================
echo [7mMake sure your quest is plugged in![0m
echo ==========================================

cmdMenuSel f870 "Enable Keep Alive" "Disable Keep Alive" "==Exit=="

if "%ERRORLEVEL%"=="1" (
cls
echo Enabling...
adb shell svc power stayon true
echo Enabled!
pause
goto start
)

if "%ERRORLEVEL%"=="2" (
cls
echo Disabling...
adb shell svc power stayon false
echo Disabled!
pause
goto start
)

if "%ERRORLEVEL%"=="3" exit

