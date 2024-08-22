echo [i][X] Copying test mode status...
call ini.bat /s Status /i CallTestMode E:\AppTransition.ini > temp.txt
set /p TESTMODE_STATE=<temp.txt
del temp.txt

if "%TESTMODE_STATE%" == "1" goto :launch_testmode
goto end_testmode

:launch_testmode
echo [i][X] Copying test mode config...
mkdir testmode\testmode > nul 2>&1
copy /Y rominfo.xml testmode\rominfo.xml
copy /Y testmode\testConfig.xml testmode\testmode\testConfig.xml
echo [i][X] Enter test mode!
call testmode\testmode.exe -screen-fullscreen 1 -screen-width 1920 -screen-height 1080 -logfile ..\nvram\link_testmode.log


:end_testmode