@echo off
cd /d %~dp0

echo ---------------------------------------------------------------------
echo haruMod ESx launchscript v4
echo Part of The GenericMusicGames Preservation Project
echo - Saving service based games from being lost to time -
echo - and where they get another chance -
echo Thanks to all helpful people involved in AC data!
echo ---------------------------------------------------------------------
echo This is FREE software! If you have paid, "donated" or otherwise spent
echo money for this, you have been scammed!
echo ---------------------------------------------------------------------

echo [i] Loading configuration...
set CONFIG_FILE=Configuration.bat
if %1.==. goto load_config
echo [i] Using config file %1 from command line.
set CONFIG_FILE=%1

:load_config
call %CONFIG_FILE%

if "%SKIP_ADMIN_CHECK%" == "1" goto check_oas_updater
echo [i] Checking admin permission...
net session > nul 2>&1
if %ERRORLEVEL% EQU 0 goto check_oas_updater
echo [E] No admin permissions, restarting as admin!
mshta "javascript: var shell = new ActiveXObject('shell.application'); shell.ShellExecute('%~nx0', '%*', '', 'runas', 1);close();"
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
if not exist %PREP_DIR%\ echo [E] PREP_DIR not found! && goto end_exit
if not exist %GAME_DIR%\%GAME_EXE% echo [E] GAME_DIR/GAME_EXE not found! && goto end_exit

goto amauth

:check_dir_failure

:amauth_restart
echo [W] AMUpdater is requesting a restart.

:amauth
echo [i] Closing duplicate processes...
taskkill /F /IM AMAuthd.exe > nul 2>&1
taskkill /F /IM AMUpdater.exe > nul 2>&1
taskkill /F /IM muchacd.exe > nul 2>&1

cd /d %~dp0

if "%IS_CABINET%" == "1" goto after_fake_drives

echo [i] Creating directories...
mkdir nvram > nul 2>&1

echo [i] Creating fake drives...
mkdir nvram > nul 2>&1
subst J: /D > nul 2>&1
subst I: /D > nul 2>&1
subst H: /D > nul 2>&1
subst G: /D > nul 2>&1
subst F: /D > nul 2>&1
subst J: .\nvram
subst I: .\nvram
subst H: .\nvram
subst G: .\nvram
subst F: .\nvram

:after_fake_drives

cd /d %~dp0
cd %PREP_DIR%

if "%HAS_IMPORT_CERT%" == "0" goto keychip
echo [i] Installing certificate...
ImportCertificate.exe

:keychip
echo [i] Obtaining keychip data...
%PREP_CALL%

:hexedit
echo [i] Applying binary patches to game exe...
call extra\Patches.bat

cd /d %~dp0
cd %AMCUS_DIR%

echo [i] Creating directories...
mkdir ..\nvram\amcus > nul 2>&1
mkdir ..\nvram\amcus\uptemp > nul 2>&1
mkdir ..\nvram\amcus\dtio > nul 2>&1
echo [i] Cleaning logs...
del /Q ..\nvram\amcus\*.log > nul 2>&1
echo [i] Registering All.Net COM dll...
regsvr32 /s iauthdll.dll
echo [i] Launching AMAuthd...
start /min inject -d -k %HOOK_DLL_NAME% AMAuthd.exe
c:\windows\system32\timeout 2 > nul
echo [i] Launching AMUpdater...
inject -d -k %HOOK_DLL_NAME% AMUpdater.exe -wait -passThru > nul 2>&1
if ERRORLEVEL 1 goto amauth_restart

if "%IS_CABINET%" == "1" goto after_noncab_patches
echo [i] Setting ESx registry keys...
reg add HKLM\SOFTWARE\NBGI /v SystemVersion /t REG_SZ /d "haruMod ESx Launchscript" /f
reg add HKLM\SOFTWARE\NBGI\ESx /v Key0 /t REG_SZ /d "0" /f
reg add HKLM\SOFTWARE\NBGI\ESx /v Key1 /t REG_SZ /d "0" /f

:after_noncab_patches

cd /d %~dp0
if "%EXTRA_LAUNCH%" == "" goto :game_start
echo [i] Launching extra script!
call %EXTRA_LAUNCH%

:game_start
echo [i] Launching game!

cd /d %~dp0
cd %GAME_DIR%

c:\windows\system32\timeout 1 > nul
if "%GAME_UNHOOKED%" == "1" goto :launch_unhooked
goto launch

:launch
inject -k %HOOK_DLL_NAME% -d %GAME_EXE% %GAME_ARGS% -wait -passThru 
goto after_exit

:launch_unhooked
inject -d %GAME_EXE% %GAME_ARGS% -wait -passThru 
goto after_exit

:after_exit
set exitcode=%ERRORLEVEL%
echo [i] Game exit code: %ERRORLEVEL%

cd /d %~dp0
if "%EXTRA_LAUNCH_END%" == "" goto :end
echo [i] Launching extra script!
call %EXTRA_LAUNCH_END%

:end
echo [i] Closing helper applications...
taskkill /F /IM AMAuthd.exe > nul 2>&1
taskkill /F /IM muchacd.exe > nul 2>&1

echo [i] Running ONEXIT...
%ONEXIT%

echo [i] Deleting fake drives...
subst J: /D > nul 2>&1
subst I: /D > nul 2>&1
subst H: /D > nul 2>&1
subst G: /D > nul 2>&1
subst F: /D > nul 2>&1

:end_exit

if "%PAUSE_BEFORE_EXIT%" == "1" pause

exit /B %exitcode%