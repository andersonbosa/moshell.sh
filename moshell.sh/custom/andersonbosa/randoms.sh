# -*- coding: utf-8 -*-

translate() {
  sr translate -from="portugues" -to="en" "$@"
}

weather() {
  if [ -z "$1" ]; then # if string empty
    curl "https://wttr.in/"
  else
    place="$(echo $1 | sed -r 's/ /+/')"
    curl "https://wttr.in/$1"
  fi
}

find-easy() {
  find . -name "*$1*"
}

get-port-connections() {
  local system_name="$(lsb_release -si)"

  if [[ $system_name = "ManjaroLinux" ]]; then
    sudo ss --oneline --listening --processes --info | grep -i -E "$1"
  else
    sudo netstat -nlp | grep -E "$1"
  fi

  unset system_name
}

pomodoro() {
  local pom_time="$1"
  local final_phrase="$2"
  local speak_in="$3"

  if [[ -z $pom_time ]]; then
    pom_time='25m'
  fi

  if [[ -z $final_phrase ]]; then
    final_phrase="Você terminou $pom_time de trabalho, parabéns!"
  fi

  if [[ -z $speak_in ]]; then
    speak_in="pt-br"
  fi

  $HOME/.venv/bin/termdown $pom_time &&
    notify-send "Pomodoro" $final_phrase &&
    espeak-ng -v "$speak_in" "$final_phrase" 2>/dev/null

  unset pom_time final_phrase
}

get_vpn_ip() {
  ip a | grep tun | grep inet | cut -d " " -f 6-6 | cut -d "/" -f -1
}

listen() {
  local port_to_listen="$1"

  echo "# Listenning connections port: $port_to_listen"
  nc -vnlp $port_to_listen | tee -a ./listen.log
}

zipit() {
  # usage: zipit /path/name  -> /path/name.zip
  local file_to_zip="$1"
  zip -r "${file_to_zip}.zip" "$file_to_zip" &&
    echo "# Zipped! ~"
}

pfind() {
  echo 'USER         PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND'
  ps -au | grep $@
}

datestamp() {
  date +%Y-%m-%d__%H-%M-%S__%s
}

tmux-save-pane() {
  TMP_PATH_FILE=$1
  if [[ -z "${TMP_PATH_FILE}" ]]; then
    local TMP_PATH_FILE="/tmp/tmux.output.$(datestamp).txt"
  fi
  tmux capture-pane -pS - >$TMP_PATH_FILE
  echo "$TMP_PATH_FILE"
}

git-checkpoint() {
  local commit_msg="$@"
  if [ -z $commit_msg ]; then
    commit_msg="dumb commit"
  fi
  git add .
  git commit -m $commit_msg
  git push
}

wtf() {
  echo "[+] whatis:"
  whatis $1
  echo

  echo "[+] ls -lhv:"
  ls -lhv $1
  echo

  echo "[+] whereis:"
  whereis $1
  echo

  echo "[+] type:"
  type $1
  echo

  echo "[+] which:"
  which $1
  echo

  echo "[+] command:"
  command -v $1
  echo

  echo "[+] --help:"
  $1 --help
  echo
}

dawscli() {
  # https://docs.aws.amazon.com/cli/latest/userguide/getting-started-docker.html
  docker run --rm \
    -it \
    -v ~/.aws:/root/.aws \
    source ./utils/index.sh

  amazon/aws-cli $@
}

git_clone_folder() {
  local USAGE='usage: git_clone_folder owner/repo repo_folder/sub_folder'

  if [[ -z "$1" ]]; then
    echo $USAGE
    return 0
  fi

  if [[ -z "$2" ]]; then
    echo $USAGE
    return 0
  fi

  local OWNER_AND_REPO=$1
  local WANTED_FOLDER_PATH=$2

  local REPO=$(echo $OWNER_AND_REPO | sed -r "s/^.+\///")
  local WORK_DIR=$(pwd)

  echo "[INFO] Clonning full repository..."
  rm -rf /tmp/$REPO >/dev/null
  git clone "git@github.com:${OWNER_AND_REPO}.git" /tmp/$REPO

  local DST_PATH="${WORK_DIR}/${WANTED_FOLDER_PATH}"

  echo "[INFO] Extracting desired folder..."
  cp -r "/tmp/$REPO/${WANTED_FOLDER_PATH}" $DST_PATH

  echo "[INFO] Cleaning..."
  rm -fr /tmp/$REPO

  echo "[INFO] Extracted to folder: $DST_PATH"
}

find_commit() {
  git branch --contains=$1 | grep $2
}

watch_deploy() {
  local COMMIT_TO_IDENTIFY=$1
  local MESSAGE=$2
  local BRANCH_TO_FIND=$3

  if [[ -z "${MESSAGE}" ]]; then
    echo "missing requried param: MESSAGE at position \$2"
    return 2
  fi

  if [[ -z "${BRANCH_TO_FIND}" ]]; then
    BRANCH_TO_FIND="master"
  fi

  watch -g -n 10 "find_commit $COMMIT_TO_IDENTIFY $MESSAGE && notify-send "Commit Identified!" "$MESSAGE""
}

get_graphql_schema() {
  get-graphql-schema --header "X-API-KEY=$FLOW_API_KEY" $FLOW_API_URL/graphql >/tmp/graphql_schema
}

create_venv() {
  python3 -m venv .venv
}

ffmpeg_screenrecorder() {
  OUTPUT_PATH=$1

  echo "[🔴] PRESS CTRL+C TO STOP"
  ffmpeg -video_size 2560x1080 -framerate 20 -f x11grab -i :0.0 -f pulse -ac 2 -i default $OUTPUT_PATH
  echo "[🟢] Stored in: $OUTPUT_PATH"
}

rm-apt-repository() {
  local REPO="$1"
  sudo add-apt-repository --remove "$REPO"
}

pysource() {
  declare -a FILES=(
    'venv/bin/activate'
    '.venv/bin/activate'
  )
  for FIL in $FILES; do
    [ -f $FIL ] && source $FIL
  done
}

add-react-component() {
  local componentName=$1

  if [[ -z "${componentName}" ]]; then
    return 0
  fi

  mkdir -p $componentName
  touch $componentName/index.{js,css}
}

pycache_clean() {
  find . | grep -E "(__pycache__|\.pyc|\.pyo$)" | xargs rm -rf # clean pycache
}

docker-user-permission() {
  docker info &>/dev/null && echo "can access as non root user" || echo "can not access as non root user"
}

docker-prune() {
  docker volume prune
  docker image prune
  docker container prune
}

dvim() {
  # TODO: compartilhar configuração
  CODEBASE=$(realpath $1)
  docker run -it --rm -v $CODEBASE:/home/spacevim/code spacevim/spacevim bash nvim code
}

git_init_work() {
  git commit --allow-empty -m "$(git_current_branch)"
  git push -u origin $(git_current_branch)
}

httpxx() {
  httpx -http-proxy "$PROXY_8080" $@
}

chad() {
  commit-chad --gemini
}

chady() {
  yes | commit-chad --gemini -y
}

tarme() {
  FOLDER_PATH="$1"
  tar -czvf $2 $FOLDER_PATH.tar.xz $FOLDER_PATH
}

untarme() {
  FOLDER_PATH="$1"
  tar -xzvf $2 $FOLDER_PATH.tar.xz $FOLDER_PATH
}

commit_package_lock() {
  git add **/package-lock.json
  git commit -m 'chore: update package-lock.json'
}

freeze_deps() {
  pip freeze --local | grep -v '-e git' >requirements.txt
  cat requirements.txt
}
