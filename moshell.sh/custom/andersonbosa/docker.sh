postgresql_docker() {
  local database_name="$1"
  docker run --rm \
    -e POSTGRES_USER=psql_user \
    -e POSTGRES_PASSWORD=psql_pass \
    -e POSTGRES_DB="${database_name:-postgres}" \
    -p 5432:5432 \
    bitnami/postgresql:14
}


dev_docker() {
  dcdn && dcup --build
}

docker_watch_ps() {
  local cmd="docker ps $@"
  watch -n1 $cmd
}

docker_grep_exec() {
  local container_name=$1
  local shelltype=$2
  local shelluser=$3

  local container_to_enter=$(docker ps -a | grep "$container_name" | awk '{print $1}')

  if [[ -z "$container_to_enter" ]]; then
    echo "Container not found."
    return 1
  fi

  if [[ -z "$shelltype" ]]; then
    shelltype="sh"
  fi

  if [[ -n "$shelluser" ]]; then
    docker exec -it --user "$shelluser" "$container_to_enter" "$shelltype"
  else
    docker exec -it "$container_to_enter" "$shelltype"
  fi
}


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
  docker run --rm -p 6379:6379 --name redis -d redis/redis-stack:latest
}

redis_up_verbose() {
  docker run --rm -p 6379:6379 --name redis redis/redis-stack:latest
}

docker_stop_all() {
  for container_id in $(docker ps -q); do
    docker stop $container_id
  done
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

mariadb_up() {
  docker run --rm \
    -p 3306:3306 \
    -v ephemeral_mariadb:/bitnami/mariadb \
    --user 1001 \
    --network external-net \
    -e MARIADB_DATABASE=ephemeral_mariadb \
    -e MARIADB_USER=bitnami_user \
    -e MARIADB_PASSWORD=bitnami_pass \
    -e MARIADB_ROOT_USER=admin \
    -e MARIADB_ROOT_PASSWORD=admin \
    bitnami/mariadb:11.4.2
}
