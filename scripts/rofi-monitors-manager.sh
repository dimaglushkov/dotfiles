#!/bin/bash

OPT=("   &#xf26c;\tHDMI" "   &#xf109;\tLAPTOP" "  &#xf26c;&#xf109;\tHDMI-LAPTOP" "  &#xf109;&#xf26c;\tLAPTOP-HDMI" " &#xf26c;←&#xf109;\tDUPLICATE LAPTOP")
CHOSEN=$(echo -e "${OPT[1]}\n${OPT[0]}\n${OPT[2]}\n${OPT[3]}\n${OPT[4]}" | rofi -dmenu -i -p "Choose layout: " -theme sidebar -font "Noto Mono 14" -markup-rows)


CHOSEN=${CHOSEN//	/$'\\t'}

case "$CHOSEN" in
    "${OPT[0]}" )
        $CONFIGS/screen-layouts/hdmi.sh
    ;;

    "${OPT[1]}" )
        $CONFIGS/screen-layouts/laptop.sh
    ;;

    "${OPT[2]}" )
        $CONFIGS/screen-layouts/hdmi-laptop.sh
    ;;

    "${OPT[3]}" )
        $CONFIGS/screen-layouts/laptop-hdmi.sh
    ;;

    "${OPT[4]}" )
        $CONFIGS/screen-layouts/duplicate-laptop.sh
    ;;


esac
