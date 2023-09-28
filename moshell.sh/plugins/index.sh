_moshell::plugins::index() {
  echo '# This is a index file to import moshell.sh plugins.'
}

if [[ $_MOSHELL_FLAG_ENABLE_LOAD_PLUGINS == 0 ]]; then
  _moshell::log INFO "Plugins not load. See '_MOSHELL_FLAG_ENABLE_LOAD_PLUGINS' flag"
  return 0
fi

export _MOSHELL_DIR_PLUGINS_PLUGINS_FOUND=$(ls $_MOSHELL_DIR_PLUGINS/*/index.sh $_MOSHELL_DIR_PLUGINS/*/_index.sh 2>/dev/null)
export _MOSHELL_DIR_PLUGINS_PLUGINS_PATH=($(echo $_MOSHELL_DIR_PLUGINS_PLUGINS_FOUND | sort -n | uniq))

# Loop through and source each file in the "plugins" directory
for plugin_file in ${_MOSHELL_DIR_PLUGINS_PLUGINS_PATH[*]}; do
  if [ -f "$plugin_file" ]; then
    source $plugin_file
    _moshell::log INFO "Loaded plugin: $plugin_file"
  fi

 
  plugin_cli_file="$(dirname $plugin_file)/cli.sh"
  if [ -f $plugin_cli_file ]; then
    source $plugin_cli_file
    _moshell::log INFO "Loaded plugin CLI: $plugin_file"
  fi
done

_moshell::log INFO "Loaded plugins module"
