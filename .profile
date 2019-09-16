# ~/.profile: executed by the command interpreter for login shells.

export BROWSER=firefox
export TERMINAL=konsole
export EDITOR=vim

# setting up path to dotfiles
export CONFIGS=$HOME/.config
export DOTFILES=~/Repos/dotfiles
export REPO=~/Repos

export RANGER_LOAD_DEFAULT_RC=FALSE

# path used for sshfs
export HELIOS_FS=$HOME/heliosFS

# set path so it includes user's scripts
if [ -d "$DOTFILES/scripts" ] ; then
	PATH="$DOTFILES/scripts:$PATH"
fi

if [ -d "$HOME/Applications" ] ; then
	PATH="~/Applications:$PATH"
fi

if [ -d "$REPO/SSW-BSP" ] ; then
	PATH="$REPO/SSW-BSP:$PATH"
fi

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$DOTFILES/.bashrc" ]; then
	. "$DOTFILES/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi
