#!/bin/sh

dev_name="Touchpad"

dev_id=$(xinput --list | awk -v name="$dev_name" -F $'\t' '{if($1~name && ($1!~"Control" && $1!~"Keyboard")){for(i=1;i<NF;i++){if($i~"id="){print $i}}}}')
dev_id=$(echo "${dev_id#*=}")
xinput --set-prop $dev_id 'libinput Natural Scrolling Enabled' 1
xinput --set-prop $dev_id 'libinput Tapping Enabled' 1
