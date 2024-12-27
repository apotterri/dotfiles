source ~/.profile
export APPMAP_TELEMETRY_DISABLED=true APPMAP_ZENDESK_DEBUG=true

set -k
setopt prompt_subst pushdignoredups no_banghist ignore_eof rmstarsilent shwordsplit
set -o emacs

WORDCHARS='*?~&;!#$%^(){}<>'

_dbsh() {
  set -x
  local shell=$1; shift
  local container=$1; shift

  local term_env="-e LINES=$(tput lines) -e COLUMNS=$(tput cols) -e LESS=-iRX -e TERM=xterm"

  cid=$(docker compose ps -q $container 2>/dev/null)
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

alias dkc='docker compose'
alias g=git
alias lgn=lazygit
# alias lg="kitty --session lazygit.session"
alias hk=heroku
alias today='date +"%Y%m%d"'
alias pyproj="echo 'layout python' > .envrc && direnv allow"
alias rbproj="echo 'layout ruby' > .envrc && direnv allow"
alias ajfb="./gradlew clean check integrationTest && bin/test"
alias gw="./gradlew"
alias mw="./mvnw"
alias pip="uv pip"

latest() {
  greadlink -f "$@${@:+/}$(ls -t "$@" | head -1)"

}

now() {
  gdate +"%Y%m%d%H%M%S"
}

# eval "$(rbenv init -)"

zle_highlight=(none)

# Completions
if type brew &>/dev/null; then
  fpath+=~/.zfunc
  FPATH=$(brew --prefix)/share/zsh-completions:$FPATH

  autoload -Uz compinit
  compinit
else
  if [[ -f /etc/bash_completion.d/git-prompt ]]; then
    source /etc/bash_completion.d/git-prompt
  fi
fi

if [[ -f $HOMEBREW_PREFIX/etc/bash_completion.d/git-prompt.sh ]]; then
  source $HOMEBREW_PREFIX/etc/bash_completion.d/git-prompt.sh
fi

# export PS1="%n@%m %1~ %# "
GIT_PS1_SHOWDIRTYSTATE=true
GIT_PS1_SHOWSTASHSTATE=true
GIT_PS1_SHOWUPSTREAM_="verbose name"
export PROMPT=$'$(__git_ps1 "%s") %F{cyan}$(gdate +"%Y%m%d %H%M%S")%F{default}\n%n@%m %1~ %# '

zstyle ':completion:*' matcher-list '' \
  'm:{a-z\-}={A-Z\_}' \
  'r:[^[:alpha:]]||[[:alpha:]]=** r:|=* m:{a-z\-}={A-Z\_}' \
  'r:|?=** m:{a-z\-}={A-Z\_}'

#export PATH="$HOME/.jenv/bin:$PATH"
#eval "$(jenv init -)"

#eval "$(pyenv init --path)"
#eval "$(pyenv init -)"
#eval "$(pyenv virtualenv-init -)"
export PIP_REQUIRE_VIRTUALENV=true

travis_debug() {
  local token="$1"
  local id="$2"
  curl -s -X POST \
     -H "Content-Type: application/json" \
     -H "Accept: application/json" \
     -H "Travis-API-Version: 3" \
     -H "Authorization: token ${token}" \
     -d "{\"quiet\": true}" \
     https://api.travis-ci.com/job/${id}/debug
}

pipnve() {
  UV_SYSTEM_PYTHON=true uv pip "$@"
}



export HISTSIZE=1000000
export APPLE_SSH_ADD_BEHAVIOR=macos

#export NVM_DIR="$HOME/.nvm"
#[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
#[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
#export SDKMAN_DIR="$HOME/.sdkman"
#[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

appmap_start() {
  curl -XPOST localhost:${1=8080}/_appmap/record
}
appmap_stop() {
  curl -XDELETE localhost:${1=8080}/_appmap/record
}
appmap_status() {
  curl localhost:${1=8080}/_appmap/record
}

appmaps() {
  local args
  if [[ $1 == "-"* ]] ; then
    args="$1"; shift
  fi
  local dir="${1:-.}"; [[ $# > 0 ]]
  find -L "${dir}" \( -name .direnv -o -name .tox \) -prune -o -name "*.appmap.json" $args
}

export SLACK_DEVELOPER_MENU=true

echo "zshrc: PATH: $PATH"


test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
