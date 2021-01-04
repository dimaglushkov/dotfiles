#!/bin/sh

if [[ $DOTFILES == '' ]]; then
	echo '[ERROR] Set $DOTFILES to downloaded/cloned config directory path'
	exit 1
fi

cd $DOTFILES
CONFIGS=$(ls -d */ | tr -d /)
DOTFILES=$(ls -d .* | grep -v '\.$\|\.git')
INSTALL=""
SAVE_PATH=""
CONF_DIR="$HOME/.config"
DOTF_DIR=$HOME


save_existing()
{
	echo -e "[INFO] Saving existing:\n$INSTALL \nto $SAVE_PATH"

	WARNINGS=0
	COPIES=0
	mkdir -p $SAVE_PATH
	for i in ${INSTALL}; do
		echo "[INFO] Saving $i"

		if [[ $CONFIGS == *$i*  ]]; then
			if [[ -d $CONF_DIR/$i ]]; then
				 cp -r $CONF_DIR/$i $SAVE_PATH/$i
			else
				echo "[WARNING] $CONF_DIR/$i does not exist"
				((WARNINGS++))
			fi
	 	else
			if [[ -f $DOTF_DIR/$i ]]; then
				cp $DOTF_DIR/$i $SAVE_PATH/$i
			else
				echo "[WARNING] $DOTF_DIR/$i does not exist"
				((WARNINGS++))
			fi
		fi
		((COPIES++))
	done

	echo -e "[INFO] Saving finished with $WARNINGS/$COPIES warnings"
}

moving()
{
	echo "[INFO] Updating existing files"

	COPIES=0
	for i in ${INSTALL}; do
		if [[ $CONFIGS == *$i*  ]]; then
			rm -rf $CONF_DIR/$i
			cp -r ./$i $CONF_DIR/$i
		else
			rm -f $DOTF_DIR/$i
			cp ./$i $DOTF_DIR/$i
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
			mkdir -p $HOME/.config.old/
			SAVE_PATH=$HOME/.config.old/$(date +ver.%d.%m.%y-%T)
		;;

		-cfd )
			shift
			if [[ -d $1  &&  $1!='' ]]; then
				CONF_DIR=$1
			else
				>&2 echo "[ERROR] Wrong config directory"
				exit 1
			fi
		;;

		-dfd )
			shift
			if [[ -d $1 && $1!='' ]]; then
				DOTF_DIR=$1
			else
				>&2 echo "[ERROR] Wrong dotfile directory"
				exit 1
			fi
		;;

		* )
			if [[ $CONFIGS == *$1* || $DOTFILES == *$1* ]]; then
				INSTALL="$INSTALL $1"
			else
				>&2 echo "[ERROR] Wrong config or dotfile name"
				exit 1
			fi
		;;

	esac
	shift
done

if [[ $INSTALL == "" ]]; then
	INSTALL="$CONFIGS $DOTFILES"
fi

if [[ $SAVE_PATH != "" ]]; then
	save_existing
fi

moving
echo "[INFO] Updating finished SUCCESSFULLY"

cd -
