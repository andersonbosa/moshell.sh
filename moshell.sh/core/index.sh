_moshell::core::index() {
  echo '# This is a index file to import (and export to shell) all files required by moshell.sh.'
}

# NOTE: The order matters
source "$_MOSHELL_DIR_CORE/flags.sh"
source "$_MOSHELL_DIR_CORE/logger.sh"
source "$_MOSHELL_DIR_CORE/banner.sh"
source "$_MOSHELL_DIR_CORE/cli.sh"

_moshell::log INFO "Loaded core index."
