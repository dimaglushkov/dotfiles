# dotfiles
Dotfiles and configuration
## Installation script
**WARNING! There is still a lot of work to be done. Do NOT launch this script unless you've set $DOTFILES to the location of this directory**

You can simply install configs from this repo by running `install` script. It's simply going to replace existing dotfiles & configs with ones from this repo.

Usage:
`./install [-s PATH | -sd] [-cfd PATH] [-dfd PATH] ARGS`
### Description
* `-cfd PATH` 	- system config directory. By default it's `$HOME/.config`
* `-dfd PATH` 	- system dotfiles directory. By default it's `$HOME`
* `-s PATH`		  - saving exsisting version of configs in PATH.
* `-sd` 		    - saving into `$HOME/.config.old/ver.%DATE-%TIME`
* `ARGS`		    - names of configs you want to install. If none specified then installing everything.
### TODO:
* implement network i3block to get rid of i3status
* collect list of all utilities/tools into requirements file to be able to download all of them on a new pc
* update dotfiles structure and update install according to new structural conventions
* add some images of how system looks with this configs
* improve readme :)
