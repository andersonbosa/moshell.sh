#
# Glossary
#   0=no
#   1=yes
#
###############################################################################
export _MOSHEL_DIR_CORE_FLAGS="${BASH_SOURCE:-$0}"

# TODO: add control of logs and feedbacks by levels
# export _MOSHELL_LOGGING_LEVEL=0 # DEBUG
# export _MOSHELL_VERBOSE_VERBOSE=1 # INFO

# Log to file:
export _MOSHELL_LOGGING=1

# Log to screen
export _MOSHELL_VERBOSE=1

# Enable plugins
export _MOSHELL_LOAD_PLUGINS=1
export _MOSHELL_LOAD_CUSTOMS=1

###############################################################################
# Keep this import at the end of "flags.sh"
export _MOSHEL_DIR_CORE_FLAGS_OVERRIDE="${_MOSHEL_DIR_CORE_FLAGS}.override"
touch $_MOSHEL_DIR_CORE_FLAGS_OVERRIDE
source $_MOSHEL_DIR_CORE_FLAGS_OVERRIDE
