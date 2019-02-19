# Manjaro

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
sudo pacman -Syu
sudo pacman -R yaourt
sudo pacman -S yay
yay -S google-chrome
sudo pacman -S rofi
sudo pacman -S python-pip
yay -S visual-studio-code-bin
sudo pacman -S otf-fira-code
yay -S gitkraken
sudo pacman -S gvim
code
```

**Install in vscode:**

- Better Comments by Aaron Bond
- Bracket Pair Colorizer 2 by CoenraadS
- Material Icon Theme by Philipp Kief
- One Dark Pro by binaryify
- Python by Microsoft

## Browser

[Set the default browser, system-wide, on Manjaro](https://unix.stackexchange.com/a/434465).
```
vim ~/.config/mimeapps.list  # google-chrome-stable.desktop
vim ~/.profile  # export BROWSER=/usr/bin/google-chrome-stable
```

## dotfiles

```bash
cd ~/apps/venv
virtualenv -p python vscode
cd i3manjaro-dotfiles
yes | cp -vrf dotfiles/. ~/
nitrogen --set-scaled ~/Pictures/wallpaper/martino-pietropoli.jpg --save
sed -i '$a export PATH="$PATH:~/.local/bin"\nif [ -f ~/.bash_aliases ]; then\n    . ~/.bash_aliases\nfi' ~/.bashrc
sed -i '$a export HISTTIMEFORMAT="%d/%m/%y %T "' ~/.bashrc
sed -i '$a export PATH="$PATH:~/.local/bin"\nif [ -f ~/.bash_aliases ]; then\n    . ~/.bash_aliases\nfi' ~/.xinitrc
sudo reboot
```

## OpenvSwitch

```bash
git clone https://github.com/openvswitch/ovs.git
cd ovs
./boot.sh
pip install six --user
pip install flake8 --user
./configure
make  # http://docs.openvswitch.org/en/latest/intro/install/general/
sudo make install
sed -i '$a export PATH="$PATH:/usr/local/share/openvswitch/scripts"' ~/.bashrc
. ~/.bashrc
mkdir -p /usr/local/etc/openvswitch
sudo mkdir -p /usr/local/var/log/openvswitch/
sudo mkdir -p /usr/local/var/run/openvswitch
sudo touch /usr/local/var/log/openvswitch/ovs-vswitchd.log
sudo ovsdb-tool create /usr/local/etc/openvswitch/conf.db vswitchd/vswitch.ovsschema
sudo reboot
# sudo ovsdb-server --remote=punix:/usr/local/var/run/openvswitch/db.sock --remote=db:Open_vSwitch,Open_vSwitch,manager_options --private-key=db:Open_vSwitch,SSL,private_key --certificate=db:Open_vSwitch,SSL,certificate --bootstrap-ca-cert=db:Open_vSwitch,SSL,ca_cert --pidfile --detach --log-file
# sudo ovsdb-server --remote=punix:/usr/local/var/run/openvswitch/db.sock --remote=db:Open_vSwitch,Open_vSwitch,manager_options --pidfile --detach --log-file
# sudo ovs-vsctl --no-wait init
# ovs-vswitchd --pidfile --detach --log-file
```

## mininet

```bash
git clone http://github.com/mininet/mininet
cd mininet
# py3 env
sudo python setup.py install
gcc mnexec.c
sudo mv a.out /usr/bin/mnexec
pacman -S net-tools
pacman -S tcpdump
pacman -S wireshark-qt
pip install ryu --user
# ryu-manager ryu.app.simple_switch
# mn --controller remote
```
