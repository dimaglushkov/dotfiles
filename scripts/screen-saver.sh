#!/bin/bash

# Source: https://github.com/savoca/dotfiles/blob/gray/home/.bin/scripts/lock.sh

scrot /tmp/screen.png
convert /tmp/screen.png -scale 10% -scale 1000% /tmp/screen.png
[[ -f $1 ]] && convert /tmp/screen.png $1 -gravity center -composite -matte /tmp/screen.png
setxkbmap -layout us
i3lock -i /tmp/screen.png
setxkbmap -layout us,ru -option 'grp:alt_shift_toggle'
rm /tmp/screen.png

