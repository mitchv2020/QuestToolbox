@echo off
:start
cls
echo ==========================================
echo List of packages: 
echo ==========================================
adb shell pm list packages -3
pause
goto start