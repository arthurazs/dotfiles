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
- install nala (apt), git, gcc, python (venv), bat (cat), glow (markdown viewer)
- neovim (vim) + nvChad + pyright, ruff and mypy
- fish (bash) + starship
- ssh config for custom ssh key
- eza (ls), fdfind (find), zoxide (cd) + fzf, procs (ps), ripgrep (rg)

## Install

```bash
sudo apt install -y git
git clone https://github.com/arthurazs/my-dotfiles
cd my-dotfiles
sh install.sh
```

## Commands to test

- apt fetch
- fish
- cat README.md
- glow README.md
- vim README.md
- l, ls, ll, la, tree
- find -e md
- cd, cd my
- procs
- rg install.sh
