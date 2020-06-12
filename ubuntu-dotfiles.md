# Ubuntu

`sudo sed -i '$a '$USER' ALL=(ALL) NOPASSWD:ALL' /etc/sudoers`

## SSH Key

[Generating a new SSH key and adding it to the ssh-agent](https://help.github.com/articles/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent/).

```bash
ssh-keygen -t rsa -b 4096 -C "arthurazsoares@gmail.com"
eval "$(ssh-agent -s)"
ssh-add $HOME/.ssh/id_rsa
```

[Adding a new SSH key to your GitHub account](https://help.github.com/articles/adding-a-new-ssh-key-to-your-github-account/).

## Softwares

```bash
sudo apt update
sudo apt install -y software-properties-common apt-transport-https wget

sudo wget -qO - https://wavebox.io/dl/client/repo/archive.key | sudo apt-key add -
echo "deb https://wavebox.io/dl/client/repo/ x86_64/" | sudo tee --append /etc/apt/sources.list.d/wavebox.list
sudo add-apt-repository ppa:daniruiz/flat-remix

wget -qO - https://packages.microsoft.com/keys/microsoft.asc | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main"

sudo apt update
sudo apt upgrade
sudo apt install -y tilix rofi python3-pip fonts-firacode vim python3-distutils wireshark git p7zip-full vlc nemo dconf-editor wavebox ttf-mscorefonts-installer llvm clang curl code gnome-tweak-tool chrome-gnome-shell gconf2 powerline fonts-powerline tree insomnia-designer ipython3

sudo apt install -y flat-remix flat-remix-gtk flat-remix-gnome

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

wget https://release.gitkraken.com/linux/gitkraken-amd64.deb
sudo dpkg -i gitkraken-amd64.deb
# sudo apt --fix-broken install -y

for uuid in "user-theme@gnome-shell-extensions.gcampax.github.com" "Vitals@CoreCoding.com"; do shell_version=$(gnome-shell --version | cut -d' ' -f3); wget "https://extensions.gnome.org/download-extension/$uuid.shell-extension.zip?shell_version=$shell_version" -O tmp.zip; 7z x tmp.zip -o"$HOME/.local/share/gnome-shell/extensions/$uuid"; rm tmp.zip; done
```

Check the [latest pycharm version](https://www.jetbrains.com/pycharm/download/#section=linux) and update `pycharm_version` accordingly

```bash
pycharm_version=2020.1.2
wget -O - https://download.jetbrains.com/python/pycharm-community-$pycharm_version.tar.gz | tar -C $HOME/apps/PyCharm/ --strip-components 1 -xzf -
```

## dotfiles

```bash
rsync -az /usr/share/powerline/config_files/ $HOME/.config/powerline/
cd my-dotfiles
yes | cp -vrf ubuntu-dotfiles/. $HOME/
sed -i '$a \\n# new configuration\nexport HISTTIMEFORMAT="%d/%m/%y %T "' $HOME/.bashrc
source $HOME/.bashrc
cd $HOME/apps && wget -O - "https://telegram.org/dl/desktop/linux" | 7z x -si -txz -so | 7z x -si -ttar
chmod +x Telegram/Telegram
cd $HOME/apps && wget -O - "https://www.dropbox.com/download?plat=lnx.x86_64" | tar xzf -
cd $HOME/apps/venv
virtualenv -p python3 vscode
vscode/bin/python -m pip install -U flake8
sed -i '$a \\n# tilix configuration\nif [ $TILIX_ID ] || [ $VTE_VERSION ]; then\n  source /etc/profile.d/vte.sh\nfi' $HOME/.bashrc
sudo ln -s /etc/profile.d/vte-2.91.sh /etc/profile.d/vte.sh
sed -i '$a \\n# Powerline configuration\nif [ -f /usr/share/powerline/bindings/bash/powerline.sh ]; then\n  powerline-daemon -q\n  POWERLINE_BASH_CONTINUATION=1\n  POWERLINE_BASH_SELECT=1\n  source /usr/share/powerline/bindings/bash/powerline.sh\nfi' $HOME/.bashrc
sed -i '$a \\n# Starship initialization\neval "$(starship init bash)"' $HOME/.bashrc
sed -i '$a \\nsyntax on\ncolorscheme onedark\npython3 from powerline.vim import setup as powerline_setup\npython3 powerline_setup()\npython3 del powerline_setup\n\nset laststatus=2' $HOME/.vimrc
reboot
```

After reboot

```bash
dconf load /org/gnome/ < .config/dconf/gnome.conf
dconf load /com/gexperts/Tilix/ < .config/dconf/tilix.conf
dconf write /org/gnome/desktop/background/picture-uri "'file:///$HOME/Pictures/wallpaper/alena-aenami-stay-1k.jpg'"
dconf write /org/gnome/desktop/screensaver/picture-uri "'file:///$HOME/Pictures/wallpaper/alena-aenami-coldredlight.jpg'"
```

For this next part you will have to run some of the commands with sudo

```bash
convert -crop 394x394+375+422 -resize 96x96 $HOME/Pictures/wallpaper/alena-aenami-rooflinesgirl-1k-2.jpg $HOME/.face
sudo cp $HOME/.face /var/lib/AccountsService/icons/$USER
sudo sed -i '/Icon=/c\Icon=/var/lib/AccountsService/icons/'$USER /var/lib/AccountsService/users/$USER
```

<!-- TODO Add commands to change the login background image -->
