# dotfiles

## Win OS setup

1. *Elevated* [Install chocolatey](https://chocolatey.org/install)
2. *Elevated* `choco install git`
3. Copy ssh key
4. `cd ~ ; git clone git@github.com:saitonakamura/dotfiles.git; mv ~/dotfiles/**/* ~/`
5. *Elevated* `~/scripts/install-software.ps1` with appropriate options
6. *Elevated* `~/scripts/file-assoc.ps1`
7. Run `:PlugInstall` in `nvim-qt.exe`
