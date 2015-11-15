#!/bin/bash

###############################################################################
#
# install.sh
# ~~~~~~~~~~
# 
# copyright: (c) 2015 by Gabriel Lima
# license: MIT
#
# Installation script for a linux development machine basic configuration.
# 
# source:	https://github.com/ewilazarus/dotfiles/install.sh
#
# prereq:	- admin rights
#			- git (version 1.9.1 or greater)
# 			- curl (version 7.35.0 or greater)
#
###############################################################################

################################# VARIABLES ###################################

DFDIR=$HOME/.dotfiles
OLDDFDIR=$HOME/.old_dotfiles

PACKAGES=$DFDIR/etc/packages.txt
TMPDIR=$DFDIR/tmp

GETPIP=get-pip.py
GETPIPURL=http://bootstrap.pypa.io/$GETPIP

###############################################################################

################################# FUNCTIONS ###################################

function homelink {
	ln -s $DFDIR/$1 $HOME/$2
}

###############################################################################

echo "bootstraping configurations"

# Clone the repository and backs up old dotfiles dir to "$HOME/.old_dotfiles"
if [ -d "$DFDIR" ]; then
	echo "creating a backup of old $DFDIR in $OLDDFDIR"
	mv $DFDIR $OLDDFDIR
fi

echo "cloning git@github.com:ewilazarus/dotfiles.git into $DFDIR"
git clone --recursive git@github.com:ewilazarus/dotfiles.git $DFDIR
cd $DFDIR


# Install packages defined in "$HOME/.dotfiles/etc/packages"
echo "updating package manager"
apt-get update > /dev/null

echo "upgrading package manager"
apt-get upgrade > /dev/null

while read package; do
	if [[ $package != \#* && ! -z $package ]] ; then
		echo "installing package: $package"
		apt-get install $package -y > /dev/null
	fi
done < $PACKAGES


echo "creating symbolic links in $HOME"
homelink conky/conkyrc .conkyrc
homelink conky/conkystart .conkystart
homelink git/gitconfig .gitconfig
homelink irssi/ .irssi
homelink tmux/tmux/ .tmux
homelink tmux/tmux.conf .tmux.conf
homelink vim/vim/ .vim
homelink vim/vimrc .vimrc
homelink zsh/oh-my-zsh/ .oh-my-zsh
homelink zsh/zshrc .zshrc


echo "installing powerline fonts"
git clone git@github.com:powerline/fonts.git $TMPDIR
cd $TMPDIR && ./install.sh > /dev/null
cd $DFDIR && rm -rf $TMPDIR


echo "installing vim plugins"
vim -c PluginInstall -c quitall


echo "installing tmux plugins"
# TODO


echo "installing pip"
curl -sO $GETPIPURL
python $GETPIP
rm $GETPIP


echo "installing virtualenv and virtualenvwrapper"
pip install virtualenvwrapper


echo "switching to zshell"
chsh -s /bin/zsh $(logname)


echo "grating permission to $DFDIR without admin rights"
chown -R $(logname) $DFDIR


echo "done"
echo "rebooting the machine in 10s ..."
sleep 10
shutdown -r 0
