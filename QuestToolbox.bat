@echo off

:configloader
rename config.ini config.bat
call config.bat
rename config.bat config.ini

setlocal
call :setESC

:ADBConfirm
cls
echo ==========================================
echo     %ESC%[7mDo you have ADB Drivers installed?%ESC%[0m
echo ==========================================
echo 1) Yes
echo 2) No
echo ==========================================
if "%firsttime%"=="1" goto MainMenu

:ADBInput
set adbinput=
set /p adbinput=Answer: 
if "%adbinput%"=="1" goto firsttimedone
if "%adbinput%"=="2" goto installadb
echo Please enter a valid Answer!
pause
goto ADBConfirm

:installadb
cls
start https://forum.xda-developers.com/attachment.php?attachmentid=4623157
echo %ESC%[7mInstall these ADB Drivers and re-open this.%ESC%[0m
pause
goto firsttimedone
exit

:firsttimedone
SetLocal EnableDelayedExpansion
:: Edit the following three lines as needed.
:: Specifiy the full path to the file, or the current directory will be used
Set _PathtoFile=config.ini
Set _OldLine=set firsttime=0
Set _NewLine=set firsttime=1
:: End of Search parameters
Call :_Parse "%_PathtoFile%"
Set _Len=0
Set _Str=%_OldLine%
Set _Str=%_Str:"=.%987654321
:_Loop
If NOT "%_Str:~18%"=="" Set _Str=%_Str:~9%& Set /A _Len+=9& Goto _Loop
Set _Num=%_Str:~9,1%
Set /A _Len=_Len+_Num
PushD %_FilePath%
If Exist %_FileName%.new Del %_FileName%.new
If Exist %_FileName%.old Del %_FileName%.old
Set _LineNo=0
For /F "Tokens=* Eol=" %%I In (%_FileName%%_FileExt%) Do (
Set _tmp=%%I
Set /A _LineNo+=1
If /I "!_tmp:~0,%_Len%!"=="%_OldLine%" (
>>%_FileName%.new Echo %_NewLine%
) Else (
If !_LineNo! GTR 1 If "!_tmp:~0,1!"=="[" Echo.>>%_FileName%.new
SetLocal DisableDelayedExpansion
>>%_FileName%.new Echo %%I
EndLocal
))
Ren %_FileName%%_FileExt% %_FileName%.old
Ren %_FileName%.new %_FileName%.ini
PopD
rename config.ini config.bat
call config.bat
rename config.bat config.ini
if "%firsttime%"=="1" goto MainMenu

:_Parse
Set _FilePath=%~dp1
Set _FileName=%~n1
Set _FileExt=%~x1
Goto :EOF

:MainMenu
cls
title Quest Toolbox
echo               %ESC%[7mQuest Toolbox%ESC%[0m
echo ==========================================
echo Which would you like to do?
echo ==========================================
echo 1) Change Recording Res/FPS
echo 2) Keep Alive (keep the screen on)
echo 3) Change Refresh Rate
echo ==========================================
echo A) Setup Wireless ADB
echo B) Change Wireless ADB IP
echo C) Disconnect Wireless ADB
echo D) Install ADB Drivers
echo ==========================================

:MainMenuInput
set INPUT=
set /p INPUT=Answer: 
if "%INPUT%"=="1" goto capture
if "%INPUT%"=="2" goto keepalive
if "%INPUT%"=="3" goto refreshrate
if "%INPUT%"=="A" goto wirelesssetup
if "%INPUT%"=="a" goto wirelesssetup
if "%INPUT%"=="B" goto changeip
if "%INPUT%"=="b" goto changeip
if "%INPUT%"=="C" goto disconnect
if "%INPUT%"=="c" goto disconnect
if "%INPUT%"=="D" goto installadb
if "%INPUT%"=="d" goto installadb
Echo Please enter a valid answer!
pause
goto MainMenu

:wirelesssetup
cls
title Do you want to setup wireless adb?
echo ==========================================
echo     %ESC%[7mDo you want to setup wireless adb?%ESC%[0m
echo ==========================================
echo 1) Yes
echo 2) No
echo ==========================================

:wirelessinput
set INPUT=
set /p INPUT=Answer: 
if "%INPUT%"=="1" goto wirelessIP
if "%INPUT%"=="2" goto MainMenu
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
echo 1) Yes
echo 2) No
echo ==========================================

set /p confirm=Answer: 
if "%confirm%"=="1" goto connecting
if "%confirm%"=="2" goto wirelessIP
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
echo 1) Yes
echo 2) No
echo ==========================================

set confirm2=
set /p confirm2=Answer: 
if "%confirm2%"=="1" goto disconnecting
if "%confirm2%"=="2" goto MainMenu
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
adb shell setprop debug.oculus.capture.fps %fps%
Echo done.
pause
goto capture

:keepalive
cls
echo %ESC%[7mDo not close KeepAlive to keep the screen on!%ESC%[0m
pause
cd ./Requirements
start KeepAlive.bat
echo Started KeepAlive...
pause
goto MainMenu

:refreshrate
cls
title Which refresh rate do you want to use?
echo ==========================================
echo Which Refresh Rate do you want to use?
echo ==========================================
echo 1) 60Hz
echo 2) 72Hz
echo 3) 90Hz (Quest 2 ONLY)
echo ==========================================
echo 9) Go Back
echo ==========================================

set refreshrateInput=
set /p refreshrateInput=Answer: 

if "%refreshrateInput%"=="1" goto 60
if "%refreshrateInput%"=="2" goto 72
if "%refreshrateInput%"=="3" goto 90
if "%refreshrateInput%"=="9" goto MainMenu
echo Please enter a valid answer!
pause
goto refreshrate

:60
cls
title Updating Refresh Rate...
echo Updating Refresh Rate...
adb shell setprop debug.oculus.refreshRate 60
title Done!
echo Done!
pause
goto refreshrate

:72
cls
title Updating Refresh Rate...
echo Updating Refresh Rate...
adb shell setprop debug.oculus.refreshRate 72
title Done!
echo Done!
pause
goto refreshrate

:90
cls
title Updating Refresh Rate...
echo Updating Refresh Rate...
adb shell setprop debug.oculus.refreshRate 90
title Done!
echo Done!
pause
goto refreshrate

::IGNORE THIS LINE::
:setESC
for /F "tokens=1,2 delims=#" %%a in ('"prompt #$H#$E# & echo on & for %%b in (1) do rem"') do (
  set ESC=%%b
  exit /B 0
)
exit /B 0