echo off
:: Sets the title and window size respectively
title KeepAlive
mode con: cols=72 lines=20 

:tap
cls
echo Please keep this window open to keep the Quest from sleeping
echo [7mPinging the device! Keep the device connected and this window open![0m
adb shell input tap 916 960

if "%errorlevel%"=="-1" (
cls
echo [7mYou have either more than 1 or no Android devices connected!
echo Please disconnect any other devices or connect your Quest.[0m
pause
goto tap
)

TIMEOUT 5 
goto tap

exit