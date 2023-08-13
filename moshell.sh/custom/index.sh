_moshell::custom::index() {
  echo '# This is a index file to import (and export to shell) all files wanted. For better organization it was separeted by username.'
}

BASE_PATH="$(dirname "$(realpath "$0")")"

# NOTE: The order matters
source "$BASE_PATH/andersonbosa/ai_prompts.sh"
source "$BASE_PATH/andersonbosa/docker.sh"
source "$BASE_PATH/andersonbosa/generators.sh"
source "$BASE_PATH/andersonbosa/randoms.sh"
source "$BASE_PATH/andersonbosa/termbin.sh"
source "$BASE_PATH/andersonbosa/workrounds.sh"

_moshell::log success "Loaded customizations."
