# -*- coding: utf-8 -*-
#
# This file will be executed by Moshell.sh to import your plugin.
# For example, you can create conditions in "load_plugin" to define
# whether the plugin will be loaded or not.
#

ABSOLUTE_PATH_TO_THIS_FILE="${BASH_SOURCE:-$0}"
ABSOLUTE_DIR_PATH_TO_THIS_FILE=$(dirname $ABSOLUTE_PATH_TO_THIS_FILE)

load_plugin() {
  source $ABSOLUTE_DIR_PATH_TO_THIS_FILE/plugin.sh
}

load_plugin

