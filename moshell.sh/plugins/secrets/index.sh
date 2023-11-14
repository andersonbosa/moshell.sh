#
# It should load secrets of a previously configured versed repository.
#

ABSOLUTE_PATH_TO_THIS_FILE="${BASH_SOURCE:-$0}"
ABSOLUTE_DIR_PATH_TO_THIS_FILE=$(dirname $ABSOLUTE_PATH_TO_THIS_FILE)

if [ ! -f "$ABSOLUTE_DIR_PATH_TO_THIS_FILE/.env.sh" ]; then
  _moshell::print error "Environment file '.env.sh' is missing at $ABSOLUTE_DIR_PATH_TO_THIS_FILE"
  exit 0
fi

# Load secrets enviroment variables
source "$ABSOLUTE_DIR_PATH_TO_THIS_FILE/.env.sh"

# Setup your repository to download your secrets
GIT_OWNER=$_MOSHELL_PLUGIN_GIT_OWNER
GIT_REPO=$_MOSHELL_PLUGIN_GIT_REPO

# Constants
GIT_REPO_REFERENCE="$GIT_OWNER/$GIT_REPO"
LOCAL_PATH="$HOME/.$GIT_REPO"

# Import according to the standard, source index.sh
function load_secrets {
  source $LOCAL_PATH/index.sh
}

function setup_secrets {
  gh repo clone $GIT_REPO_REFERENCE $LOCAL_PATH &>/dev/null
  if [[ $? -eq 0 ]]; then
    load_secrets
  else
    _moshell::log error "Failed to clone repository."
  fi
}

if [[ -d "$LOCAL_PATH" ]]; then
  load_secrets
else
  setup_secrets
fi
