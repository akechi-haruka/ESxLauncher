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
* musicinfo/musicinfo_aou.xtal were edited to remove expiration dates and reset unlock states to the last online version.
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


--- Sword Art Online Arcade: Deep Explorer ---


Installation:

1. (Recommended) Delete all existing .bat and .ps1 files for a less messy folder.
2. Download the ESx launcher (from Releases on the right side) for Sword Art Online AC: DE and extract everything to the game's main folder. (includes the translation and SwordArtOffline)
 - https://github.com/akechi-haruka/SwordArtOffline
 - https://github.com/akechi-haruka/SAOACDETranslation
 - https://github.com/akechi-haruka/ZebraSpooler/
3. Create a folder called nvram.
4. Copy rominfo.xml into the notice folder.
5. Open a command prompt in the root directory as administrator (otherwise mklink will fail) and run the following to link the modloader configuration of all three "game" executables together (so you only have to modify keybindings in one of the "games":

    type NUL >> game\BepInEx\config\SwordArtOffline.cfg
    del notice\BepInEx\config\SwordArtOffline.cfg
    mklink /H notice\BepInEx\config\SwordArtOffline.cfg game\BepInEx\config\SwordArtOffline.cfg
    del testmode\BepInEx\config\SwordArtOffline.cfg
    mklink /H testmode\BepInEx\config\SwordArtOffline.cfg game\BepInEx\config\SwordArtOffline.cfg

6. Edit AMCUS\segatools.ini to change the server URL and the keychip ID. 
7. Edit AMCUS\AMConfig.ini and change the server URL (cacfg-auth_server_url) and the keychip ID (cacfg-game_board_id).
8. Run Launch.bat to start the game.
9. If the System Check screen starts honking at you with a camera error, press the test menu button (default: F2) to ignore and continue. (Do not do this on other errors)
10. Press F1 ingame to open the mod settings menu, and navigate under "SwordArtOffline" to set your keybindings, change your card ID and control other settings.
11. If you want to go into the test menu (disable close time, free play, check keybindings, etc) press the test menu button (default: F2). This will shut down the main game and launch the test menu "game".
