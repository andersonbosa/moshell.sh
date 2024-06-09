
docker_prune_none() {
  for IMG in $(docker images | grep none | awk '{print $3}'); do
    docker image remove -f $IMG
  done
}

docker_get_ip() {
  local CONTAINER_ID="$1"

  docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' $CONTAINER_ID
}

redis_up() {
  docker run --rm -p 6379:6379 --name redis -d redis:latest
}

redis_up_verbose() {
  docker run --rm -p 6379:6379 --name redis redis:latest
}

docker_stop_all() {
  for i in $( docker ps -q ); docker stop $i
}

_docker_logs_all_cleanup() {
  kill $(jobs -p)
  exit 0
}

docker_logs_all() {
  trap _docker_logs_all_cleanup SIGINT SIGTERM
  container_ids=$(docker ps -q)
  for cid in $container_ids; do
    docker logs -f $cid &
  done
  wait
}
