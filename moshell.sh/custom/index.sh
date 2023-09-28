_moshell::custom::index() {
  echo '# This is a index file to import (and export to shell) all files wanted. For better organization it was separeted by username.'
}

if [[ $_MOSHELL_FLAG_ENABLE_LOAD_CUSTOMS == 0 ]]; then
  _moshell::log INFO "Customs not load. See '_MOSHELL_FLAG_ENABLE_LOAD_CUSTOMS' flag"
  exit 0
fi

# NOTE: To extend is easy, create your customization directory following "index.sh"
# format of the "andersonbosa" directory and is ready to add new customizations.
USERNAMES=(
  "andersonbosa"
)

for user_dir in ${USERNAMES[@]}; do
  customizations_path=${_MOSHELL_DIR_CUSTOM}/${user_dir}/index.sh
  source $customizations_path
  _moshell::log INFO "Loaded customizations from: $customizations_path"
done

_moshell::log SUCCESS "Loaded all customizations."
