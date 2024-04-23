## macos

- set lang change to option space
- set caps lock to esc
- set keyboard repeat rate to fast

## brew

https://brew.sh

```sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

## 1password

https://1password.com/downloads/mac/

## app store stuff

- ominvore
- xcode
- 1password for safari
- vimari
- magnet
- slack

## middle

https://middleclick.app

## cascadia code

https://github.com/microsoft/cascadia-code#installation

## kitty

```sh
brew install kitty
defaults write -app kitty ApplePressAndHoldEnabled -bool false
ln -s ~/dotfiles/.config/kitty ~/.config/kitty
```

## ssh

- copy keys

```sh
brew install keychain
```

## git

```sh
brew install git
ln -sfn ~/dotfiles/.gitconfig ~/.gitconfig
```

## git sign

```conf
[commit]
  gpgsign = true
[tag]
  gpgsign = true
```

## gh

```sh
brew install gh
gh auth login
```

## dotfiles

```sh
gh repo clone saitonakamura/dotfiles ~/dotfiles
```

## show all files

```sh
defaults write com.apple.Finder AppleShowAllFiles true
killall Finder
```

## vscode

```sh
brew install visual-studio-code
defaults write com.microsoft.VSCode ApplePressAndHoldEnabled -bool false
defaults delete -g ApplePressAndHoldEnabled
```

- enable settings sync
- disable context-dependent extensions

## neovim

```sh
brew install neovim
mkdir -p ~/.config/nvim
ln -sfn ~/dotfiles/nvim/init.lua ~/.config/nvim/init.lua
ln -sfn ~/dotfiles/nvim/stylua.toml ~/.config/nvim/stylua.toml
ln -sfn ~/dotfiles/nvim/.neoconf.json ~/.config/nvim/.neoconf.json
ln -s ~/dotfiles/nvim/lua ~/.config/nvim/lua
# ln -sfn ~/dotfiles/nvim/init.lua ~/.config/nvim/init.lua
# ln -s ~/dotfiles/nvim/lua ~/.config/nvim/lua
```

### paq

https://github.com/savq/paq-nvim/#installation

```sh
git clone --depth=1 https://github.com/savq/paq-nvim.git \
    "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/pack/paqs/start/paq-nvim
```

## neovide

```sh
brew install neovide
# TODO fix version?
ln -sfv /opt/homebrew/Cellar/neovide/0.11.1/Neovide.app /Applications/Neovide.app
mkdir  ~/.config/neovide
ln -sfn ~/dotfiles/neovide/config.toml ~/.config/neovide/config.toml
```

````

## starship

https://starship.rs/guide/

```sh
mkdir -p ~/.config
ln -sfn ~/dotfiles/.config/starship.toml ~/.config/starship.toml
````

## omz

https://github.com/ohmyzsh/ohmyzsh#basic-installation

https://ss64.com/osx/syntax-profile.html

```sh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
rm ~/.zshrc
ln -sfn ~/dotfiles/.zshenv ~/.zshenv
ln -sfn ~/dotfiles/.zshrc ~/.zshrc
ln -sfn ~/dotfiles/.p10k.zsh ~/.p10k.zsh
```

## fzf

https://github.com/junegunn/fzf#using-homebrew
https://github.com/Aloxaf/fzf-tab#oh-my-zsh

```sh
brew install fzf
$(brew --prefix)/opt/fzf/install
git clone https://github.com/Aloxaf/fzf-tab ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/fzf-tab
```

- cleanup bash stuff

## bat

https://github.com/sharkdp/bat#on-macos-or-linux-via-homebrew

```sh
brew install bat
```

## stuff

```sh
brew install jq exa ripgrep
```

## fd

https://github.com/sharkdp/fd#on-macos

```sh
brew install fd
```

## code

```sh
mkdir ~/code
```

## fnm

```sh
curl -fsSL https://fnm.vercel.app/install | bash -s -- --skip-shell
```

- restart shell

```sh
fnm install --lts --corepack-enabled
```

## yarn

```sh
ln -sfn ~/dotfiles/.yarnrc.yml ~/.yarnrc.yml
```

## python

```sh
brew install python
```

### pipenv

```sh
pip3 install pipenv --user
```
