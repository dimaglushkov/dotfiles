#!/bin/bash

apps_file=$DOTFILES/.apps
USAGE="Usage:\tadd_app.sh name [execution_path]\n\tIf execution_path is missing using name"

case $# in
    1)
        app_name=$1
        app_path=$1
    ;;

    2)
        app_name=$1
        app_path=$2
    ;;

    *)
        echo -e $USAGE
        exit 1;
    ;;
esac

app_full_path="$(which $app_path)"

if [ -x "$app_full_path" ] ; then
    echo -e "$app_name\t$app_full_path" >> $apps_file
    echo "Successfully added $app_name"
else
echo "Can't find $app_path. Maybe it's not in \$PATH or just doesn't exist"
    exit 1
fi


