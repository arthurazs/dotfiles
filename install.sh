#!/bin/bash

# pre-req
sudo apt install curl wget fuse gpg

# sudo w/o passwd
sudo sed -i '$a '$USER' ALL=(ALL) NOPASSWD:ALL' /etc/sudoers

# glow 
curl -fsSL https://repo.charm.sh/apt/gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/charm.gpg
echo "deb [signed-by=/etc/apt/keyrings/charm.gpg] https://repo.charm.sh/apt/ * *" | sudo tee /etc/apt/sources.list.d/charm.list

# req
sudo apt update
sudo apt install nala git gcc python3-venv fish bat glow npm -y
git config --global user.email "github@zope.me"

# aliases
echo 'alias apt="sudo nala"' >> ~/.bash_aliases
echo 'alias cat="batcat"' >> ~/.bash_aliases
echo 'alias glow="glow -p"' >> ~/.bash_aliases

# neovim + nvchad
wget https://github.com/neovim/neovim/releases/download/v0.9.5/nvim.appimage
chmod +x nvim.appimage
sudo mv nvim.appimage /usr/local/bin/vim
rm -rf ~/.config/nvim
rm -rf ~/.local/share/nvim
git clone https://github.com/NvChad/NvChad ~/.config/nvim --depth 1

# fish
echo -e "if status is-interactive\n    # Commands to run in interactive sessions can go here\nend" > ~/.config/fish/config.fish
sed -i '$i\\    alias apt="sudo nala"' ~/.config/fish/config.fish
sed -i '$i\\    alias cat="batcat"' ~/.config/fish/config.fish
sed -i '$i\\    alias glow="glow -p"' ~/.config/fish/config.fish
curl -sS https://starship.rs/install.sh | sh
sed -i '$i\\    starship init fish | source' ~/.config/fish/config.fish

# .files
cp -vrf custom/ ~/.config/nvim/lua/
cp config ~/.ssh/
