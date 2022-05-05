get-github-latest-release() {
  curl -s -L "https://api.github.com/repos/$1/releases/latest" | \
      jq ".assets[] | select(.name | contains(\"$2\") and contains(\"$3\")) | .browser_download_url" --raw-output
}

# install-lua-langserver() {
#     gh repo clone sumneko/lua-language-server ~/.local/share/lua-language-server
#     cd ~/.local/share/lua-language-server
#     git submodule update --init --recursive

#     cd 3rd/luamake
#     ninja -f ninja/linux.ninja
#     cd ../..
#     ./3rd/luamake/luamake rebuild
# }

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


curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
sudo apt-get update

# sudo apt-get install ninja-build -y

sudo update-alternatives --install /usr/bin/vi vi /usr/bin/nvim 60
sudo update-alternatives --config vi
sudo update-alternatives --install /usr/bin/vim vim /usr/bin/nvim 60
sudo update-alternatives --config vim
sudo update-alternatives --install /usr/bin/editor editor /usr/bin/nvim 60
sudo update-alternatives --config editor

# install-npm-langservers
# install-lua-langserver

