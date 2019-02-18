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
sudo pacman -R yaourt
sudo pacman -S yay
yay -S visual-studio-code-bin
yay -S google-chrome
sudo pacman -S python-pip
sudo pacman -S otf-fira-code
```

## Browser

[Set the default browser, system-wide, on Manjaro](https://unix.stackexchange.com/a/434465).
```
vim ~/.config/mimeapps.list  # google-chrome-stable.desktop
vim ~/.profile  # export BROWSER=/usr/bin/google-chrome-stable
```

## dotfiles

```bash
yes | cp -vrf dotfiles/. ~/
nitrogen --set-scaled ~/Pictures/wallpaper/martino-pietropoli.jpg --save
```

## Alias

```bash
sed -i '$a export PATH="$PATH:~/.local/bin"\nif [ -f ~/.bash_aliases ]; then\n    . ~/.bash_aliases\nfi' ~/.bashrc

sed -i '$a export PATH="$PATH:~/.local/bin"\nif [ -f ~/.bash_aliases ]; then\n    . ~/.bash_aliases\nfi' ~/.xinitrc
```

## vscode

```bash
cd ~/apps/venv
virtualenv -p python vscode
```

**Install**

- Better Comments by Aaron Bond
- Bracket Pair Colorizer 2 by CoenraadS
- Material Icon Theme by Philipp Kief
- One Dark Pro by binaryify
- Python by Microsoft

## mininet

```bash
git clone http://github.com/mininet/mininet
cd mininet
# py3 env
python setup.py install
gcc mnexec.c
mv a.out ~/apps/venv/python3/bin/mnexec
```

## OpenvSwitch

```bash
git clone https://github.com/openvswitch/ovs.git
./boot.sh
pip install six
pip install flake8
./configure
make  # http://docs.openvswitch.org/en/latest/intro/install/general/
```
