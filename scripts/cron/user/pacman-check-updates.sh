#!/bin/bash

# this script runs daily after one from root (check cron/root/pacman-sync.sh)
# to check for outdated packages
# for my case cronjob:
# 30 21 * * * <full-path>/pacman-check-updates.sh

# this part takes DBUS_SESSION_BUS_ADDRESS to be able to send notifications
# check .profile to get more info on /tmp/.xdbus
if [ -r "/tmp/.xdbus" ]; then
  . "/tmp/.xdbus"
fi

dest=$HOME/.outdated-packages

pacman -Qqu > $dest
pacman -Qqm | awk '{print "AUR/"$0}' >> $dest
outdated=$(wc -l $dest | cut -f 1 -d " ")
notify-send "Pacman update checker" "Pacman update checker finished successfully\nThere is  $outdated  outdated packages"
