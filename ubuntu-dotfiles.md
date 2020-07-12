<!-- TODO

https://github.com/thiggy01/ubuntu-20.04-change-gdm-background
https://github.com/PRATAP-KUMAR/focalgdm3/tree/master
https://askubuntu.com/questions/1230714/lock-screen-wallpaper-option-on-ubuntu-20-04-lts-is-not-available -->

# Ubuntu

This *dotfile* was tested on Ubuntu 20.04.

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
sudo sed -i '$a '$USER' ALL=(ALL) NOPASSWD:ALL' /etc/sudoers

wget -qO - https://wavebox.io/dl/client/repo/archive.key | sudo apt-key add -
echo "deb https://wavebox.io/dl/client/repo/ x86_64/" | sudo tee --append /etc/apt/sources.list.d/wavebox.list

wget -qO - https://packages.microsoft.com/keys/microsoft.asc | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main"  # check if necessary

sudo apt update
sudo apt upgrade

# validar se ta instalado: imagemagick-6.q16 imagemagick-6 imagemagick-6-common
# gconf2 for gitkraken, imagemagick to crop wallpaper
sudo apt install -y tilix rofi python3-pip fonts-firacode vim wireshark git p7zip-full vlc nemo curl code gconf2 tree ipython3 imagemagick gufw ttf-mscorefonts-installer wavebox
sudo ufw enable

code --install-extension aaron-bond.better-comments
code --install-extension coenraads.bracket-pair-colorizer-2
code --install-extension pkief.material-icon-theme
code --install-extension zhuangtongfa.material-theme
code --install-extension ms-python.python

pip3 install virtualenv
sudo gpasswd -a $USER wireshark
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
source $HOME/.cargo/env
cargo install bat

for uuid in "https://release.gitkraken.com/linux/gitkraken-amd64.deb" "https://updates.insomnia.rest/downloads/ubuntu/latest?app=com.insomnia.app" "https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb"; do sudo dpkg -i tmp.deb; rm tmp.deb; done

for uuid in "user-theme@gnome-shell-extensions.gcampax.github.com" "Vitals@CoreCoding.com"; do shellversion=$(gnome-shell --version | cut -d' ' -f3); wget -O tmp.zip "https://extensions.gnome.org/download-extension/$uuid.shell-extension.zip?shell_version=$shellversion"; 7z x tmp.zip -o"$HOME/.local/share/gnome-shell/extensions/$uuid"; rm tmp.zip; done
```

Check the [latest pycharm version](https://www.jetbrains.com/pycharm/download/#section=linux) and update `pycharm_version` accordingly

```bash
pycharm_version=2020.1.2
mkdir -p $HOME/apps/PyCharm
wget -O - https://download.jetbrains.com/python/pycharm-community-$pycharm_version.tar.gz | tar -C $HOME/apps/PyCharm/ --strip-components 1 -xzf -

wget -O - "https://telegram.org/dl/desktop/linux" | 7z x -si -txz -so | 7z x -si -ttar -o$HOME/apps
chmod +x $HOME/apps/Telegram/Telegram
wget -O - "https://www.dropbox.com/download?plat=lnx.x86_64" | tar -C $HOME/apps/ -xzf -

$HOME/.local/bin/virtualenv -p python3 $HOME/apps/venv/vscode
$HOME/apps/venv/vscode/bin/python -m pip install -U flake8

```

## Optional

### If you use a laptop

```bash
sudo apt install -y tlp
sudo tlp start
sudo tlp-stat -s
```

### If you have a SSD

Add `noatime,` in `/etc/fstab` before:

- `errors=` for the / partition
- `defaults` for the /home partition

Update `sysctl.conf`:

```bash
sudo sed -i '$a \\n# Sharply reduce the inclination to swap\nvm.swappiness=5' /etc/sysctl.conf
```

If you use firefox:

1. enter `about:config` in the URL bar;
2. enter ` browser.cache.disk.enable` in the search bar;
3. toggle its value to `false` by double-clicking;
4. enter `browser.cache.memory.capacity` in the search bar;
5. set its value to `204800`;
6. enter `browser.sessionstore.interval` in the search bar; and
7. set its value to `15000000`.

Enter `about:cache` in the URL bar and check if it is using disk only.

## dotfiles

```bash
cd my-dotfiles
yes | cp -vrf ubuntu-dotfiles/. $HOME/
sed -i '$a \\n# new configuration\nexport HISTTIMEFORMAT="%d/%m/%y %T "' $HOME/.profile
sed -i '$a \\n# tilix configuration\nif [ $TILIX_ID ] || [ $VTE_VERSION ]; then\n  source /etc/profile.d/vte.sh\nfi' $HOME/.bashrc
sudo ln -s /etc/profile.d/vte-2.91.sh /etc/profile.d/vte.sh
reboot
```

After reboot

```bash
dconf load /org/gnome/ < .config/dconf/gnome.conf
dconf load /com/gexperts/Tilix/ < .config/dconf/tilix.conf
dconf write /org/gnome/desktop/background/picture-uri "'file:///$HOME/Pictures/wallpaper/alena-aenami-stay-1k.jpg'"
dconf write /org/gnome/desktop/screensaver/picture-uri "'file:///$HOME/Pictures/wallpaper/alena-aenami-coldredlight.jpg'"

convert -crop 394x394+375+422 -resize 96x96 $HOME/Pictures/wallpaper/alena-aenami-rooflinesgirl-1k-2.jpg $HOME/.face

apt purge -y imagemagick
```

## NOTE

Wallpaper by [Alena Aenami](https://gumroad.com/aenamiart).

- Alena on [Behance](https://www.behance.net/aenami)
- Alena on [Artstation](https://aenamiart.artstation.com/)
- Alena on [DeviantArt](https://www.deviantart.com/aenami)

Consider donating to Alena on [Patreon](https://www.patreon.com/aenamiart)
