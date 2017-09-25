dsand() {
  docker exec -it "${PWD##*/}-sandbox" /bin/bash
}

dbash() {
  docker exec -it "$@" /bin/bash
}

dkill() {
  docker ps -aq | xargs docker rm -f
}

alias dk=docker

run_master() {
  local cuke_image=${cuke_image:-registry.tld/conjur-appliance-cuke-master}
  local cuke_image_tag=${cuke_image_tag:-4.9-stable}

  docker rm -f cuke-master
  docker run -d --security-opt seccomp=unconfined --name cuke-master \
      -e TERM=xterm -e LESS=-irX \
      -v ~/.bashrc:/root/.bashrc \
      "$@" ${cuke_image}:${cuke_image_tag}
  docker exec cuke-master /opt/conjur/evoke/bin/wait_for_conjur
}
	 
	 
