source ~/.bashrc
source ~/.profile

export CONJUR_MAJOR_VERSION=4

export LESS=-iRX
[ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

source /usr/local/etc/bash_completion.d/git-prompt.sh

GIT_PS1_SHOWDIRTYSTATE=true
GIT_PS1_SHOWUPSTREAM_="verbose name"
PS1='${CONJURRC+$(tput setaf 1)$CONJURRC$(tput sgr0)} $(__git_ps1 "(%s)")\n\h \W\$ '

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"


