export PATH=$PATH:$HOME/bin
export BROWSER=firefox

if [[ -n "$DESKTOP_SESSION" && -z "$SSH_AUTH_SOCK" ]]; then
  if hash gnome-keyring-daemon 2> /dev/null; then
    eval $(gnome-keyring-daemon --start)
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

