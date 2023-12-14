#!/bin/sh

sens=-0.65
dev_name="HyperX"

dev_id=$(xinput --list | awk -v name="$dev_name" -F $'\t' '{if($1~name && ($1!~"Control" && $1!~"Keyboard")){for(i=1;i<NF;i++){if($i~"id="){print $i}}}}')
dev_id=$(echo "${dev_id#*=}")
xinput --set-prop $dev_id 'libinput Accel Speed' $sens
