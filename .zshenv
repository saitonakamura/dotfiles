# HELPERS

command_exists () {
  type "$1" &> /dev/null ;
}

export LANG=en_US.UTF-8
export LC_CTYPE=C
export DOTNET_CLI_TELEMETRY_OPTOUT=1

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

if [ -d "$HOME/.npm-global/bin" ] ; then
  export PATH="$HOME/.npm-global/bin:$PATH"
fi

if [ -d "$HOME/.local/bin" ] ; then
  export PATH="$HOME/.local/bin:$PATH"
fi

# export PATH="/usr/local/opt/node/bin:$PATH"
export PATH="/usr/local/sbin:/usr/local/bin:$PATH"

# fnm
if command_exists fnm ; then
  eval "`fnm env`"
fi

# pyenv
if command_exists pyenv ; then
  export PYENV_ROOT="$HOME/.pyenv"
  command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
  eval "$(pyenv init -)"
fi

if [ -f "$HOME/.cargo/env" ] ; then
  . "$HOME/.cargo/env"
fi

# opam
[[ ! -r /home/saito/.opam/opam-init/init.zsh ]] || source /home/saito/.opam/opam-init/init.zsh  > /dev/null 2> /dev/null