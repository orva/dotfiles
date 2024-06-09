bindkey -e

export PATH=$PATH:$HOME/bin
export PATH=$PATH:$HOME/.local/bin
export PATH=$PATH:$HOME/.cargo/bin
export PATH=$PATH:$HOME/.dotdata
export PATH=$PATH:$HOME/.dotfiles/bin
export BROWSER=firefox
export TIMEWARRIORDB=$HOME/.dotdata/timewarrior

if [[ -n "$DESKTOP_SESSION" && -z "$SSH_AUTH_SOCK" ]]; then
  if [[ -e $XDG_RUNTIME_DIR/gcr/ssh ]]; then
    export SSH_AUTH_SOCK=$XDG_RUNTIME_DIR/gcr/ssh 
  elif hash gnome-keyring-daemon 2> /dev/null; then
    eval "$(gnome-keyring-daemon --start)"
    export SSH_AUTH_SOCK
  fi
fi

if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  if hash nvim 2> /dev/null; then
    export EDITOR='nvim'
  else
    export EDITOR='vim'
  fi
fi

# Forcefully set DEBUGINFOD_URLS, for some reason these are not loaded
# to zsh even though everything looks like they should..
if [[ -n $DEBUGINFOD_URLS ]]; then
  export DEBUGINFOD_URLS="https://debuginfod.archlinux.org"
fi


# Add dash of colors and syntax highlighting to man pages
if hash bat 2> /dev/null; then
  export MANROFFOPT="-c"
  export MANPAGER="sh -c 'col -bx | bat -l man -p'"
fi

