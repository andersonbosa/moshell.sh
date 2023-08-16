_moshell::core::index() {
  echo '# This is a index file to import (and export to shell) all files required by Moshell.sh.'
}

# NOTE: The order matters
source "$_MOSHEL_DIR_CORE/flags.sh"
source "$_MOSHEL_DIR_CORE/logger.sh"
source "$_MOSHEL_DIR_CORE/banner.sh"
source "$_MOSHEL_DIR_CORE/cli.sh"

_moshell::log INFO "Loaded core index."
