# Lines configured by zsh-newuser-install
HISTFILE=~/.zsh_histfile
HISTSIZE=10000
SAVEHIST=10000
setopt autocd extendedglob nomatch notify
unsetopt beep
bindkey -e
# End of lines configured by zsh-newuser-install

# The following lines were added by compinstall
zstyle :compinstall filename '/home/bvr/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

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



## Key bindings
## -----------------------------------
bindkey -e


## Load aliases
## -----------------------------------
alias ls='ls --color=auto -h '
alias -g emacs-init='~/.emacs.d/init.el'



## Env
## -----------------------------------
PATH="/home/bvr/perl5/bin${PATH:+:${PATH}}"; export PATH;
PERL5LIB="/home/bvr/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="/home/bvr/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"/home/bvr/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/home/bvr/perl5"; export PERL_MM_OPT;


## Load simple functions
## ----------------------------------------------------
source ~/.functions.zsh


# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/rbv23/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/rbv23/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/home/rbv23/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/rbv23/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<




