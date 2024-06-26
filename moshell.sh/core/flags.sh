# Required line: exports flags.sh location to be imported by others files
export _MOSHELL_DIR_CORE_FLAGS="${BASH_SOURCE:-$0}"

###############################################################################
# Glossary
#   0=no/disabled
#   1=yes/enabled
#
###############################################################################

##
# ALL FLAGS
##

# TODO: add control of logs and feedbacks by levels
# export _MOSHELL_LOGGING_LEVEL=0 # DEBUG  # default=0 # DEBUG
# export _MOSHELL_VERBOSE_VERBOSE=1 # INFO  # default=1 # INFO

export _MOSHELL_FLAG_LOGGING=1             # default=1 # Log to file:
export _MOSHELL_FLAG_VERBOSE=0             # default=1 # Log to screen
export _MOSHELL_FLAG_EDITOR=vim            # default=vim # Modifies which editor is used in "Moshell Edit"
export _MOSHELL_FLAG_ENABLE_LOAD_PLUGINS=1 # default=1 # Enable plugins
export _MOSHELL_FLAG_ENABLE_LOAD_CUSTOMS=1 # default=1 # Enable customizations

###############################################################################
# Keep this import at the end of "flags.sh"
export _MOSHELL_DIR_CORE_FLAGS_OVERRIDE="${_MOSHELL_DIR_CORE_FLAGS}.override"
touch $_MOSHELL_DIR_CORE_FLAGS_OVERRIDE
source $_MOSHELL_DIR_CORE_FLAGS_OVERRIDE
