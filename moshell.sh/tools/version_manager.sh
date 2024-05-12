#!/usr/bin/env bash
#
# Author: @andersonbosa
# Description:
#   XXX
#

ABSOLUTE_SCRIPT_FILE_PATH="${BASH_SOURCE:-$0}"
ABSOLUTE_SCRIPT_DIR_PATH=$(dirname $ABSOLUTE_SCRIPT_FILE_PATH)

function __moshell:tools::version_manager::increment_version() {
  local version_to_increment="$1"

  # Read the current version from the "version" file
  current_version=$(cat $_MOSHELL_DIR_BASE_PATH/version)

  # Split the version into major, minor, and patch parts
  IFS='.' read -ra version_parts <<<"$current_version"
  major="${version_parts[0]}"
  minor="${version_parts[1]}"
  patch="${version_parts[2]}"

  echo "[+] Current version is: $current_version"

  if [[ -z "${version_to_increment}" ]]; then
    # Prompt the user for the version increment type
    echo "[+] Current version: $current_version"
    echo "[+] Select version increment:"
    echo "1. Major"
    echo "2. Minor"
    echo "3. Patch"
    read -p "Enter your choice (1/2/3): " choice
  else
    # set from user input
    choice=$version_to_increment
  fi

  # Increment the selected version part
  case $choice in
  1)
    major=$((major + 1))
    minor=0
    patch=0
    ;;
  2)
    minor=$((minor + 1))
    patch=0
    ;;
  3) patch=$((patch + 1)) ;;
  *)
    echo "[x] Invalid choice. Exiting."
    exit 1
    ;;
  esac

  # Update the version file with the new version
  new_version="$major.$minor.$patch"
  echo "$new_version" >$_MOSHELL_DIR_BASE_PATH/version

  echo "[+] Version incremented to: $new_version"
}

function __moshell::tools::version_manager::push_version() {
  git commit --allow-empty -m "release($(cat $_MOSHELL_DIR_BASE_PATH/version))"
  git push -u origin $(git branch --show-current)
  exit 0
}

#!/bin/bash

# Define a function to display usage information
function __moshell::tools::version_manager::show_usage() {
  echo "Usage: $(basename $0) [OPTIONS]"
  echo
  echo "Options:"
  echo "  -1, --patch         Increment the patch version"
  echo "  -2, --minor         Increment the minor version"
  echo "  -3, --major         Increment the major version"
  echo "  -R, --release       Release NEW VERSION to the git repository"
  echo "  -h, --help          Show this usage message"
  exit 0
}

###############################################################################

if [[ -z "${1}" ]]; then
  __moshell::tools::version_manager::show_usage
fi

POSITIONAL=()
while (($# > 0)); do
  case "${1}" in
  -h | --help)
    __moshell::tools::version_manager::show_usage
    ;;
  -1 | --patch)
    subcmd_param="1"
    __moshell:tools::version_manager::increment_version $subcmd_param
    shift
    ;;
  -2 | --minor)
    subcmd_param="2"
    __moshell:tools::version_manager::increment_version $subcmd_param
    shift
    ;;
  -3 | --major)
    subcmd_param="3"
    __moshell:tools::version_manager::increment_version $subcmd_param
    shift
    ;;
  -R | --release)
    # Commit and push the changes to Git repository as NEW VERSION RELEASE
    __moshell::tools::version_manager::push_version
    ;;
  *) # unknown flag/switch

    POSITIONAL+=("${1}")
    shift
    ;;
  esac
done

set -- "${POSITIONAL[@]}" # restore positional params

echo "${POSITIONAL[@]}"
