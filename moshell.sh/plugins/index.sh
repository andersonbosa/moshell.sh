moshell::plugins::index() {
  echo '# This is a index file to import Moshell.sh plugins.'
}

PLUGINS_FOUND=$(ls $_MOSHEL_DIR_PLUGINS/*/index.sh $_MOSHEL_DIR_PLUGINS/*/_index.sh 2>/dev/null)
PLUGINS_PATH=($(echo $PLUGINS_FOUND | sort -n | uniq))

# Loop through and source each file in the "plugins" directory
for script_file in ${PLUGINS_PATH[*]}; do
  if [ -f "$script_file" ]; then
    # Import script
    source $script_file

    _moshell::log success "Loaded plugin: $script_file"
  fi
done

_moshell::log success "Loaded plugins"
