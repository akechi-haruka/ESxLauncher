ESx Launchscripts

Scripts for various games on the ESx series of cabinets to add modifications/segatools or run on other machines.

---

Installation:

Synchronica:
Download all files and everything from the "synchronica" folder in the main game directory (where init.ps1 is)
Download hexedit.exe (https://github.com/akechi-haruka/hexedit-cmd) and place it in the utils directory!
Edit segatools.ini to change the server URL and the keychip ID. (The file gets automatically copied to the relevant directories)
Edit AMCUS\AMConfig.ini and change the server URL (cacfg-auth_server_url) and the keychip ID (cacfg-game_board_id).
Edit app\DEVICE\banapass.txt to your banapass ID.
Use Launch.bat to start the game.

If you crash with "[ERROR] (network::local_network::initialize) initialize error: bind", run "net stop winnat" as admin.

Misc. Notes:

* is_holiday.xtal was edited so the game doesn't crash outside of 2018
* self_check.xtal was edited so the game doesn't attempt to ping a hardcoded store router address causing a network error (game still works, however an ugly "NETWORK ERROR" message is displayed on the bottom.
* To change side for multiplayer, edit "side" to L/R in segatools.ini

Default keybindings:
* Touchscreen: Everything (WinTouch is a requirement!)
* Backspace: Scan Card
* 1: TEST
* 2: SERVICE
* 3: COIN / Test Menu ENTER
* 4: Test Menu Up
* 5: Test Menu Down

---

Development:

Same as installation, but also add synchook.dll/inject.exe to both AMCUS and app folders.
