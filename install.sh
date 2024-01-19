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
git config --global user.email "github@zope.me"
git config --global user.name "Arthur Zopellaro"

# aliases
echo 'alias apt="sudo nala"' >> ~/.bash_aliases
echo 'alias cat="batcat"' >> ~/.bash_aliases
echo 'alias glow="glow -p"' >> ~/.bash_aliases
echo 'alias apt-snap=~/apps/./clean_snap.sh' >> ~/.bash_aliases
echo 'alias find="fdfind"' >> ~/.bash_aliases
echo 'alias ls="exa --icons --group-directories-first"' >> ~/.bash_aliases
echo 'alias l="ls -a"' >> ~/.bash_aliases
echo 'alias ll="exa -l --git --icons --color-scale -h -g --group-directories-first"' >> ~/.bash_aliases
echo 'alias la="ll -a"' >> ~/.bash_aliases
echo 'alias tree="exa --tree --icons --level 2 --group-directories-first"' >> ~/.bash_aliases

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
sed -i '$i\\    alias find="fdfind"' ~/.config/fish/config.fish
sed -i '$i\\    alias ls="exa --icons --group-directories-first"' ~/.config/fish/config.fish
sed -i '$i\\    alias l="ls -a"' ~/.config/fish/config.fish
sed -i '$i\\    alias ll="exa -l --git --icons --color-scale -h -g --group-directories-first"' ~/.config/fish/config.fish
sed -i '$i\\    alias la="ll -a"' ~/.config/fish/config.fish
sed -i '$i\\    alias tree="exa --tree --icons --level 2 --group-directories-first"' ~/.config/fish/config.fish
curl -sS https://starship.rs/install.sh | sh
sed -i '$i\\    starship init fish | source' ~/.config/fish/config.fish

# procs
wget https://github.com/dalance/procs/releases/download/v0.14.4/procs-v0.14.4-x86_64-linux.zip -O /tmp/procs.zip
unzip /tmp/procs.zip
mv procs ~/.local/bin

# zoxide
curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | bash
echo 'eval "$(~/.local/bin/zoxide init bash)"' >> ~/.bashrc
echo 'alias cd="z"' >> ~/.bash_aliases
sed -i '$i\\   zoxide init fish | source' ~/.config/fish/config.fish
sed -i '$i\\    alias cd="z"' ~/.config/fish/config.fish

# .files
mkdir -p ~/apps
mkdir -p ~/.config/nvim/lua
mkdir ~/.ssh
cp -vrf nvim/ ~/.config/nvim/lua/
cp config ~/.ssh/
chmod +x clean_snap.sh
cp clean_snap.sh ~/apps/
cp -vrf procs ~/.config/procs/
