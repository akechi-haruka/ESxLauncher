rem --------------------------------------
rem This is the configuration file for
rem the haruMod ESx launchscript
rem --------------------------------------

rem Disables the updating system
set OAS_UPDATER_DISABLED=1

rem Skips checking (and restarting) the script to obtain admin permissions.
set SKIP_ADMIN_CHECK=0

rem Leaves the command line open before the script exists (debug only)
set PAUSE_BEFORE_EXIT=1

rem Whether or not ImportCertificate.exe is present
set HAS_IMPORT_CERT=0

rem Hook DLL name
set HOOK_DLL_NAME=synchook.dll

rem Is this running on a cabinet?
set IS_CABINET=0

rem If this is 1, the hook dll above will NOT be injected into the game
set GAME_UNHOOKED=0

rem Game launch parameters
set PREP_DIR=.
set PREP_CALL=AMCUS\inject.exe -w -k AMCUS\%HOOK_DLL_NAME% PreprocessAmAuth.exe
set AMCUS_DIR=AMCUS
set GAME_DIR=app
set GAME_EXE=sync_release.exe
set GAME_ARGS=gmg-amcus-fs-touch.ini
set ONEXIT=taskkill /F /IM xtender.exe


rem --------------------------------------
rem cabinet flag check
if "%IS_CABINET%" == "0" goto after_cab_extra_flags
set GAME_ARGS=gmg-amcus-fs-cab.ini
rem --------------------------------------
:after_cab_extra_flags
