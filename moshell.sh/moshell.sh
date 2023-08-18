# set -x # Helpul when debugging

# REFACTOR:
# Particularly I find this ugly, I would prefer a way to invoke
# these paths through functions ... but I couldn't make something compatible
# between ZSH, Bash, for root and non-root users.
ABSOLUTE_PATH_TO_THIS_FILE="$(cd $(dirname ${BASH_SOURCE:-$0}) && pwd)"
###############################################################################

export _MOSHELL_DIR_BASE_PATH=$ABSOLUTE_PATH_TO_THIS_FILE
export _MOSHELL_DIR_CORE="$_MOSHELL_DIR_BASE_PATH/core"
export _MOSHELL_DIR_PLUGINS="$_MOSHELL_DIR_BASE_PATH/plugins"
export _MOSHELL_DIR_CUSTOM="$_MOSHELL_DIR_BASE_PATH/custom"

# To infinity and beyond!
source $_MOSHELL_DIR_CORE/index.sh
source $_MOSHELL_DIR_CUSTOM/index.sh
source $_MOSHELL_DIR_PLUGINS/index.sh

_moshell::log success "moshell.sh version '$(mo version)' initialized!"

[[ "$_MOSHELL_FLAG_VERBOSE" == 1 ]] && _moshell::banner::print

_moshell::log success "Moshell.sh version '$(mo version)' initialized!"
[[ "$_MOSHELL_VERBOSE" == 1 ]] && _moshell::banner::print

###############################################################################
# TODO: I tried to perform import in a dynamic way but it was not possible ...
#
# function moshell::import_libs() {
#   # NOTE: If you need to import something in order, you can do this by numbering the files.For example: `1.Example.sh`
#
#   local DIR_PATH="$1"
#
#   # Loop through and source each file in the "lib" directory, sorted numerically
#   for script_file in $(ls "$DIR_PATH"/**/*.sh | sort -n); do
#
#     if [ -f "$script_file" ]; then
#       # Import script
#       source $script_file 2>&1 | tee -a "$_MOSHELL_DIR_LOGS_FILE"
#
#       # Verbose if flag is diff 0
#       [[ "$_MOSHELL_FLAG_LOGGING" == "1" ]] && echo "[DEBUG] loaded: $script_file"
#     fi
#   done
# }
#
# moshell::import_libs $_MOSHELL_DIR_CORE 2>&1 | tee -a "$_MOSHELL_DIR_LOGS_FILE"
# moshell::import_libs $_MOSHELL_DIR_CUSTOM 2>&1 | tee -a "$_MOSHELL_DIR_LOGS_FILE"
#
###############################################################################
