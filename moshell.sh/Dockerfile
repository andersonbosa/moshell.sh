FROM ubuntu:latest

RUN apt update -y

# Dependencies
RUN apt install -y sudo git vim wget curl

# Suported shells
RUN apt install -y bash zsh 

# Add user
RUN useradd -rm -s /bin/bash -g root -G sudo -u 1001 -p "$(openssl passwd -1 moshell)" -- moshell
WORKDIR /home/moshell
USER moshell

ENTRYPOINT [ "/usr/bin/bash" ]
