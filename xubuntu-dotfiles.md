```bash
sudo sed -i '$a arthurazs ALL=(ALL) NOPASSWD:ALL' /etc/sudoers
sed -i '$a export PATH="$PATH:~/.local/bin"' ~/.bashrc

ssh-keygen -t rsa -b 4096 -C "arthurazsoares@gmail.com"
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_rsa

sudo apt install mininet tilix rofi python-pip fonts-firacode vim freeradius python3-distutils

pip install ryu
```
Download and install (`dpkg -i`) [vscode](https://code.visualstudio.com/docs/?dv=linux64_deb) and [gitkraken](https://www.gitkraken.com/download/linux-deb).

```bash
sudo apt --fix-broken install

source ~/.bashrc

mkdir -p ~/apps/venv
cd ~/apps/venv
virtualenv -p python3 vscode
```

Configure hotkey for `rofi -show run -run-list-command ". .alias.sh" -run-command "/bin/bash -i -c '{cmd}'" -rnow`

```bash
sed -i '$a if [ $TILIX_ID ] || [ $VTE_VERSION ]; then\n        source /etc/profile.d/vte.sh\nfi' ~/.bashrc
sudo ln -s /etc/profile.d/vte-2.91.sh /etc/profile.d/vte.sh
```
