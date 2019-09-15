# dotfiles
Dotfiles configuration
## Installation script
You can update your configs by running `install` script. It's simply gonna replace exsisting dotfiles&configs by ones from this repo.
### Usage
`./install [-s PATH | -sd] [-cfd PATH] [-dfd PATH] ARGS`
### Description
* `-cfd PATH` 	- system config directory. By default it's `$HOME/.config`
* `-dfd PATH` 	- system dotfiles directory. By default it's `$HOME`
* `-s PATH`		- saving exsisting version of configs in PATH.
* `-sd` 		- saving into `$HOME/.config.old/ver.%DATE-%TIME`
* `ARGS`		- names of configs you want to install. If none specified then installing everything.
