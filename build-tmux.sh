#!/bin/bash

cd `dirname $0`
SCRIPTPATH=`pwd`
source "${SCRIPTPATH}/functions"

VERSION=$(option_value version)
debug "VERSION = ${VERSION}"
PACKAGE_MANAGER=$(get_package_manager)
debug "PACKAGE_MANAGER = ${PACKAGE_MANAGER}"

if [ "${VERSION}" == "" ]; then
	echo "Querying latest version of tmux..."
	VERSION=$(curl -H 'Accept: application/vnd.github.v3+json' https://api.github.com/repos/tmux/tmux/releases/latest -s | json "tag_name")
fi

echo -e "\e[36mBuilding tmux ${VERSION}...\e[0m"


cd /tmp
if [ -d tmux ]; then
	rm -rf tmux
fi

echo -e "\e[35mCloning tmux ${VERSION}...\e[0m"
if [ "${VERSION}" == "" ]; then
	git clone --depth=1 https://github.com/tmux/tmux.git
else
	git clone --depth=1 -b ${VERSION} https://github.com/tmux/tmux.git
fi

echo -e "\e[35mCompiling tmux...\e[0m"
cd tmux
sh autogen.sh --quiet > /dev/null
#./configure --prefix=/usr/local #--quiet > /dev/null
./configure --quiet > /dev/null
make --quiet > /dev/null

echo -e "\e[35mRemoving existing version of vi/vim...\e[0m"
if [ $PACKAGE_MANAGER == "apt" ]; then
	$SUDO apt-get remove -y tmux
fi
if [ $PACKAGE_MANAGER == "yum" ]; then
	$SUDO yum -y remove tmux
fi

echo -e "\e[35mInstalling tmux...\e[0m"
SUDO=$(which sudo 2> /dev/null)
$SUDO make install --quiet > /dev/null
cd ..
rm -rf tmux

echo -e "\e[35mDone installing tmux\e[0m"
