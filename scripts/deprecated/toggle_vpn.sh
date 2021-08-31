#!/bin/bash

# $1 - is a name of vpn connection to toggle on/off

STATUS=$(LC_ALL=eng nmcli -f Name,Type,State c | awk -v name=$1 '{if ($1==name && $2 == "vpn") if($3=="--") print "off"; else if ($3 == "activated") print "on";}')

if [[ "$STATUS" == "on" ]]; then
	nmcli con down $1
	notify-send --urgency=low "Сообщение авторизации VPN" "Соединение <b>VPN<b> успешно закрыто."
elif [[ "$STATUS" == "off" ]]; then
	nmcli con up $1
else
	notify-send "VPN toggler" "Unknown vpn status - can't turn on/off connection"
fi

