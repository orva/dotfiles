ZSH=$HOME/.oh-my-zsh
ZSH_THEME="robbyrussell"

plugins=(git)
unsetopt correct

source /bin/virtualenvwrapper.sh
source ~/.nvm/nvm.sh
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

eval `dircolors ~/confs/dircolors.zenburn`

# for gnugpg
GPG_TTY=$(tty)
export GPG_TTY

export EDITOR=vim
export BROWSER=firefox
export CHROME_BIN=chromium

# golang settings:
export GOPATH=$HOME/src/go-workspace
export PATH=$GOPATH/bin

# Path stuff:
export PATH=$HOME/bin:$PATH

