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

REMOTE=git@github.com:ewilazarus/dotfiles.git
LOCAL=$HOME/.dotfiles
BACKUP=$HOME/.dotfiles_bak
PACKAGES=$LOCAL/etc/packages.txt
TMPDIR=$LOCAL/tmp
PWRLINE=git@github.com:powerline/fonts.git
GETPIP=http://bootstrap.pypa.io/get-pip.py

###############################################################################

################################# FUNCTIONS ###################################

function homelink {
	ln -s $LOCAL/$1 $HOME/$2
}

###############################################################################

echo "bootstraping configurations"

# Clone the repository and backs up old dotfiles dir to "$HOME/.old_dotfiles"
if [ -d "$LOCAL" ]; then
	echo "creating a backup of old $LOCAL in $BACKUP"
	mv $LOCAL $BACKUP
fi

echo "cloning $REMOTE into $LOCAL"
git clone $REMOTE $LOCAL --recursive
cd $LOCAL


# Install packages defined in "$HOME/.dotfiles/etc/packages.txt"
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
git clone $PWRLINE $TMPDIR
cd $TMPDIR && ./install.sh > /dev/null
cd $LOCAL && rm -rf $TMPDIR


echo "installing vim plugins"
vim -c PluginInstall -c quitall


echo "installing tmux plugins"
# TODO


echo "installing pip"
curl -s $GETPIP | python /dev/stdin


echo "installing virtualenv and virtualenvwrapper"
pip install virtualenvwrapper


echo "switching to zshell"
chsh -s /bin/zsh $(logname)


echo "grating permission to $LOCAL without admin rights"
chown -R $(logname) $LOCAL


echo "done"
echo "rebooting the machine in 10s ..."
sleep 10
shutdown -r 0
