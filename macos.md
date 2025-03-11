## macos

- set keyboard repeat rate to fast
- remove junk (imovie, garage band)

## show all files

```sh
defaults write com.apple.Finder AppleShowAllFiles true
killall Finder
```

## 1password

https://1password.com/downloads/mac/

## brew

https://brew.sh

```sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
echo >> ~/.zprofile
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
```

## app store stuff

- readwise
- xcode
- 1password for safari
- vimari
- magnet
- slack
- duckduck

## ssh

- copy keys
- configure 1pass

## git

```sh
brew install git
ln -sfn ~/dotfiles/.gitconfig ~/.gitconfig
```


## gh

```sh
brew install gh
gh auth login
```

## git sign

copy `.local.gitconfig.sample` to `.local.gitconfig` and uncomment macos line

## dotfiles

```sh
gh repo clone saitonakamura/dotfiles ~/dotfiles
```


## vscode

```sh
brew install visual-studio-code
defaults write com.microsoft.VSCode ApplePressAndHoldEnabled -bool false
```

- enable settings sync
- disable context-dependent extensions

## middle

https://middleclick.app

## fonts

https://www.nerdfonts.com ?

https://github.com/microsoft/cascadia-code#installation

## kitty

```sh
brew install kitty
defaults write -app kitty ApplePressAndHoldEnabled -bool false
```
add `include ~/dotfiles/.config/kitty/kitty.mine.conf` to default kitty conf


## neovim

```sh
brew install neovim
mkdir -p ~/.config/nvim
ln -sfn ~/dotfiles/nvim/init.lua ~/.config/nvim/init.lua
ln -sfn ~/dotfiles/nvim/stylua.toml ~/.config/nvim/stylua.toml
ln -sfn ~/dotfiles/nvim/.neoconf.json ~/.config/nvim/.neoconf.json
ln -s ~/dotfiles/nvim/lua ~/.config/nvim/lua
# ln -sfn ~/dotfiles/nvim/init.lua ~/.config/nvim/init.lua # ln -s ~/dotfiles/nvim/lua ~/.config/nvim/lua
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
mkdir  ~/.config/neovide
ln -sfn ~/dotfiles/neovide/config.toml ~/.config/neovide/config.toml
```

````

## starship

https://starship.rs/guide/

```sh
brew install starship
mkdir -p ~/.config
ln -sfn ~/dotfiles/.config/starship.toml ~/.config/starship.toml
````

## zsh

https://ss64.com/osx/syntax-profile.html

```sh
rm ~/.zshrc
git submodule update --init 
ln -sfn ~/dotfiles/.zshenv ~/.zshenv
ln -sfn ~/dotfiles/.zprofile ~/.zprofile
ln -sfn ~/dotfiles/.zshrc ~/.zshrc
```

## fzf

https://github.com/junegunn/fzf#using-homebrew
https://github.com/Aloxaf/fzf-tab#oh-my-zsh

```sh
brew install fzf
$(brew --prefix)/opt/fzf/install
```

- cleanup bash stuff

## bat

https://github.com/sharkdp/bat#on-macos-or-linux-via-homebrew

```sh
brew install bat
```

## stuff

```sh
brew install jq ripgrep
ln -sfn ~/dotfiles/.ripgreprc ~/.ripgreprc
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

## stuff other

```sh
brew install lazygit hyperfine
brew install --cask logseq raycast karabiner-elements ukelele chromium google-chrome figma obs discord
```

## karabiner

```shell
mkdir ~/code/personal/
gh repo clone saitonakamura/KE-complex_modifications ~/code/personal/KE-complex_modifications/
cd ~/code/personal/KE-complex_modifications/
git submodule update --init
```
```
