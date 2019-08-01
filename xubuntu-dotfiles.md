# xUbuntu

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
sudo apt upgrade
sudo apt install mininet tilix rofi python3-pip fonts-firacode vim freeradius python3-distutils wireshark git

pip3 install ryu
pip3 install virtualenv
```

Download and install (`dpkg -i`) [vscode](https://code.visualstudio.com/docs/?dv=linux64_deb) and [gitkraken](https://www.gitkraken.com/download/linux-deb).

`sudo apt --fix-broken install`

**Install in vscode:**

- Better Comments by Aaron Bond
- Bracket Pair Colorizer 2 by CoenraadS
- Material Icon Theme by Philipp Kief
- One Dark Pro by binaryify
- Python by Microsoft

## dotfiles

```bash
cd my-dotfiles
yes | cp -vrf xubuntu-dotfiles/. ~/
sed -i '$a export HISTTIMEFORMAT="%d/%m/%y %T "\n\nexport PATH="$PATH:~/.local/bin"' ~/.bashrc
source ~/.bashrc
cd ~/apps/venv
virtualenv -p python3 vscode
vscode/bin/python -m pip install -U flake8
sed -i '$a if [ $TILIX_ID ] || [ $VTE_VERSION ]; then\n        source /etc/profile.d/vte.sh\nfi' ~/.bashrc
sudo ln -s /etc/profile.d/vte-2.91.sh /etc/profile.d/vte.sh
reboot
```

## Hotkeys

Configure hotkey (Super+D) in *Keyboard* for `rofi -show run -run-list-command ". .alias.sh" -run-command "/bin/bash -i -c '{cmd}'" -rnow`.

Configure hotkey (Super+Enter) in *Keyboard* for `tilix`.

Configure hotkey (Super+F2) in *Keyboard* for `exo-open --launch WebBrowser`.

Configure hotkey (Super+F3) in *Keyboard* for `exo-open --launch FileManager`.

Configure hotkey (\<Shift>\<Super>Q) in *Settings Editor* for `close_window_key`.
