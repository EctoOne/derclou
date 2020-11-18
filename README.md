# Der Clou! - SDL Port
---

Original version by neo Software Produktions GmbH

Port by Vasco Alexandre da Silva Costa

- Copyright (c) 1993,1994 neo Software Produktions GmbH
- Copyright (c) 2005 Vasco Alexandre da Silva Costa
- Copyright (c) 2005 Thomas Trummer
- Copyright (c) 2005 Jens Granseuer

---

A burglary simulation game originally created by neo Software Produktions GmbH. See:

http://www.mobygames.com/game/clue

---

This is a compiled version from the code by [Vasco Alexandre da Silva Costa](https://github.com/vcosta/derclou).
It was build on a Raspberry 3B+
Note: For some reason the intro doesn't always plays.

Included is a script, which can completly install the game.
It will get the gamefiles from the ["Clou! Open Source Project"](https://sourceforge.net/projects/cosp/).

The script can install the Windows SDL port from the ["Clou! Open Source Project"](https://sourceforge.net/projects/cosp/).
Which can be used on a Raspberry Pi 4 with [Box86/Wine86](https://github.com/ptitSeb/box86).
Sadly, it crashes when a new game is started.

The script was made on Raspberry Pi OS and is only tested with that.
That means it uses the default `pi` user paths and therefore might not work
on other distros or with different user accounts.

The versions have not been fully testet yet, so it is possible that errors might appear.

Also the Windoes version is not as old as the linux version, so it might have less problems.
But running it through Wine86 might cause for other issues.
Also the menu entry for the Windows version needs the wine binary in a specific folder: `/home/pi/apps/Wine/bin/wine`
So if the shortcut doesn't start the game, make sure to check this path.

The Windows version also comes with the `cosp.cfg` file, which is used to set different options.
