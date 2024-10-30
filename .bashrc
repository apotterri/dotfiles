set -o ignoreeof

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

dbsh() {
  _dbsh /bin/sh "$@"
}

dsand() {
  _dbsh "$@" /bin/bash
}

dkill() {
  docker ps -aq | xargs docker rm -f
}

alias dk=docker

_setup_cukenet() {
  docker network create cukenet || true
}

run_master() {
  local cuke_image=${cuke_image:-registry2.itci.conjur.net/conjur-appliance-cuke-master}
  local cuke_image_tag=${cuke_image_tag:-5.0-stable}
  local cuke_container_name=${cuke_container_name:-cuke-master}

  _setup_cukenet
  docker rm -f ${cuke_container_name}
  docker run -P -d --security-opt seccomp=unconfined \
      --net cukenet \
      --name ${cuke_container_name} \
      -e CONJUR_ACCOUNT=cucumber -e CONJUR_AUTHN_LOGIN=admin -e CONJUR_AUTHN_API_KEY=secret \
      -e TERM=xterm -e LESS=-irX \
      -v ~/.bashrc:/root/.bashrc \
      "$@" ${cuke_image}:${cuke_image_tag}
  docker exec ${cuke_container_name} /opt/conjur/evoke/bin/wait_for_conjur
}

run_4master() {
  cuke_image_tag=4.9-stable cuke_container_name=${cuke_container_name-cuke-master-4} \
    run_master
}

run_standby() {
  local cuke_image=${cuke_image:-registry2.itci.conjur.net/conjur-appliance-cuke-standby}
  local cuke_image_tag=${cuke_image_tag:-4.9-stable}
  local cuke_container_name=${cuke_container_name:-cuke-standby}

  _setup_cukenet
  docker rm -f ${cuke_container_name}
  docker run -d --security-opt seccomp=unconfined -P \
      --net cukenet \
      --name ${cuke_container_name} \
      -e CONJUR_ACCOUNT=cucumber -e CONJUR_AUTHN_LOGIN=admin -e CONJUR_AUTHN_API_KEY=secret \
      -e TERM=xterm -e LESS=-irX \
      -v ~/.bashrc:/root/.bashrc \
      "$@" ${cuke_image}:${cuke_image_tag}
#  docker exec cuke-master /opt/conjur/evoke/bin/wait_for_conjur
}

run_follower() {
  local cuke_image=${cuke_image:-registry2.itci.conjur.net/conjur-appliance-cuke-follower}
  local cuke_image_tag=${cuke_image_tag:-4.9-stable}
  local cuke_container_name=${cuke_container_name:-cuke-follower}

  _setup_cukenet
  docker rm -f ${cuke_container_name}
  docker run -d --security-opt seccomp=unconfined -P \
      --net cukenet \
      --name ${cuke_container_name} \
      -e CONJUR_ACCOUNT=cucumber -e CONJUR_AUTHN_LOGIN=admin -e CONJUR_AUTHN_API_KEY=secret \
      -e TERM=xterm -e LESS=-irX \
      -v ~/.bashrc:/root/.bashrc \
      "$@" ${cuke_image}:${cuke_image_tag}
#  docker exec cuke-master /opt/conjur/evoke/bin/wait_for_conjur
}

run_conjur() {
  local cuke_image=${cuke_image:-registry2.itci.conjur.net/conjur-appliance}
  local cuke_image_tag=${cuke_image_tag:-5.0-stable}
  local cuke_container_name=${cuke_container_name:-conjur-appliance}
  
  _setup_cukenet
  docker rm -f ${cuke_container_name}
  docker run -d --security-opt seccomp=unconfined \
      --net cukenet \
      --name ${cuke_container_name} \
      -e TERM=xterm -e LESS=-irX \
      -v ~/.bashrc:/root/.bashrc \
      "$@" ${cuke_image}:${cuke_image_tag}
}

alias today='date +"%Y%m%d"'
alias dkc='docker-compose'

ccurl() {
  curl -H "$(conjur authn authenticate -H)" "$@"
}

cli5() {
  local appliance_url="${appliance_url:-https://cuke-master}"
  local cukenet=${cukenet:= cukenet}
  docker run -e CONJUR_APPLIANCE_URL="$appliance_url" -e CONJUR_ACCOUNT=cucumber -it --rm --net $cukenet cyberark/conjur-cli:5 "$@"
}

alias g=git
alias gu=gitup

# [ -f ~/.fzf.bash ] && source ~/.fzf.bash

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

alias hk=heroku

jdb() {
  rlwrap $(jenv which jdb) "$@"
}

latest() {
  ls -t "$@" | head -1
}
source "$HOME/.cargo/env"
