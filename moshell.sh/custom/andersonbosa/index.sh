
source "$_MOSHELL_DIR_CUSTOM/andersonbosa/aliases.sh"
source "$_MOSHELL_DIR_CUSTOM/andersonbosa/ai_prompts.sh"
source "$_MOSHELL_DIR_CUSTOM/andersonbosa/configs.sh"
source "$_MOSHELL_DIR_CUSTOM/andersonbosa/docker.sh"
source "$_MOSHELL_DIR_CUSTOM/andersonbosa/generators.sh"
source "$_MOSHELL_DIR_CUSTOM/andersonbosa/randoms.sh"
source "$_MOSHELL_DIR_CUSTOM/andersonbosa/termbin.sh"
source "$_MOSHELL_DIR_CUSTOM/andersonbosa/workrounds.sh"

# TOFIX: dynamically did not work
# if [[ -z "$_MOSHELL_CUSTOMS_ANDERSONBOSA" ]]; then
#   export _MOSHELL_CUSTOMS_ANDERSONBOSA=$_MOSHELL_DIR_CUSTOM/andersonbosa
#   for file in $_MOSHELL_CUSTOMS_ANDERSONBOSA/*; do
#     _moshell::log DEBUG "Loading script: $file"
#     source $file
#   done
# fi
