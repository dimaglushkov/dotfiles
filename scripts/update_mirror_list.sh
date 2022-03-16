#!/bin/sh

ARGS=1
ip_version="4"

if [[ $# -ne "$ARGS" ]]; then
  echo "Usage: update_mirror_list.sh <country code>"
  exit 1
fi

country=$1

curl -s "https://archlinux.org/mirrorlist/?country=$country&ip_version=$ip_version&protocol=http&protocol=https&use_mirror_status=on" | sed -e 's/^#Server/Server/' -e '/^#/d' > /tmp/mirrorlist

first_line="$(head -1 /tmp/mirrorlist)"

if [[ "$first_line" == *"<!DOCTYPE html>"* ]]; then 
    notify-send "Can not find mirrors for the $country"
    exit 1
fi

sudo /usr/bin/rankmirrors /tmp/mirrorlist > /tmp/mirrorlist_ranked
if [[ $? -eq 0 ]]; then
    sudo mv -f /tmp/mirrorlist_ranked /etc/pacman.d/mirrorlist
    notify-send "Mirror list was ranked and updated successfully"
else 
    sudo mv -f /tmp/mirrorlist /etc/pacman.d/mirrorlist
    notify-send "Mirror list was updated but was not ranked properly"
fi

cat /etc/pacman.d/mirrorlist