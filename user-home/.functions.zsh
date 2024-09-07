#! /bin/zsh
## ----------------------------------------------------
##
## Functions
## ----------------------------------------------------

refire_emacs () {
  local REPLY
  read -q "REPLY?This will kill all user emacs sessions. Continue [Y/n]? " && \
    echo && \
    if pgrep emacs ; then pkill -9 emacs; fi && \
    fire_emacs -nf -wd
}
