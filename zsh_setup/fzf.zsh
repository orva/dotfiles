if hash fzf 2> /dev/null; then
  if [[ -d "/usr/share/fzf/shell" ]]; then
    source /usr/share/fzf/shell/key-bindings.zsh
  elif [[ -d "/usr/share/fzf" ]]; then
    source /usr/share/fzf/key-bindings.zsh
    source /usr/share/fzf/completion.zsh
  elif [[ -d "/opt/homebrew/opt/fzf" ]]; then
    source /opt/homebrew/opt/fzf/shell/key-bindings.zsh
    source /opt/homebrew/opt/fzf/shell/completion.zsh
  elif [[ -d "$HOME/.fzf" ]]; then
    # shellcheck source=/dev/null
    source "$HOME/.fzf/shell/key-bindings.zsh"
    # shellcheck source=/dev/null
    source "$HOME/.fzf/shell/completion.zsh"
  fi
fi

