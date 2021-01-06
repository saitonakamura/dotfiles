ITERM2_DARK_PRESET='OneHalfDark'
ITERM2_LIGHT_PRESET='OneHalfLight'

theme=`defaults read -g AppleInterfaceStyle` &>/dev/null

if [ "$theme" = 'Dark' ] ; then
  theme='dark'
else
  theme='light'
fi

if [ "$theme" = 'dark' ] ; then
  echo -e "\033]1337;SetColors=preset=$ITERM2_DARK_PRESET\a"
else
  echo -e "\033]1337;SetColors=preset=$ITERM2_LIGHT_PRESET\a"
fi

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

username=`id -un`

export LANG=en_US.UTF-8
export LC_CTYPE=C

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
DEFAULT_USER="$username"
# ZSH_THEME="saitonakamura"
ZSH_THEME="powerlevel10k/powerlevel10k"

if [ -d "$HOME/.npm-global/bin" ] ; then
  export PATH="$HOME/.npm-global/bin:$PATH"
fi

# export PATH="/usr/local/opt/node/bin:$PATH"
export PATH="/usr/local/sbin:$PATH"


# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

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

export BAT_THEME=$([ "$theme" = 'dark' ] && echo "OneHalfDark" || echo "OneHalfLight" )

bat_force_colors="--color=always --theme=$BAT_THEME"

# if [ "$theme" = 'dark' ] ; then
#   alias ctop='ctop'
# else
#   alias ctop='ctop -i'
# fi

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
  zsh-syntax-highlighting
  zsh-autosuggestions
  ssh-agent
  ripgrep
)

source $ZSH/oh-my-zsh.sh

# User configuration

# HELPERS

command_exists () {
  type "$1" &> /dev/null ;
}

# export MANPATH="/usr/local/man:$MANPATH"
system='unknown'

#if [ "$(uname)" == 'Darwin' ]; then
#  system='Macos'
#else
#  system='Linux'
#fi

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"
if command_exists fd ; then
  export FZF_DEFAULT_COMMAND='fd --hidden --exclude ".git"'
else
  export FZF_DEFAULT_COMMAND='fdfind --hidden --exclude ".git"'
fi

export ANDROID_SDK_ROOT="/usr/local/share/android-sdk"

GPG_TTY=$(tty)
export GPG_TTY

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# SETUP

alias zshconfig="nvim ~/.zshrc"
alias zshreloadconfig="source ~/.zshrc"

if command_exists fd ; then
else
  alias fd=fdfind
fi

turn-into-dotfile() {
  cp "$1" "$1.back" &&
  cp "$1" "$2" &&
  rm "$1" &&
  ln -sfn "$2" "$1"
}

list-dirs() {
  fd --hidden --type d --exclude ".git" . "${1-.}"
}

list-files() {
  fd --hidden --type f --exclude ".git" . "${1-.}"
}

# SHOWING

unalias pd 2>/dev/null
pd() {
  if command_exists exa ; then
    exa --long --header --all "$@"
  else
    ls -a -l -G -F "$@"
  fi
}

unalias pf 2>/dev/null
pf() {
  list-files "$@" | fzf --preview "bat --style=numbers $bat_force_colors | head -500"
}

# NAVIGATION

unalias nd 2>/dev/null
nd() {
  if command_exists exa ; then
    cd "$(list-dirs "$@" | fzf --preview "exa --long --header $bat_force_colors {} | head -100")"
  else
    cd "$(list-dirs "$@" | fzf --preview "ls -a -l -G -F {} | head -100")"
  fi
}

unalias nf 2>/dev/null
nf() {
  nvim "$(list-files "$@" | fzf --preview "bat --style=numbers $bat_force_colors {} | head -500")"
}

unalias gsb 2>/dev/null
gsb() {
  local branches branch branchForSwitch
  branches=$(git branch --all | grep -v HEAD) &&
  branch=$(echo "$branches" | fzf) &&
  branchForSwitch=$(echo $branch | sed "s/.* //" | sed "s#remotes/[^/]*/##") &&
  git switch $branchForSwitch
}

# SEARCHING

alias rgc='rg --no-heading --column'

# COPYING

alias cfp='fd --type f --hidden | fzf --preview "bat --style=numbers --color=always {} | head -500" | pbcopy'

alias cdp='fd --type d --hidden | fzf --preview "exa --long --header --color=always | head -100" | pbcopy'

# MISC

unalias get-github-latest-release 2>/dev/null
get-github-latest-release() {
  curl -s -L "https://api.github.com/repos/$1/releases/latest" | \
  jq ".assets[] | select(.name == \"$2\") | .browser_download_url" --raw-output
}

# POSTSETUP

if [[ -f ~/.fzf.zsh ]]; then
  source ~/.fzf.zsh
elif [[ -f /usr/share/doc/fzf/examples/key-bindings.zsh ]]; then
  source /usr/share/doc/fzf/examples/key-bindings.zsh
  source /usr/share/doc/fzf/examples/completion.zsh
fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

export PATH="/usr/local/opt/mozjpeg/bin:$HOME/.local/bin:$HOME/.npm-global/bin:$PATH"
