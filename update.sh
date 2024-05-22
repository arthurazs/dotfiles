#!/bin/bash
LOG_NAME="/tmp/arthurazs-dotfiles.log"

NEOVIM_REPO="neovim/neovim"
NEOVIM_NAME="nvim"
PROCS_REPO="dalance/procs"
PROCS_NAME="procs"
ZELLIJ_REPO="zellij-org/zellij"
ZELLIJ_NAME="zellij"

echo "Logging to $LOG_NAME"

# Versions
latest_version () {
    echo $(curl -s "https://api.github.com/repos/${1}/releases/latest" | grep -Po '"tag_name": "\K[^"]*')
}

version_url () {
    echo "https://github.com/$1/releases/download/$2/$3"
}

# neovim
NEOVIM_VERSION=`latest_version $NEOVIM_REPO`
echo "Installing $NEOVIM_NAME $NEOVIM_VERSION..."
wget `version_url $NEOVIM_REPO $NEOVIM_VERSION $NEOVIM_NAME.appimage` -O /tmp/$NEOVIM_NAME >> $LOG_NAME 2>&1
chmod +x /tmp/$NEOVIM_NAME
/tmp/./$NEOVIM_NAME --appimage-extract >> $LOG_NAME 2>&1
mv squashfs-root /tmp
mkdir -p ~/.local/share/applications ~/.local/bin/ ~/.local/share/icons/hicolor/
mv /tmp/squashfs-root/$NEOVIM_NAME.desktop ~/.local/share/applications/
cp -rv /tmp/squashfs-root/usr/share/icons/hicolor/* ~/.local/share/icons/hicolor/ >> $LOG_NAME 2>&1
mv /tmp/$NEOVIM_NAME ~/.local/bin/

# neovim dotfiles
echo "Installing $NEOVIM_NAME dotfiles..."
rm -rf ~/.config/$NEOVIM_NAME
rm -rf ~/.local/share/$NEOVIM_NAME
git clone https://github.com/arthurazs/$NEOVIM_NAME --depth 1 ~/.config/$NEOVIM_NAME >> $LOG_NAME 2>&1
echo "Installing $NEOVIM_NAME plugins..."
sh ~/.config/nvim/install.sh

# starship
echo "Installing starship..."
curl -sS https://starship.rs/install.sh | sh -s -- -b ~/.local/bin -y >> $LOG_NAME 2>&1

# procs
PROCS_VERSION=`latest_version $PROCS_REPO`
echo "Installing $PROCS_NAME $PROCS_VERSION..."
wget `version_url $PROCS_REPO $PROCS_VERSION $PROCS_NAME-${PROCS_VERSION}-x86_64-linux.zip` -O /tmp/$PROCS_NAME.zip >> $LOG_NAME 2>&1
unzip -o /tmp/$PROCS_NAME.zip -d ~/.local/bin/ >> $LOG_NAME 2>&1

# zoxide
curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | bash  >> $LOG_NAME 2>&1

# zellij
ZELLIJ_VERSION=`latest_version $ZELLIJ_REPO`
echo "Installing $ZELLIJ_NAME $ZELLIJ_VERSION..."
wget `version_url $ZELLIJ_REPO $ZELLIJ_VERSION $ZELLIJ_NAME-x86_64-unknown-linux-musl.tar.gz` -O /tmp/$ZELLIJ_NAME.tar.gz >> $LOG_NAME 2>&1
tar -xzf /tmp/$ZELLIJ_NAME.tar.gz -C /tmp/
mv /tmp/$ZELLIJ_NAME ~/.local/bin/

echo "Done updating!"

