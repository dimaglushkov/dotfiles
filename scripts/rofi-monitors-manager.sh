#!/bin/bash

OPT=("   &#xf26c;\tHDMI" "   &#xf109;\tLAPTOP" "  &#xf26c;&#xf109;\tHDMI-LAPTOP" "  &#xf109;&#xf26c;\tLAPTOP-HDMI" " &#xf26c;←&#xf109;\tDUPLICATE LAPTOP")

CHOSEN=$(echo -e "${OPT[0]}\n${OPT[1]}\n${OPT[4]}\n${OPT[2]}\n${OPT[3]}" | rofi -dmenu -i -p "Choose layout: " -theme sidebar -font "Noto Mono 14" -markup-rows)
CHOSEN=${CHOSEN//	/$'\\t'}

BUILTIN_OUTPUT="eDP1"
HDMI_OUTPUT="HDMI-0"

case "$CHOSEN" in
    "${OPT[0]}" )
        xrandr --output $BUILTIN_OUTPUT --off --output $HDMI_OUTPUT --primary --mode 1920x1080 --pos 0x0 --rotate normal -r 165
        sed -i '/  size: 9/c\  size: 13' $CONFIGS/alacritty/alacritty.yml
    ;;

    "${OPT[1]}" )
        xrandr --output $HDMI_OUTPUT --off --output $BUILTIN_OUTPUT --primary --mode 1920x1080 --pos 0x0 --rotate normal -r 240
        sed -i '/  size: 13/c\  size: 9' $CONFIGS/alacritty/alacritty.yml
        xsetroot -name "fsignal:3"
    ;;

    "${OPT[2]}" )
        xrandr --output $HDMI_OUTPUT --primary --mode 1920x1080 --pos 0x0 --rotate normal -r 165 --output $BUILTIN_OUTPUT --primary --mode 1920x1080 --pos 1920x0 --rotate normal -r 240
        sed -i '/  size: 9/c\  size: 13' $CONFIGS/alacritty/alacritty.yml
    ;;

    "${OPT[3]}" )
        xrandr --output $BUILTIN_OUTPUT --primary --mode 1920x1080 --pos 0x0 --rotate normal -r 240 --output $HDMI_OUTPUT --primary --mode 1920x1080 --pos 1920x0 --rotate normal -r 165
        sed -i '/  size: 9/c\  size: 13' $CONFIGS/alacritty/alacritty.yml
    ;;

    "${OPT[4]}" )
        xrandr --output $HDMI_OUTPUT --primary --mode 1920x1080 --pos 0x0 --rotate normal -r 165 --output $BUILTIN_OUTPUT --primary --mode 1920x1080 --pos 0x0 --rotate normal -r 240
        sed -i '/  size: 9/c\  size: 13' $CONFIGS/alacritty/alacritty.yml
    ;;

esac
