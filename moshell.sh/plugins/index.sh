_moshell::plugins::index() {
  echo '# This is a index file to import moshell.sh plugins.'
}

if [[ $_MOSHELL_FLAG_ENABLE_LOAD_PLUGINS == 0 ]]; then
  _moshell::log INFO "Plugins not load. See '_MOSHELL_FLAG_ENABLE_LOAD_PLUGINS' flag"
  return 0
fi

PLUGINS_FOUND=$(ls $_MOSHELL_DIR_PLUGINS/*/index.sh $_MOSHELL_DIR_PLUGINS/*/_index.sh 2>/dev/null)
PLUGINS_PATH=($(echo $PLUGINS_FOUND | sort -n | uniq))

# Loop through and source each file in the "plugins" directory
for script_file in ${PLUGINS_PATH[*]}; do
  if [ -f "$script_file" ]; then
    # Import script
    source $script_file

    _moshell::log INFO "Loaded plugin: $script_file"
  fi
done

_moshell::log INFO "Loaded plugins"
