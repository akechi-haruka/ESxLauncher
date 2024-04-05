rem --------------------------------------
rem This is the configuration file for
rem the haruMod ESx launchscript
rem --------------------------------------

rem Disables the updating system
set OAS_UPDATER_DISABLED=1

rem Skips checking (and restarting) the script to obtain admin permissions.
set SKIP_ADMIN_CHECK=0

rem Leaves the command line open before the script exists (debug only)
set PAUSE_BEFORE_EXIT=0

rem Whether or not ImportCertificate.exe is present
set HAS_IMPORT_CERT=1

rem Hook DLL name
set HOOK_DLL_NAME=mkhook.dll

rem Game launch parameters
set PREP_DIR=mariokart
set PREP_CALL=inject.exe -w -k mkhook.dll PreprocessAmAuth.exe
set AMCUS_DIR=mariokart\AMCUS
set GAME_DIR=mariokart
set GAME_EXE=MK_AGP3_FINAL.exe
set GAME_ARGS=

rem If this is 1, the hook dll above will NOT be injected into the game
set GAME_UNHOOKED=0
