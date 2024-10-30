export APPMAP_TELEMETRY_DISABLED=true APPMAP_ZENDESK_DEBUG=true

if [ -x /usr/libexec/path_helper ]; then
  eval "$(/usr/libexec/path_helper)"
fi

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
alias st=/usr/local/bin/stree
alias ajfb="./gradlew clean check integrationTest && bin/test"
alias gw="./gradlew"
alias mw="./mvnw"

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
fi

source /usr/local/etc/bash_completion.d/git-prompt.sh
# export PS1="%n@%m %1~ %# "
GIT_PS1_SHOWDIRTYSTATE=true
GIT_PS1_SHOWSTASHSTATE=true
GIT_PS1_SHOWUPSTREAM_="verbose name"
export PROMPT=$'$(__git_ps1 "%s") %F{cyan}$(gdate +"%Y%m%d %H%M%S")%F{default}\n%n@%m %1~ %# '

export PATH="$HOME/bin:$PATH"


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
  env -u PIP_REQUIRE_VIRTUALENV pip "$@"
}

export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"

export EDITOR=vi

source $(brew --prefix asdf)/libexec/asdf.sh
source ~/.asdf/plugins/java/set-java-home.zsh
export JAVA_OUTPUT_OPTIONS="-Xshare:off"

eval "$(asdf exec direnv hook zsh)"

# because homebrew told me I should:
export PATH="/usr/local/sbin:$HOME/.local/bin:$PATH:"
export RUBY_CONFIGURE_OPTS="--with-openssl-dir=$(brew --prefix openssl@1.1)"
export LDFLAGS="-L$(brew --prefix openssl@3)/lib"
export CPPFLAGS="-I$(brew --prefix openssl@3)/include"

export HISTSIZE=1000000
export APPLE_SSH_ADD_BEHAVIOR=macos

#export NVM_DIR="$HOME/.nvm"
#[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
#[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
#export SDKMAN_DIR="$HOME/.sdkman"
#[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
source "${XDG_CONFIG_HOME:-$HOME/.config}/asdf-direnv/zshrc"

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

