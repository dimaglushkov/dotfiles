#!/bin/bash

# this script runs daily from root's cron to sync pacman repositories
# for my case cronjob:
# 0 21 * * * /root/.bin/pacman-sync.sh

# this part takes DBUS_SESSION_BUS_ADDRESS to be able to send notifications
# check .profile to get more info on /tmp/.xdbus
if [ -r "/tmp/.xdbus" ]; then
  . "/tmp/.xdbus"
fi

pacman -Sy
su <username> -c 'notify-send "Pacman upgrade" "Repositories synchronized successfully"'
