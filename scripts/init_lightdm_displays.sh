#!/bin/sh
# makes lighdtm visible on every availiable screen
# set as lightdm start script at /etc/lightdm/lightdm.conf -> display-setup-script 
avail_outputs=($(xrandr -q | grep " connected" | cut -d " " -f1))
for i in "${avail_outputs[@]}"
do
   xrandr --output $i --mode 1920x1080 --pos 0x0 --rotate normal 
done