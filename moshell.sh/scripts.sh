#!/usr/bin/env bash
# -*- coding: utf-8 -*-

# Defines used constants
MOSHELL_IMAGE="moshell.sh:develop"
MOSHELL_LOCAL_PATH="$(dirname $(pwd))"

# Build docker image to perform tests in Moshell.SH
function _moshell::scripts::build() {
  docker build --progress plain -t ${MOSHELL_IMAGE} .
}

# Run docker image shareing Moshell.SH tools to speed up installation test
function _moshell::scripts::run() {
  local HOST_PATH=$MOSHELL_LOCAL_PATH/moshell.sh/tools
  local CONTAINER_PATH=/home/moshell/tools

  docker run --rm \
    -it \
    -v $HOST_PATH:$CONTAINER_PATH \
    --entrypoint $1 \
    $MOSHELL_IMAGE
}

# Useful for testing different shells
function _moshell::scripts::test() {
  docker run --rm -it --entrypoint $1 $MOSHELL_IMAGE
}

function _moshell::scripts::usage() {
  echo "$(basename $0)"
  echo ""
  echo "OPTIONS:"
  echo -e "\t --build \t build docker image"
  echo -e "\t --run \t\t run docker container"
  echo ""
  echo ""
  echo "EXAMPLE:"
  echo -e "\t./script --build --run"
  echo ""
}

#####################################################################

# Arguments sanity check
if [[ -z "$1" ]]; then # if first argument is empty
  _moshell::scripts::usage
  exit 0
fi

# Argument parsing
while (($# > 0)); do
  case "${1}" in

  --build)
    _moshell::scripts::build
    shift
    ;;
  --run)
    shell_tool=$2
    if [[ -z "$shell_tool" ]]; then
      shell_tool="bash" # default shell option
    fi
    _moshell::scripts::run $shell_tool
    exit
    ;;
  *)
    echo "Invalid option."
    ;;
  esac
done
