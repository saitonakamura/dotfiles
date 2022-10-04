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
eval "`fnm env`"

if [ -f "$HOME/.cargo/env" ] ; then
  . "$HOME/.cargo/env"
fi

