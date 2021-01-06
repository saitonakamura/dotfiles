install-lua-langserver() {
    gh repo clone sumneko/lua-language-server ~/.local/share/lua-language-server
    cd ~/.local/share/lua-language-server
    git submodule update --init --recursive

    cd 3rd/luamake
    ninja -f ninja/macos.ninja
    cd ../..
    ./3rd/luamake/luamake rebuild
}

sh ./setup.sh

ln -sfn ~/dotfiles/vscode/settings.json ~/Library/ApplicationSupport/Code/User/settings.json
ln -sfn ~/dotfiles/vscode/keybindings.json ~/Library/ApplicationSupport/Code/User/keybindings.json

mkdir ~/.local
mkdir ~/.local/bin
mkdir ~/.local/share

install-npm-langservers
install-lua-langserver