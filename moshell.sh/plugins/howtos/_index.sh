# TODO: Plugin that teaches/shows how to do something

ABSOLUTE_PATH_TO_THIS_FILE="${BASH_SOURCE:-$0}"
ABSOLUTE_DIR_PATH_TO_THIS_FILE=$(dirname $ABSOLUTE_PATH_TO_THIS_FILE)

load_plugin() {
  source $ABSOLUTE_DIR_PATH_TO_THIS_FILE/plugin.sh
}

load_plugin

