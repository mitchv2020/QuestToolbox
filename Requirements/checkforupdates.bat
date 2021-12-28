curl.exe -s -o "sc.txt" https://api.github.com/repos/mitchv2020/questtoolbox/releases
findstr "tag_name" sc.txt > list_of_ver.txt
fc list_of_ver.txt list_of_ver_fromdate.txt > nul
if errorlevel 1 goto matchFail

:next
goto continueSetup
pause

:matchFail
echo [7mThere is a new version of QuestToolBox available.
echo Do you want to update? (This will be automatic in the future)[0m

::options
cmdMenuSel f870 "Yes (Opens default browser)" "No"
if "%errorlevel%"=="1" (
    start https://github.com/mitchv2020/QuestToolbox/releases
    exit
)
if "%errorlevel%"=="2" goto MainMenu