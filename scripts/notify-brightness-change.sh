#!/bin/sh

brightness=$(xbacklight | cut -f1 -d".")
dunstify "Brightness:" -u low -h int:value:$brightness