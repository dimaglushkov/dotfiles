#!/bin/sh

if [[ $DOTFILES == '' ]]; then
	echo '[ERROR] Set $DOTFILES to downloaded/cloned config directory path'
	exit 1
fi

cd $DOTFILES
EXISTING_CONFIGS=$(ls -d */ | tr -d / | grep -v 'scripts')
EXISTING_DOTFILES=$(ls -d .* | grep -v '\.$\|\.git')
EXISTING_SCRIPTS=$(ls scripts | grep '.py\|.sh')

TO_UPDATE=""
SAVE_PATH=""
DOTFILES_PATH=$HOME
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
			SAVE_PATH=$CONFIGS.old/$(date +%y.%m.%d_%T)
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
echo "[INFO] Updating finished SUCCESSFULLY"
i3-msg restart

cd -
