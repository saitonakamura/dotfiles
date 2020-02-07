# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

username=`id -un`
# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
DEFAULT_USER="$username"
ZSH_THEME="agnoster"

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
)

source $ZSH/oh-my-zsh.sh

# User configuration

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
export FZF_DEFAULT_COMMAND='fd --hidden'

export ANDROID_SDK_ROOT="/usr/local/share/android-sdk"

export NVM_DIR="$HOME/.nvm"

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

if ! [ hash fd 2>/dev/null ]; then
  alias fd=fdfind
fi

copy-and-link-dotfile() {
  cp "$1" "$2" &&
  ln -sfn "$2" "$1"
}

# SHOWING

unalias ld 2>/dev/null
ld() {
  if hash exa 2>/dev/null; then
    exa --long --header --all "$@"
  else
    ls -a -l -G -F "$@"
  fi
}

# NAVIGATION

unalias nd 2>/dev/null
nd() {
  if hash exa 2>/dev/null; then
    cd $(fd --type d | fzf --preview "exa --long --header --color=always {} | head -100")
  else
    cd $(fd --type d | fzf --preview "ls -a -l -G -F {} | head -100")
  fi
}

unalias nf 2>/dev/null
nf() {
  nvim $(fd --hidden --type f --exclude ".git" . "${1-.}" | fzf --preview "bat --style=numbers --color=always {} | head -100")
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

# POSTSETUP

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
