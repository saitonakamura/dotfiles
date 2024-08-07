sudo apt update
sudo apt install zsh -y
chsh -c $(which zsh)
# reload shell
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/Aloxaf/fzf-tab ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/fzf-tab

rm ~/.zshrc

mkdir ~/.config
mkdir ~/.config/nvim

ln -sfn ~/dotfiles/.zshrc ~/.zshrc
ln -sfn ~/dotfiles/.zshenv ~/.zshenv
ln -sfn ~/dotfiles/init.vim ~/.config/nvim/init.vim
ln -sfn ~/dotfiles/.ideavimrc ~/.ideavimrc
ln -sfn ~/dotfiles/.p10k.zsh ~/.p10k.zsh
ln -sfn ~/dotfiles/.gitconfig ~/.gitconfig
ln -sfn ~/dotfiles/.yarnrc.yml ~/.yarnrc.yml

install-npm-langservers() {
	npm install -g vim-language-server
	npm install -g vscode-css-languageserver-bin
	npm install -g vscode-html-languageserver-bin
	npm install -g vscode-json-languageserver
	npm install -g typescript typescript-language-server
	npm install -g bash-language-server
}
