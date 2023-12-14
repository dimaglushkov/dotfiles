#!/bin/sh
read -p "Transfering $1 to msc:$2. Are you sure?" -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
	rsync -vrP --delete-after $1 msc:$2
fi

