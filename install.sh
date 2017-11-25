#!/bin/bash

set -o nounset
set -o errexit
set -o pipefail

conf_dir=$PWD
bin_dir=$HOME/.dotfiles-bin
configs=( "dircolors.zenburn" "emacs.d" "tmux.conf" "vimperatorrc" "vimrc" "Xresources" "zshrc" "psqlrc" "i3" "i3status.conf")

echo -e "\n-- configs ---\n"

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

echo -e "\n--- misc ---\n"

if [ ! -e "$HOME/.dotfiles-bin" ]; then
	echo -e "linking dotfiles-bin"
	ln -s $conf_dir/bin $bin_dir
else
	echo "skip dotfiles-bin linking, already present"
fi

if [ ! -e $bin_dir/qf ]; then
	echo -e "\ninstalling quickfind\n"

	tmp=$(mktemp -d)
	trap "rm -rf $tmp; exit" SIGHUP SIGINT SIGTERM

	git clone https://github.com/akojo/quickfind.git $tmp
	cd $tmp
	make
	cp --verbose qfind qselect $bin_dir
	cd $conf_dir
	rm --recursive --force $tmp
	echo
else
	echo "skip quickfind install, already present"
fi

if [ ! -e "$HOME/.oh-my-zsh" ]; then
	echo -e "installing oh-my-zsh"
	git clone https://github.com/robbyrussell/oh-my-zsh.git $HOME/.oh-my-zsh
	echo
else
	echo "skip oh-my-zsh install, already present"
fi
