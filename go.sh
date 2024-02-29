rm -r ~/.local/go
wget https://go.dev/dl/go1.22.0.linux-amd64.tar.gz -O /tmp/go.tar.gz
tar -xzf /tmp/go.tar.gz -C ~/.local
echo -e 'export GOPATH="/home/$USER/.local/go"\nexport GOBIN="$GOPATH/bin"\nexport PATH="$PATH:$GOBIN"' >> ~/.profile
vim +GoInstallBinaries

