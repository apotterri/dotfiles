if [[ "$(/usr/bin/uname -m)" == "arm64" ]]; then
  HOMEBREW_PREFIX=/opt/homebrew
else
  HOMEBREW_PREFIX=/usr/local
fi

source ~/.bashrc
source ~/.profile

export HISTCONTROL=ignoredups:erasedups  # no duplicate entries
export HISTSIZE=100000                   # big big history
export HISTFILESIZE=100000               # big big history
shopt -s histappend                      # append to history, don't overwrite it

export CONJUR_MAJOR_VERSION=4

export LESS=-iRX
[ -f $HOMEBREW_PREFIX/gc/etc/bash_completion ] && . /usr/local/etc/bash_completion

#source "$HOME/lib/mgalgs/fuzzy_bash_completion/fuzzy_bash_completion"
#fuzzy_setup_for_command cd...v0.1.6
#fuzzy_setup_for_command pushd

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

for c in git-prompt.sh git-completion.bash docker; do
  source $HOMEBREW_PREFIX/gc/etc/bash_completion.d/"$c"
done
complete -F __git_wrap__git_main g

# __docker_complete_containers_running dbash

GIT_PS1_SHOWDIRTYSTATE=true
GIT_PS1_SHOWSTASHSTATE=true
GIT_PS1_SHOWUPSTREAM_="verbose name"
PS1='${CONJURRC+$(tput setaf 1)$CONJURRC$(tput sgr0)} $(__git_ps1 "(%s)")\n\h \W\$ '

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"



export SUMMON_PROVIDER=summon-conjur

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/ajp/Downloads/google-cloud-sdk/path.bash.inc' ]; then source '/Users/ajp/Downloads/google-cloud-sdk/path.bash.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/ajp/Downloads/google-cloud-sdk/completion.bash.inc' ]; then source '/Users/ajp/Downloads/google-cloud-sdk/completion.bash.inc'; fi

export PATH="$HOMEBREW_PREFIX/gc/bin:/usr/local/sbin:$HOME/.jenv/bin:$PATH"
eval "$(rbenv init -)"
eval "$(jenv init -)"

test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

export CUCUMBER_PUBLISH_QUIET=true
source "$HOME/.cargo/env"

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

