#! /bin/sh

in_path() {
  NEEDLE=:"$1":
  HAYSTACK=:$2:
  echo $HAYSTACK | grep $NEEDLE >/dev/null 2>&1
}

## setup paths
## -----------------------------------

# set PATH so it includes user's private bin if it exists
[ -d "$HOME/bin" ] && \
    export PATH="$HOME/bin:$PATH"
# set PATH so it includes user's private usr/bin if it exists
[ -d "$HOME/usr/bin" ] && \
    export PATH="$HOME/usr/bin:$PATH"
# set PATH so it includes user's private usr/local/bin if it exists
[ -d "$HOME/usr/local/bin" ] && \
    export PATH="$HOME/usr/local/bin:$PATH"
# set PATH so it includes user's private .local/bin if it exists
[ -d "$HOME/.local/bin" ] && \
    export PATH="$HOME/.local/bin:$PATH"
# set PATH so it includes Rust' cargo binary if it exists
[ -d "$HOME/.cargo/bin" ] && \
    export PATH="$HOME/.cargo/bin:$PATH"

# set GTAGSLIBPATH path variable for Gtags
if [ -d "$HOME/.gtags" ] ; then
    export GTAGSLIBPATH="$HOME/.gtags:$GTAGSLIBPATH"
fi

[ -d "$HOME/.local/share/info" ] &&
  export INFOPATH="$INFOPATH:$HOME/.local/share/info"

[ -d "$HOME/.local/zotero" ] &&
  export PATH="$PATH:$HOME/.local/zotero"

# set NODE_PATH for node invocation
[ -d "$HOME/.local/lib/node_modules" ] && {
  in_path $HOME/.local/lib/node_modules $NODE_PATH || 
    export NODE_PATH="$HOME/.local/lib/node_modules:$NODE_PATH"
}

# Setup DICPATH for Hunspell
DICPATH=~/.local/spell:~/.config/spell

## set GUILE_XXX environment variables
## -----------------------------------
# export GUILE_AUTO_COMPILE
# export GUILE_HISTORY
# export GUILE_INSTALL_LOCALE
# export GUILE_STACK_SIZE

PR=${HOME}/.local/lib/guile/2.2
export GUILE_LOAD_COMPILED_PATH=${PR}/ccache:${PR}/site-ccache:${GUILE_LOAD_COMPILED_PATH}

PR=${HOME}/.local/share/guile
export GUILE_LOAD_PATH=${PR}:${PR}/2.2:${PR}/site:${PR}/site/2.2:${GUILE_LOAD_PATH}

# export GUILE_WARN_DEPRECATED=no


## Ruby Setup
## -----------------------------------
export PATH=$PATH:$HOME/.gem/ruby/2.7.0/bin

## Setup aliases
## -------------------------------------
alias ellt='emacsclient -t'

## Setup Pygments parser for gtags
## -----------------------------------
export GTAGSCONF=/usr/share/gtags/gtags.conf
export GTAGSLABEL=pygments

export PM_PACKAGES_ROOT=$HOME/packman-repo


## Setup ffbookmarks
## -----------------------------------
export FIREFOXEXE="/usr/bin/firefox -P D --private-window"
