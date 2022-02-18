#!/bin/sh
name="$(echo 'screen-')$(date +%H:%M:%S)$(echo '.png')"
if [ "$1" == "-s" ]; then
	scrot $name -s -f -q 100 -e "mkdir -p $SCREENSHOTS/%Y-%m-%d ; mv \$f $SCREENSHOTS/%Y-%m-%d/"
else
	scrot $name -q 100 -e "mkdir -p $SCREENSHOTS/%Y-%m-%d ; mv \$f $SCREENSHOTS/%Y-%m-%d/"
fi
