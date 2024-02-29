rm -rf ~/.local/go
wget https://go.dev/dl/go1.22.0.linux-amd64.tar.gz -O /tmp/go.tar.gz
tar -xzf /tmp/go.tar.gz -C ~/.local
echo 'export PATH="$PATH:$HOME/.local/go/bin"' >> ~/.profile
. ~/.profile
~/.local/bin/vim +GoInstallBinaries

