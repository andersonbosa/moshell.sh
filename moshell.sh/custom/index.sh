_moshell::custom::index() {
  echo '# This is a index file to import (and export to shell) all files wanted. For better organization it was separeted by username.'
}

# NOTE: The order matters
source "$_MOSHEL_DIR_CUSTOM/andersonbosa/ai_prompts.sh"
source "$_MOSHEL_DIR_CUSTOM/andersonbosa/docker.sh"
source "$_MOSHEL_DIR_CUSTOM/andersonbosa/generators.sh"
source "$_MOSHEL_DIR_CUSTOM/andersonbosa/randoms.sh"
source "$_MOSHEL_DIR_CUSTOM/andersonbosa/termbin.sh"
source "$_MOSHEL_DIR_CUSTOM/andersonbosa/workrounds.sh"

_moshell::log INFO "Loaded customizations."
