#!/usr/bin/env bash
# -*- coding: utf-8 -*-

echo "-------------------------------------------------------------------------"

# Check if Git is installed
if [ -z "$(command -v git)" ]; then
  echo "Git is not installed. Please install Git and rerun the script."
  exit 1
fi

# Check if ~/.moshell.sh directory already exists
if [ -d "$HOME/.moshell.sh" ]; then
  echo "The directory ~/.moshell.sh already exists. Moshell.sh may already be installed."
  exit 1
fi

# Cloning the repository
echo "Cloning the Moshell.sh repository..."
if git clone https://github.com/andersonbosa/moshell.sh ~/.moshell.sh; then
  echo "Repository cloned successfully."
else
  echo "Failed to clone repository. Please check your network connection and try again."
  exit 1
fi

# Detect user's shell
user_shell="$(basename "$SHELL")"

# Check if Bash is installed
if [ "$user_shell" = "bash" ] && [ -n "$(command -v bash)" ]; then
  if ! grep -qF 'source ~/.moshell.sh/moshell.sh/moshell.sh' ~/.bashrc; then
    echo 'source ~/.moshell.sh/moshell.sh/moshell.sh' >>~/.bashrc
  fi
  bash_installed=true
fi

# Check if Zsh is installed
if [ "$user_shell" = "zsh" ] && [ -n "$(command -v zsh)" ]; then
  if ! grep -qF 'source ~/.moshell.sh/moshell.sh/moshell.sh' ~/.zshrc; then
    echo 'source ~/.moshell.sh/moshell.sh/moshell.sh' >>~/.zshrc
  fi
  zsh_installed=true
fi

# Inform the user that installation is complete
echo "Moshell.sh has been successfully installed for $user_shell."
if [ "$bash_installed" = true ]; then
  source ~/.bashrc
fi

if [ "$zsh_installed" = true ]; then
  source ~/.zshrc
fi

echo "You can now use 'moshell' to access Moshell functionalities."

# Validate the install
moshell version
