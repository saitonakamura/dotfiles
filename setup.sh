git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

rm ~/.zshrc
ln -sfn ~/dotfiles/.zshrc ~/.zshrc
ln -sfn ~/dotfiles/init.vim ~/.config/nvim/init.vim
ln -sfn ~/dotfiles/vscode/settings.json ~/Library/ApplicationSupport/Code/User/settings.json
ln -sfn ~/dotfiles/vscode/keybindings.json ~/Library/ApplicationSupport/Code/User/keybindings.json
ln -sfn ~/dotfiles/vscode/settings.json ~/.vscode-server/data/Machine/settings.json
ln -sfn ~/dotfiles/vscode/keybindings.json ~/.vscode-server/data/Machine/keybindings.json
ln -sfn ~/dotfiles/.fdignore ~/.fdignore
ln -sfn ~/dotfiles/.ideavimrc ~/.ideavimrc
ln -sfn ~/dotfiles/saitonakamura.zsh-theme ~/.oh-my-zsh/custom/themes/saitonakamura.zsh-theme
ln -sfn ~/dotfiles/.p10k.zsh ~/.p10k.zsh
