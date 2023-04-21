## prepare

```sh
sudo apt update && sudo apt upgrade -y
```

## ssh

* copy
```sh
chmod go-r ~/.ssh/*
```

## install gh
https://github.com/cli/cli/blob/trunk/docs/install_linux.md#debian-ubuntu-linux-raspberry-pi-os-apt

```sh
type -p curl >/dev/null || (sudo apt update && sudo apt install curl -y)
curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg \
&& sudo chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg \
&& echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
&& sudo apt update \
&& sudo apt install gh -y
```

## get dotfiles

```sh
gh auth login
gh repo clone saitonakamura/dotfiles ~/dotfiles
cd ~/dotfiles
```

### setup git

```sh
ln -sfn ~/dotfiles/.gitconfig ~/.gitconfig
```

## install nvim

https://github.com/neovim/neovim/wiki/Installing-Neovim#ubuntu

```sh
sudo add-apt-repository ppa:neovim-ppa/unstable -y
sudo apt-get update
sudo apt-get install neovim -y
```

set as editor

```sh
sudo update-alternatives --install /usr/bin/vi vi /usr/bin/nvim 60
sudo update-alternatives --config vi
sudo update-alternatives --install /usr/bin/vim vim /usr/bin/nvim 60
sudo update-alternatives --config vim
sudo update-alternatives --install /usr/bin/editor editor /usr/bin/nvim 60
sudo update-alternatives --config editor
```

### nvim plug

https://github.com/junegunn/vim-plug#unix-linux

```sh
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
```

### nvim settings

```sh
mkdir ~/.config
mkdir ~/.config/nvim
ln -sfn ~/dotfiles/init.vim ~/.config/nvim/init.vim
ln -sfn ~/dotfiles/.ideavimrc ~/.ideavimrc
nvim -c PlugInstall -c qall
ln -sfn ~/dotfiles/.ideavimrc ~/.ideavimrc
```

## zsh

```sh
sudo apt install zsh -y
chsh -c $(which zsh)
```

restart shell

```sh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
rm ~/.zshrc
ln -sfn ~/dotfiles/.zshrc ~/.zshrc
ln -sfn ~/dotfiles/.zshenv ~/.zshenv
ln -sfn ~/dotfiles/.p10k.zsh ~/.p10k.zsh
```

## fzf

https://github.com/junegunn/fzf#using-linux-package-managers
https://github.com/Aloxaf/fzf-tab#oh-my-zsh

```sh
sudo apt install fzf -y
git clone https://github.com/Aloxaf/fzf-tab ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/fzf-tab
```

restart shell

## fd

https://github.com/sharkdp/fd#on-ubuntu

```sh
sudo apt install fd-find -y
mkdir -p ~/.local/bin
ln -s /usr/bin/fdfind ~/.local/bin/fd
ln -sfn ~/dotfiles/.fdignore ~/.fdignore
```

## fnm

```sh
sudo apt install curl unzip -y
curl -fsSL https://fnm.vercel.app/install | bash -s -- --skip-shell
```

restart shell

```sh
fnm install --lts
```

restart shell

## yarn

```sh
ln -sfn ~/dotfiles/.yarnrc.yml ~/.yarnrc.yml
corepack enable
```

## code

```sh
mkdir ~/code
```

### stuff

```sh
sudo apt install bat jq exa ripgrep -y
```

## bat

```sh
sudo apt install bat -y
mkdir -p ~/.local/bin
ln -s /usr/bin/batcat ~/.local/bin/bat
```

restart shell