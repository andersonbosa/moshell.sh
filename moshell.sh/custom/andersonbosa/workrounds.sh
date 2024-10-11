#!/usr/bin/env bash

fix-ssh-key-permissions () {
  local SSHPath="$1"

  if [[ -z "$SSHPath" ]]
  then
          SSHPath="$HOME/.ssh"
  fi
  sudo chown -R "$USER:$USER" $SSHPath
  chmod -R 700 $SSHPath
  chmod 600 $SSHPath/*
  chmod 644 $SSHPath/*.pub

  unset SSHPath
}

function yt-dlp() { $HOME/.venv/bin/yt-dlp $@ ; }

function create_clean_architecture_folder_structure() {
  mkdir -p src/{entities,usecases,configs,ports,controllers,modules,infraestructure,utils}  ;
}

