# dotfiles
My dotfiles, configs, and scripts
![Screen sample](https://github.com/dimaglushkov/dotfiles/blob/main/assets/screenshots/screen-sample-dwm-arch.png)

## Installation 
You can automatically install this configuration on _probably_ any Arch-based system.
To install this configuration, just launch ```install.sh``` installation script. It will automatically download _probably_ all necessary tools and programs and move their condfigs to the right directories. After that, it will ask you to restart your session for changes to have an effect

__Warning:__ It's not well tested, so I don't recommend you to launch this script unless you know what's going on. You are doing it at your own risk

## Updating your configs
If you want to apply any changes on this configs, you can simply apply changes on the files in this repo and run ```update_dotfiles.sh``` (or ```dcr``` if using this configuration as it is or added .aliases to your shells .rc file)

It also requires `$DOTFILES` and `$CONFIGS` env variables to be set.
### Update script usage
`update_dotfiles.sh [-s PATH | -sd] ARGS`
* `-s PATH`		  - saving exsisting version of given ARGS into PATH.
* `-sd` 		    - saving exsisting version of given ARGS into `$HOME/.cache/.config.old/%DATE-%TIME`.
* `ARGS`		    - list of configs/dotfiles/scripts you want to install. If not specified then installing everything at `$DOTFILES`.
