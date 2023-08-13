#!/bin/bash

# Log messages with different colors based on log level and save to a log file
# Usage: _moshell::log_and_save log_level message
function _moshell::log {
  local logtype="$1"
  local message="$2"

  local log_colors
  local word_colors="\e[30m" # Black text color
  local log_reset="\e[0m"

  # Transform to lowercase
  logtype=$(echo "$logtype" | tr '[:upper:]' '[:lower:]')

  case "$logtype" in
  prompt) log_colors="\e[45m" ;;  # Magenta background
  success) log_colors="\e[42m" ;; # Green background
  info) log_colors="\e[44m" ;;    # Blue background
  debug) log_colors="\e[47m" ;;   # White background
  warn) log_colors="\e[43m" ;;    # Yellow background
  error) log_colors="\e[41m" ;;   # Red background
  *)
    # Default to red background for unknown log levels
    logtype="info"
    log_colors="\e[41m"
    ;;
  esac

  # Transform to uppercase
  logtype=$(echo "$logtype" | tr '[:lower:]' '[:upper:]')

  # Log to the terminal with colors
  if [[ "$_MOSHELL_VERBOSE" == 1 ]]; then
    printf "${log_colors}${word_colors}[%s]${log_reset}:%s\n" "$logtype" "$message" >&2
  fi

  if [[ "$_MOSHELL_LOGGING" == 1 ]]; then
    # Save to log file
    local logfile="$(date +%F)_moshell.sh.log"
    local logpath="$_MOSHEL_DIR_BASE/logs/$logfile"
    echo "[$(date --iso-8601=ns)] [$logtype] $message" >>"$logpath"
  fi
}

# # Usage examples:
# _moshell::log prompt "This is a prompt message"
# _moshell::log success "This is a success message"
# _moshell::log info "This is an info message"
# _moshell::log debug "This is a debug message"
# _moshell::log warn "This is a warning message"
# _moshell::log error "This is an error message"
