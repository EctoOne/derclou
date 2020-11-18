#!/bin/bash

function option_1() {
	echo $'\n    	Installing required packages if needed...\n'
		sudo apt-get -qq update
		pkgList="git libsdl2-2.0-0"
		for pkgName in $pkgList; do
			dpkg -l | grep -qw $pkgName || sudo apt-get -y install $pkgName
		done
	echo $'\n    	...done\n'
	echo $'\n    	Downloading and extracting [Der Clou]...\n'
		cd ~
		mkdir -p apps
		cd apps/
		git clone -q https://github.com/EctoOne/derclou DerClou
		cd DerClou
		rm -rf .git/
		sudo chmod +x derclou
	echo $'\n    	...done\n'
}

function option_2() {
	echo $'\n    	Installing required packages if needed...\n'
		sudo apt-get -qq update
		pkgList="git libsdl2-2.0-0 libsdl2-dev"
		for pkgName in $pkgList; do
			dpkg -l | grep -qw $pkgName || sudo apt-get -y install $pkgName
		done
	echo $'\n    	...done\n'
	echo $'\n    	Downloading and compiling [Der Clou]...\n'
		cd ~
		mkdir -p apps
		cd apps/
		git clone -q https://github.com/vcosta/derclou DerClou
		cd DerClou
		make --ignore-errors --quiet
		rm -rf */
		rm -rf .git/
		rm -f indent.sh
		rm -f Makefile
		rm -f README.md
		rm -f replace.sh
		rm -f theclou.h
		wget -q https://github.com/EctoOne/derclou/raw/master/logo.png -O logo.png
	echo $'\n    	...done\n'
}

function option_3() {
	echo $'\n    	Installing required packages if needed...\n'
		sudo apt-get -qq update
		pkgList="git libsdl2-2.0-0"
		for pkgName in $pkgList; do
			dpkg -l | grep -qw $pkgName || sudo apt-get -y install $pkgName
		done
	echo $'\n    	...done\n'
	echo $'\n    	Downloading and extracting [Der Clou]...\n'
		cd ~
		mkdir -p apps
		cd apps/
		wget -q https://sourceforge.net/projects/cosp/files/Open%20SDL%20Port/0.7/cosp-0.7b-win32.zip -O Clou.zip
		unzip -o -qq Clou.zip -d DerClou
		rm -rf Clou.zip
		cd DerClou/
		wget -q https://github.com/EctoOne/derclou/raw/master/logo.png -O logo.png
	echo $'\n    	...done\n'
}

function option_4() {
	echo $'\n    	Select the language of the game:\n'
	echo "		1  -  English (No Voices)"
	echo "		2  -  English (German Voices)"
	echo "		3  -  German (No Voices)"
	echo "		4  -  German (German Voices)"
	echo -n $'\n  Enter selection: '
	read n
	case $n in
		1 ) clear ; getfiles ; wget -q https://sourceforge.net/projects/cosp/files/Original%20Game%20Files/The%20Clue%21%20%2B%20Profidisk%20%28English%29/TheClueProfiData.zip -O ClouData.zip ; datapack ;;
		2 ) clear ; getfiles ; wget -q https://sourceforge.net/projects/cosp/files/Open%20SDL%20Port/0.7/cosp-0.7-win32-std-english-%28with_german_voice%29.zip -O ClouFull.zip ; fullpack ;;
		3 ) clear ; getfiles ; wget -q https://sourceforge.net/projects/cosp/files/Original%20Game%20Files/Der%20Clou%21%20%2B%20Profidisk%20%28German%29/DerClouProfiData.zip -O ClouData.zip ; datapack ;;
		4 ) clear ; getfiles ; wget -q https://sourceforge.net/projects/cosp/files/Open%20SDL%20Port/0.7/cosp-0.7-win32-full-german.zip -O ClouFull.zip ; fullpack ;;
		* ) clear ; echo $'\n Invalid option! Try again.\n' ; enter ; option_3 ;;
	esac
}

function getfiles() {
	echo $'\n    	Downloading and installing Game files...\n'
	cd ~
	cd apps/
}

function datapack() {
	mkdir -p DerClou
	unzip -o -qq ClouData.zip -d DerClou
	rm -f ClouData.zip
}

function fullpack() {
	unzip -o -qq ClouFull.zip
	mkdir -p DerClou
	cp -fr cosp-0.7-win32*/* DerClou
	rm -f ClouFull.zip
	rm -fr cosp-0.7-win32*
	cd DerClou
	rm -fr cosp-0.7.txt
	rm -fr cosp-0.7-win32.exe
}

function option_5() {
	echo $'\n    	Creating menu entry...\n'
		if [ -f "/home/pi/.local/share/applications/derclou.desktop" ];
		then
			rm -fr /home/pi/.local/share/applications/derclou.desktop
		fi
		shortcut="/home/pi/.local/share/applications/derclou.desktop"
		echo "[Desktop Entry]" > $shortcut
		echo "Name=Der Clou!" >> $shortcut
		echo "Comment=A Heist Simulation/Adventure game" >> $shortcut
		echo "Icon=/home/$(whoami)/apps/DerClou/logo.png" >> $shortcut
		if [ -f "/home/pi/apps/DerClou/cosp-0.7b-win32.exe" ];
		then
			echo "Exec=/home/pi/apps/wine/bin/wine /home/pi/apps/DerClou/cosp-0.7b-win32.exe" >> $shortcut
		else
			echo "Exec=/home/$(whoami)/apps/DerClou/derclou -g2" >> $shortcut
		fi
		echo "Path=/home/$(whoami)/apps/DerClou" >> $shortcut
		echo "Type=Application" >> $shortcut
		echo "Encoding=UTF-8" >> $shortcut
		echo "Terminal=false" >> $shortcut
		echo "Categories=AdventureGame;Game;" >> $shortcut
		#chmod 755 $shortcut
		while true; do
			read -p "    	Do you want shortcut on the desktop? [Y]es/[N]o: " yn
			case $yn in
			[Yy]* )
				echo $'\n    	Adding Desktop shortcut...\n' ;
				cp -f ~/.local/share/applications/derclou.desktop ~/Desktop/derclou.desktop ;
				break ;;
			[Nn]* )
				echo $'\n    	Desktop shortcut skipped\n' ;
				break ;;
			* ) echo "Please answer yes or no.";;
		esac
		done
	echo $'\n    	...done\n'
}

function option_6() {
	cd /home/pi/apps/DerClou/
	if [ -f "cosp-0.7b.txt" ];
	then
	   xdg-open cosp-0.7b.txt
	else
	   xdg-open README
	fi
}

function enter() {
	echo -n $'\n    	Press Enter to continue '
	read
	clear
}

until [ "$selection" = "0" ]; do
	clear
	echo $'\n    	[Der Clou / The Clue] Installer'
	echo $'    	-------------------------------\n'
	echo "		1  -  Download binary (Quick)"
	echo "		2  -  Compile binary (Slow)"
	echo "		3  -  Download binary (Wine86)"
	echo "		4  -  Select language"
	echo "		5  -  Create Menu entry"
	echo "		6  -  Show README"
	echo "		0  -  Exit"
	echo -n $'\n  Enter selection: '
	read selection
	echo ""
	case $selection in
		1 ) clear ; option_1 ; enter ;;
		2 ) clear ; option_2 ; enter ;;
		3 ) clear ; option_3 ; enter ;;
		4 ) clear ; option_4 ; enter ;;
		5 ) clear ; option_5 ; enter ;;
		6 ) clear ; option_6 ;;
		0 ) clear ; exit ;;
		* ) clear ; echo $'\n Invalid option! Try again.\n' ; enter ;;
	esac
done


