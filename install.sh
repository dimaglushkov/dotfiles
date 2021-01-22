#!/bin/bash

dependencies="dependencies.txt"

function confirmation {
	read -p "> Are you sure? [y/n]: " -n 1 -r
	echo ""
	if [[ $REPLY != "y" && $REPLY != "Y" ]]
	then
		echo "> [WARN] Installation was canceled by user"
		exit 1
	fi
}

function generate_profile {
	echo "> Generating .profile file"
	dotfiles="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
	cur_dir_name=${dotfiles##*/}
	if [[ $cur_dir_name != "dotfiles"  ]]; then
		echo "> [ERROR] Installation script is launched from unknown context"
		exit 1
	fi

	configs=$HOME/.config
	background=$HOME/Pictures/background
	screenshots=$HOME/Pictures/screenshots
	repositories=$(cd $dotfiles/.. ; pwd)
	browser=$(awk -v FS='#' '$2 ~ /--browser/ {print $1}' $dotfiles/$dependencies)
	editor=vim
	terminal=$(awk -v FS='#' '$2 ~ /--terminal/ {print $1}' $dotfiles/$dependencies)

	echo "> Setting next values at .profile:"
	echo ">> Important variables:"
	echo ">>> \$DOTFILES=$dotfiles"
	echo ">>> \$CONFIGS=$configs"
	echo ">> Optional variables (you can safely change this values):"
	echo ">>> \$BACKGROUND=$background"
	echo ">>> \$SCREENSHOTS=$screenshots"
	echo ">>> \$REPOSITORIES=$repositories"
	echo ">>> \$BROWSER=$browser"
	echo ">>> \$EDITOR=$editor"
	echo ">>> \$TERMINAL=$terminal"
	confirmation

	echo "> Creating .profile"
	echo -e "export DOTFILES=$dotfiles\nexport CONFIGS=$configs\n\nexport BACKGROUND=$background\nexport SCREENSHOTS=$screenshots\nexport REPOSITORIES=$repositories\nexport BROWSER=$browser\nexport EDITOR=$editor\nexport TERMINAL=$terminal" > $dotfiles/.profile
	echo "> Successfully created $dotfiles/.profile"

	mkdir -p $background
	mkdir -p $screenshots
}

function configure_display_manager {
	echo "> Configuring display manager"
	cd $repositories
	git clone https://github.com/allacee/lightdm-webkit2-theme-minimal.git
	sudo cp -r lightdm-webkit2-theme-minimal/ /usr/share/lightdm-webkit/themes/minimal
	sudo awk -i inplace -v FS="=" '{if($1 ~/#greeter-session/){print $1, "= lightdm-webkit2-greeter" } else {print $0}}' /etc/lightdm/lightdm.conf
	sudo awk -i inplace -v FS="=" '{if($1 ~/webkit_theme/){print $1, "= minimal" } else {print $0}}' /etc/lightdm/lightdm-webkit2-greeter.conf
	systemctl enable lightdm --force 
	
	cd $dotfiles
}

function install_dependencies {
	echo "> Insatlling all needed dependencies"
	echo ">> Looking for yay"
	yay_installed=$(pacman -Qq yay)
	if [[ $yay_installed != "yay" ]]; then
		echo ">> Can't find yay installation"
		echo ">> Installing yay using pacman"
		sudo pacman -Sy
		sudo pacman -S base-devel yay
	else
		echo ">> Successfully found yay"
	fi
	
	echo "> Installing packages listed at dependencies.txt using"
	yay -S --needed $(awk -v FS="#" '{print $1}' $dotfiles/$dependencies)
}

function install_fonts {
	echo "> Installing fonts"
	fonts=($(ls $dotfiles/assets/fonts/*.ttf))
	for font in $fonts
	do
		makefontpkg --install $font
	done
	cd $cur_dir
	echo "> Successfully installed fonts: $fonts"
}

function install_sounds {
	echo "> Installing sounds"
	mkdir -p $HOME/Music/Notifications
	cp $dotfiles/assets/sounds/screenshot-notification/screenshot-notification.mp3 $HOME/Music/Notifications
	echo "> Successfully installed screenshot-notification sound"
}

generate_profile
source $dotfiles/.profile
install_dependencies
install_fonts
install_sounds
configure_display_manager

echo "> Replacing existing configs..."
confirmation
$dotfiles/scripts/set_background.sh $dotfiles/assets/backgrounds/manjaro-2.jpg
$dotfiles/scripts/update_dotfiles.sh -sd