
# Setting PATH for Python 3.13
# The original version is saved in .zprofile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/3.13/bin:${PATH}"
export PATH

export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"


# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

source $(/opt/homebrew/bin/brew --prefix asdf)/libexec/asdf.sh
#source ~/.asdf/plugins/java/set-java-home.zsh
#export JAVA_OUTPUT_OPTIONS="-Xshare:off"
source "${XDG_CONFIG_HOME:-$HOME/.config}/asdf-direnv/zshrc"

eval "$(asdf exec direnv hook zsh)"

eval "$(/opt/homebrew/bin/brew shellenv)"

# because homebrew told me I should:
export PATH="$HOMEBREW_PREFIX/sbin:$HOME/.local/bin:$PATH:"
export RUBY_CONFIGURE_OPTS="--with-openssl-dir=$(brew --prefix openssl@1.1)"
export LDFLAGS="-L$(brew --prefix openssl@3)/lib"
export CPPFLAGS="-I$(brew --prefix openssl@3)/include"

# source "$HOME/.cargo/env"
