if [ -x /usr/libexec/path_helper ]; then
  eval "$(/usr/libexec/path_helper)"
fi
eval "$(/opt/homebrew/bin/brew shellenv)"

export PATH=$HOME/bin:$PATH:$HOME/go/bin

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

export EDITOR=vi
# source "$HOME/.cargo/env"

export XDG_CONFIG_HOME="$HOME/.config"

# >>> coursier install directory >>>
export PATH="$PATH:/Users/ajp/Library/Application Support/Coursier/bin"
# <<< coursier install directory <<<
