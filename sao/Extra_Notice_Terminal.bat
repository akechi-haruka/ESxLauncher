echo [i][X] Copying version data...
copy /Y rominfo.xml notice\rominfo.xml
echo [i][X] Cleaning transition file...
del E:\AppTransition.ini
echo [i][X] Starting checking application...
notice\noticeScreen.exe -screen-fullscreen 1 -screen-width 1920 -screen-height 1080 -mod-swordartoffline-force-terminal