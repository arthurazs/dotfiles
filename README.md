# .files for debian-based distro

Works on both ubuntu and debian.

**NOTE** you may add your user in the sudoers group with:

```bash
su -
apt install sudo
usermod -a -G sudo <username>
```

---

Contains:

- update user to use sudo w/o passwd
- install nala (apt), git, gcc, python (venv), bat (cat)
- neovim (vim) + nvChad + pyright, ruff and mypy
  - vi (nvim with kickstart config)
- fish (bash) + starship
- ssh config for custom ssh key
- eza (ls), fdfind (find), zoxide (cd) + fzf, procs (ps), ripgrep (rg)
- lazygit (cli git gui)
- zellij (terminal workspace)
- optional
  - go

## Install Default

```bash
sudo apt install -y git
git clone https://github.com/arthurazs/dotfiles
cd dotfiles
sh install.sh
```

### Commands to test

- apt fetch
- fish
- cat README.md
- vim README.md
- l, ls, ll, la, tree
- find -e md
- cd, cd my
- procs
- rg install.sh
- lazygit
- zellij
- vi

## Install Go

```bash
cd dotfiles
sh go.sh
```

