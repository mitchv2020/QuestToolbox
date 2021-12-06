@echo off
title List of Installed Apps
:start
cls
echo ==========================================
echo List of packages: 
echo ==========================================
adb shell pm list packages -3

if "%errorlevel%"=="-1" (
cls
echo [7mYou have either more than 1 or no Android devices connected!
echo Please disconnect any other devices or connect your Quest.[0m
pause
goto start
)

pause
goto start
