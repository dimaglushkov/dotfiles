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

	echo "$dotfiles/$dependencies"
	configs=$HOME/.config
	background=$HOME/Pictures/background
	repositories=$HOME/Repos
	browser=$(awk -v FS='#' '$2 ~ /--browser/ {print $1}' $dotfiles/$dependencies)
	editor=$(awk -v FS='#' '$2 ~ /--editor/ {print $1} ' $dotfiles/$dependencies)
	terminal=$(awk -v FS='#' '$2 ~ /--terminal/ {print $1}' $dotfiles/$dependencies)


	echo "> Setting next values at .profile:"
	echo ">> Important variables:"
	echo ">>> \$DOTFILES=$dotfiles"
	echo ">>> \$CONFIGS=$configs"
	echo ">> Optional variables (you can safely change this values):"
	echo ">>> \$BACKGROUND=$background"
	echo ">>> \$REPOSITORIES=$repositories"
	echo ">>> \$BROWSER=$browser"
	echo ">>> \$EDITOR=$editor"
	echo ">>> \$TERMINAL=$terminal"
	confirmation

	echo "> Creating .profile"
	echo -e "export DOTFILES=$dotfiles\nexport CONFIGS=$configs\n\nexport BACKGROUND=$background\nexport REPOSITORIES=$repositories\nexport BROWSER=$browser\nexport EDITOR=$editor\nexport TERMINAL=$terminal" > $dotfiles/.profile
	echo "> Successfully created $dotfiles/.profile"
}

function install_dependencies {
	echo "> Insatlling all needed dependencies..."
	echo ">> Looking for yay...."
	yay_installed=$(pacman -Qq yay)
	if [[ $yay_installed != "yay" ]]; then
		echo ">> Can't find yay installation"
		echo ">> Installing yay using pacman"
		sudo pacman -S yay
	else
		echo ">> Successfully found yay"
	fi
	
	echo "> Installing packages listed at dependencies.txt using"
	yay -S --needed $(awk -v FS="#" '{print $1}' $DOTFILES/depenedencies.txt)
}

generate_profile
source $dotfiles/.profile
install_dependencies
confirm
$dotfiles/update -sd
