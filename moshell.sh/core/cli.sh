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
  plugins             [TODO] Plugins management
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
    cd "$_MOSHEL_DIR_BASE_PATH"

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

# Updates a flag in the flags configuration file and its override file.
# If the flag doesn't exist in the override file, adds it.
#
# Usage: _moshell::flags::update <flag_name> <new_value>
#
# Parameters:
#   - flag_name: The name of the flag to update.
#   - new_value: The new value to set for the flag.
#
# Example:
#   _moshell::flags::update _MOSHELL_LOGGING 1
function _moshell::flags::update() {
  local flag_name="$1"
  local new_value="$2"

  if [[ -z "$flag_name" || -z "$new_value" ]]; then
    _moshell::print error "Usage: _moshell::flags::update <flag_name> <new_value>"
    return 1
  fi

  _MOSHEL_DIR_CORE_FLAGS_OVERRIDE="${_MOSHEL_DIR_CORE_FLAGS}.override"
  touch "$_MOSHEL_DIR_CORE_FLAGS_OVERRIDE"

  # Check if the flag exists in the override file
  if grep -qF "export $flag_name=" "$_MOSHEL_DIR_CORE_FLAGS_OVERRIDE"; then
    # Update the existing entry in the override file
    sed -i "s/^export $flag_name=.*/export $flag_name=$new_value/" "$_MOSHEL_DIR_CORE_FLAGS_OVERRIDE"
  else
    # Add a new entry to the override file
    echo "export $flag_name=$new_value" >>"$_MOSHEL_DIR_CORE_FLAGS_OVERRIDE"
  fi

  # [optional] Uncomment to update the original flags file
  # sed -i "s/^export $flag_name=.*/export $flag_name=$new_value/" "$_MOSHEL_DIR_CORE_FLAGS"
}

function _moshell::flags::list() {
  _moshell::print info "Getting flags in '$_MOSHEL_DIR_CORE_FLAGS':"
  echo
  cat $_MOSHEL_DIR_CORE_FLAGS $_MOSHEL_DIR_CORE_FLAGS_OVERRIDE | grep -P "^export" | grep -v "override" | sort | uniq
  echo
}

function _moshell::flags() {
  local flag_name="$1"
  local new_value="$2"

  if [[ ! -z $flag_name ]] && [[ ! -z $new_value ]]; then
    _moshell::flags::update $flag_name $new_value
    return 0
  fi

  _moshell::flags::list
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
