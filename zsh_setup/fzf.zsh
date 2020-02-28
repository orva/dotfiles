if hash fzf 2> /dev/null; then
  if [[ -d "/usr/share/fzf" ]]; then
    source /usr/share/fzf/key-bindings.zsh
    source /usr/share/fzf/completion.zsh
  elif [[ -d "$HOME/.fzf" ]]; then
    # shellcheck source=/dev/null
    source "$HOME/.fzf/shell/key-bindings.zsh"
    # shellcheck source=/dev/null
    source "$HOME/.fzf/shell/completion.zsh"
  fi
fi

