ESx Launchscripts

Scripts for various games on the ESx series of cabinets to add modifications/segatools or run on other machines.

The source for the segatools build I use can be found here: https://github.com/akechi-haruka/segatools

--- Synchronica ---

Installation:

Download all files (Click "Releases" on the right side) and put everything from the "synchronica" folder in the main game directory (where init.ps1 is)
Edit segatools.ini to change the server URL and the keychip ID. (The file gets automatically copied to the relevant directories)
Edit AMCUS\AMConfig.ini and change the server URL (cacfg-auth_server_url) and the keychip ID (cacfg-game_board_id).
Edit app\DEVICE\banapass.txt to your banapass ID.
Use Launch.bat to start the game.

If you crash with "[ERROR] (network::local_network::initialize) initialize error: bind", run "net stop winnat" as admin.

If the game passes all startup checks, but still appears offline, turn off CLOSE TIME SETTING from the test menu.

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

Development:

Same as installation, but also add synchook.dll/inject.exe to both AMCUS and app folders.

--- MKACGPDX ---

Installation:

Download all files and everything from the "mk118" folder in any directory.
Place all game files in the "mariokart" sub-folder. (MK_AGP3_FINAL.exe should be inside "mariokart")
Edit segatools.ini and AMCUS\segatools.ini to change the server URL and the keychip ID. 
Edit AMCUS\AMConfig.ini and change the server URL (cacfg-auth_server_url) and the keychip ID (cacfg-game_board_id).
Edit app\DEVICE\banapass.txt to your banapass ID.
Use Launch.bat to start the game.

Misc. Notes:

* Some PCs may throw a direct X error on startup. Fix unknown.
* To use the NamCam, you need a 720p compatible camera.

Default keybindings:
* Backspace: Scan Card
* 1: TEST
* 2: SERVICE
* 3: COIN
* Up Arrow: Test Menu Up
* Down Arrow: Test Menu Down
* Enter: Test Menu Confirm

Default Keybindings (input_mode=1 - Keyboard):
* Left/Right Arrows: Steering
* Up Arrow: Accelerate
* Down Arrow: Brake / Drift
* Up Arrow/Down Arrow: Mario Button
* D / S: Item Button

Keybindings (input_mode=2 - XInput):
X/Y: mario button
A: item primary
B: item secondary
Left Stick: steering
LT: brake
RT: accelerator

Development:

Same as installation, but also add mkhook.dll/inject.exe/security_buster.dll to both AMCUS and mariokart folders.
