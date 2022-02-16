#!/bin/sh
if [[ -f $CONFIGS/.apps ]]; then
    apps_file=$CONFIGS/.apps
elif [[ -f $HOME/.apps ]]; then
    apps_file=$HOME/.apps
fi

CHOSEN=$(cat $apps_file | awk '{print $1}' | rofi -dmenu -i -p "Launch an app: " -theme sidebar -font "Noto Mono 14")
eval "$(cat $apps_file | awk -v app=$CHOSEN '$1==app{$1=""; print $0, "&"}')"
