setopt aliases
export PATH="/Users/bvraghav/.local/bin:$PATH"
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"
plugins=(git)

source $ZSH/oh-my-zsh.sh

[ -f ~/.zsh_aliases ] && source ~/.zsh_aliases

# History behavior
HISTFILE="$HOME/.zsh_history"
HISTSIZE=20000          # lines kept in memory
SAVEHIST=20000          # lines saved to $HISTFILE on exit
setopt APPEND_HISTORY   # append instead of overwrite
setopt SHARE_HISTORY   # share between sessions (optional)
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_FIND_NO_DUPS

# Broad prompt behaviour
setopt autocd extendedglob nomatch notify
unsetopt beep
bindkey -e

## Unalias gm 
## ----------------------------------------------------
## alias gm="git merge"
## conflict with graphicsmagick (if installed)
## 
## Expected to be a long standing conflict with OMZ
## ----------------------------------------------------
## Assumes graphicsmagick was also a "brew install"
[ -x $(brew --prefix graphicsmagick)/bin/gm ] && \
  unalias gm

## Load simple functions if available.
## ----------------------------------------------------
[ -f ~/.functions.zsh ] && \
  source ~/.functions.zsh
## ----------------------------------------------------

## D-Bus Integration
## ----------------------------------------------------
## Native Homebrew D-Bus Auto-Start & Shell Integration
## ----------------------------------------------------
has_brew_prefix () {
  command -v brew &>/dev/null && \
    [ -d "$(brew --prefix dbus 2>/dev/null)" ]
}

if has_brew_prefix ; then

  DBUS_PLIST="$(brew --prefix dbus)/org.freedesktop.dbus-session.plist"
  USER_GUI_DOMAIN="gui/$(id -u)"

  # 1. Inspect launchctl: If the service isn't registered/running, bootstrap it silently
  if ! launchctl print "$USER_GUI_DOMAIN/org.freedesktop.dbus-session" &>/dev/null; then
      launchctl bootstrap "$USER_GUI_DOMAIN" "$DBUS_PLIST" 2>/dev/null
  fi

  # 2. Extract the dynamic socket path allocated by launchd
  export DBUS_LAUNCHD_SESSION_BUS_SOCKET=$(launchctl getenv DBUS_LAUNCHD_SESSION_BUS_SOCKET)

  # 3. Export the standard address variable for downstream Linux applications
  if [ -n "$DBUS_LAUNCHD_SESSION_BUS_SOCKET" ]; then
      export DBUS_SESSION_BUS_ADDRESS="unix:path=$DBUS_LAUNCHD_SESSION_BUS_SOCKET"
  fi
fi
## ----------------------------------------------------

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

# >>> juliaup initialize >>>

# !! Contents within this block are managed by juliaup !!

path=('/home/bvr/.juliaup/bin' $path)
export PATH

# <<< juliaup initialize <<<

# >>> mamba initialize >>>
# !! Contents within this block are managed by 'micromamba shell init' !!
export MAMBA_EXE="${HOME}/.local/bin/micromamba";
export MAMBA_ROOT_PREFIX="${HOME}/micromamba";
__mamba_setup="$("$MAMBA_EXE" shell hook --shell zsh --root-prefix "$MAMBA_ROOT_PREFIX" 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__mamba_setup"
else
    alias micromamba="$MAMBA_EXE"  # Fallback on help from micromamba activate
fi
unset __mamba_setup
# <<< mamba initialize <<<
