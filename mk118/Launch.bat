@echo off
cd /d %~dp0
echo ---------------------------------------------------------------------
echo haruMod ESx launchscript v2
echo Part of The GenericMusicGames Preservation Project
echo - Saving service based games from being lost to time -
echo - and where they get another chance -
echo Thanks to all helpful people involved in AC data!
echo ---------------------------------------------------------------------

echo [i] Loading configuration...
set CONFIG_FILE=Configuration.bat
if %1.==. goto load_config
echo [i] Using config file %1 from command line.
set CONFIG_FILE=%1

:load_config
call %CONFIG_FILE%

rem Check admin
if "%SKIP_ADMIN_CHECK%" == "1" goto check_oas_updater
echo [i] Checking admin permission...
net session > nul 2>&1
if %ERRORLEVEL% EQU 0 goto check_oas_updater
echo [E] No admin permissions, restarting as admin!
mshta "javascript: var shell = new ActiveXObject('shell.application'); shell.ShellExecute('%~nx0', '%*', '', 'runas', 1);close();"
rem if "%PAUSE_BEFORE_EXIT%" == "1" pause
exit

:check_oas_updater
if "%IS_FROM_OAS_UPDATER%" == "1" goto check_dirs
if "%OAS_UPDATER_DISABLED%" == "1" goto check_dirs
echo [i] Checking updater...
OASUpdaterSAO
if "%PAUSE_BEFORE_EXIT%" == "1" pause
exit

:check_dirs
echo [i] Checking directories...

if not exist %AMCUS_DIR%\ echo [E] AMCUS_DIR not found! && goto end_exit
if not exist %AMCUS_DIR%\AMAuthd.exe echo [E] AMAuthd.exe not found! && goto end_exit
if not exist %AMCUS_DIR%\AMUpdater.exe echo [E] AMUpdater.exe not found! && goto end_exit
if not exist %PREP_DIR%\ echo [E] PREP_DIR not found! && goto end_exit
if not exist %GAME_DIR%\%GAME_EXE% echo [E] GAME_DIR/GAME_EXE not found! && goto end_exit

goto amauth

:amauth_restart
echo [W] AMUpdater is requesting a restart.

:amauth

cd /d %~dp0
cd %GAME_DIR%

echo [i] Creating fake drives...
subst G: /D > nul 2>&1
subst F: /D > nul 2>&1
subst G: .\nvram
subst F: .\nvram

cd /d %~dp0
cd %PREP_DIR%

if "%HAS_IMPORT_CERT%" == "0" goto keychip
echo [i] Installing certificate...
ImportCertificate.exe

:keychip
echo [i] Obtaining keychip data...
%PREP_CALL%

cd /d %~dp0
cd %AMCUS_DIR%

rem echo [i] Applying All.Net Hops fix...
rem ..\..\util\hexedit AmAuthD.exe AmAuthd.exe 0x0000BB7E 0x01 0x20

echo [i] Creating directories...
mkdir appdata > nul 2>&1
mkdir appdata\uptemp > nul 2>&1
mkdir appdata\dtio > nul 2>&1
echo [i] Cleaning logs...
del /Q appdata\*.log > nul 2>&1
echo [i] Closing duplicate processes...
taskkill /F /IM AMAuthd.exe > nul 2>&1
taskkill /F /IM AMUpdater.exe > nul 2>&1
taskkill /F /IM muchacd.exe > nul 2>&1
echo [i] Registering All.Net COM dll...
regsvr32 /s iauthdll.dll
echo [i] Exit code: %ERRORLEVEL%
echo [i] Launching AMAuthd...
start /min inject -d -k %HOOK_DLL_NAME% -d AMAuthd.exe
c:\windows\system32\timeout 2 > nul
echo [i] Launching AMUpdater...
inject -k %HOOK_DLL_NAME% -d AMUpdater.exe -wait -passThru > nul 2>&1
echo [i] Exit code: %ERRORLEVEL%
if ERRORLEVEL 1 goto amauth_restart



echo [i] Applying binary patches to game exe...

rem disable trace_process_memory
rem util\hexedit sync_release.exe sync_release.exe 0x000698D1 0xE9,0x98,0x01,0x00 0x0F,0x86,0x97,0x01

rem ESx keys
reg add HKLM\SOFTWARE\NBGI /v SystemVersion /t REG_SZ /d "haruMod ESx launchscript v2" /f
reg add HKLM\SOFTWARE\NBGI\ESx /v Key0 /t REG_SZ /d "0" /f
reg add HKLM\SOFTWARE\NBGI\ESx /v Key1 /t REG_SZ /d "0" /f

:after_noncab_patches
echo [i] Launching game!

cd /d %~dp0
cd %GAME_DIR%

c:\windows\system32\timeout 1 > nul
if "%GAME_UNHOOKED%" == "1" goto :launch_unhooked
goto launch

:launch
inject -k %HOOK_DLL_NAME% -d %GAME_EXE% -wait -passThru %GAME_ARGS%
goto after_exit

:launch_unhooked
inject -d %GAME_EXE% -wait -passThru %GAME_ARGS%
goto after_exit

:after_exit
echo [i] Game exit code: %ERRORLEVEL%
set exitcode=%ERRORLEVEL%

:end
echo [i] Closing helper applications...
taskkill /F /IM AMAuthd.exe > nul 2>&1
taskkill /F /IM muchacd.exe > nul 2>&1

echo [i] Deleting fake drives...
subst G: /D > nul 2>&1
subst F: /D > nul 2>&1

:end_exit

if "%PAUSE_BEFORE_EXIT%" == "1" pause

exit /B %exitcode%
