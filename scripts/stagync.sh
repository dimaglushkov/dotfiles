#!/bin/sh
read -p "Transfering $1 to stage:$2. Are you sure?" -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
	rsync -vrP --delete-after --exclude-from=$REPOSITORIES/iplus-backend/.rsyncignore $1 root@stage:$2
fi

