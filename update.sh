#!/bin/bash
LOG_NAME="/tmp/arthurazs-dotfiles.log"

FONT_REPO="ryanoasis/nerd-fonts"
FONT_NAME="JetBrainsMono"
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

# nerd font
FONT_VERSION=`latest_version $FONT_REPO`
echo "Installing $FONT_NAME $FONT_VERSION..."
echo "\n$(date) $FONT_NAME $FONT_VERSION" >> $LOG_NAME
wget `version_url $FONT_REPO $FONT_VERSION ${FONT_NAME}.zip` -O /tmp/$FONT_NAME.zip -a $LOG_NAME -nv
unzip -o /tmp/$FONT_NAME.zip ${FONT_NAME}NerdFont-Regular.ttf -d ~/.local/share/fonts >> $LOG_NAME 2>&1
fc-cache -f -r

# neovim
NEOVIM_VERSION=`latest_version $NEOVIM_REPO`
echo "Installing $NEOVIM_NAME $NEOVIM_VERSION..."
echo "\n$(date) $NEOVIM_NAME $NEOVIM_VERSION" >> $LOG_NAME
wget `version_url $NEOVIM_REPO $NEOVIM_VERSION $NEOVIM_NAME.appimage` -O /tmp/$NEOVIM_NAME -a $LOG_NAME -nv
chmod +x /tmp/$NEOVIM_NAME
/tmp/./$NEOVIM_NAME --appimage-extract >> $LOG_NAME 2>&1
rm -rf /tmp/squashfs-root-$NEOVIM_NAME
mv squashfs-root /tmp/squashfs-root-$NEOVIM_NAME
mkdir -p ~/.local/share/applications ~/.local/bin/ ~/.local/share/icons/hicolor/
mv /tmp/squashfs-root-${NEOVIM_NAME}/${NEOVIM_NAME}.desktop ~/.local/share/applications/
cp -rv /tmp/squashfs-root-${NEOVIM_NAME}/usr/share/icons/hicolor/* ~/.local/share/icons/hicolor/ >> $LOG_NAME 2>&1
mv /tmp/$NEOVIM_NAME ~/.local/bin/

# neovim dotfiles
echo "Installing $NEOVIM_NAME dotfiles..."
echo "\n$(date) $NEOVIM_NAME dotfiles" >> $LOG_NAME
rm -rf ~/.config/$NEOVIM_NAME
rm -rf ~/.local/share/$NEOVIM_NAME
git clone https://github.com/arthurazs/$NEOVIM_NAME --depth 1 ~/.config/$NEOVIM_NAME >> $LOG_NAME 2>&1
echo "Installing $NEOVIM_NAME plugins..."
sh ~/.config/nvim/install.sh

# starship
echo "Installing starship..."
echo "\n$(date) starship" >> $LOG_NAME
curl -sS https://starship.rs/install.sh | sh -s -- -b ~/.local/bin -y >> $LOG_NAME 2>&1

# procs
PROCS_VERSION=`latest_version $PROCS_REPO`
echo "Installing $PROCS_NAME $PROCS_VERSION..."
echo "\n$(date) $PROCS_NAME $PROCS_VERSION" >> $LOG_NAME
wget `version_url $PROCS_REPO $PROCS_VERSION $PROCS_NAME-${PROCS_VERSION}-x86_64-linux.zip` -O /tmp/$PROCS_NAME.zip -a $LOG_NAME -nv
unzip -o /tmp/$PROCS_NAME.zip -d ~/.local/bin/ >> $LOG_NAME 2>&1

# zoxide
echo "Installing zoxide..."
echo "\n$(date) zoxide" >> $LOG_NAME
curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | bash  >> $LOG_NAME 2>&1

# zellij
ZELLIJ_VERSION=`latest_version $ZELLIJ_REPO`
echo "Installing $ZELLIJ_NAME $ZELLIJ_VERSION..."
echo "\n$(date) $ZELLIJ_NAME $ZELLIJ_VERSION" >> $LOG_NAME
wget `version_url $ZELLIJ_REPO $ZELLIJ_VERSION $ZELLIJ_NAME-x86_64-unknown-linux-musl.tar.gz` -O /tmp/$ZELLIJ_NAME.tar.gz -a $LOG_NAME -nv
tar -xzf /tmp/$ZELLIJ_NAME.tar.gz -C /tmp/
mv /tmp/$ZELLIJ_NAME ~/.local/bin/

echo "Done updating!"

