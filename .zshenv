# HELPERS

command_exists () {
  type "$1" &> /dev/null ;
}

# if command_exists "defaults" ; then
#   # macos
#   # export SSH_AUTH_SOCK=~/Library/Group\ Containers/2BUA8C4S2C.com.1password/t/agent.sock
#   export PATH="$HOME/.local/flutter/bin:$PATH"
#   export GEM_HOME=$HOME/.gem
#   export PATH=$GEM_HOME/ruby/2.6.0/bin:$PATH
# fi

export DOTNET_CLI_TELEMETRY_OPTOUT=1

if [ -d "$HOME/.npm-global/bin" ] ; then
  export PATH="$HOME/.npm-global/bin:$PATH"
fi

if [ -d "$HOME/.local/bin" ] ; then
  export PATH="$HOME/.local/bin:$PATH"
fi

# fnm
if [ -d "$HOME/.local/share/fnm" ] ; then
  export PATH="/home/saito/.local/share/fnm:$PATH"
fi
if command_exists fnm ; then
  export FNM_COREPACK_ENABLED=true
  eval "`fnm env`"
fi

export PATH="/usr/local/sbin:/usr/local/bin:$PATH"

# pyenv
# also check that it's wsl pyenv, not windows one
if command_exists pyenv && [ -d "$HOME/.pyenv" ] ; then
  export PYENV_ROOT="$HOME/.pyenv"
  command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
  eval "$(pyenv init -)"
fi

if [ -f "$HOME/.cargo/env" ] ; then
  . "$HOME/.cargo/env"
fi

# opam
[[ ! -r /home/saito/.opam/opam-init/init.zsh ]] || source /home/saito/.opam/opam-init/init.zsh  > /dev/null 2> /dev/null
