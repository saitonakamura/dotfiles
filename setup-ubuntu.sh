get-github-latest-release() {
  curl -s -L "https://api.github.com/repos/$1/releases/latest" | \
      jq ".assets[] | select(.name | contains(\"$2\") and contains(\"$3\")) | .browser_download_url" --raw-output
}

install-lua-langserver() {
    gh repo clone sumneko/lua-language-server ~/.local/share/lua-language-server
    cd ~/.local/share/lua-language-server
    git submodule update --init --recursive

    cd 3rd/luamake
    ninja -f ninja/linux.ninja
    cd ../..
    ./3rd/luamake/luamake rebuild
}

sh ./setup.sh

ln -sfn ~/dotfiles/vscode/settings.json ~/.vscode-server/data/machine/settings.json
ln -sfn ~/dotfiles/vscode/keybindings.json ~/.vscode-server/data/machine/keybindings.json
ln -sfn ~/dotfiles/.npmrc ~/.npmrc

mkdir ~/.local
mkdir ~/.local/bin
mkdir ~/.local/share

mkdir ~/.npm-global
mkdir ~/.npm-global/bin

sudo apt-get update

sudo apt-get install software-properties-common -y
sudo add-apt-repository ppa:neovim-ppa/unstable -y
sudo apt-get update
sudo apt-get install neovim -y

sudo apt-get install jq -y

sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-key C99B11DEB97541F0
sudo apt-add-repository https://cli.github.com/packages
sudo apt-get update
sudo apt-get install gh -y

sudo apt-get install ninja-build -y

wget https://packages.microsoft.com/config/ubuntu/20.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
sudo dpkg -i packages-microsoft-prod.deb
rm packages-microsoft-prod.deb
sudo apt-get update
sudo apt-get install -y apt-transport-https && \
sudo apt-get update && \
sudo apt-get install -y dotnet-sdk-5.0

sudo update-alternatives --install /usr/bin/vi vi /usr/bin/nvim 60
sudo update-alternatives --config vi
sudo update-alternatives --install /usr/bin/vim vim /usr/bin/nvim 60
sudo update-alternatives --config vim
sudo update-alternatives --install /usr/bin/editor editor /usr/bin/nvim 60
sudo update-alternatives --config editor

rm -rf ~/.local/share/omnisharp
mkdir ~/.local/share/omnisharp
curl -L "$(get-github-latest-release OmniSharp/omnisharp-roslyn omnisharp-linux x64.tar)" | \
    tar --extract --gzip --directory ~/.local/share/omnisharp
ln -sfn ~/.local/share/omnisharp/run ~/.local/bin/omnisharp-language-server


curl -L "$(get-github-latest-release sharkdp/bat bat_ amd64.deb)" -o /tmp/bat.deb
sudo dpkg -i /tmp/bat.deb
rm /tmp/bat.deb

curl -L "$(get-github-latest-release ogham/exa exa-linux x86_64)" -o /tmp/exa.zip
unzip -d ~/.local/bin /tmp/exa.zip
mv ~/.local/bin/exa-linux-x86_64 ~/.local/bin/exa
rm /tmp/exa.zip


install-npm-langservers
install-lua-langserver

npm install -g esy
sudo apt-get install m4 -y
