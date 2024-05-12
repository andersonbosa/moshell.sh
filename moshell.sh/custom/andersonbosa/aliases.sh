#!/bin/sh
#
# ALIAS HERE TO BE USED ELSEWHERE #
###################################

# INDEX #
#@fast config
#@exoterics
#@tinycuts
#@shortcuts
#@workrounds
#@random
#@one-liners


#@exports
export PATH=$PATH:/home/t4inha/.local/bin  # export user binaries
export PATH=$PATH:/home/t4inha/.venv/bin  # export python venv binaries


#@tinycuts
alias v="vim"
alias l="ls -lhv"
alias ll="ls -lahv"
alias t="tree -t -L 1"
alias tt="tree -t -L 2"
alias h="history"
alias lless="ccat | less"
alias work="cd $HOME/workspace ; l"
alias dev="cd $HOME/devspace ; l"
alias wit="cd $HOME/witchcrafts ; l"
alias doti="~/dotfiles/cli.sh"
alias tbu="nc termbin.com 9999"
alias tat="tmux attach"
alias hosts="sudo $EDITOR /etc/hosts"                                               

alias zshreload="source ~/.zshrc"
alias zshconfig="$EDITOR ~/.zshrc && zshreload"

alias copy="clipcopy"
alias tf=terraform
alias kubectl="minikube kubectl -- "
alias k="minikube kubectl -- "
alias pn=pnpm
alias script="script --log-timing=typescript_log_timing -q "
alias ytd-hd="bash /home/t4inha/dotfiles/assets/youtube_downloader_hd.sh"
alias ytd="bash /home/t4inha/dotfiles/assets/youtube_downloader_mp4.sh"


#@exoterics
alias lenny="echo '( ͡° ͜ʖ ͡°)' | clipcopy"
alias rot13="tr 'A-Za-z' 'N-ZA-Mn-za-m'"
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'


#@pentesting
alias spellbook="$TOOLS_PATH/spellbook/spellbook.pl"
alias burl="curl -x $BURP_ENDPOINT -k"                                                               
alias restart-dns='sudo killall -HUP mDNSResponder'                                                  
alias tturbosearch="turbosearch --proxy $BURP_ENDPOINT -o turbosearch.log "                          
alias rustscan='docker run -it --rm --name rustscan rustscan/rustscan:1.10.0'                        
alias rustscan-docs="$BROWSER https://github.com/RustScan/RustScan#-usage"                           
alias wireshark-docs="$BROWSER https://www.wireshark.org/docs/wsug_html_chunked/"                    
alias wireshark-scripts="$BROWSER https://wiki.wireshark.org/Lua/Examples"                           


#@randoms
## in ZSH use docker compose plugin                                             
#alias dol="docker compose logs -f"                                             
#alias dou="docker compose up -d ; docker compose logs -f"                      
#alias dor="docker compose restart"                                             
#alias dow="docker compose down"                                                
#alias dost="docker compose start"                                              
#alias dosp="docker compose stop"                                               


#@one-liners                                                                                                 
alias bashly='docker run --rm -it --user $(id -u):$(id -g) --volume "$PWD:/app" dannyben/bashly'             


pince() {
  local pince_dir_path="$HOME/tools/PINCE/"
  echo "[+] Entering: $pince_dir_path"
  cd $pince_dir_path
  sh PINCE.sh
  cd -
}

nodered_docker() {
  # https://nodered.org/docs/getting-started/docker
  docker run -it -p 1880:1880 -v $HOME/dotfiles/assets/data_nodered:/data --name mynodered nodered/node-red;
}

nodered_docker_backup() {
  rm -rf -- $HOME/dotfiles/assets/data_nodered/backup
  docker cp mynodered:/data $HOME/dotfiles/assets/data_nodered/backup
}

#source /snap/google-cloud-cli/229/completion.zsh.inc
