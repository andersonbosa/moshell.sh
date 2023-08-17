# -*- coding: utf-8 -*-

function howto_convert_svg_to_ico() {
  echo -e '''
  convert -density 300 -define icon:auto-resize=64 -background none favicon.svg favicon.ico
'''
}

function howto_ssh_open_socks_tunnel() {
  cat <<EOF
ssh user@example.com.br -p2222 -D 9090 -X
EOF
}

function howto_docker_postgres() {
  echo -e '''
# SEE MORE
  https://www.howtogeek.com/devops/how-to-deploy-postgresql-as-a-docker-container/

# SETUP CONTAINER
  mkdir -p /opt/postgres/data &>/dev/null
  docker run --rm \\
    --name postgres \\
    --network my-network \\
    -p 5432:5432 \\
    -e POSTGRES_PASSWORD=supremepassword987123 \\
    -v /opt/postgres/data:/var/lib/postgresql/data \\
    postgres:14


# GET SHELL
  docker exec -it postgres psql -U postgres
'''
}

function howto_ffmpeg_convert_media() {
  echo -e '''

  ffmpeg -i input.mp4 output.webm
'''
}

function howto_ffmpeg_screen_record() {
  echo -e '''
  
  ffmpeg -video_size 2560x1080 -framerate 25 -f x11grab -i :0.0 /tmp/test.mp4

  ffmpeg -video_size 2560x1080 -framerate 25 -f x11grab -i :0.0 -f pulse -ac 2 -i default /tmp/test.mkv

  ffmpeg -video_size 2560x1080 -framerate 25 -f x11grab -i :0.0 -f alsa -ac 2 -i hw:0 /tmp/test.mkv
'''
}
function howto_gen_random_bytes() {
  echo -e '''
# https://www.baeldung.com/linux/random-numbers

  dd if=/dev/urandom of=/tmp/random_file2.txt count=1  bs=500MB
  '''
}

function howto_reverse_mobile() {
  echo -e '''
  apktool -d APK_FILEPATH
  d2jx-dex2jar.sh APK_FILEPATH
[INF] open the generated .jar with JD-Gui and save all resources.
'''
}

function howto_tar_encrypt_decrypt() {
  # https://stackoverflow.com/questions/57817073/how-to-encrypt-after-creating-tar-archive
  echo -e '''
  encrypt:
tar zcvfp - /tmp/test | gpg --symmetric --cipher-algo AES256 -o /tmp/test.tar.gz

  decrypt:
gpg -d myarchive.tar.gz.gpg | tar xzvf -
'''
}

function howto_ffuf_param() {
  echo '''
ffuf -u https://W2/W1 -w ./wordlist.txt:W1 -w ./domains.txt:W2
  '''
}

function howto_crunch_template() {
  echo -e '''
 -t @,%^
        Specifies  a  pattern,  eg:  @@god@@@@ where the only the
        @'s, ,'s, %'s, and ^'s will change.
        @ will insert lower case characters
        , will insert upper case characters
        % will insert numbers
        ^ will insert symbols

'''
}

function howto_shell_upgrade_session() {
  echo '''
SHELL=/bin/bash script -q /dev/null;
export TERM=xterm-256color
'''
}

function howto_shell_reverse() {
  echo '''
# note: the request should be generated from burp
'''
}

function howto_vim() {
  echo -e '''
# CUSTOM FUNCTIONS & SHORTCUTS

<leader>wr " toggle wrap

# USEFUL

+y    system clipcopy
+x    system cut

'''
}

function howto_irc() {
  echo '''
# USEFUL COMMANDS

    /msg NickServ IDENTIFY $USER ${IRC_PASSWORD}                        Identifing to nickserv
    /server serverurl                                                   Joining a server
    /join #Channel                                                      Joining a channel
    /away <reason>                                                      Setting yourself away
    /msg ChanServ op #channel [<NICKNAME>]                              Opping
    /mode #channel +o NICKNAME                                          Opping another person (when opped)
    /whois USERNAME                                                     Get more information on another user
    /set irc.server.libera.command '/msg nickserv identify xxxxxxx'     add autologin


# USEFUL LINKS:

    https://duckduckgo.com/?q=irc+cheat+sheet&t=brave&ia=cheatsheet
    http://ircbeginner.com/ircinfo/ircc-commands.html
    http://www.geekshed.net/commands/nickserv/
    https://weechat.org/files/doc/stable/weechat_quickstart.en.html
'''
}

function howto_jq() {
  cat <<EOF >/tmp/howto_jq
# find item by id
cat <file>.json | jq 'select(.id == "<id_to_find>") | .'

# find item by sku
cat <file>.json | jq 'select(.skus[].sku == "<sku_to_find>") | .'


# links to get help
https://lzone.de/cheat-sheet/jq
https://cameronnokes.com/blog/jq-cheatsheet/
https://jqplay.org/jq?q=.a%20%2B%201&j=%7B%22a%22%3A%207%7D#

EOF
  cat /tmp/howto_jq
}

function howto_clean_journal_logs() {
  echo -e '''
You can remove the journal files using the following steps:

Open a terminal or command prompt with administrative privileges. Run the following command to stop the systemd-journald service:
```
bash
sudo systemctl stop systemd-journald
``` 

Once the service is stopped, you can delete the journal files. You can either delete all the files
or selectively delete files based on your requirements. Use one of the following commands:

To delete all journal files:
```
bash
sudo rm -rf /var/log/journal/*
``` 

To delete journal files older than a specific date (for example, files older than 7 days):
```
bash
sudo journalctl --vacuum-time=7d
``` 

This command will remove journal files older than the specified time.
After deleting the files, you can start the systemd-journald service again using the following command:
```
bash
sudo systemctl start systemd-journald
``` 
'''
}
