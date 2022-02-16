## Mouse cursore theme
Source:  https://www.opendesktop.org/p/1339462
### Installation
For user-wide scope run
``` bash
$ tar xvf X11-Default-Black.tar -C ~/.local/share/icons
```

For system-wide scope run
``` bash
# tar xvf X11-Default-Black.tar -C /usr/share/icons
```

### Configuration
For user-wide scope edit `~/.icons/default/index.theme`; for system-wide scope edit `/usr/share/icons/default/index.theme`:
```
[Icon Theme]
Inherits=X11-Default-Black
```

Also edit `~/.config/gtk-3.0/settings.ini`
```
[Settings]
gtk-cursor-theme-name=X11-Default-Black
```
