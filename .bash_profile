source ~/.bashrc
source ~/.profile

export CONJUR_MAJOR_VERSION=4

export LESS=-iRX
[ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

for c in git-prompt.sh git-completion.bash docker; do
  source /usr/local/etc/bash_completion.d/"$c"
done

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

eval "$(rbenv init -)"
export PATH="$HOME/.jenv/bin:$PATH"
eval "$(jenv init -)"

test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"

