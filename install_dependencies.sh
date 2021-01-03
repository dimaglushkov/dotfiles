#!/bin/zsh
echo "> Insatlling all needed dependencies..."
echo ">> Looking for yay...."
yay_location=$(which yay)
if [[ $yay_location =~ "not found" ]]; then
	echo ">> Can't find yay installation"
	echo ">> Installing yay using pacman"
	sudo pacman -S yay
else
	echo ">> Successfully found yay at $yay_location"
fi

echo "> Installing packages listed at dependencies.txt using"
yay -S --needed $(awk -v FS="#" '{print $1}' $DOTFILES/depenedencies.txt)
