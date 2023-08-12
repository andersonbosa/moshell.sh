#!/usr/bin/env bash
# -*- coding: utf-8 -*-

export _MOSHEL_DIR_BASE="$(dirname "$(realpath "$0")")"
export _MOSHEL_DIR_LIB="$_MOSHEL_DIR_BASE/lib"
export _MOSHEL_DIR_CUSTOM="$_MOSHEL_DIR_BASE/custom"
export _MOSHEL_DIR_LOGS_FILE="$_MOSHEL_DIR_BASE/logs/$(date +%s).log"

# =============================================================================

# TOFIX: I tried to perform import in a dynamic way but it was not possible ...
# function moshell::import_libs() {
#   # NOTE: If you need to import something in order, you can do this by numbering the files.For example: `1.Example.sh`

#   local DIR_PATH="$1"

#   # Loop through and source each file in the "lib" directory, sorted numerically
#   for script_file in $(ls "$DIR_PATH"/**/*.sh | sort -n); do

#     if [ -f "$script_file" ]; then
#       # Import script
#       source $script_file 2>&1 | tee -a "$_MOSHEL_DIR_LOGS_FILE"

#       # Verbose if flag is diff 0
#       [[ "$_MOSHELL_DEBUG" == "1" ]] && echo "[DEBUG] loaded: $script_file"
#     fi
#   done
# }
#
# moshell::import_libs $_MOSHEL_DIR_LIB 2>&1 | tee -a "$_MOSHEL_DIR_LOGS_FILE"
# moshell::import_libs $_MOSHEL_DIR_CUSTOM 2>&1 | tee -a "$_MOSHEL_DIR_LOGS_FILE"
#

# =============================================================================

# To infinity and beyond!
source $_MOSHEL_DIR_LIB/index.sh
source $_MOSHEL_DIR_CUSTOM/index.sh
