@echo off

setlocal
call :setESC

:start
cls
title Quest Keep Alive
echo ==========================================
echo %ESC%[41mYour Quest has to be Plugged in to do this!%ESC%[0m
echo ==========================================
echo 1) ENABLE Keep Alive
echo 2) DISABLE Keep Alive
echo 3) Exit (disables it)
echo ==========================================

set keepaliveInput=
set /p keepaliveInput=Answer: 
if "%keepaliveInput%"=="1" goto enable
if "%keepaliveInput%"=="2" goto disable
if "%keepaliveInput%"=="3" goto exit
echo Please enter a valid answer!
goto start

:enable
cls
title Enabling...
echo Enabling...
adb shell svc power stayon true
title Enabled!
echo Enabled!
pause
goto start

:disable
cls
title Disabling...
echo Disabling...
adb shell svc power stayon false
title Disabled!
echo Disabled!
pause
goto start

:exit
cls
title Disabling...
echo Disabling...
adb shell svc power stayon false
title Exiting...
Echo Exiting...
exit

:setESC
for /F "tokens=1,2 delims=#" %%a in ('"prompt #$H#$E# & echo on & for %%b in (1) do rem"') do (
  set ESC=%%b
  exit /B 0
)
exit /B 0