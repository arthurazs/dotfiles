#!/bin/bash

# pre-req
sudo apt -y install curl wget fuse gpg unzip

# sudo w/o passwd
sudo sed -i '$a '$USER' ALL=(ALL) NOPASSWD:ALL' /etc/sudoers

# glow 
curl -fsSL https://repo.charm.sh/apt/gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/charm.gpg
echo "deb [signed-by=/etc/apt/keyrings/charm.gpg] https://repo.charm.sh/apt/ * *" | sudo tee /etc/apt/sources.list.d/charm.list

# req
sudo apt update
sudo apt install nala git gcc python3-venv fish bat glow npm -y
git config --global user.email "github@zope.me"
git config --global user.name "Arthur Zopellaro"

# aliases
echo 'alias apt="sudo nala"' >> ~/.bash_aliases
echo 'alias cat="batcat"' >> ~/.bash_aliases
echo 'alias glow="glow -p"' >> ~/.bash_aliases
echo 'alias apt-snap=~/apps/./clean_snap.sh' >> ~/.bash_aliases

# neovim + nvchad
cur_dir=$(pwd)
cd /tmp
wget https://github.com/neovim/neovim/releases/download/v0.9.5/nvim.appimage -O vim
chmod +x vim
./vim --appimage-extract
sed -i '/TryExec=nvim/d' squashfs-root/nvim.desktop
sed -i '/Exec=nvim/c Exec=vim' squashfs-root/nvim.desktop
mkdir -p ~/.local/share/applications
mv squashfs-root/nvim.desktop ~/.local/share/applications/vim.desktop
cp -rv squashfs-root/usr/share/icons/hicolor/* ~/.local/share/icons/hicolor/
mkdir -p ~/.local/bin
mv vim ~/.local/bin/
rm -rf ~/.config/nvim
rm -rf ~/.local/share/nvim
git clone https://github.com/NvChad/NvChad ~/.config/nvim --depth 1
cd $cur_dir

# fish
mkdir -p ~/.config/fish
echo -e "if status is-interactive\n    # Commands to run in interactive sessions can go here\nend" > ~/.config/fish/config.fish
sed -i '$i\\    alias apt="sudo nala"' ~/.config/fish/config.fish
sed -i '$i\\    alias cat="batcat"' ~/.config/fish/config.fish
sed -i '$i\\    alias glow="glow -p"' ~/.config/fish/config.fish
sed -i '$i\\    alias apt-snap="~/apps/./clean_snap.sh"' ~/.config/fish/config.fish
curl -sS https://starship.rs/install.sh | sh
sed -i '$i\\    starship init fish | source' ~/.config/fish/config.fish

# procs
wget https://github.com/dalance/procs/releases/download/v0.14.4/procs-v0.14.4-x86_64-linux.zip -O /tmp/procs.zip
unzip /tmp/procs.zip
mv procs ~/.local/bin

# .files
mkdir -p ~/apps
mkdir -p ~/.config/nvim/lua
mkdir ~/.ssh
cp -vrf nvim/ ~/.config/nvim/lua/
cp config ~/.ssh/
chmod +x clean_snap.sh
cp clean_snap.sh ~/apps/
cp -vrf procs ~/.config/procs/
