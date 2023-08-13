#!/usr/bin/env bash
# -*- coding: utf-8 -*-

export _MOSHEL_DIR_BASE="$(dirname "$(realpath "$0")")"
export _MOSHEL_DIR_CORE="$_MOSHEL_DIR_BASE/core"
export _MOSHEL_DIR_PLUGINS="$_MOSHEL_DIR_BASE/plugins"
export _MOSHEL_DIR_CUSTOM="$_MOSHEL_DIR_BASE/custom"

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
#       [[ "$_MOSHELL_LOGGING" == "1" ]] && echo "[DEBUG] loaded: $script_file"
#     fi
#   done
# }
#
# moshell::import_libs $_MOSHEL_DIR_CORE 2>&1 | tee -a "$_MOSHEL_DIR_LOGS_FILE"
# moshell::import_libs $_MOSHEL_DIR_CUSTOM 2>&1 | tee -a "$_MOSHEL_DIR_LOGS_FILE"
#

# =============================================================================

# To infinity and beyond!
source $_MOSHEL_DIR_CORE/index.sh
source $_MOSHEL_DIR_PLUGINS/index.sh
source $_MOSHEL_DIR_CUSTOM/index.sh

_moshell::log success "Moshell.sh initialized with success!"
