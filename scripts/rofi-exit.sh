#!/bin/sh
CHOSEN=$($CONFIGS/i3/rofi-menu -t " &#xf137; Logout\n &#xf011; Poweroff\n &#xf0e2; Reboot\n &#xf023; Lock\n &#xf017; Suspend" -f 14 -w 22 -l 5 -h "Exit menu")
case "$CHOSEN" in
	" &#xf137; Logout" )
		i3-msg exit
		killall dwm
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
		/usr/bin/systemctl suspend
	;;

esac
