#!/bin/bash

if [ ! -d ${HOME}/.tmux ]; then
	echo -e "\e[35mDownloading tmux configuration for the first time...\e[0m"
	git clone https://github.com/codisms/tmux-config.git ${HOME}/.tmux
fi

${HOME}/.tmux/config-tmux.sh $@

