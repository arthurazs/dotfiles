# .files for ubuntu

Tested on ubuntu 24.04.1.

**NOTE** you may need to add your user in the sudoers group with:

```bash
su -
apt install sudo
usermod -a -G sudo <username>
```

---

Contains:

- TODO...
- Split `apt.sh` into multiple scripts
- Copy apt-snap
- Create function for "do you wish to proceed \[y/n\]"
- Add config copying inside instalation script (see cli/go.sh for example), add to nvim too? (it would download another repo)
- Remove all `wget` and `#!/bin/bash` and `RED|YELLOW|ETC`
- Rework `pip.sh` to install only uv from git
- Review ==gui==

## Install Default

```bash
sudo apt install -y curl
curl https://github.com/arthurazs/dotfiles/blob/feature/add-gui-scripts/init.sh | sh
```

### Commands to test

- apt fetch, apt update
- fish
- cat README.md
- l, ls, ll, la, tree
- fdfind -e md
- cd dotfiles
- ==TODO== procs
- rg install.sh
- lazygit
- zellij
- vim, vi

## GNOME Shells 

Recomendations:

- Vitals
