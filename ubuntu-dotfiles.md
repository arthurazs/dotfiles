# Ubuntu

`sudo sed -i '$a arthurazs ALL=(ALL) NOPASSWD:ALL' /etc/sudoers`

## SSH Key

[Generating a new SSH key and adding it to the ssh-agent](https://help.github.com/articles/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent/).

```bash
ssh-keygen -t rsa -b 4096 -C "arthurazsoares@gmail.com"
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_rsa
```

[Adding a new SSH key to your GitHub account](https://help.github.com/articles/adding-a-new-ssh-key-to-your-github-account/).

## Softwares

```bash
sudo apt update
sudo apt install -y software-properties-common apt-transport-https wget

sudo wget -qO - https://wavebox.io/dl/client/repo/archive.key | sudo apt-key add -
echo "deb https://wavebox.io/dl/client/repo/ x86_64/" | sudo tee --append /etc/apt/sources.list.d/wavebox.list
sudo add-apt-repository ppa:daniruiz/flat-remix

wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main"

sudo apt update
sudo apt upgrade
sudo apt install -y tilix rofi python3-pip fonts-firacode vim python3-distutils wireshark git p7zip-full vlc nemo dconf-editor wavebox ttf-mscorefonts-installer llvm clang curl code gnome-tweak-tool chrome-gnome-shell gconf2

sudo apt install -y flat-remix flat-remix-gtk flat-remix-gnome

code --install-extension aaron-bond.better-comments
code --install-extension coenraads.bracket-pair-colorizer-2
code --install-extension pkief.material-icon-theme
code --install-extension zhuangtongfa.material-theme
code --install-extension ms-python.python

pip3 install virtualenv
sudo gpasswd -a arthurazs wireshark
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
source ~/.cargo/env
cargo install bat

wget https://release.gitkraken.com/linux/gitkraken-amd64.deb
sudo dpkg -i gitkraken-amd64.deb
# sudo apt --fix-broken install -y
```

## dotfiles

```bash
cd my-dotfiles
yes | cp -vrf ubuntu-dotfiles/. ~/
sed -i '$a export HISTTIMEFORMAT="%d/%m/%y %T "\n\nexport PATH="$PATH:~/.local/bin"' ~/.bashrc
source ~/.bashrc
cd ~/apps && wget -O - "https://telegram.org/dl/desktop/linux" | 7z x -si -txz -so | 7z x -si -ttar
chmod +x Telegram/Telegram
cd ~/apps && wget -O - "https://www.dropbox.com/download?plat=lnx.x86_64" | tar xzf -
cd ~/apps/venv
virtualenv -p python3 vscode
vscode/bin/python -m pip install -U flake8
sed -i '$a if [ $TILIX_ID ] || [ $VTE_VERSION ]; then\n        source /etc/profile.d/vte.sh\nfi' ~/.bashrc
sudo ln -s /etc/profile.d/vte-2.91.sh /etc/profile.d/vte.sh
reboot
```

After reboot

```bash
dconf load /org/gnome/ < .config/dconf/gnome.conf
dconf load /com/gexperts/Tilix/ < .config/dconf/tilix.conf
```
