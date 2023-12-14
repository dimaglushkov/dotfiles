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
	cache=$HOME/.cache
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
	echo -n "export DOTFILES=$dotfiles
export CONFIGS=$configs
export CACHE=$cache

export XDG_CONFIG_HOME=$configs
export XDG_CACHE_HOME=$cache
export XDG_DATA_HOME=$HOME/.local/share
export XDG_STATE_HOME=$HOME/.local/state

export BACKGROUND=$background
export SCREENSHOTS=$screenshots
export REPOSITORIES=$repositories
export BROWSER=$browser
export EDITOR=$editor
export TERMINAL=$terminal
export VIMINIT=\"source $configs/vim/.vimrc\""	> $dotfiles/.profile
	
	echo "> Successfully created $dotfiles/.profile"

	mkdir -p $background
	mkdir -p $screenshots
}

function configure_display_manager {
	echo "> Configuring display manager"
	cd $repositories
	git clone https://github.com/allacee/lightdm-webkit2-theme-minimal.git
	sudo mkdir -p /usr/share/lightdm-webkit/themes/minimal
	sudo cp -r lightdm-webkit2-theme-minimal/ /usr/share/lightdm-webkit/themes/minimal
	sudo cp xsessions/dwm.desktop /usr/share/xsessions/dwm.desktop
	sudo awk -i inplace -v FS="=" '{if($1 ~/#greeter-session/){"greeter-session = lightdm-webkit2-greeter" } else {print $0}}' /etc/lightdm/lightdm.conf
	sudo awk -i inplace -v FS="=" '{if($1 ~/webkit_theme/){print $1, "= minimal" } else {print $0}}' /etc/lightdm/lightdm-webkit2-greeter.conf
	systemctl enable lightdm --force

	cd $dotfiles
}

function install_dependencies {
	echo "> Insatlling all needed dependencies"
	echo ">> Syncing repositories"
	sudo pacman -Sy
	echo ">> Looking for yay"
	yay_installed=$(pacman -Qq yay)
	if [[ $yay_installed = "" ]]; then
		echo ">> Can't find yay installation"
		echo ">> Installing yay"
		cd /opt/
		sudo pacman -S base-devel git
		sudo git clone https://aur.archlinux.org/yay-git.git
		cd yay-git/
		sudo chown -R $USER:$USER .
		makepkg -si
	else
		echo ">> Successfully found yay"
	fi

	echo "> Installing packages listed at dependencies.txt using"
	yay -S --needed $(awk -v FS="#" '{if (length($1) != 0) {print $1}}' $dotfiles/$dependencies)
	if [ $? -eq 0 ]; then
		echo "> Successfully installed depenedencies"
	else
		echo "> ERROR: Something went wrong while dependencies installation, exiting"
		exit 1
	fi
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

function postprocess {
	echo "> Postprocessing"

	echo ">> Checking for existing picom conf"
	if [[ -f "$configs/picom.conf" ]]; then
		">> Moving existing picom.conf"
		mkdir $configs/picom
		mv $configs/picom.conf $configs/picom/picom.conf
	fi
	echo ">> Disabling keylock indicator notifications"
	dconf write /apps/indicators/keylock/notifications false
}

generate_profile
source $dotfiles/.profile
read -p "> Install dependencies (skip if dependencies are already installed)? [y/n]: " -n 1 -r
echo ""
if [[ $REPLY = "y" || $REPLY = "Y" ]]
then
	install_dependencies
	install_fonts
	install_sounds
else
	echo ">> Skipping dependencies installation"
	exit 1
fi
configure_display_manager
postprocess

echo "> Replacing existing configs..."
confirmation
mkdir -p $HOME/.local/bin
$dotfiles/scripts/set_background.sh $dotfiles/assets/backgrounds/manjaro-2.jpg
$dotfiles/scripts/update_dotfiles.sh -sd
