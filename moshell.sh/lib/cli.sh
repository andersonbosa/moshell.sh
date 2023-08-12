#!/usr/bin/env bash
# -*- coding: utf-8 -*-

## Utility functions

# usage:
# _moshell::log error "lorem ipsum"
function _moshell::log {
  # if promptsubst is set, a message with `` or $()
  # will be run even if quoted due to `print -P`
  setopt localoptions nopromptsubst

  # $1 = info|warn|error|debug
  # $2 = text
  # $3 = (optional) name of the logger

  local logtype="$1"
  local logname="" # TODO: inpired in OhMyZSH

  # Choose coloring based on log type
  case "$logtype" in
  prompt) print -Pn "%S%F{blue}$logname%f%s: $2" ;;
  debug) print -P "%F{white}$logname%f: $2" ;;
  info) print -P "%F{green}$logname%f: $2" ;;
  warn) print -P "%S%F{yellow}$logname%f%s: $2" ;;
  error) print -P "%S%F{red}$logname%f%s: $2" ;;
  esac >&2
}

function _moshell::confirm {
  # If question supplied, ask it before reading the answer
  # NOTE: uses the logname of the caller function
  if [[ -n "$1" ]]; then
    _moshell::log prompt "$1" "$2"
  fi

  # Read one character
  read -r -k 1

  # If no newline entered, add a newline
  if [[ "$REPLY" != $'\n' ]]; then
    echo
  fi
}

## User-facing commands

function _moshell::help {
  cat >&2 <<EOF
Usage: moshell <command> [options]

Available commands:

  help                Print this help message
  edit                Edit moshell configurations
  reload              Reload the configuration
  update              Update Moshell.sh
  version             Show the version

EOF
}

function _moshell::reload {
  # TODO: source moshell index
  echo "[INFO] Recharged Settings"
  source "$_MOSHEL_DIR_BASE/moshell.sh"
}

function _moshell::version {
  (
    builtin cd -q "$_MOSHEL_DIR_BASE"

    # Get the version name:
    # 1) try tag-like version
    # 2) try branch name
    # 3) try name-rev (tag~<rev> or branch~<rev>)
    local version
    version=$(command git describe --tags HEAD 2>/dev/null) ||
      version=$(command git symbolic-ref --quiet --short HEAD 2>/dev/null) ||
      version=$(command git name-rev --no-undefined --name-only --exclude="remotes/*" HEAD 2>/dev/null) ||
      version="<detached>"

    # Get short hash for the current HEAD
    local commit=$(command git rev-parse --short HEAD 2>/dev/null)

    # Show version and commit hash
    printf "%s (%s)\n" "$version" "$commit"
  )
}

function _moshell {
  local -a cmds subcmds
  cmds=(
    'help:Print this help message'
    'edit:Edit moshell configurations'
    'reload:Reload the configuration'
    'update:Update Moshell.sh'
    'version:Show the version'
  )

  # TODO: process commands

  return 0
}

function moshell {
  [[ $# -gt 0 ]] || {
    _moshell::help
    return 1
  }

  local command="$1"
  shift

  # Subcommand functions start with _ so that they don't
  # appear as completion entries when looking for `moshell`
  if ! declare -f "_moshell::$command" &>/dev/null; then
    _moshell::help
    return 1
  fi

  _moshell::$command "$@"
}

alias mo="moshell"
