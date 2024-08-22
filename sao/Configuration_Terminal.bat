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
set HAS_IMPORT_CERT=0

rem Hook DLL name
set HOOK_DLL_NAME=mkhook.dll

rem Game launch parameters
set PREP_DIR=AMCUS
set PREP_CALL=inject.exe -w -k mkhook.dll PreprocessAmAuth.exe
set AMCUS_DIR=.\AMCUS
set GAME_DIR=.
set GAME_EXE=game\link.exe
set EXTRA_LAUNCH=rem Extra_Notice_Terminal.bat
set EXTRA_LAUNCH_END=
set GAME_ARGS=-pc 0 -screen-fullscreen 1 -screen-width 1920 -screen-height 1080 -logfile ..\nvram\link_terminal.log -mod-swordartoffline-force-terminal

rem If this is 1, the hook dll above will NOT be injected into the game
set GAME_UNHOOKED=1
