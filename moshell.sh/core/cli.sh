## Utility function()s

function _moshell::confirm() {
  # If question supplied, ask it before reading the answer
  # NOTE: uses the logname of the caller functio()n
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

function _moshell::help() {
  cat >&2 <<EOF
Usage: moshell <command> [options]

Available commands:

  help                Print this help message
  edit                Edit moshell configurations
  reload              Reload the configuration
  flags               Update Moshell.sh environment variables
  update              [TODO] Update Moshell.sh
  version             Show the version

EOF
}

function _moshell::edit() {
  if [[ -z "$EDITOR" ]]; then
    _moshell::log info "Using default EDITOR"
    EDITOR=$(which vi)
  fi

  _moshell::log info "Openning in your prefered editor: $EDITOR... "
  sleep 1
  $EDITOR $_MOSHEL_DIR_BASE_PATH
  return 0
}

function _moshell::reload() {
  _moshell::log info $msg
  source "$_MOSHEL_DIR_BASE_PATH/moshell.sh"
  return 0
}

function _moshell::version() {
  (
    builtin cd -q "$_MOSHEL_DIR_BASE_PATH"

    # Get the version name:
    # 1) try tag-like version
    # 2) try branch name
    # 3) try name-rev (tag~<rev> or branch~<rev>)
    local remote_version
    remote_version=$(command git describe --tags HEAD 2>/dev/null) ||
      remote_version=$(command git symbolic-ref --quiet --short HEAD 2>/dev/null) ||
      remote_version=$(command git name-rev --no-undefined --name-only --exclude="remotes/*" HEAD 2>/dev/null) ||
      remote_version="<detached>"

    # Get short hash for the current HEAD
    local commit=$(command git rev-parse --short HEAD 2>/dev/null)

    local local_version=$(cat $_MOSHEL_DIR_BASE_PATH/version)

    # Show version and commit hash
    printf "[%s] %s (%s)\n" "$local_version" "$remote_version" "$commit"
  )
}

function _moshell::flags() {
  echo "FLAGS: "
  # TODO: 
  return 0
}

function _moshell() {
  local -a cmds subcmds
  cmds=(
    'help:Print this help message'
    'edit:Edit moshell configurations'
    'reload:Reload the configuration'
    'flags:Update Moshell.sh environment variables'
    'update:Update Moshell.sh'
    'version:Show the version'
  )

  # TODO: process commands

  return 0
}

function moshell() {
  [[ $# -gt 0 ]] || {
    _moshell::help
    return 0
  }

  local command="$1"
  shift

  # Subcommand functions start with _ so that they don'()t
  # appear as completion entries when looking for `moshell`
  if ! declare -f "_moshell::$command" &>/dev/null; then
    _moshell::help
    return 0
  fi

  _moshell::$command "$@"
}

alias mo="moshell"
