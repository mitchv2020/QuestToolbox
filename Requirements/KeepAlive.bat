@echo off

setlocal
call :setESC

:start
cls
title Quest Keep Alive
echo %ESC%[7mDo not close KeepAlive to keep the screen on!%ESC%[0m
echo ==========================================
echo %ESC%[41mYour Quest has to be Plugged in to do this!%ESC%[0m
echo ==========================================

cmdMenuSel f870 "ENABLE Keep Alive" "DISABLE Keep Alive" "Exit (disables it)"

if "%ERRORLEVEL%"=="1" goto enable
if "%ERRORLEVEL%"=="2" goto disable
if "%ERRORLEVEL%"=="3" goto exit
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