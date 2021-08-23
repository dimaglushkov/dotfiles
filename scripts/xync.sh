#!/bin/sh

read -p "Transfering $1 to xyz:$2. Are you sure?" -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
	if [[ $2 =~ ^(\/var\/www\/main|\/var\/www\/sort)$ ]];  then
		rsync -vrP --delete-after --exclude-from=$REPOSITORIES/dimaglushkov.xyz/.rsyncignore $1 root@xyz:$2
	else
		rsync -vrP --delete-after $1 root@xyz:$2
	fi
fi

