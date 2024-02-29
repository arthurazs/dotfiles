#!/bin/bash

# pre-req
sudo apt -y install curl wget fuse gpg unzip

# sudo w/o passwd
sudo sed -i '$a '$USER' ALL=(ALL) NOPASSWD:ALL' /etc/sudoers

# eza
wget -qO- https://raw.githubusercontent.com/eza-community/eza/main/deb.asc | sudo gpg --dearmor -o /etc/apt/keyrings/gierens.gpg
echo "deb [signed-by=/etc/apt/keyrings/gierens.gpg] http://deb.gierens.de stable main" | sudo tee /etc/apt/sources.list.d/gierens.list
# sudo chmod 644 /etc/apt/keyrings/gierens.gpg /etc/apt/sources.list.d/gierens.list

# req
sudo apt update
sudo apt install -y nala git gcc python3-venv fish bat npm fzf ripgrep fd-find eza

# neovim
wget https://github.com/neovim/neovim/releases/download/v0.9.5/nvim.appimage -O /tmp/vim
chmod +x /tmp/vim
/tmp/./vim --appimage-extract
mv squashfs-root /tmp
sed -i '/TryExec=nvim/d' /tmp/squashfs-root/nvim.desktop
sed -i '/Exec=nvim/c Exec=vim' /tmp/squashfs-root/nvim.desktop
mkdir -p ~/.local/share/applications ~/.local/bin ~/.local/share/icons/hicolor/
mv /tmp/squashfs-root/nvim.desktop ~/.local/share/applications/vim.desktop
cp -rv /tmp/squashfs-root/usr/share/icons/hicolor/* ~/.local/share/icons/hicolor/
mv /tmp/vim ~/.local/bin/

# nvchad
rm -rf ~/.config/nvim
rm -rf ~/.local/share/nvim
git clone https://github.com/NvChad/NvChad ~/.config/nvim --depth 1

# vim kickstart
git clone https://github.com/nvim-lua/kickstart.nvim.git ~/.config/vi

# fish
mkdir -p ~/.config/fish

# starship
curl -sS https://starship.rs/install.sh | sh
echo 'eval "$(starship init bash)"' >> ~/.bashrc

# procs
wget https://github.com/dalance/procs/releases/download/v0.14.4/procs-v0.14.4-x86_64-linux.zip -O /tmp/procs.zip
unzip /tmp/procs.zip -d ~/.local/bin

# zoxide
curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | bash
echo 'eval "$(~/.local/bin/zoxide init --cmd cd bash)"' >> ~/.bashrc

# .files
mkdir -p ~/apps ~/.config/nvim/lua/custom ~/.ssh ~/.config/procs
# chmod +x .files/clean_snap.sh
cp -vrf .files/apps/* ~/apps/
cp .files/bash/.bash_aliases ~
cp .files/fish/config.fish ~/.config/fish/
cp .files/starship/starship.toml ~/.config/starship.toml
cp .files/git/.gitconfig ~
cp -vrf .files/nvim/* ~/.config/nvim/lua/custom
cp .files/procs/config.toml ~/.config/procs/
cp .files/ssh/config ~/.ssh/

# lazygit
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
curl -Lo /tmp/lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
mkdir -p /tmp/lazygit
tar -xzf /tmp/lazygit.tar.gz -C /tmp/
mv /tmp/lazygit ~/.local/bin

# zellij
wget https://github.com/zellij-org/zellij/releases/download/v0.39.2/zellij-x86_64-unknown-linux-musl.tar.gz -O /tmp/zellij.tar.gz
tar -xzf /tmp/zellij.tar.gz -C /tmp/
mv /tmp/zellij ~/.local/bin

# download vim plugins
vim +MasonInstallAll

