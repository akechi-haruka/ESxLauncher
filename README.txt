ESx Launchscripts

Scripts for various games on the ESx series of cabinets to add modifications/segatools or run on other machines.

---

Installation:

Synchronica:
Download all files and place them in the main game directory (where init.ps1 is)
Download hexedit.exe (https://github.com/akechi-haruka/hexedit-cmd) and place it in the utils directory!
Edit segatools.ini to change the server URL and the keychip ID. (The file gets automatically copied to the relevant directories)
Edit AMCUS\AMConfig.ini and change the server URL (cacfg-auth_server_url) and the keychip ID (cacfg-game_board_id).
Edit app\DEVICE\banapass.txt to your banapass ID.
Use Launch.bat to start the game.

If you crash with "[ERROR] (network::local_network::initialize) initialize error: bind", run "net stop winnat" as admin.

---

Development:

Same as installation, but also add synchook.dll/inject.exe to both AMCUS and app folders.
