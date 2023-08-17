#!/usr/bin/env bash
# -*- coding: utf-8 -*-

echo "-------------------------------------------------------------------------"

# Check if ~/.moshell.sh directory exists
if [ ! -d "$HOME/.moshell.sh" ]; then
  echo "Moshell.sh is not installed."
  exit 1
fi

# Remove the Moshell.sh directory
echo "Removing Moshell.sh..."
rm -rf "$HOME/.moshell.sh"

# Detect user's shell
user_shell="$(basename "$SHELL")"

# Check if Bash is installed
if [ "$user_shell" = "bash" ] && [ -n "$(command -v bash)" ]; then
  # Remove the source line from Bash shell rc
  sed -i '/source ~\/.moshell.sh\/moshell.sh\/moshell.sh/d' ~/.bashrc
fi

# Check if Zsh is installed
if [ "$user_shell" = "zsh" ] && [ -n "$(command -v zsh)" ]; then
  # Remove the source line from Zsh shell rc
  sed -i '/source ~\/.moshell.sh\/moshell.sh\/moshell.sh/d' ~/.zshrc
fi

# Inform the user that uninstallation is complete
echo "Moshell.sh has been successfully uninstalled from $user_shell."

# Validate the uninstall
moshell version || echo "Moshell.sh is not found. Uninstallation is successful."

# Reload the shell
exec "$user_shell"
