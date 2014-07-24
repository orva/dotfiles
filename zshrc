export ZSH=$HOME/.oh-my-zsh
ZSH_THEME="robbyrussell"

plugins=(git mercurial)

# Much faster git in large repos
DISABLE_UNTRACKED_FILES_DIRTY="true"

source $ZSH/oh-my-zsh.sh

# Interpreter handling tools

if [ -e /bin/virtualenvwrapper.sh ]; then
	source /bin/virtualenvwrapper.sh
elif [ -e /etc/bash_completion.d/virtualenvwrapper ]; then
	# Ubuntu
	source /etc/bash_completion.d/virtualenvwrapper
fi

if [ -e ~/.nvm/nvm.sh ]; then
	source ~/.nvm/nvm.sh
fi

if [ -e ~/.rbenv ]; then
	export PATH="$HOME/.rbenv/bin:$PATH"
	eval "$(rbenv init -)"
fi

eval `dircolors ~/.dircolors.zenburn`

# for gnugpg
GPG_TTY=$(tty)
export GPG_TTY

export EDITOR=vim
export BROWSER=firefox
export CHROME_BIN=chromium

# golang settings:
export GOPATH=$HOME/src/go-workspace
export PATH=$PATH:$GOPATH/bin

# Path stuff:
export PATH=$HOME/.dotfiles-bin:$PATH
export PATH=$HOME/bin:$PATH

# '=' instead of '==' because of ancient Ubuntu..
if [ "$COLORTERM" = "gnome-terminal" ] || [ "$COLORTERM" = "xfce4-terminal" ]
then
	TERM=xterm-256color
elif [ "$COLORTERM" = "rxvt-xpm" ]
then
	TERM=rxvt-256color
fi
