# HELPERS

command_exists () {
  type "$1" &> /dev/null ;
}

# COLORS
if command_exists "defaults" ; then
  theme=`defaults read -g AppleInterfaceStyle` &>/dev/null
  system='Macos'

  if [ "$theme" = 'Dark' ] ; then
    theme='dark'
  else
    theme='light'
  fi
fi

if command_exists "reg.exe" ; then
  system='WSL'

  appsUseLightTheme=`reg.exe query "HKCU\\Software\\Microsoft\\Windows\\CurrentVersion\\Themes\\Personalize" /v AppsUseLightTheme | sed '2 s/.*//' | sed '3 s/^.*0x//g' | sed '/^\s*$/d'`
  if [ "$appsUseLightTheme" = '0' ] ; then
    theme='dark'
  else
    theme='light'
  fi
fi

if [ "$theme" = 'dark' ] ; then
  echo -e "\033]1337;SetColors=preset=OneHalfDark\a"
  export BAT_THEME="OneHalfDark"
  export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS --color dark"
else
  echo -e "\033]1337;SetColors=preset=OneHalfLight\a"
  export BAT_THEME="OneHalfLight"
  export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS --color light"
fi

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

bat_force_colors="--color=always --theme=$BAT_THEME"

# Powerlevel10k instant prompt

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# VARIABLES
username=`id -un`
DEFAULT_USER="$username"
ZSH_THEME="powerlevel10k/powerlevel10k"

zstyle ':omz:update' mode auto

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/keychain
zstyle :omz:plugins:keychain agents ssh
zstyle :omz:plugins:keychain identities id_ed25519

if [ "$system" = 'Macos' ] ; then
  zstyle :omz:plugins:keychain options --quiet --inherit any
else
  zstyle :omz:plugins:keychain options --quiet
fi

zstyle ':fzf-tab:complete:cd:*' fzf-preview 'exa --oneline $realpath'
# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  # ssh-agent
  keychain
  git
  gitfast
  git-auto-fetch
  ripgrep
  fd
  docker
  # vi-mode
  # fzf
  fzf-tab
  # zsh-syntax-highlighting
  # zsh-autosuggestions
)

source $ZSH/oh-my-zsh.sh

# User configuration

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

if command_exists fd ; then
  export FZF_DEFAULT_COMMAND='fd'
else
  export FZF_DEFAULT_COMMAND='fdfind'
fi

export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="$FZF_DEFAULT_COMMAND --type d"

export FZF_CTRL_T_OPTS="
  --preview 'test -d {} && exa --long --tree --level=3 --group-directories-first {} || bat $bat_force_colors {} | head -200'
  --bind 'ctrl-/:change-preview-window(down|hidden|)'"

export FZF_ALT_C_OPTS="--preview 'exa --long --tree --level=3 --group-directories-first {} | head -200'"

# export ANDROID_SDK_ROOT="/usr/local/share/android-sdk"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# SETUP

if [ -d "/mnt/c" ] ; then
  alias neovide="/mnt/c/Users/saito/.cargo/bin/neovide.exe --wsl --nofork --multigrid"
fi

if command_exists fd ; then
else
  alias fd=fdfind
fi

# turn-into-dotfile() {
#   cp "$1" "$1.back" &&
#   cp "$1" "$2" &&
#   rm "$1" &&
#   ln -sfn "$2" "$1"
# }

# list-dirs() {
#   fd --hidden --type d . "${1-.}"
# }

# list-files() {
#   fd --hidden --type f . "${1-.}"
# }

# SHOWING

# unalias pd 2>/dev/null
# pd() {
#   if command_exists exa ; then
#     exa --long --header --all "$@"
#   else
#     ls -a -l -G -F -h "$@"
#   fi
# }

# unalias pf 2>/dev/null
# pf() {
#   list-files "$@" | fzf --preview "bat --style=numbers $bat_force_colors | head -500"
# }

# NAVIGATION

# unalias nd 2>/dev/null
# nd() {
#   if command_exists exa ; then
#     cd "$(list-dirs "./" | fzf --query "$1" --preview "exa --header --color=always --long --all {} | head -100")"
#   else
#     cd "$(list-dirs "./" | fzf --query "$1" --preview "ls -a -l -G -F {} | head -100")"
#   fi
# }

# unalias nf 2>/dev/null
# nf() {
#   nvim "$(list-files "$@" | fzf --preview "bat --style=numbers $bat_force_colors {} | head -500")"
# }

unalias gsb 2>/dev/null
gsb() {
  local branches branch branchForSwitch
  branches=$(git branch --all | grep -v HEAD) &&
  branch=$(echo "$branches" | fzf --query "$1") &&
  branchForSwitch=$(echo $branch | sed "s/.* //" | sed "s#remotes/[^/]*/##") &&
  git switch $branchForSwitch
}

# MISC

# unalias get-github-latest-release 2>/dev/null
# get-github-latest-release() {
#   curl -s -L "https://api.github.com/repos/$1/releases/latest" | \
#   jq ".assets[] | select(.name == \"$2\") | .browser_download_url" --raw-output
# }

if command_exists fnm ; then
  eval "`fnm env`"
fi

# POSTSETUP

if [[ -f ~/.fzf.zsh ]]; then
  source ~/.fzf.zsh
# TODO find out what is this?
# elif [[ -f /usr/share/doc/fzf/examples/key-bindings.zsh ]]; then
#   source /usr/share/doc/fzf/examples/key-bindings.zsh
#   source /usr/share/doc/fzf/examples/completion.zsh
fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# opam configuration
# test -r /home/saito/.opam/opam-init/init.zsh && . /home/saito/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true
