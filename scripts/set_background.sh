#!/bin/bash

USAGE="Usage:\tset_background.sh img"

case $# in
    1)
        img_path=$1
    ;;

    *)
        echo -e $USAGE
        exit 1;
    ;;
esac

if [[ ! -f "$img_path" ]]; then
    echo "Error: file $img_path doesn't exist"
    exit 1
fi

if [[ "$img_path" != *.jpg && "$img_path" != *.png ]]; then
    echo "Error: provided file isn't jpeg/png extension"
    exit 1
fi

mkdir -p $BACKGROUND

prev_img=$BACKGROUND/$(ls $BACKGROUND)
rm $prev_img
cp $img_path $BACKGROUND
feh --bg-fill $BACKGROUND
mv $HOME/.fehbg $HOME/.local/bin
