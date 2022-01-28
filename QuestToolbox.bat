@echo off
:: Developed By:
:: mitchv2020 and LordNikonUK

set version=v1.5.1

:::::::::::::::::::::
:::: FILE CHECKS ::::
:::::::::::::::::::::
if not exist ".\Requirements" goto noRequirements

if not exist ".\Requirements\curl.exe" (
	set missingFile=curl.exe
	goto missingFile
)

if not exist ".\Requirements\checkforupdates.bat" (
	set missingFile=checkforupdates.bat
	goto missingFile
)

if not exist ".\Requirements\list_of_ver_fromdate.txt" (
	set missingFile=list_of_ver_fromdate.txt
	goto missingFile
)

if not exist ".\Requirements\cmdmenusel.exe" (
	set missingFile=cmdmenusel.exe
	goto missingFile
)

if not exist ".\Requirements\adb.exe" (
	set missingFile=adb.exe
	goto missingFile
)

if not exist ".\Requirements\scrcpy.exe" (
	set missingFile=scrcpy.exe
	goto missingFile
)

if not exist ".\Requirements\ffmpeg.exe" (
	set missingFile=ffmpeg.exe
	goto missingFile
)

if not exist ".\Requirements\packages.bat" (
	set missingFile=packages.bat
	goto missingFile
)

if not exist ".\Requirements\wiredalvr.bat" (
	set missingFile=wiredalvr.bat
	goto missingFile
)

if not exist ".\Requirements\keepaliveReplay.bat" (
	set missingFile=keepaliveReplay.bat
	goto missingFile
)

if not exist ".\Requirements\AdbWinApi.dll" (
	set missingFile=AdbWinApi.dll
	goto missingFile
)

if not exist ".\Requirements\AdbWinUsbApi.dll" (
	set missingFile=AdbWinUsbApi.dll
	goto missingFile
)

if not exist ".\Requirements\avcodec-58.dll" (
	set missingFile=avcodec-58.dll
	goto missingFile
)

if not exist ".\Requirements\avformat-58.dll" (
	set missingFile=avformat-58.dll
	goto missingFile
)

if not exist ".\Requirements\avutil-56.dll" (
	set missingFile=avutil-56.dll
	goto missingFile
)

if not exist ".\Requirements\scrcpy-server" (
	set missingFile=The scrcpy-server file
	goto missingFile
)

if not exist ".\Requirements\SDL2.dll" (
	set missingFile=SDL2.dll
	goto missingFile
)

if not exist ".\Requirements\swresample-3.dll" (
	set missingFile=swresample-3.dll
	goto missingFile
)

if not exist ".\Requirements\swscale-5.dll" (
	set missingFile=swscale-5.dll
	goto missingFile
)

:continueSetup
:: Sets the window size
mode con: cols=72 lines=21 

:: Checks for updates
cd requirements
echo Checking for updates...
call checkforupdates.bat

:MainMenu
cls
title Quest Toolbox
echo               [7mQuest Toolbox[0m			      Version: [7m%version%[0m
echo ==========================================
echo Which would you like to do?
echo ==========================================

:: Options
cmdMenuSel f870 "Change Recording Res/FPS" "Stream Quest screen to PC" "Sideload an APK File" "Uninstall an App" "Keep Alive" "Enable Wired ALVR" "Change Refresh Rate" "Replay Tools" "Change Quest Resolution" "Update QuestToolbox" "ADB Options" "==========================================" "Developer Credits" "Special Thanks" "Help"
if "%errorlevel%"=="1" goto capture
if "%errorlevel%"=="2" goto mirrorScreen
if "%errorlevel%"=="3" goto sideloadPrompt
if "%errorlevel%"=="4" goto uninstallAPKPrompt
if "%errorlevel%"=="5" goto startkeepAlive
if "%errorlevel%"=="6" goto wiredALVR
if "%errorlevel%"=="7" goto refreshrate
if "%errorlevel%"=="8" goto replayTools
if "%errorlevel%"=="9" goto changeResPrompt
if "%errorlevel%"=="10" goto update
if "%errorlevel%"=="11" goto adbmenu
if "%errorlevel%"=="12" goto MainMenu
if "%errorlevel%"=="13" goto devcredits
if "%errorlevel%"=="14" goto specialThanks
if "%errorlevel%"=="15" goto Support
goto MainMenu


:capture
cls
echo            [7mChange Recording Res/FPS[0m
echo ==========================================
echo Which capture commands do you want to run?
echo ==========================================

::Options
cmdMenuSel f870 "1920x1080 60fps (Widescreen)" "1280x1280 60fps (Square)" "1080x1920 60fps (Youtube Shorts)" "Custom res/fps" "==Back=="
if "%errorlevel%"=="1" goto wide
if "%errorlevel%"=="2" goto square
if "%errorlevel%"=="3" goto shorts
if "%errorlevel%"=="4" goto custom
if "%errorlevel%"=="5" goto MainMenu
goto capture

:wide
cls
adb shell setprop debug.oculus.capture.width 1920
adb shell setprop debug.oculus.capture.height 1080
adb shell setprop debug.oculus.capture.bitrate 10000000
adb shell setprop debug.oculus.foveation.level 0
adb shell setprop debug.oculus.capture.fps 60

if "%errorlevel%"=="-1" goto noDevices

if "%errorlevel%"=="0" (
	cls
	echo Successfully Changed Resolution and FPS!
	pause
	goto MainMenu
)

pause
goto MainMenu

:square
cls
adb shell setprop debug.oculus.capture.width 1280
adb shell setprop debug.oculus.capture.height 1280
adb shell setprop debug.oculus.capture.bitrate 10000000
adb shell setprop debug.oculus.foveation.level 0
adb shell setprop debug.oculus.capture.fps 60

if "%errorlevel%"=="-1" goto noDevices

if "%errorlevel%"=="0" (
	cls
	echo Successfully Changed Resolution and FPS!
	pause
	goto MainMenu
)

pause
goto MainMenu

:shorts
cls
adb shell setprop debug.oculus.capture.width 1080
adb shell setprop debug.oculus.capture.height 1920
adb shell setprop debug.oculus.capture.bitrate 10000000
adb shell setprop debug.oculus.foveation.level 0
adb shell setprop debug.oculus.capture.fps 60

if "%errorlevel%"=="-1" goto noDevices

if "%errorlevel%"=="0" (
	cls
	echo Successfully Changed Resolution and FPS!
	pause
	goto MainMenu
)

pause
goto MainMenu

:custom
cls

:: Clears all the variables
set width=
set height=
set fps=

:setWidth
cls
set /p width=Custom Width: 

if "%width%"=="" (
	cls
	echo Please enter a width!
	pause
	goto setWidth
)

goto setHeight

:setHeight
cls
set /p height=Custom Height: 

if "%height%"=="" (
	cls
	echo Please enter a height!
	pause
	goto setHeight
)

:setFPS
cls
echo [7mDue to oculus capping FPS, min is 30 and max is 90![0m
set /p fps=Custom FPS: 

if "%fps%"=="" (
	cls
	echo Please enter a fps!
	pause
	goto setFPS
)

adb shell setprop debug.oculus.capture.width %width%
adb shell setprop debug.oculus.capture.height %height%
adb shell setprop debug.oculus.capture.bitrate 10000000
adb shell setprop debug.oculus.foveation.level 0
adb shell setprop debug.oculus.capture.fps %fps%

if "%errorlevel%"=="-1" goto noDevices

if "%errorlevel%"=="0" (
	cls
	echo Successfully Changed Resolution and FPS!
	pause
	goto MainMenu
)

pause
goto MainMenu



:mirrorScreen
cls
echo            [7mStream Quest Screen[0m
echo ==========================================
echo Do you have a Quest 1 or 2?
echo ==========================================

::Options
cmdMenuSel f870 "Quest 1" "Quest 2" "==Back=="
if "%errorlevel%"=="1" goto Q1mirror
if "%errorlevel%"=="2" goto Q2mirror
if "%errorlevel%"=="3" goto MainMenu

:Q1mirror
cls
echo ==========================================
echo What FPS would you like the stream to be?
echo ==========================================
cmdMenuSel f870 "60 FPS" "30 FPS" "Custom" "==back=="
if "%errorlevel%"=="1" goto 60Q1
if "%errorlevel%"=="2" goto 30Q1
if "%errorlevel%"=="3" goto customQ2
if "%errorlevel%"=="4" goto mirrorScreen

:60Q1
:: Clears the FPS variable
set Q1streamFPS=
:: Sets the FPS of stream to 60
set Q1streamFPS=60
goto Q1bitrate

:30Q1
:: Clears the FPS variable
set Q1streamFPS=
:: Sets the FPS of stream to 30
set Q1streamFPS=30
goto Q1bitrate

:customQ1
cls
:: Clears the FPS variable
set Q1streamFPS=
:: Input for custom FPS
set /p Q1streamFPS=Custom FPS:
goto Q1bitrate

:Q1bitrate
cls
echo ==========================================
echo What bitrate would you like the stream to be (MB)?
echo ==========================================
:: Clears the Bitrate Variable
set Q1bitrate=
:: Input for bitrate of stream
set /p Q1bitrate=Answer:

if "%Q1bitrate%"=="" (
	cls
	echo Please enter a bitrate!
	pause
	goto Q1bitrate
)

goto Q1streaming

:Q1streaming
cls
echo Starting stream at %Q1streamFPS% FPS....
:: Starts a stream to the quest at a custom fps and bitrate with a crop set
scrcpy --max-fps %Q1streamFPS% --crop 1280:720:1500:350 --bit-rate %Q1bitrate%M

if "%errorlevel%"=="1" goto noDevices

pause
goto MainMenu

:Q2mirror
cls
echo ==========================================
echo What FPS would you like the stream to be?
echo ==========================================

::Options
cmdMenuSel f870 "60 FPS" "30 FPS" "Custom" "==back=="
if "%errorlevel%"=="1" goto 60Q2
if "%errorlevel%"=="2" goto 30Q2
if "%errorlevel%"=="3" goto customQ2
if "%errorlevel%"=="4" goto mirrorScreen

:60Q2
:: Clears the FPS variable
set Q2streamFPS=
:: Sets the FPS of stream to 60
set Q2streamFPS=60
goto Q2bitrate

:30Q2
:: Clears the FPS variable
set Q2streamFPS=
:: Sets the FPS of stream to 30
set Q2streamFPS=30
goto Q2bitrate

:customQ2
cls
:: Clears the FPS variable
set Q2streamFPS=
:: Input for custom FPS
set /p Q2StreamFPS=Custom FPS:
goto Q2bitrate

:Q2bitrate
cls
echo ==========================================
echo What bitrate would you like the stream to be (MB)?
echo ==========================================
:: Clears the Bitrate Variable
set Q2bitrate=
:: Input for bitrate of stream
set /p Q2bitrate=Answer:

if "%Q2bitrate%"=="" (
	cls
	echo Please enter a bitrate!
	pause
	goto Q2bitrate
)

goto Q2streaming

:Q2streaming
cls
echo Starting stream at %Q2streamFPS% FPS....
:: Starts a stream to the quest at a custom fps with a crop set
scrcpy --max-fps %Q2streamFPS% --crop 1600:900:2017:510 --bit-rate %Q2bitrate%M

if "%errorlevel%"=="1" goto noDevices

pause
goto MainMenu



:sideloadPrompt
cls
echo ==========================================
echo      [7mDo you want to sideload an APK?[0m
echo ==========================================

:: Options
cmdMenuSel f870 "Yes" "No"
if "%errorlevel%"=="1" goto sideload
if "%errorlevel%"=="2" goto MainMenu
goto sideloadPrompt

:sideload
cls
echo ==========================================
echo Type in the directory of the file (including file name)
echo [7mMake sure that the file and directory does not have a space in it![0m
echo ==========================================
echo [7mType "exit" to cancel.[0m
:: Resets the APK directory selected
set APKdir=
:: Input
set /p APKdir=Answer:
if /I "%APKdir%"=="exit" goto MainMenu
if "%APKdir%"=="" goto sideloadIncorrect
cls
echo Sideloading APK.... Please wait
adb install %APKdir%

if "%errorlevel%"=="1" goto noDevices

if "%errorlevel%"=="0" (
	cls
	echo Successfully Sideloaded APK!
	pause
	goto MainMenu
)

pause
goto MainMenu

:sideloadIncorrect
cls
echo Please Enter a directory
pause
goto sideload



:uninstallAPKPrompt
cls
echo ==========================================
echo [7mAre you sure you want to uninstall an App?[0m
echo ==========================================
cmdMenuSel f870 "Yes" "No"
if "%errorlevel%"=="1" goto uninstallAPK
if "%errorlevel%"=="2" goto MainMenu

:uninstallAPK
cls
echo ==========================================
echo [7mA new window will open with all the apps installed.[0m
echo ==========================================
pause
start packages.bat
goto uninstalling

:uninstalling
cls
echo ==========================================
echo Please Enter the package name of 
echo the app you would like to uninstall (Without the "package:")
echo ==========================================
echo [7mType "exit" to cancel.[0m
set APKuninst=
set /p APKuninst=Answer:
if "%APKuninst%"=="" goto wrongInputAPK
if /I "%APKuninst%"=="exit" goto MainMenu
cls
echo Uninstalling APK....
adb uninstall %APKuninst%

if "%errorlevel%"=="-1" goto noDevices

if "%errorlevel%"=="0" (
	echo Successfully Uninstalled APK!
	pause
	goto MainMenu
)

pause
goto MainMenu

:wrongInputAPK
cls
echo Please enter a package name!
pause
goto uninstalling



:startkeepAlive
cls
echo Starting keepAlive.bat...
start keepAlive.bat
goto MainMenu



:wiredALVR
cls
echo ==========================================
echo [7mA new window will open, do NOT close it 
echo otherwise wired ALVR will stop working.[0m
echo ==========================================
pause
echo Starting bat...
start wiredalvr.bat
goto MainMenu




:refreshrate
cls
echo               [7mRefresh Rate[0m
echo ==========================================
echo Which Refresh Rate do you want to use?
echo ==========================================

::Options
cmdMenuSel f870 "60Hz" "72Hz" "90Hz (Quest 2 ONLY)" "120Hz (Quest 2 ONLY)" "==Back=="
if "%errorlevel%"=="1" goto 60
if "%errorlevel%"=="2" goto 72
if "%errorlevel%"=="3" goto 90
if "%errorlevel%"=="4" goto 120
if "%errorlevel%"=="5" goto MainMenu
goto refreshrate

:60
cls
echo Updating Refresh Rate...
adb shell setprop debug.oculus.refreshRate 60

if "%errorlevel%"=="-1" goto noDevices

if "%errorlevel%"=="0" (
	cls
	echo Successfully Applied Refresh Rate!
	pause
	goto MainMenu
)

pause
goto MainMenu

:72
cls
echo Updating Refresh Rate...
adb shell setprop debug.oculus.refreshRate 72

if "%errorlevel%"=="-1" goto noDevices

if "%errorlevel%"=="0" (
	cls
	echo Successfully Applied Refresh Rate!
	pause
	goto MainMenu
)

pause
goto MainMenu

:90
cls
echo Updating Refresh Rate...
adb shell setprop debug.oculus.refreshRate 90

if "%errorlevel%"=="-1" goto noDevices

if "%errorlevel%"=="0" (
	cls
	echo Successfully Applied Refresh Rate!
	pause
	goto MainMenu
)

pause
goto MainMenu

:120
cls
echo Updating Refresh Rate...
adb shell setprop debug.oculus.refreshRate 120

if "%errorlevel%"=="-1" goto noDevices

if "%errorlevel%"=="0" (
	cls
	echo Successfully Applied Refresh Rate!
	pause
	goto MainMenu
)

pause
goto MainMenu

:replayTools
cls
echo               [7mReplay Tools[0m
echo ==========================================
echo Which would you like to do?
echo ==========================================
echo These options are for the Render release of 
echo Replay mod for Beat Saber. (not publicly available yet)
echo ==========================================
cmdMenuSel f870 "Render files" "Remux Rendered Files (Must render first!)" "==Back=="

:: Options
if "%errorlevel%"=="1" goto keepaliveReplay
if "%errorlevel%"=="2" goto remux
if "%errorlevel%"=="3" goto MainMenu

:keepaliveReplay
cls
adb shell am broadcast -a com.oculus.vrpowermanager.prox_close
start keepaliveReplay.bat
cls
echo [41mPlease keep the keepAlive window open while rendering
echo to not corrupt the render![0m
echo ==========================================================
echo [7mPress enter once you have finished rendering the video
echo and the other batch window is closed![0m
pause
shell am broadcast -a com.oculus.vrpowermanager.automation_disable
goto replayTools

:remux
cls
echo [41mMake sure to render first and that both files are 
echo not located on your quest but on your computer![0m
echo.
echo [7mType "exit" to cancel.[0m
echo.
set /p fileLoc=Enter file location of [7maudio.wav[0m and [7mvideo.h264[0m: 

if "%fileLoc%"=="" (
	cls
	echo Please enter a Directory!
	pause
	goto remux
)

if /I "%fileLoc%"=="exit" goto replayTools

:fPerSec
cls
echo [41mMake sure to render first and that both files are 
echo not located on your quest but on your computer![0m
echo.
echo [7mType "exit" to cancel.[0m
echo.
set /p framesPS=Please enter what FPS you would like it to be rendered at: 

if "%framesPS%"=="" (
	cls
	echo Please enter a value!
	pause
	goto fPerSec
)

if /I "%framesPS%"=="exit" goto replayTools

cls
echo Converting [7maudio.wav[0m to [7maudio.ogg[0m
ffmpeg -hide_banner -loglevel error -i %fileLoc%/audio.wav -acodec libvorbis %fileloc%/audio.ogg

if "%errorlevel%"=="1" (
	cls
	echo [7maudio.wav[0m does not exist in the directory
	echo you have entered! Please check the folder.
	pause
	goto remux
)

cls
echo Merging both [7mvideo.h264[0m and [7maudio.ogg[0m into [7moutput.mp4[0m. this could take a while.
ffmpeg -hide_banner -loglevel error -framerate %framesPS% -i %fileLoc%/video.h264 -i %fileLoc%/audio.ogg -c copy %fileLoc%/output.mp4

if "%errorlevel%"=="1" (
	cls
	echo [7mvideo.h264[0m does not exist in the directory
	echo you have entered! Please check the folder.
	pause
	goto remux
)

cls
echo Check the [7moutput.mp4[0m file. Does the audio need to be synced?
cmdMenuSel f870 "Yes" "No"

:: Options
if "%errorlevel%"=="1" goto syncNeeded
if "%errorlevel%"=="2" (
set remuxedFile=output.mp4
goto RemuxFinished
)

:syncNeeded
cls
echo Fixing audio and video desync
ffmpeg -hide_banner -loglevel error -i %fileLoc%/output.mp4 -itsoffset -0.3 -i %fileLoc%/output.mp4 -vcodec copy -acodec copy -map 0:0 -map 1:1 %fileLoc%/finalVideo.mp4

if "%errorlevel%"=="1" (
	cls
	echo [7moutput.mp4[0m could not be found. Please try remuxing again.
	pause
	goto replayTools
)

del %fileLoc%/output.mp4
set remuxedFile=finalVideo.mp4
goto RemuxFinished

:RemuxFinished
cls
echo Finished remuxing audio and video. Open File?
cmdMenuSel f870 "Yes" "No"

:: Options

if "%errorlevel%"=="1" (
	start %fileLoc%/%remuxedFile%
	goto MainMenu
)
if "%errorlevel%"=="2" goto MainMenu

goto RemuxFinished


:changeResPrompt
cls
echo ==========================================
echo         [7mChange Quest Resolution[0m
echo ==========================================
echo Default resolution is currently a bit broken. Use at your own risk
echo.

::Options
cmdMenuSel f870 "Default Resolution (1832x1920)" "Custom Resolution" "==Back=="
if "%errorlevel%"=="1" goto defaultRes
if "%errorlevel%"=="2" goto changeCustomRes
if "%errorlevel%"=="3" goto MainMenu

:defaultRes
cls
echo ==========================================
echo [7mAre you sure you want to change resolution?[0m
echo ==========================================

::Options
cmdMenuSel f870 "Yes" "No"
if "%errorlevel%"=="1" goto changingToDefault
if "%errorlevel%"=="2" goto MainMenu

:changingToDefault
cls
echo Changing Resolution...
adb shell setprop debug.oculus.textureHeight 1832
adb shell setprop debug.oculus.textureWidth 1920

if "%errorlevel%"=="-1" goto noDevices

if "%errorlevel%"=="0" (
	cls
	echo Successfully Changed Resolution!
	pause
	goto MainMenu
)



:changeCustomRes
cls
echo ==========================================
echo [7mAre you sure you want to change resolution?[0m
echo ==========================================

::Options
cmdMenuSel f870 "Yes" "No"
if "%errorlevel%"=="1" goto customRes
if "%errorlevel%"=="2" goto MainMenu

:customRes
set resHeight=
set resWidth=

:resHeight
cls
echo ==========================================
echo [7mBe careful because if you do something wrong it can break.[0m
echo If something does go wrong, a reboot usually fixes it.
echo ==========================================
echo [7mType "exit" to cancel.[0m
set /p resHeight=Custom Height: 

if /I "%resHeight%"=="exit" goto MainMenu

if "%resHeight%"=="" (
	cls
	echo Please enter a Height!
	pause
	goto resHeight
)

:resWidth
cls
echo ==========================================
echo [7mBe careful because if you do something wrong it can break.[0m
echo If something does go wrong, a reboot usually fixes it.
echo ==========================================
echo [7mType "exit" to cancel.[0m
set /p resWidth=Custom Width: 

if /I "%resWidth%"=="exit" goto MainMenu

if "%resWidth%"=="" (
	cls
	echo Please enter a Width!
	pause
	goto resWidth
)

cls
echo Changing resolution...
adb shell setprop debug.oculus.textureHeight %resHeight%
adb shell setprop debug.oculus.textureWidth %resWidth%

if "%errorlevel%"=="-1" goto noDevices

if "%errorlevel%"=="0" (
	cls
	echo Successfully Changed Resolution!
	pause
	goto MainMenu
)

pause
goto MainMenu



:update
cls
set update=yes
echo Checking for updates...
call checkforupdates.bat
goto MainMenu

:ADBMenu
cls
echo               [7mADB Options[0m
echo ==========================================
echo Which would you like to do?
echo ==========================================
cmdMenuSel f870 "Setup Wireless ADB" "Disconnect Wireless ADB" "Custom ADB Command" "Sideload Firmware" "Download Firmware Files" "Disable Proximity Sensor" "==Back=="

:: Options
if "%errorlevel%"=="1" goto wirelesssetup
if "%errorlevel%"=="2" goto disconnect
if "%errorlevel%"=="3" goto customADB
if "%errorlevel%"=="4" goto firmwareConfirm
if "%errorlevel%"=="5" goto downloadFirmware
if "%errorlevel%"=="6" goto proximitySensorOptions
if "%errorlevel%"=="7" goto MainMenu

:wirelesssetup
cls
echo ==========================================
echo     [7mDo you want to setup wireless adb?[0m
echo ==========================================

:: Options
cmdMenuSel f870 "Yes" "No"
if "%errorlevel%"=="1" goto wirelessIP
if "%errorlevel%"=="2" goto ADBMenu
goto wirelesssetup

:wirelessIP
cls
echo ==========================================
echo [41mPlease plug in your Quest / Quest 2![0m
echo ==========================================
echo [7mType "exit" to cancel.[0m
:: Resets the local ip
set localip=
:: Prompts for the local IP
set /p localip=Quest / Quest 2 local IP: 
if /I "%localip%"=="exit" goto ADBMenu
if "%localip%"=="" goto IncorrectInputIP

cls
echo ==========================================
echo You set your Quest / Quest 2 local ip to [7m%localip%[0m. is that correct?
echo ==========================================

:: Options
cmdMenuSel f870 "Yes" "No"
if "%errorlevel%"=="1" goto connecting
if "%errorlevel%"=="2" goto wirelessIP
goto WirelessIP

:connecting
cls
:: Sets the quest up for wireless
adb tcpip 5555

if "%errorlevel%"=="1" goto noDevices

:: Connects to the quest wirelessly
adb connect %localip%:5555
pause
goto MainMenu

:IncorrectInputIP
cls
echo Please enter an IP
pause
goto wirelessIP


:customADB
cls
echo ==========================================
echo [41mMake sure you know what you are doing
echo before typing in adb commands.[0m
echo ==========================================
echo [7mType "[1mexit[0m[7m" to cancel.[0m
set adbCom=
set /p adbCom=adb 

if /I "%adbCom%"=="exit" goto ADBMenu

if "%adbCom%"=="" (
	cls
	echo Please input a command.
	pause
	goto customADB
)

cls
echo Running ADB Command
echo ==========================================
adb %adbCom%
echo ==========================================
if "%errorlevel%"=="0" echo Successfully executed command.
pause
goto ADBMenu



:disconnect
cls
echo ==========================================
echo [7mDo you want to disconnect wireless ADB?[0m
echo ==========================================

cmdMenuSel f870 "Yes" "No"
if "%errorlevel%"=="1" goto disconnecting
if "%errorlevel%"=="2" goto ADBMenu

:disconnecting
cls
adb disconnect

if "%errorlevel%"=="0" (
	cls
	echo Successfully Disconnected
	pause
	goto MainMenu
)

pause
goto MainMenu

:firmwareConfirm
cls
echo ==========================================
echo [7mAre you sure you want to sideload firmware?[0m
echo ==========================================
cmdMenuSel f870 "Yes" "No"

if "%errorlevel%"=="1" goto firmwareSetup
if "%errorlevel%"=="2" goto ADBMenu

:firmwareSetup
cls
echo [7mMake sure to boot your Quest into Recovery mode
echo and select the "Sideload Update" option!![0m
pause
goto sideloadFirmware

:sideloadFirmware
cls
echo ==========================================
echo [7mMake sure you know what you are doing!![0m
echo Type in the directory of the .zip containing 
echo the firmware (including file name)
echo ==========================================
echo [7mType "exit" to cancel.[0m

set FirmwareZip=
set /p FirmwareZip=Answer: 

if "%FirmwareZip%"=="" (
	cls
	echo Please enter a valid directory
	pause
	goto sideloadFirmware
)

if /I "%FirmwareZip%"=="exit" goto ADBMenu

cls
echo Sideloading...
adb sideload %FirmwareZip%

if "%errorlevel%"=="0" (
	cls
	echo Successfully sideloaded
	pause
	goto MainMenu
)

pause
goto MainMenu

:downloadFirmware
cls
echo ==========================================
echo Which firmware version would you like to download?
echo ==========================================

cmdMenuSel f870 "v34" "v33" "v28" "v20" "v19" "v18" "v17" "v16" "v15" "v14" "v13" "v12" "v11" "v10" "v9" "v8" "==Back=="
if "%errorlevel%"=="1" (
	start https://vrdiscord.com/10000000_607329520697967_1131219119747458298_n.zip
	goto sideloadQuestion
)

if "%errorlevel%"=="2" (
	start https://cdn.discordapp.com/attachments/494585360689397792/887311532059418624/v33partialq2.zip
	goto sideloadQuestion
)

if "%errorlevel%"=="3" (
	start https://vrdiscord.com/10000000_199590601735813_1333856360172557081_n.zip
	goto sideloadQuestion
)

if "%errorlevel%"=="4" (
	start http://www.mediafire.com/file/qewy4hqr1exu9dt/10000000_733778840807572_3134597064107830720_n.zip/file
	goto sideloadQuestion
)

if "%errorlevel%"=="5" (
	start http://www.mediafire.com/file/mlv23o1x1gsnpjm/8214900132100000_8214900132100000.zip/file
	goto sideloadQuestion
)

if "%errorlevel%"=="6" (
	start http://www.mediafire.com/file/77v1isc5tpp25k7/7386600268600000_7386600268600000.zip/file
	goto sideloadQuestion
)

if "%errorlevel%"=="7" (
	start http://www.mediafire.com/file/ul49zg6cconvvm1/6551400235200000_6551400235200000.zip/file
	goto sideloadQuestion
)

if "%errorlevel%"=="8" (
	start http://www.mediafire.com/file/f8umqyxgq8jimdq/6023800249000000_6023800249000000.zip/file
	goto sideloadQuestion
)

if "%errorlevel%"=="9" (
	start http://www.mediafire.com/file/d2n4as1rkfi64y3/5551800225700000_5551800225700000.zip/file
	goto sideloadQuestion
)

if "%errorlevel%"=="10" (
	start http://www.mediafire.com/file/a6ya3lpylx578bh/5072400209400000_5072400209400000.zip/file
	goto sideloadQuestion
)

if "%errorlevel%"=="11" (
	start http://www.mediafire.com/file/xdbwqhwnmc9tsoh/4566800260600000_4566800260600000.zip/file
	goto sideloadQuestion
)

if "%errorlevel%"=="12" (
	start http://www.mediafire.com/file/ouw6f4cdybmck9l/4342600050300000_4342600050300000.zip/file
	goto sideloadQuestion
)

if "%errorlevel%"=="13" (
	start http://www.mediafire.com/file/lej5us8gideodsl/4156300067000000_4156300067000000.zip/file
	goto sideloadQuestion
)

if "%errorlevel%"=="14" (
	start http://www.mediafire.com/file/a478lchz1ullzof/3965200061700115_3965200061700115.zip/file
	goto sideloadQuestion
)

if "%errorlevel%"=="15" (
	start http://www.mediafire.com/file/6geqiuyuv2njnzc/3774800165000000_3774800165000000.zip/file
	goto sideloadQuestion
)

if "%errorlevel%"=="16" (
	start http://www.mediafire.com/file/0i14r6f683h6nwm/3585700093200000_3585700093200000.zip/file
	goto sideloadQuestion
)

if "%errorlevel%"=="17" goto ADBMenu

:sideloadQuestion
cls
echo ==========================================
echo Would you like to sideload the firmware?
echo ==========================================

cmdMenuSel f870 "Yes" "No"
if "%errorlevel%"=="1" goto firmwareSetup
if "%errorlevel%"=="2" goto ADBMenu



:proximitySensorOptions
cls
echo ==========================================
echo Which would you like to do?
echo ==========================================
cmdMenuSel f870 "Enable Proximity Sensor" "Disable Proximity Sensor" "==Back=="

if "%errorlevel%"=="1" goto enableProximitySens
if "%errorlevel%"=="2" goto disableProximitySens
if "%errorlevel%"=="3" goto ADBMenu
goto proximitySensorOptions

:enableProximitySens
cls
echo Enabling...
adb shell am broadcast -a com.oculus.vrpowermanager.prox_close

if "%errorlevel%"=="-1" goto noDevices

if "%errorlevel%"=="0" (
	cls
	echo Enabled Successfully!
	pause
	goto ADBMenu
)
pause

:disableProximitySens
cls
echo Disabling...
adb shell am broadcast -a com.oculus.vrpowermanager.automation_disable

if "%errorlevel%"=="-1" goto noDevices

if "%errorlevel%"=="0" (
	cls
	echo Disabled Successfully!
	pause
	goto ADBMenu
)
pause


:devcredits
cls
echo ==========================================
echo Developed by:
echo ==========================================

:: Options
cmdMenuSel f870 "mitchv2020" "LordNikonUK" "==Back=="
if "%errorlevel%"=="1" goto dev1
if "%errorlevel%"=="2" goto dev2
if "%errorlevel%"=="3" goto MainMenu
goto devcredits

:dev1
cls
:: Redirects the user to mitchv2020's youtube channel
start https://www.youtube.com/channel/UCZW2Nxa-fCm6V8bvDeF0Fyg
goto :devcredits

:dev2
cls
:: Redirects the user to lordnikon's youtube channel
start https://www.youtube.com/channel/UCTaoq74t_tMPA5jUITxB3lw
goto :devcredits



:specialThanks
cls
echo ==========================================
echo Special Thanks to:
echo ==========================================

cmdMenuSel f870 "Henwill8" "==Back=="

if "%errorlevel%"=="1" (
	cls
	start https://www.youtube.com/channel/UCSvbTEjaYHRH-ZAgAOONZeg
	goto MainMenu
)

if "%errorlevel%"=="2" goto MainMenu

:Support
cls
echo ==========================================
echo Add on Discord: (you can click on them)
echo ==========================================

cmdMenuSel f870 "mitchv2020#5697" "LordNikon#1793" "==Back=="

if "%errorlevel%"=="1" (
	cls
	start https://discord.com/users/330282620833366016
	goto MainMenu
)

if "%errorlevel%"=="2" (
	cls
	start https://discord.com/users/555856178500993024
	goto MainMenu
)

if "%errorlevel%"=="3" goto MainMenu
goto Support






::::::::::::::::::::::::::::::::::::::::
:::::::::::::ERROR MESSAGES:::::::::::::
::::::::::::::::::::::::::::::::::::::::

:noDevices
cls
echo [7mYou have either more than 1 or no Android devices connected!
echo Please disconnect any other devices or connect your Quest.[0m
pause
goto MainMenu

:noRequirements
mode con: cols=90 lines=20 
cls
echo [41mThe requirements folder does not exist, please redownload![0m
pause
start https://github.com/mitchv2020/QuestToolbox/releases/latest
exit

:missingFile
mode con: cols=90 lines=20 
cls
echo [41m%missingFile% was not found in the requirements folder. Please redownload![0m
pause
start https://github.com/mitchv2020/QuestToolbox/releases/latest
exit
