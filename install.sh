#!/bin/bash

# pre-req
sudo apt -y install curl wget fuse gpg unzip

# sudo w/o passwd
sudo sed -i '$a '$USER' ALL=(ALL) NOPASSWD:ALL' /etc/sudoers

# glow 
curl -fsSL https://repo.charm.sh/apt/gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/charm.gpg
echo "deb [signed-by=/etc/apt/keyrings/charm.gpg] https://repo.charm.sh/apt/ * *" | sudo tee /etc/apt/sources.list.d/charm.list

# exa
wget -qO- https://raw.githubusercontent.com/eza-community/eza/main/deb.asc | sudo gpg --dearmor -o /etc/apt/keyrings/gierens.gpg
echo "deb [signed-by=/etc/apt/keyrings/gierens.gpg] http://deb.gierens.de stable main" | sudo tee /etc/apt/sources.list.d/gierens.list
# sudo chmod 644 /etc/apt/keyrings/gierens.gpg /etc/apt/sources.list.d/gierens.list

# req
sudo apt update
sudo apt install -y nala git gcc python3-venv fish bat glow npm fzf ripgrep fd-find eza

# neovim + nvchad
wget https://github.com/neovim/neovim/releases/download/v0.9.5/nvim.appimage -O /tmp/vim
chmod +x /tmp/vim
/tmp/./vim --appimage-extract
mv squashfs-root /tmp
sed -i '/TryExec=nvim/d' /tmp/squashfs-root/nvim.desktop
sed -i '/Exec=nvim/c Exec=vim' /tmp/squashfs-root/nvim.desktop
mkdir -p ~/.local/share/applications
mv /tmp/squashfs-root/nvim.desktop ~/.local/share/applications/vim.desktop
cp -rv /tmp/squashfs-root/usr/share/icons/hicolor/* ~/.local/share/icons/hicolor/
mkdir -p ~/.local/bin
mv /tmp/vim ~/.local/bin/
rm -rf ~/.config/nvim
rm -rf ~/.local/share/nvim
git clone https://github.com/NvChad/NvChad ~/.config/nvim --depth 1

# fish
mkdir -p ~/.config/fish
curl -sS https://starship.rs/install.sh | sh

# procs
wget https://github.com/dalance/procs/releases/download/v0.14.4/procs-v0.14.4-x86_64-linux.zip -O /tmp/procs.zip
unzip /tmp/procs.zip -d ~/.local/bin

# zoxide
curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | bash

# .files
mkdir -p ~/apps
mkdir -p ~/.config/nvim/lua
mkdir ~/.ssh
# chmod +x .files/clean_snap.sh
cp -vrf .files/apps/ ~/apps/
cp .files/bash/.bash_aliases ~
cp .files/fish/config.fish ~/.config/fish/
cp .files/git/.gitconfig ~
cp -vrf .files/nvim/ ~/.config/nvim/lua/
cp .files/procs/config.toml ~/.config/procs/
cp .files/ssh/config ~/.ssh/

