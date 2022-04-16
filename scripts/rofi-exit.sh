#!/bin/sh
CHOSEN=$(echo -e " &#xf137; Logout\n &#xf011; Poweroff\n &#xf0e2; Reboot\n &#xf023; Lock\n &#xf017; Suspend" |  rofi -dmenu -i -p "Exit menu " -theme sidebar -font "Noto Mono 14" -markup-rows)
case "$CHOSEN" in
	" &#xf137; Logout" )
		killall dwm
		i3-msg exit
	;;

	" &#xf011; Poweroff" )
		/usr/bin/systemctl poweroff
	;;

	" &#xf0e2; Reboot" )
		/usr/bin/systemctl reboot
	;;

	" &#xf023; Lock" )
		screen-saver.sh
	;;

	" &#xf017; Suspend" )
screen-saver.sh ; /usr/bin/systemctl suspend
	;;

esac
