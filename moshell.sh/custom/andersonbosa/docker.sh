


function docker_prune_none() {
  for IMG in $(docker images | grep none | awk '{print $3}'); do
    docker image remove -f $IMG
  done
}