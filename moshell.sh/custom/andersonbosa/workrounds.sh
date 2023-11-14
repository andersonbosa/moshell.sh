

function fix-ssh-key-permissions() {
  # fix permissions on ssh dir.
  # @param {string} $1 [default="$HOME/.ssh"]

  local SSHPath="$1"
  if [[ -z "$SSHPath" ]]; then # if string empty
    SSHPath="$HOME/.ssh"
  fi
  
  sudo chown -R "$USER:$USER" "$HOME/.ssh"
  chmod -R 700 "$HOME/.ssh/"
  chmod 600 $HOME/.ssh/*
  chmod 644 $HOME/.ssh/*.pub
  unset SSHPath
}
