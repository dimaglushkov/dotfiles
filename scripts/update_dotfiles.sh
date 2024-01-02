#!/bin/sh

if [[ $DOTFILES == '' ]]; then
	echo '[ERROR] Set $DOTFILES to downloaded/cloned config directory path'
	exit 1
fi

cd $DOTFILES
EXISTING_CONFIGS=$(ls -d */ | tr -d / | grep -v 'scripts\|assets\|etc')
EXISTING_DOTFILES=$(ls -d .* | grep -v '\.$\|\.git')
EXISTING_SCRIPTS=$(ls -p scripts | grep -v '/')

TO_UPDATE=""
SAVE_PATH=""
DOTFILES_PATH=$CONFIGS
CONFIGS_PATH=$CONFIGS
SCRIPTS_PATH=$HOME/.local/bin

save_before_update()
{
	echo -e "[INFO] Saving existing:\n$TO_UPDATE \nto $SAVE_PATH"

	WARNINGS=0
	COPIES=0
	mkdir -p $SAVE_PATH
	for i in ${TO_UPDATE}; do
		echo "[INFO] Saving $i"

		if [[ $EXISTING_CONFIGS == *$i*  ]]; then
			if [[ -d $CONFIGS_PATH/$i ]]; then
				 cp -r $CONFIGS_PATH/$i $SAVE_PATH/$i
			else
				echo "[WARNING] $CONFIGS_PATH/$i does not exist"
				((WARNINGS++))
			fi
		elif [[ $EXISTING_DOTFILES == *$i* ]]; then
			if [[ -f $DOTFILES_PATH/$i ]]; then
				cp $DOTFILES_PATH/$i $SAVE_PATH/$i
			else
				echo "[WARNING] $DOTFILES_PATH/$i does not exist"
				((WARNINGS++))
			fi
		else
			if [[ -f $SCRIPTS_PATH/$i ]]; then
				cp $SCRIPTS_PATH/$i $SAVE_PATH/$i
			else
				echo "[WARNING] $SCRIPTS_PATH/$i does not exist"
				((WARNINGS++))
			fi

		fi
		((COPIES++))
	done

	echo -e "[INFO] Saving finished with $WARNINGS/$COPIES warnings"
}

replace()
{
	echo "[INFO] Replacing existing files"

	COPIES=0
	for i in ${TO_UPDATE}; do
		if [[ $EXISTING_CONFIGS == *$i*  ]]; then
			rm -rf $CONFIGS_PATH/$i
			cp -r ./$i $CONFIGS_PATH/$i
		elif [[ $EXISTING_DOTFILES == *$i* ]]; then
			rm -f $DOTFILES_PATH/$i
			cp ./$i $DOTFILES_PATH/$i
		else
			rm -f $SCRIPTS_PATH/$i
			cp scripts/$i $SCRIPTS_PATH/$i
		fi
		((COPIES++))
	done
	echo "[INFO] $COPIES dotfiles/configs moved"
}

set_rcconf_values()
{
	echo "[INFO] Replacing $'s with actual values in rc.conf"
	sed -ie "s+\$DOTFILES+$DOTFILES+g" $CONFIGS/ranger/rc.conf
	sed -ie "s+\$REPOSITORIES+$REPOSITORIES+g" $CONFIGS/ranger/rc.conf
	sed -ie "s+\$HOME+$HOME+g" $CONFIGS/ranger/rc.conf
	sed -ie "s+\$CONFIGS+$CONFIGS+g" $CONFIGS/ranger/rc.conf
	echo "[INFO] Successfully replaced"
}


while [[ $1 != "" ]]; do
	case $1 in
		-s | --save )
			shift
			if [[ -d $1  &&  $1!='' ]]; then
				SAVE_PATH=$1
			else
				>&2 echo "[ERROR] Wrong saving path"
				exit 1
			fi
		;;

		-sd )
			SAVE_PATH=$CACHE/config.old/$(date +%y.%m.%d_%T)
		;;


		* )
			if [[ $EXISTING_CONFIGS == *$1* || $EXISTING_DOTFILES == *$1* || $EXISTING_SCRIPTS == *$1* ]]; then
				TO_UPDATE="$TO_UPDATE $1"
			else
				>&2 echo "[ERROR] Wrong config or dotfile name: $1"
				exit 1
			fi
		;;

	esac
	shift
done

if [[ $TO_UPDATE == "" ]]; then
	echo "[INFO] Nothing was specified. Updating everything"
	TO_UPDATE="$EXISTING_CONFIGS $EXISTING_DOTFILES $EXISTING_SCRIPTS"
fi

if [[ $SAVE_PATH != "" ]]; then
	save_before_update
fi

mkdir -p $SCRIPTS_PATH
replace

if [[ $TO_UPDATE == *ranger* ]]; then
	set_rcconf_values
fi

if [[ $TO_UPDATE == *.profile* ]]; then
	echo -e "[WARN] You are going to update .profile\n\tFor changes to have effect you need to restart your session"
	read -p "Restart right now? [y/n]: " -n 1 -r
	echo ""
	if [[ $REPLY == "y" || $REPLY == "Y" ]]
	then
		i3-msg exit
		killall dwm
	fi
fi

echo "[INFO] Updating finished SUCCESSFULLY"

cd -
