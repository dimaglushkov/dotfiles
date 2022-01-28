#!/bin/sh
muted=$(pactl get-sink-mute @DEFAULT_SINK@ | awk '{if ($2 == "yes"){print "MUTE"}}')
if [ -n "$muted" ] 
then
	dunstify "Volume: Muted" -u low -h int:value:0
else
	volume=$(pactl get-sink-volume @DEFAULT_SINK@ | awk '{if($5 ~ /[0-9][0-9]%/){print $5}}' | tr -d "%")
    dunstify "Volume: " -u low -h int:value:$volume
fi