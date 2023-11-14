_moshell::custom::index() {
  echo '# This is a index file to import (and export to shell) all files wanted. For better organization it was separeted by username.'
}

if [[ $_MOSHELL_FLAG_ENABLE_LOAD_CUSTOMS == 0 ]]; then
  _moshell::log INFO "Customs not load. See '_MOSHELL_FLAG_ENABLE_LOAD_CUSTOMS' flag"
  return 0
fi

# NOTE: The order matters
source "$_MOSHELL_DIR_CUSTOM/andersonbosa/ai_prompts.sh"
source "$_MOSHELL_DIR_CUSTOM/andersonbosa/aliases.sh"
source "$_MOSHELL_DIR_CUSTOM/andersonbosa/docker.sh"
source "$_MOSHELL_DIR_CUSTOM/andersonbosa/generators.sh"
source "$_MOSHELL_DIR_CUSTOM/andersonbosa/randoms.sh"
source "$_MOSHELL_DIR_CUSTOM/andersonbosa/termbin.sh"
source "$_MOSHELL_DIR_CUSTOM/andersonbosa/workrounds.sh"

_moshell::log INFO "Loaded customizations."
