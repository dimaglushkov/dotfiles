#!/bin/sh
CHOSEN=$(cat $HOME/.apps | awk '{print $1}' | rofi -dmenu -i -p "Launch an app: " -theme sidebar -font "Noto Mono 14")
eval "$(cat $HOME/.apps | awk -v app=$CHOSEN '$1==app{$1=""; print $0, "&"}')"
