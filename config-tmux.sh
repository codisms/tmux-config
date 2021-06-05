#!/bin/bash

cd `dirname $0`
source ./functions

BUILD=$(option_set build)
debug BUILD = ${BUILD}

if [ ${BUILD} -eq 1 ]; then
	${HOME}/.tmux/build-tmux.sh $@
fi

echo -e "\e[35mInstalling tmux tools...\e[0m"
#gem --update system

#echo -e "\e[35mInstalling tmuxinator\e[0m"
# gem install tmuxinator > /dev/null

#echo -e "\e[35mConfiguring tmux...\e[0m"
cd ${HOME}

echo -e "\e[35mDownloading tmux configuration to $(pwd)...\e[0m"
if [ ! -d ${HOME}/.tmux ]; then
	git clone https://github.com/codisms/tmux-config.git ${HOME}/.tmux
	cd ${HOME}/.tmux
else
	cd ${HOME}/.tmux
	git pull
fi

if [ ! -f ${HOME}/.tmux.conf ]; then
	#echo -e "\e[35mLinking tmux.conf...\e[0m"
	ln -s ${HOME}/.tmux/tmux.conf ${HOME}/.tmux.conf
fi

echo -e "\e[35mDownloading submodules...\e[0m"
git submodule update --init --recursive --remote
git submodule update --recursive --remote --merge
cd ..

echo -e "\e[35mDone configuring tmux\e[0m"
