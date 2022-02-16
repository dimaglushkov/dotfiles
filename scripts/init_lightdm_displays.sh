#!/bin/sh
# makes lighdtm visible on every availiable screen
# copy this script to /usr/bin
# set as lightdm start script at /etc/lightdm/lightdm.conf -> display-setup-script=/usr/bin/init_lightdm_displays.sh
avail_outputs=($(xrandr -q | grep " connected" | cut -d " " -f1))
for i in "${avail_outputs[@]}"
do
   xrandr --output $i --mode 1920x1080 --pos 0x0 --rotate normal 
done