# Loosely, these are the things you can do on any OS. .zprofile has the things you can do on macOS

if [ -x /usr/libexec/path_helper ]; then
  eval "$(/usr/libexec/path_helper)"
fi
export EDITOR=vi

export PATH=$HOME/bin:$HOME/dotfiles/bin:$PATH:$HOME/go/bin

export COMPOSE_MENU=false

export XDG_CONFIG_HOME="$HOME/.config"

export LESS=-iRX

