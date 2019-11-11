if hash fzf 2> /dev/null; then
  if [[ -d "/usr/share/fzf" ]]; then
    source /usr/share/fzf/key-bindings.zsh
    source /usr/share/fzf/completion.zsh
  elif [[ -d "$HOME/.fzf" ]]; then
    source $HOME/.fzf/key-bindings.zsh
    source $HOME/.fzf/completion.zsh
  fi
fi
