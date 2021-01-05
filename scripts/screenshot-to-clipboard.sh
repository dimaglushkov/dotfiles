#!/bin/sh
temp=$(ls -1trR $SCREENSHOTS/*/*.png | tail -n 1) \
	&& /usr/bin/xclip -selection clipboard -target image/png -i $temp ;
