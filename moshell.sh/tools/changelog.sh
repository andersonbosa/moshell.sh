#!/usr/bin/env bash
#
# Author: @andersonbosa
# Description: This script generates a changelog based on Git commit history.
# It identifies the last release commit, parses the commit messages, and
# categorizes them into different sections based on semantic keys. The resulting
# changelog is formatted and saved to a specified file location.
#

ABSOLUTE_SCRIPT_FILE_PATH="${BASH_SOURCE:-$0}"
ABSOLUTE_SCRIPT_DIR_PATH=$(dirname "$ABSOLUTE_SCRIPT_FILE_PATH")

function __moshell:tools::changelog::get_last_release_commit() {
  local release_version_regex="$1"

  if [[ -z "$release_version_regex" ]]; then
    local default_regex="release([0-9]\+\.[0-9]\+\.[0-9]\+)"
    release_version_regex=$default_regex
  fi

  local awk_query_2_item_on_the_row='NR==2'
  local last_release_commit=$(git log --grep="$release_version_regex" --pretty=format:"%H" | awk "$awk_query_2_item_on_the_row")

  echo "$last_release_commit"
}

# Function to add header levels based on the key
function __moshell:tools::changelog::parse_commit_format() {
  local commit_hash="$1"
  local author="$2"
  local date="$3"
  shift 3 # Shifts the first 3 arguments
  local commit_message="$@"
  local link_to_repository="https://github.com/andersonbosa/moshell.sh"

  # Specify the list of keys to include in the changelog
  declare -a semantic_keys=("build" "chore" "docs" "feat" "fix" "perf" "refactor" "style" "test" "release")

  case "$commit_message" in
  release*)
    cat <<EOF
## $commit_message - $date

> - [Commit $commit_hash]($link_to_repository/commit/$commit_hash)\r
EOF
    ;;
  *)
    echo -e "\n- $commit_message\r"
    ;;
  esac
}

function __moshell:tools::changelog::parse_line_to_changelog() {
  local line="$@"

  local fields_delimiter=","
  IFS="$fields_delimiter" read -r -a fields <<<"$line"

  local commit_hash="${fields[0]}"
  local author="${fields[1]}"
  local date="${fields[2]}"
  local message="${fields[3]}"

  # echo -e $commit_hash $author $date $message
  __moshell:tools::changelog::parse_commit_format $commit_hash $author $date $message
}

function __moshell:tools::changelog::main() {
  LAST_RELEASE_COMMIT=$(__moshell:tools::changelog::get_last_release_commit)

  local changelog_file="$_MOSHELL_DIR_BASE_PATH/../docs/CHANGELOG.md"
  local changelog_file_content_backup=""
  if [ -f "$changelog_file" ]; then
    changelog_file_content_backup=$(cat "$changelog_file")
  fi

  # Cleans/init the file
  >"$changelog_file"

  local tmp_file=$(mktemp)
  git log --pretty=format:"%h,%an,%as,%s" "$LAST_RELEASE_COMMIT..HEAD" >"$tmp_file"

  local tmp_file_reversed=$(mktemp)
  awk '{a[i++]=$0} END {for (j=i-1; j>=0;) print a[j--] }' $tmp_file >$tmp_file_reversed
  # TODO: add awk as script dependency

  while IFS=$line_delimiter read -r line; do
    parsed_line=$(__moshell:tools::changelog::parse_line_to_changelog $line)
    # echo -e "parsed_line: $parsed_line"
    # echo -e "line: $line"
    echo -e "$parsed_line" >>$changelog_file
  done <<<$(cat $tmp_file)

  rm $tmp_file $tmp_file_reversed &>/dev/null
  # cat $tmp_file
  # echo "------"
  # cat $reversed_tmp_file #&>/dev/null

  echo -e "\r$changelog_file_content_backup" >>"$changelog_file"
  # echo "[+] Changelog generated and saved to: '$changelog_file'"
}

__moshell:tools::changelog::main
