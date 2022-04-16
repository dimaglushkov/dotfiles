#!/bin/sh
VPNS=$(nmcli con | awk '{if ($3=="wireguard")print $1 "\t" $4 }')
echo -e "$VPNS"
VPN=$(echo -e "$VPNS" | awk '{if($2 != "--") status="&#xf00c;"; else status="&#xf00d;"; print status "\t" $1}'|  rofi -i -dmenu -p "Detected VPNs: " -theme sidebar -font "Noto Mono 14"  -markup-rows | awk '{print $2}')

if [[ $VPN != "" ]]; then
	CONNECTED_VPN=$(echo "$VPNS" | awk '{if($2 != "--") print $1}')
	toggler=$(which toggle_vpn.sh)
	if [[ $toggler == "" ]]; then
		notify-send "VPN manager" "toggle_vpn.sh script was not found"
		exit 1
	fi
	echo "$CONNECTED_VPN $VPN"
	if [[ $CONNECTED_VPN != $VPN && $CONNECTED_VPN != "" ]]; then
		$toggler $CONNECTED_VPN
	fi
	$toggler $VPN
fi

sleep 2
pkill -RTMIN+20 dwmblocks
