P10K_DIR="$HOME/.p10k.git"
if [[ ! -d "$P10K_DIR" ]]; then
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$P10K_DIR"
fi

# shellcheck source=/dev/null
source "$P10K_DIR/powerlevel10k.zsh-theme"
unset P10K_DIR

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
P10K_USR_CONF="$HOME/.dotfiles/zsh_setup/p10k.zsh"
[[ ! -f "$P10K_USR_CONF" ]] || source "$P10K_USR_CONF"
unset P10K_USR_CONF

alias ls='ls --color=auto'
setopt HIST_IGNORE_SPACE
