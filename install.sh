#!/bin/bash
LOG_NAME="/tmp/arthurazs-dotfiles.log"

echo "Logging to $LOG_NAME" | tee -a $LOG_NAME
date >> $LOG_NAME

# export path
echo "Exporting ~/.local/bin to PATH" | tee -a $LOG_NAME
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc

# sudo w/o passwd
echo "Enabling sudo without password..." | tee -a $LOG_NAME
sudo sed -i '$a '$USER' ALL=(ALL) NOPASSWD:ALL' /etc/sudoers >> $LOG_NAME 2>&1

# pre-req
echo "Installing pre-requirements [curl, wget, fuse, gpg and unzip]..." | tee -a $LOG_NAME
sudo apt-get -y install curl wget fuse gpg unzip >> $LOG_NAME 2>&1

# eza
echo "Adding eza repository to apt..." | tee -a $LOG_NAME
wget -qO- https://raw.githubusercontent.com/eza-community/eza/main/deb.asc | sudo gpg --dearmor -o /etc/apt/keyrings/gierens.gpg >> $LOG_NAME 2>&1
sudo echo "deb [signed-by=/etc/apt/keyrings/gierens.gpg] http://deb.gierens.de stable main" > /etc/apt/sources.list.d/gierens.list
sudo chmod 644 /etc/apt/keyrings/gierens.gpg /etc/apt/sources.list.d/gierens.list >> $LOG_NAME 2>&1

# req
echo "Updating apt..." | tee -a $LOG_NAME
sudo apt-get update >> $LOG_NAME 2>&1
echo "Installing requirements [nala, git, gcc, python3-venv, fish, bat, npm, fzf, ripgrep, fd-find and eza]..." | tee -a $LOG_NAME
sudo apt-get install -y nala git gcc python3-venv fish bat npm fzf ripgrep fd-find eza >> $LOG_NAME 2>&1
sudo npm install -g n | tee -a $LOG_NAME
N_PREFIX=${HOME}/.local n latest

# installing/updating dependencies
sh update.sh

# zoxide
echo 'eval "$(~/.local/bin/zoxide init --cmd cd bash)"' >> ~/.bashrc

# starship
echo 'eval "$(starship init bash)"' >> ~/.bashrc

# .files
echo "Copying dotfiles [fish, clean_snap, aliases, starship, gitconfig, procs, ssh]..." | tee -a $LOG_NAME
mkdir -p ~/.config/fish ~/apps ~/.config/nvim/lua/custom ~/.ssh ~/.config/procs
cp .files/fish/config.fish ~/.config/fish/
cp -vrf .files/apps/* ~/apps/ >> $LOG_NAME 2>&1
cp .files/bash/.bash_aliases ~
cp .files/starship/starship.toml ~/.config/starship.toml
cp .files/git/.gitconfig ~
cp .files/procs/config.toml ~/.config/procs/
cp .files/ssh/config ~/.ssh/

echo "Done installing!" | tee -a $LOG_NAME

