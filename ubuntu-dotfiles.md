# Ubuntu

`sudo sed -i '$a '$USER' ALL=(ALL) NOPASSWD:ALL' /etc/sudoers`

## SSH Key

Generate a new SSH key and add it to your [github](https://github.com/settings/ssh/new)

```bash
ssh-keygen -t rsa -b 4096 -C "arthurazsoares@gmail.com"
eval "$(ssh-agent -s)"
ssh-add $HOME/.ssh/id_rsa
cat $HOME/.ssh/id_rsa.pub
```

## Softwares

```bash
sudo apt update
sudo apt install -y apt-transport-https  # why this?

wget -qO - https://wavebox.io/dl/client/repo/archive.key | sudo apt-key add -
echo "deb https://wavebox.io/dl/client/repo/ x86_64/" | sudo tee --append /etc/apt/sources.list.d/wavebox.list

wget -qO - https://packages.microsoft.com/keys/microsoft.asc | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main"  # check if necessary

sudo apt update
sudo apt upgrade
sudo apt install -y tilix rofi python3-pip fonts-firacode vim python3-distutils wireshark git p7zip-full vlc nemo wavebox ttf-mscorefonts-installer llvm clang curl code gconf2 powerline fonts-powerline tree ipython3 imagemagick  # why llvm, clang?

code --install-extension aaron-bond.better-comments
code --install-extension coenraads.bracket-pair-colorizer-2
code --install-extension pkief.material-icon-theme
code --install-extension zhuangtongfa.material-theme
code --install-extension ms-python.python

pip3 install virtualenv
sudo gpasswd -a $USER wireshark
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
source $HOME/.cargo/env
cargo install bat starship

wget -O tmp.deb https://release.gitkraken.com/linux/gitkraken-amd64.deb
sudo dpkg -i tmp.deb
# sudo apt --fix-broken install -y
rm tmp.deb

wget -O tmp.deb https://updates.insomnia.rest/downloads/ubuntu/latest?app=com.insomnia.app
sudo dpkg -i tmp.deb
rm tmp.deb

for uuid in "Vitals@CoreCoding.com"; do shellversion=$(gnome-shell --version | cut -d' ' -f3); wget -O tmp.zip "https://extensions.gnome.org/download-extension/$uuid.shell-extension.zip?shell_version=$shellversion"; 7z x tmp.zip -o"$HOME/.local/share/gnome-shell/extensions/$uuid"; rm tmp.zip; done
```

Check the [latest pycharm version](https://www.jetbrains.com/pycharm/download/#section=linux) and update `pycharm_version` accordingly

```bash
pycharm_version=2020.1.2
mkdir -p $HOME/apps/PyCharm
wget -O - https://download.jetbrains.com/python/pycharm-community-$pycharm_version.tar.gz | tar -C $HOME/apps/PyCharm/ --strip-components 1 -xzf -

wget -O - "https://telegram.org/dl/desktop/linux" | 7z x -si -txz -so | 7z x -si -ttar -o$HOME/apps
chmod +x $HOME/apps/Telegram/Telegram
wget -O - "https://www.dropbox.com/download?plat=lnx.x86_64" | tar -C $HOME/apps/ -xzf -

virtualenv -p python3 $HOME/apps/venv/vscode
$HOME/apps/venv/vscode/bin/python -m pip install -U flake8

```

## dotfiles

```bash
# reavaliate all these seds
rsync -az /usr/share/powerline/config_files/ $HOME/.config/powerline/
cd my-dotfiles
# validate if there is a bash_aliases already
yes | cp -vrf ubuntu-dotfiles/. $HOME/
# validate if there's a .profile
sed -i '$a \\n# new configuration\nexport HISTTIMEFORMAT="%d/%m/%y %T "' $HOME/.profile
source $HOME/.bashrc
sed -i '$a \\n# tilix configuration\nif [ $TILIX_ID ] || [ $VTE_VERSION ]; then\n  source /etc/profile.d/vte.sh\nfi' $HOME/.bashrc
# validate if necessary   
sudo ln -s /etc/profile.d/vte-2.91.sh /etc/profile.d/vte.sh
sed -i '$a \\n# Powerline configuration\nif [ -f /usr/share/powerline/bindings/bash/powerline.sh ]; then\n  powerline-daemon -q\n  POWERLINE_BASH_CONTINUATION=1\n  POWERLINE_BASH_SELECT=1\n  source /usr/share/powerline/bindings/bash/powerline.sh\nfi' $HOME/.bashrc
sed -i '$a \\n# Starship initialization\neval "$(starship init bash)"' $HOME/.bashrc
# maybe use this instead \
# if [[ $PROMPT_COMMAND = *"__vte_prompt_command"* ]]; then
#   eval "$(starship init bash)"
# fi
reboot
```

After reboot

```bash
# fix dconf to update to Yaru-Black
# see if it is possible to save gedit's conf through dconf
# validate dash-to-dock
dconf load /org/gnome/ < .config/dconf/gnome.conf
dconf load /com/gexperts/Tilix/ < .config/dconf/tilix.conf
dconf write /org/gnome/desktop/background/picture-uri "'file:///$HOME/Pictures/wallpaper/alena-aenami-stay-1k.jpg'"
dconf write /org/gnome/desktop/screensaver/picture-uri "'file:///$HOME/Pictures/wallpaper/alena-aenami-coldredlight.jpg'"

convert -crop 394x394+375+422 -resize 96x96 $HOME/Pictures/wallpaper/alena-aenami-rooflinesgirl-1k-2.jpg $HOME/.face

# update gdm3.css and ubuntu.css
```
