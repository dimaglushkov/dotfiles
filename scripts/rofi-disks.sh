#!/bin/sh
WIDTH=50
LINES=10
FONT=15
DISK=$(udisksctl status | rev | awk '{name=$1; $1=$2=$3=""; print $0 " |\t" name " 🖴" }' | rev | tail -n +3 |  rofi -i -dmenu -p "Detected disks: " -theme sidebar -font "Noto Mono 14"  -markup-rows | awk '{print $2}')

if [[ $DISK != "" ]]; then
	PART=$(lsblk -rpo "name,type,size,mountpoint" \
		| awk -v disk=$DISK '{if($4!="")status="&#xf00c;"; else status="&#xf00d;"; if($1~disk&&$2=="part"){print status,  $1 " | " $3,  $4}}' \
		| rofi -dmenu -i -p "Detected parts: " -theme sidebar -font "Noto Mono 14" -markup-rows | awk '{print $1, $2}')


	NAME=$(echo $PART | cut -c 10-)

	if [[ $NAME == "" ]]; then
		exit 0
	fi

	if [[ $(echo $PART | cut -c -8) == "&#xf00d;" ]]; then
		udisksctl mount -b $NAME && $TERMINAL -e ranger /run/media/$USER
	else
		udisksctl unmount -b $NAME
	fi
fi
