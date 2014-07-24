#!/bin/bash

set -o nounset
set -o errexit
set -o pipefail

conf_dir=$PWD


if [ ! -e "$HOME/.dotfiles-bin" ]; then
	echo -e "linking dotfiles-bin"
	ln -s $conf_dir/bin $HOME/.dotfiles-bin
else
	echo "skip dotfiles-bin, already present"
fi

echo -e "\n-- configs ---\n"

configs=( "dircolors.zenburn" "emacs.d" "tmux.conf" "vimperatorrc" "vimrc" "Xresources" "zshrc" )

for conf in "${configs[@]}"
do
	if [ ! -e "$HOME/.$conf" ]; then
		echo "linking $conf"
		ln -s $conf_dir/$conf $HOME/.$conf
	else
		echo "skip $conf, already present"
	fi
done

echo -e "\n-- interpreter tools ---\n"

if [ ! -e $HOME/.rbenv ]; then
	echo -e "installing rbenv\n"
	git clone https://github.com/sstephenson/rbenv.git ~/.rbenv
	git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
	echo
else
	echo "skip rbenv, already present"
fi

if [ ! -e $HOME/.nvm ]; then
	echo -e "installing nvm\n"
	git clone https://github.com/creationix/nvm.git ~/.nvm
	echo
else
	echo "skip nvm, already present"
fi

