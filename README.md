# dotfiles

## Win OS setup

1. *Elevated* [Install chocolatey](https://chocolatey.org/install)
2. *Elevated* `choco install git`
3. Copy ssh key
4. `cd ~ ; git clone git@github.com:saitonakamura/dotfiles.git; mv ~/dotfiles/**/* ~/`
5. *Elevated* `~/scripts/install-software.ps1` with appropriate options
6. *Elevated* `~/scripts/file-assoc.ps1`
7. Run `:PlugInstall` in `nvim-qt.exe`

## Vim mnemonics

* `t` - test | (code )type | tab | terminal
* `u` - unit test
* `g` - goto, code navigation (code)
* `n` - navigate to, other than code navigation
* `b` - buffer
* `w` - write | window
* `c` - command | console
* `a` - action, code action
* `f` - format, fix | file | function
* `d` - directory | diagnostic | (code) definition
* `p` - pretty (format)
* `m` - map
* `[` - back, previous
* `]` - forward, next
* `s` - (code) symbol
* `r` - refator | (code) reference
* `i` - (code) implementation

## completion rules

* completion might be triggered as I type, or forcefully called via <Tab> or <Ctrl/Option-Space>
* completion items can be fuzzy/non-fuzzy filtered
* next/prev items can be selected by <Tab>/<Shift-Tab>
* completion should be disabled when pressing <Esc>
* item should be commited when <Enter> is pressed