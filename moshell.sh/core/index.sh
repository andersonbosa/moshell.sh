_moshell::core::index() {
  echo '# This is a index file to import (and export to shell) all files required by Moshell.sh.'
}

BASE_PATH="$(dirname "$(realpath "$0")")"

# NOTE: The order matters
source "$BASE_PATH/flags.sh"
source "$BASE_PATH/banner.sh"
source "$BASE_PATH/logger.sh"
source "$BASE_PATH/cli.sh"

_moshell::log success "Loaded core."
