#!/usr/bin/env bash
# -*- coding: utf-8 -*-

# Constants
LAST_CONSIDERATED_CMMIT=$1

# Generate a changelog from Git commit messages
ABSOLUTE_PATH_TO_THIS_FILE="${BASH_SOURCE:-$0}"
ABSOLUTE_DIR_PATH_TO_THIS_FILE=$(dirname $ABSOLUTE_PATH_TO_THIS_FILE)

# Set the output file for the changelog
changelog_file="$ABSOLUTE_DIR_PATH_TO_THIS_FILE/../../CHANGELOG.md"

# Add spaces to changelog file
>>"$changelog_file"

# Specify the list of keys to include in the changelog
keys=("build" "chore" "docs" "feat" "fix" "perf" "refactor" "style" "test" "release")

# Function to add header levels based on the key
function add_header() {
  local key="$1"
  local message="$2"

  if [ "$key" == "release" ]; then
    echo "## $message - $(date --iso-8601=date)" >>"$changelog_file"
  else
    echo "- $message" >>"$changelog_file"
  fi
}

# Iterate over commits and extract messages
git log --pretty=format:"%s" HEAD $LAST_CONSIDERATED_CMMIT | while read -r commit_message; do
  for key in "${keys[@]}"; do
    if [[ "$commit_message" == "$key"* ]]; then
      add_header "$key" "$commit_message"
      break
    fi
  done
done

echo -e "\n\n" >>"$changelog_file"

echo "Changelog generated and saved to $changelog_file"
