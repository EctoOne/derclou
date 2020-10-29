#!/bin/bash

function complete() {
	echo ""
	echo "Installation done."
	echo "Look at the ReadMe file for the controls"
	exit
}

function desktop() {
	while true; do
		echo ""
		read -p "Do you want shortcut on the desktop? [Y]es/[N]o: " yn
		case $yn in
		[Yy]* )
			echo ""
			echo "Adding Desktop shortcut..."
			cp -f ~/.local/share/applications/derclou.desktop ~/Desktop/derclou.desktop
			complete;;
		[Nn]* )
			echo ""
			echo "Desktop shortcut skipped";
			complete;;
		* ) echo "Please answer yes or no.";;
	esac
	done
}

function launcher() {
	echo ""
	echo "Creating menu entry..."
	mkdir -p ~/.local/share/applications
	echo "[Desktop Entry]
	Name=Der Clou!
	Comment=A Heist Simulation/Adventure game
	Exec=/home/$(whoami)/DerClou/derclou -g2
	Path=/home/$(whoami)/DerClou
	Icon=/home/$(whoami)/DerClou/logo.png
	Terminal=false
	Type=Application
	Categories=AdventureGame;Game;" > ~/.local/share/applications/derclou.desktop
	desktop
}

function datapack() {
	unzip -o -qq ClouData.zip -d DerClou
	rm -f ClouData.zip
	launcher
}

function fullpack() {
	unzip -o -qq ClouFull.zip
	mv cosp-0.7-win32*/* DerClou
	rm -f ClouFull.zip
	rm -fr cosp-0.7-win32*
	launcher
}

function getfiles() {
	echo ""
	echo "Downloading and installing Game files..."
	cd ~
}

function langENG() {
	getfiles
	wget -q https://sourceforge.net/projects/cosp/files/Original%20Game%20Files/The%20Clue%21%20%2B%20Profidisk%20%28English%29/TheClueProfiData.zip -O ClouData.zip
	datapack
}

function langGER() {
	getfiles
	wget -q https://sourceforge.net/projects/cosp/files/Original%20Game%20Files/Der%20Clou%21%20%2B%20Profidisk%20%28German%29/DerClouProfiData.zip -O ClouData.zip
	datapack
}

function langENGvoice() {
	getfiles
	wget -q https://sourceforge.net/projects/cosp/files/Open%20SDL%20Port/0.7/cosp-0.7-win32-std-english-%28with_german_voice%29.zip -O ClouFull.zip
	fullpack
}

function langGERvoice() {
	getfiles
	wget -q https://sourceforge.net/projects/cosp/files/Open%20SDL%20Port/0.7/cosp-0.7-win32-full-german.zip -O ClouFull.zip
	fullpack
}

function languagemenu() {
	clear
	echo ""
	echo "Select the language of the game:"
	echo "  1) English (No Voices)"
	echo "  2) English (German Voices)"
	echo "  3) German (No Voices)"
	echo "  4) German (German Voices)" 
	read n
	case $n in
		1) langENG;;
		2) langENGvoice;;
		3) langGER;;
		4) langGERvoice;;
		*) echo "invalid option";;
	esac
}

function getbin() {
	echo ""
	echo "Downloading the binary..."
	cd ~
	git clone -q https://github.com/EctoOne/derclou DerClou
	cd DerClou
	rm -rf ~/DerClou/.git
	sudo chmod +x derclou
	languagemenu
}

function buildbin() {
	echo ""
	echo "Downloading and compiling the binary... (Ignore the messages)"
	cd ~
	git clone -q https://github.com/vcosta/derclou DerClou
	cd DerClou
	make --ignore-errors --quiet
	rm -rf ~/DerClou/*/
	rm -rf ~/DerClou/.git
	rm -f ~/DerClou/indent.sh
	rm -f ~/DerClou/Makefile
	rm -f ~/DerClou/README.md
	rm -f ~/DerClou/replace.sh
	rm -f ~/DerClou/theclou.h
	wget -q https://github.com/EctoOne/derclou/raw/master/logo.png -O logo.png
	languagemenu
}

function nosdl2dev() {
	echo ""
	echo "It's possible to compile the game from scource."
	echo "But it is slower and requires the libsdl2-dev package."
	read -p "Do you want to install libsdl-dev and compile the game from source? [Y]es/[N]o: " yn
	case $yn in
	[Yy]* )
		echo ""
		echo "Installing libsdl2-dev... please wait"
		sudo apt-get -qq install libsdl2-dev > /dev/null;
		buildbin;;
	[Nn]* )
		getbin;;
	* ) echo "Please answer yes or no.";;
	esac
}

function checksdldev() {
	dpkg -s libsdl2-dev &> /dev/null
	if [ $? -eq 0 ]; then
		echo ""
		while true; do
			read -p "Do you want to compile the game from source? (slower) [Y]es/[N]o: " yn
			case $yn in
			[Yy]* )
				buildbin;;
			[Nn]* )
				getbin;;
			* ) echo "Please answer yes or no.";;
		esac
		done
	else
		nosdl2dev
	fi
}

function checkgit() {
	dpkg -s git &> /dev/null
	if [ $? -eq 0 ]; then
		echo -ne ""
	else
		echo ""
		echo "The installation requires GIT!"
		while true; do
			read -p "Do you want to install it now? [Y]es/[N]o: " yn
			case $yn in
			[Yy]* )
				echo ""
				echo "Installing... please wait"
				echo ""
				sudo apt-get -qq install git > /dev/null;
				echo ""
				echo "Installation done...";
				checksdldev;;
			[Nn]* )
				echo ""
				echo "GIT (git) NOT installed!";
				echo ""
				echo "Installation aborted!";
				exit;;
			* ) echo "Please answer yes or no.";;
		esac
		done
	fi
}

function checksdl2() {
	dpkg -s libsdl2-2.0-0 &> /dev/null
	if [ $? -eq 0 ]; then
		echo -ne ""
	else
		echo ""
		echo "The game requires SDL2!"
		while true; do
			read -p "Do you want to install it now? [Y]es/[N]o: " yn
			case $yn in
			[Yy]* )
				echo ""
				echo "Installing... please wait"
				echo ""
				sudo apt-get -qq install libsdl2-2.0-0 > /dev/null;
				echo ""
				echo "Installation done...";
				break;;
			[Nn]* )
				echo ""
				echo "SDL2 (libsdl2-2.0-0) NOT installed!";
				break;;
			* ) echo "Please answer yes or no.";;
		esac
		done
	fi
}


function install() {
	clear
	echo ""
	echo "Welcome to the 'Der Clou! / The Clou!' installer."
	checksdl2
	checkgit
	checksdldev
	languagemenu
}

install

