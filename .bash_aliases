# .______        ___           _______. __    __             ___       __       __       ___           _______. _______     _______.
# |   _  \      /   \         /       ||  |  |  |           /   \     |  |     |  |     /   \         /       ||   ____|   /       |
# |  |_)  |    /  ^  \       |   (----`|  |__|  |          /  ^  \    |  |     |  |    /  ^  \       |   (----`|  |__     |   (----`
# |   _  <    /  /_\  \       \   \    |   __   |         /  /_\  \   |  |     |  |   /  /_\  \       \   \    |   __|     \   \
# |  |_)  |  /  _____  \  .----)   |   |  |  |  |        /  _____  \  |  `----.|  |  /  _____  \  .----)   |   |  |____.----)   |
# |______/  /__/     \__\ |_______/    |__|  |__|  _____/__/     \__\ |_______||__| /__/     \__\ |_______/    |_______|_______/

# shortcuts
alias v="vim"
alias fs="ranger"
alias vbrc="vim $DOTFILES/.bashrc"
alias vvrc="vim $DOTFILES/.vimrc"
alias vba="vim $DOTFILES/.bash_aliases"
alias vi3c="vim ~/.config/i3/config"
alias repo="cd $REPO"

# better terminal experience
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias q='exit'
alias st='./start'

#dfcf stands for Dotfiles&Configs
alias dcu="$DOTFILES/install -sd"	# u for update
alias dcr="$DOTFILES/install"		# r for replace

# REQURIES sshfs installed
alias hfs="mkdir $HELIOS_FS &&
		   echo \"Mounting Helios FS into $HELIOS_FS\" &&
		   sshfs helios:. $HELIOS_FS"
alias uhfs="fusermount3 -u $HELIOS_FS &&
		   rmdir $HELIOS_FS  &&
		   echo 'Helios FS unmounted succesfully!'"

# enable color support
if [ -x /usr/bin/dircolors ]; then
	test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi



