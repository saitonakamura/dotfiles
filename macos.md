## brew

https://brew.sh

```sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

## 1password

https://1password.com/downloads/mac/

## app store stuff

* ominvore
* xcode
* 1password for safari
* magnet
* slack

## middle

https://middleclick.app

## kitty

```sh
brew install kitty
```

* write `include ~/dotfiles/kitty.conf` at the top of the config file

## ssh

* copy keys
 
```sh
brew install keychain
```

## gh

```sh
brew install gh
gh auth login
```

## dotfiles

```sh
cd ~
gh repo clone saitonakamura/dotfiles
```

## show all files

```sh
defaults write com.apple.Finder AppleShowAllFiles true
killall Finder
```

## vscode

```sh
brew install visual-studio-code
```

* enable settings sync
* disable context-dependent extensions

## cascadia code

https://github.com/microsoft/cascadia-code#installation