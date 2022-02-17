#!/bin/sh
country="RU"
ip_version="4"

curl -s "https://archlinux.org/mirrorlist/?country=$country&ip_version=$ip_version&protocol=http&protocol=https&use_mirror_status=on" | sed -e 's/^#Server/Server/' -e '/^#/d' > /tmp/mirrorlist

sudo /usr/bin/rankmirrors /tmp/mirrorlist > /tmp/mirrorlist_ranked
if [[ $? -eq 0 ]]; then
    sudo mv -f /tmp/mirrorlist_ranked /etc/pacman.d/mirrorlist
    notify-send "Mirror list was ranked and updated successfully"
else 
    sudo mv -f /tmp/mirrorlist /etc/pacman.d/mirrorlist
    notify-send "Mirror list was updated but was not ranked properly"
fi
