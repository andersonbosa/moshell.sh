export _MOSHELL_DIR_CORE_LOGGER="${BASH_SOURCE:-$0}"

function _moshell::logger::get_logfile_path() {
  local datestamp=$(date +%F)
  local log_filename="${datestamp}.log"
  local log_filepath="$_MOSHELL_DIR_BASE_PATH/logs/$log_filename"

  echo $log_filepath
}

# Log messages with different colors based on log level and save to a log file
# Usage: _moshell::log_and_save log_level message
function _moshell::log {
  local logtype="$1"
  local message="$2"

  local word_colors="\e[30m" # Black text color
  local log_reset="\e[0m"
  local log_colors

  # Transform to uppercase
  logtype=$(echo "$logtype" | tr '[:lower:]' '[:upper:]')

  case "$logtype" in
  PROMPT) log_colors="\e[45m" ;;  # Magenta background
  SUCCESS) log_colors="\e[42m" ;; # Green background
  INFO) log_colors="\e[44m" ;;    # Blue background
  DEBUG) log_colors="\e[47m" ;;   # White background
  WARN) log_colors="\e[43m" ;;    # Yellow background
  ERROR) log_colors="\e[41m" ;;   # Red background
  *)
    # Default to red background for unknown log levels
    logtype="info"
    log_colors="\e[41m"
    ;;
  esac

  # Log to the terminal with colors
  if [[ "$_MOSHELL_FLAG_VERBOSE" == 1 ]]; then
    printf "${log_colors}${word_colors}[%s]${log_reset}: %s\n" "$logtype" "$message" >&2
  fi

  if [[ "$_MOSHELL_FLAG_LOGGING" == 1 ]]; then

    local logpath=$(_moshell::logger::get_logfile_path)

    if [[ ! -f $logpath ]] || [ ! -s $logpath ]; then # If file does not exist or is empty
      echo '[DATE]                                [PID]   [TYPE] [MESSAGE]' >>$logpath
    fi

    echo "[$(date)] [$$] [$logtype] $message" >>"$logpath"
  fi
}

function _moshell::print() {
  if [[ $_MOSHELL_FLAG_VERBOSE == 0 ]]; then
    _MOSHELL_FLAG_VERBOSE=1
    _moshell::log "$@"
  else
    _moshell::log "$@"
  fi
}

# # Usage examples:
# _moshell::log prompt "This is a prompt message"
# _moshell::log INFO "This is a success message"
# _moshell::log info "This is an info message"
# _moshell::log debug "This is a debug message"
# _moshell::log WARN "This is a warning message"
# _moshell::log error "This is an error message"
