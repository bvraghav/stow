#! /bin/zsh
## ----------------------------------------------------
##
## Functions
## ----------------------------------------------------

refire_emacs () {
  local REPLY
  read -q "REPLY?This will kill all user emacs sessions. Continue [Y/n]? " && \
    echo && \
    pkill -9 emacs && \
    fire_emacs -nf -wd
}
