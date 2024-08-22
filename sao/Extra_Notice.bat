echo [i][X] Checking server status...
GameServerChecker.exe
echo [i][X] Server Status: %ERRORLEVEL%
if %ERRORLEVEL% EQU 0 goto server_status_ok
echo [E][X] A connection error occurred!
timeout /T 10

:server_status_ok
echo [i][X] Copying version data...
copy /Y rominfo.xml notice\rominfo.xml
echo [i][X] Cleaning transition file...
del E:\AppTransition.ini
echo [i][X] Starting checking application...
notice\noticeScreen.exe -screen-fullscreen 1 -screen-width 1920 -screen-height 1080 -logfile ..\nvram\link_notice.log