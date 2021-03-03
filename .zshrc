if [ -x /usr/libexec/path_helper ]; then
  eval "$(/usr/libexec/path_helper)"
fi

set -k
setopt prompt_subst pushdignoredups no_banghist ignore_eof
set -o emacs

WORDCHARS='*?~&;!#$%^(){}<>-'

_dbsh() {
  set -x
  local shell=$1; shift
  local container=$1; shift
  local term_env="-e LINES=$(tput lines) -e COLUMNS=$(tput cols) -e LESS=-iRX -e TERM=xterm"

  cid=$(docker-compose ps -q $container 2>/dev/null)
  if [[ -f docker-compose.yml ]]; then
    if [[ $cid != '' ]]; then
      docker exec $term_env -it $cid "$@" $shell
    elif docker ps --format '{{.Names}}' | grep -q "${PWD##*/}-sandbox"; then
      docker exec $term_env -it "${PWD##*/}-sandbox" "$@" $shell
    else
      docker exec $term_env -it $container "$@" $shell
    fi
  elif docker ps --format '{{.Names}}' | grep -q "${PWD##*/}-sandbox"; then
    docker exec $term_env -it "${PWD##*/}-sandbox" "$@" $shell
  else
    docker exec $term_env -it $container "$@" $shell
  fi
  set +x
}

dbash() {
  _dbsh /bin/bash "$@"
}

dkill() {
  docker ps -aq | xargs docker rm -f
}

alias dk=docker

alias dkc='docker-compose'
alias g=git
alias hk=heroku
alias today='date +"%Y%m%d"'

latest() {
  ls -t "$@" | head -1
}

export NVM_DIR="$HOME/.nvm"
[ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && . "/usr/local/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

[ -f ~/.nvm.zsh ] && source ~/.nvm.zsh
# [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

eval "$(rbenv init -)"

zle_highlight=(none)

# Completions
if type brew &>/dev/null; then
  fpath+=~/.zfunc
  FPATH=$(brew --prefix)/share/zsh-completions:$FPATH

  autoload -Uz compinit
  compinit
fi

source /usr/local/etc/bash_completion.d/git-prompt.sh
# export PS1="%n@%m %1~ %# "
GIT_PS1_SHOWDIRTYSTATE=true
GIT_PS1_SHOWSTASHSTATE=true
GIT_PS1_SHOWUPSTREAM_="verbose name"
export PROMPT=$'$(__git_ps1 "%s")\n%n@%m %1~ %# '

export PATH="$HOME/bin:$PATH"


zstyle ':completion:*' matcher-list '' \
  'm:{a-z\-}={A-Z\_}' \
  'r:[^[:alpha:]]||[[:alpha:]]=** r:|=* m:{a-z\-}={A-Z\_}' \
  'r:|?=** m:{a-z\-}={A-Z\_}'

export PATH="$HOME/.jenv/bin:$PATH"
eval "$(jenv init -)"

eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"


travis_debug() {
curl -s -X POST \
  -H "Content-Type: application/json" \
  -H "Accept: application/json" \
  -H "Travis-API-Version: 3" \
  -H "Authorization: token ${token}" \
  -d "{\"quiet\": true}" \
  https://api.travis-ci.com/job/${id}/debug
}
