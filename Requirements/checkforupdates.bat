@echo off

if "%update%"=="yes" goto updateOption

:startupCheck
curl.exe -s -o "sc.txt" https://api.github.com/repos/mitchv2020/questtoolbox/releases
findstr "tag_name" sc.txt > list_of_ver.txt
fc list_of_ver.txt list_of_ver_fromdate.txt > nul
if errorlevel 1 goto matchFail

::delete temp files
del list_of_ver.txt
del sc.txt
goto continueSetup
pause

:matchFail
cls
echo [7mThere is a new version of QuestToolBox available.
echo Do you want to update? (This may be automatic in the future)[0m

::options
cmdMenuSel f870 "Yes (Opens default browser)" "No"
if "%errorlevel%"=="1" (
    ::delete temp files
    del list_of_ver.txt
    del sc.txt
    start https://github.com/mitchv2020/QuestToolbox/releases
    exit
)
if "%errorlevel%"=="2" (
    ::delete temp files
    del list_of_ver.txt
    del sc.txt
    goto continueSetup
)

:updateOption
curl.exe -s -o "sc.txt" https://api.github.com/repos/mitchv2020/questtoolbox/releases
findstr "tag_name" sc.txt > list_of_ver.txt
fc list_of_ver.txt list_of_ver_fromdate.txt > nul
if errorlevel 1 goto updateAvailable

cls
echo You are using the latest version of QuestToolbox!
del list_of_ver.txt
del sc.txt
pause 
exit /b

:updateAvailable
cls
echo [7mThere is a new version of QuestToolBox available.
echo Do you want to update? (This may be automatic in the future)[0m

::options
cmdMenuSel f870 "Yes (Opens default browser)" "No"
if "%errorlevel%"=="1" (
    ::delete temp files
    del list_of_ver.txt
    del sc.txt
    start https://github.com/mitchv2020/QuestToolbox/releases
    exit
)

if "%errorlevel%"=="2" (
    ::delete temp files
    del list_of_ver.txt
    del sc.txt
    goto MainMenu
)

set update = none 