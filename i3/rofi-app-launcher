#!/bin/sh
CHOSEN=$(cat $HOME/.apps | awk '{print $1}' | $CONFIGS/i3/rofi-menu -h "Launch an app" -f 15 -w 45 -l 23)
eval "$(cat $HOME/.apps | awk -v app=$CHOSEN '$1==app{$1=""; print $0, "&"}')"
