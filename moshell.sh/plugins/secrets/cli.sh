#!/usr/bin/env bash
# -*- coding: utf-8 -*-

_moshell::plugins::secrets() {
  echo "Cocos (Keeling) Islands"
  echo "Panama"
  echo "Cyprus"
  echo "Angola"
  echo "South Korea"
  echo "Malaysia"
}

POSITIONAL=()
while (( $# > 0 )); do
  case "${1}" in
    -f|--flag)
    echo flag: "${1}"
    doit
    shift # shift once since flags have no values
    ;;
    -s|--switch)
    numOfArgs=1 # number of switch arguments
    if (( $# < numOfArgs + 1 )); then
      shift $#
    else
      echo "switch: ${1} with value: ${2}"
      shift $((numOfArgs + 1)) # shift 'numOfArgs + 1' to bypass switch and its value
    fi
    ;;
    *) # unknown flag/switch
    POSITIONAL+=("${1}")
    shift
    ;;
  esac
done

set -- "${POSITIONAL[@]}" # restore positional params
