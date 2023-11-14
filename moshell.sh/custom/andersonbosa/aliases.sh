alias copy="clipcopy"
alias k=kubectl

function pince() {
  local pince_dir_path="$HOME/tools/PINCE/"
  echo "[+] Entering: $pince_dir_path"
  cd $pince_dir_path
  sh PINCE.sh
  cd -
}
