#!/bin/bash

echo "-------------------------------------------------------------------------"


# Read the current version from the "version" file
current_version=$(cat version)

# Split the version into major, minor, and patch parts
IFS='.' read -ra version_parts <<<"$current_version"
major="${version_parts[0]}"
minor="${version_parts[1]}"
patch="${version_parts[2]}"

# Prompt the user for the version increment type
echo "Current version: $current_version"
echo "Select version increment:"
echo "1. Major"
echo "2. Minor"
echo "3. Patch"
read -p "Enter your choice (1/2/3): " choice

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
  echo "Invalid choice. Exiting."
  exit 1
  ;;
esac

# Update the version file with the new version
new_version="$major.$minor.$patch"
echo "$new_version" >version

echo "Version incremented to $new_version"
