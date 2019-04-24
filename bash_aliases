# .______        ___           _______. __    __             ___       __       __       ___           _______. _______     _______.
# |   _  \      /   \         /       ||  |  |  |           /   \     |  |     |  |     /   \         /       ||   ____|   /       |
# |  |_)  |    /  ^  \       |   (----`|  |__|  |          /  ^  \    |  |     |  |    /  ^  \       |   (----`|  |__     |   (----`
# |   _  <    /  /_\  \       \   \    |   __   |         /  /_\  \   |  |     |  |   /  /_\  \       \   \    |   __|     \   \
# |  |_)  |  /  _____  \  .----)   |   |  |  |  |        /  _____  \  |  `----.|  |  /  _____  \  .----)   |   |  |____.----)   |
# |______/  /__/     \__\ |_______/    |__|  |__|  _____/__/     \__\ |_______||__| /__/     \__\ |_______/    |_______|_______/

# shortcuts
alias v="vim"
alias fs="ranger"

alias vbrc="vim $DOTFILES/bashrc"
alias vvrc="vim $DOTFILES/vimrc"
alias vba="vim $DOTFILES/bash_aliases"

alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

alias ga='git add'
alias gc='git commit -m '
alias gca='git commit -am '
alias gps='git push'
alias gpl='git pull'


# REQUIRES WINE
# a shortcut to execute gpssworld student puck with wine
alias gpss="wine '/home/allacee/.wine/drive_c/Program Files/GPSS/GPSSW.exe'"

# REQUIRES mdv installed (pip install mdv)
# opening todo.md with mdv
# alias todo='mdv ~/todo.md'

# fast execution of './start' scripts for asm progs
alias st='./start'

# Add an "alert" alias for long running commands.  Use like so:
# $ sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Fast ssh
# for this case helios is just a name of ITMO study server, so don't really worry about this word to much
# All $HELIOS... variables are set in .profile file (like 'export HELIOS_FS=path_to_directory')
# also can be set up with ssh config, but I'm using aliases to make it more interactive
alias helios="echo \"Connecting as $HELIOS_USER\" && ssh $HELIOS_USER@$HELIOS_HOST -p $HELIOS_PORT"

# REQURIES sshfs installed (sudo apt-get install sshfs)
# Easy way to work with remote pc's filesystem
# this one automatically creates directory in $HOME and after mounting
# remote fs opens it with nautilus.
# if you rather use nautilus (default or other file manager)
# instead of ranger replace 'ranger' 4 lines below to whatever you want
alias hfs="mkdir $HELIOS_FS &&
		   echo \"Mounting Helios FS into $HELIOS_FS\" &&
		   sshfs -p $HELIOS_PORT $HELIOS_USER@$HELIOS_HOST:. $HELIOS_FS &&
		   ranger $HELIOS_FS"
alias uhfs="sudo umount $HELIOS_FS &&
		   rmdir $HELIOS_FS  &&
		   echo 'Helios FS unmounted succesfully!'"

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    # uncomment if you using this two
	# alias dir='dir --color=auto'
    # alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi



