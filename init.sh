#!/usr/bin/sh

RED="\033[31m"
GREEN="\033[32m"
YELLOW="\033[33m"
RESET="\033[0m"
set -e # exit on error
trap 'DF_STAT=$? && [ "$DF_STAT" -ne 0 ] && echo "${RED}ERROR $DF_STAT${RESET} in $0 check the log" || echo "${GREEN}Done${RESET}"' EXIT

DF_GIT="$HOME/git"
DF_ROOT="$DF_GIT/dotfiles"

echo ">> Updating apt..."
sudo apt update
echo ">> Installing dependencies [git, curl]..."
sudo apt install git curl -y
mkdir -p "$HOME/.local/bin" "$DF_GIT"
echo ">> Downloading scripts..."
git clone --depth 1 --branch feature/add-gui-scripts https://github.com/arthurazs/dotfiles "$DF_ROOT"

echo
echo ">> Copying configuration files [xdg, alacritty, fish, git, starship]..."
mkdir -p "$HOME/.config/alacritty" "$HOME/.config/fish"
sh "$DF_ROOT/scripts/config/xdg.sh"
cp -r "$DF_ROOT/alacritty/*" "$HOME/.config/alacritty"
cp -r "$DF_ROOT/fish/*" "$HOME/.config/fish"
cp "$DF_ROOT/git/.gitconfig" "$HOME"
cp -r "$DF_ROOT/starship/*" "$HOME/.config"

echo
echo ">> Installing cli apps [eza, bat, nala, fish, btop, fd-find, ripgrep, fzf, zoxide, alacritty, libfuse2, helix, jetbrainsmono, lazygit, starship, nvim]..."
echo ">>   Note: libfuse2 required for helix"
sh "$DF_ROOT/scripts/install/cli/apt.sh"
sh "$DF_ROOT/scripts/install/cli/helix.sh"
sh "$DF_ROOT/scripts/install/cli/jetbrainsmono.sh"
sh "$DF_ROOT/scripts/install/cli/lazygit.sh"
sh "$DF_ROOT/scripts/install/cli/starship.sh"
sh "$DF_ROOT/scripts/install/cli/nvim.sh"

echo
echo ">> Cloning neovim config [arthurazs/nvim]..."
git clone --depth 1 --branch feature/improve-config https://github.com/arthurazs/nvim.git "$HOME/.config/nvim"

echo
echo ">> Installing gui apps [gimp, gnome-browser-connector, foliate, discord, obsidian, wireshark]"
sh "$DF_ROOT/scripts/install/gui/apt.sh"
sh "$DF_ROOT/scripts/install/gui/discord.sh"
sh "$DF_ROOT/scripts/install/gui/obsidian.sh"
sh "$DF_ROOT/scripts/install/gui/wireshark.h"

echo ">> ${YELLOW}WARNING${RESET} the following commands is supposed to be run on ubuntu live usb only"
echo ">> ${RED}gsettings set org.gnome.desktop.lockdown disable-lock-screen false${RESET}"
echo ">> ${RED}sudo sysctl -w kernel.apparmor_restrict_unprivileged_userns=0${RESET}"
printf ">> do you wish to proceed? [y/n]: "
read -r yn
case $yn in
[Yy]*) echo "${GREEN}Proceeding...${RESET}" ;;
[Nn]*)
    echo "${YELLOW}Leaving...${RESET}"
    return 0
    ;;
*)
    echo "${RED}Invalid answer${RESET}"
    return 13
    ;;
esac
# WARNING run only on ubuntu live usb
# enable lock screen
gsettings set org.gnome.desktop.lockdown disable-lock-screen false

# disable apparmor
# to make it persistent, add to /etc/sysctl.conf
sudo sysctl -w kernel.apparmor_restrict_unprivileged_userns=0
