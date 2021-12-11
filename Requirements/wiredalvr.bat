@echo off
title Wired ALVR
mode con: cols=65 lines=16 
echo Starting wired ALVR...
adb forward tcp:9943 tcp:9943
adb forward tcp:9944 tcp:9944
:warning
cls
echo Started wired ALVR
echo [41mDo NOT close this window or wired ALVR will stop working.[0m
pause
goto warning