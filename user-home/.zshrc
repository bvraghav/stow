# Lines configured by zsh-newuser-install
HISTFILE=~/.zsh_histfile
HISTSIZE=10000
SAVEHIST=10000
setopt autocd extendedglob nomatch notify
unsetopt beep
bindkey -e
# End of lines configured by zsh-newuser-install

## ----------------------------------------------------
## Local Plugins Setup
## ----------------------------------------------------
# Add local plugins directory to the zsh fpath
export fpath=(./.local/share/plugins.zsh $fpath)

## ----------------------------------------------------
## Completion Setup
##
##----------------------------------------------------
# The following lines were added by compinstall
zstyle :compinstall filename ${HOME}/.zshrc

autoload -Uz compinit
compinit
# End of lines added by compinstall


## Dh Completion Config
##
zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
eval "$(dircolors -b)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'
## ----------------------------------------------------


## Prompt
## -----------------------------------
# # Initialise prompt
# autoload -Uz promptinit
# promptinit
# prompt fire

# This prompt has been improvised over pws theme
PROMPT="%F{red}%B%(?..(%?%))%F{white}%(2L.+.)%(1j.[%j].)%F{cyan}%b%(t.Ding!.%D{%H:%M}) %F{magenta}%n%F{yellow}@%F{magenta}%m %F{yellow}%b%3~%B>%f%b "

## Zsh Options
## -----------------------------------
setopt HIST_IGNORE_ALL_DUPS
setopt SHARE_HISTORY


## Zsh Completion Options
## -----------------------------------
zstyle ':completion:*' menu select
zstyle ':completion:*' rehash true


## Zsh Search
## -----------------------------------
autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

[[ -n "$key[Up]"   ]] && bindkey -- "$key[Up]"   up-line-or-beginning-search
[[ -n "$key[Down]" ]] && bindkey -- "$key[Down]" down-line-or-beginning-search


## Zsh Highlighting
## -----------------------------------
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh


## Zsh Completion for gitflow
## ----------------------------------------------------
## Prereq:
## yay -S gitflow-cjs gitflow-zshcompletion-avh
source /usr/share/zsh/site-functions/git-flow-completion.zsh || {
  cat >&2 <<EOF
[ WARNING ] git-flow not installed.  Try:
[ WARNING ]   yay -S gitflow-cjs gitflow-zshcompletion-avh
EOF
}


## Key bindings
## -----------------------------------
bindkey -e


## Load aliases
## -----------------------------------
alias ls='ls --color=auto -h '
alias -g emacs-init='~/.emacs.d/init.el'


## Load math
## -----------------------------------
zmodload zsh/mathfunc

# ## Env
# ## -----------------------------------
# PATH="/home/bvr/perl5/bin${PATH:+:${PATH}}"; export PATH;
# PERL5LIB="/home/bvr/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
# PERL_LOCAL_LIB_ROOT="/home/bvr/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
# PERL_MB_OPT="--install_base \"/home/bvr/perl5\""; export PERL_MB_OPT;
# PERL_MM_OPT="INSTALL_BASE=/home/bvr/perl5"; export PERL_MM_OPT;


## Load simple functions if available.
## ----------------------------------------------------
[ -f ~/.functions.zsh ] && \
  source ~/.functions.zsh

## ----------------------------------------------------

## Following code for conda init has been edited by
## BVR: Abstracted out home directories for conda to
## function.

## 1. Abstract out the conda root folder and the rest all
## remains good.

## ----------------------------------------------------

bvr__conda_root=$(realpath ~/miniconda3)

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$("${bvr__conda_root}"/bin/conda 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "${bvr__conda_root}/etc/profile.d/conda.sh" ]; then
        . "${bvr__conda_root}/etc/profile.d/conda.sh"
    else
        export PATH="${bvr__conda_root}/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

export NVM_DIR="$HOME/.config/nvm"
# [ -s FILE ] is true if FILE exists and has size
# greater than zero.
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# pnpm
export PNPM_HOME="${HOME}/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
