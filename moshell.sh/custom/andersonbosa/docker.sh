


function docker_prune_none() {
  for IMG in $(docker images | grep none | awk '{print $3}'); do
    docker image remove -f $IMG
  done
}



function docker_get_ip() {
  local CONTAINER_ID="$1"

  docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' $CONTAINER_ID
}


