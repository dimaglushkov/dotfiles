#!/bin/bash

# $1 - is a name of vpn connection to toggle on/off
STATUS=$(LC_ALL=eng nmcli -f Name,Type,State c | awk -v name=$1 '{if ($1==name && ($2 == "vpn" || $2 == "wireguard")) if($3=="--") print "off"; else if ($3 == "activated") print "on";}')

if [[ "$STATUS" == "on" ]]; then
	nmcli con down $1
	notify-send "VPN Connection" "Successfully disconnected from $1 VPN connection"
elif [[ "$STATUS" == "off" ]]; then
	nmcli con up $1
	notify-send "VPN Connection" "Successfully connected to $1 VPN connection"
else
	notify-send "VPN toggler" "Unknown vpn status - can't turn on/off connection"
fi

pkill -RTMIN+20 dwmblocks

