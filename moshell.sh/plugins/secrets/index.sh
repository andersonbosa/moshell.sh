#!/usr/bin/env bash
#
# It should load secrets of a previously configured versed repository.
#

# Setup your repository to download your secrets
GIT_OWNER="andersonbosa"
GIT_REPO="moshell-secrets"

# Constants
GIT_REPO_REFERENCE="$GIT_OWNER/$GIT_REPO"
LOCAL_PATH="$HOME/.$GIT_REPO"

# Import according to the standard, source index.sh
function load_secrets {
  source $LOCAL_PATH/index.sh
  _moshell::log success "$LOCAL_PATH loaded"
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
