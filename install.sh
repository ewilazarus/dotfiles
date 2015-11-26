#!/bin/bash
###############################################################################
#  _           _        _ _       _
# (_)_ __  ___| |_ __ _| | |  ___| |__
# | | '_ \/ __| __/ _` | | | / __| '_ \
# | | | | \__ \ || (_| | | |_\__ \ | | |
# |_|_| |_|___/\__\__,_|_|_(_)___/_| |_|
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
PWRLINE=git@github.com:powerline/fonts.git
GETPIP=http://bootstrap.pypa.io/get-pip.py

LOCAL=$HOME/.dotfiles
BACKUP=$HOME/.dotfiles_bak
TMPDIR=$LOCAL/tmp

PACKAGESAPT=$LOCAL/etc/packages.txt
PACKAGESPIP2=$LOCAL/etc/requirements2.txt
PACKAGESPIP3=$LOCAL/etc/requirements3.txt

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
done < $PACKAGESAPT


echo "installing: pip"
curl -s $GETPIP | python /dev/stdin
#curl -s $GETPIP | python3 /dev/stdin

# Install pip packages defined in "$HOME/.dotfiles/etc/requirements*.txt"
pip install -r $PACKAGESPIP2 > /dev/null
#pip3.4 install -r $PACKAGESPIP3 > /dev/null


echo "installing: powerline-fonts"
git clone $PWRLINE $TMPDIR
cd $TMPDIR && ./install.sh > /dev/null
cd $LOCAL && rm -rf $TMPDIR




echo "creating symbolic links in $HOME"
homelink conky/conkyrc .conkyrc
homelink conky/conkystart .conkystart
homelink git/gitconfig .gitconfig
homelink irssi .irssi
homelink scripts Scripts
homelink tmux/tmux .tmux
homelink tmux/tmux.conf .tmux.conf
homelink vim/vim .vim
homelink vim/vimrc .vimrc
homelink zsh/oh-my-zsh .oh-my-zsh
homelink zsh/zshrc .zshrc


echo "installing vim plugins"
vim -c PluginInstall -c quitall


echo "installing tmux plugins"
# TODO


echo "installing virtualenv and virtualenvwrapper"
pip install virtualenvwrapper


echo "switching to zshell"
chsh -s /bin/zsh $(logname)


echo "grating permission to $LOCAL without admin rights"
chown -R $(logname) $LOCAL

echo "Remapping Caps Lock to Ctrl"
mv /etc/default/keyboard /etc/default/keyboard_bak
cp $LOCAL/etc/keyboard /etc/default/

echo "done"
echo "rebooting the machine in 10s ..."
sleep 10
shutdown -r 0
