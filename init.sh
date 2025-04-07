#!/usr/bin/sh

DF_SCRIPTS="$(dirname "$(realpath "$0")")/scripts"
# shellcheck source=scripts/trap.sh
. "${DF_SCRIPTS}/trap.sh"
# shellcheck source=scripts/log.sh
. "${DF_SCRIPTS}/log.sh"

: "${DF_GIT:=${HOME}/git}"
: "${DF_ROOT:=${DF_GIT}/dotfiles}"

echo ">> Updating apt..."
sudo apt update
echo ">> Installing dependencies [git, curl keychain]..."
sudo apt install git curl keychain -y
mkdir -p "${HOME}/.local/bin" "${DF_GIT}"
echo ">> Downloading scripts..."
git clone --depth 1 --branch feature/add-gui-scripts https://github.com/arthurazs/dotfiles "${DF_ROOT}"

echo
echo ">> Copying configuration files [xdg, alacritty, fish, git, starship]..."
mkdir -p "${HOME}/.config/alacritty" "${HOME}/.config/fish"
sh "${DF_ROOT}/scripts/config/xdg.sh"
cp -r "${DF_ROOT}/config/alacritty/." "${HOME}/.config/alacritty"
cp -r "${DF_ROOT}/config/fish/." "${HOME}/.config/fish"
cp "${DF_ROOT}/config/git/.gitconfig" "${HOME}"
cp -r "${DF_ROOT}/config/starship/." "${HOME}/.config"

echo
echo ">> Installing cli apps [eza, bat, nala, fish, btop, fd-find, ripgrep, fzf, zoxide, alacritty, libfuse2, helix, jetbrainsmono, lazygit, starship, nvim]..."
echo ">>   Note: libfuse2 required for helix"
sh "${DF_ROOT}/scripts/cli/apt.sh"
sh "${DF_ROOT}/scripts/cli/helix.sh"
sh "${DF_ROOT}/scripts/cli/jetbrainsmono.sh"
sh "${DF_ROOT}/scripts/cli/lazygit.sh"
sh "${DF_ROOT}/scripts/cli/starship.sh"
sh "${DF_ROOT}/scripts/cli/nvim.sh"

echo
echo ">> Cloning neovim config [arthurazs/nvim]..."
git clone --depth 1 --branch feature/improve-config https://github.com/arthurazs/nvim.git "$HOME/.config/nvim"

echo
echo ">> Installing gui apps [gimp, gnome-browser-connector, foliate, discord, obsidian, wireshark]"
sh "${DF_ROOT}/scripts/gui/apt.sh"
sh "${DF_ROOT}/scripts/gui/discord.sh"
sh "${DF_ROOT}/scripts/gui/obsidian.sh"
sh "${DF_ROOT}/scripts/gui/wireshark.h"

echo ">> ${TRAP_YELLOW}WARNING${TRAP_RESET} the following commands is supposed to be run on ubuntu live usb only"
echo ">> ${TRAP_RED}gsettings set org.gnome.desktop.lockdown disable-lock-screen false${TRAP_RESET}"
echo ">> ${TRAP_RED}sudo sysctl -w kernel.apparmor_restrict_unprivileged_userns=0${TRAP_RESET}"
printf ">> do you wish to proceed? [y/n]: "
read -r yn
case $yn in
[Yy]*) echo "${TRAP_GREEN}Proceeding...${TRAP_RESET}" ;;
[Nn]*)
    echo "${TRAP_YELLOW}Leaving...${TRAP_RESET}"
    return 0
    ;;
*)
    echo "${TRAP_RED}Invalid answer${TRAP_RESET}"
    return 13
    ;;
esac
# WARNING run only on ubuntu live usb
# enable lock screen
gsettings set org.gnome.desktop.lockdown disable-lock-screen false

# disable apparmor
# to make it persistent, add to /etc/sysctl.conf
sudo sysctl -w kernel.apparmor_restrict_unprivileged_userns=0
