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
0. make `install` script save old configs by default
1. install -> update & create installation script that will generate .profile
2. add list of all utilities/tools I am using or maybe even create a script to download all of them

