# vim: fdm=marker

#          _
#  _______| |__  _ __ ___
# |_  / __| '_ \| '__/ __|
#  / /\__ \ | | | | | (__
# /___|___/_| |_|_|  \___|
#
# copyright: (c) 2015-2016 Gabriel Lima
# license: MIT
#

# CONTENTS:

# 1. Defaults ------------------------------------------------------------ {{{1

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh
export TERM='xterm-256color'
[ -n "$TMUX" ] && export TERM=screen-256color

export EDITOR="vim"
export USE_EDITOR=$EDITOR
export VISUAL=$EDITOR

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="steeef"

# Uncomment the following line to disable auto-setting terminal title.
export DISABLE_AUTO_TITLE="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

# User configuration
export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games"
source $ZSH/oh-my-zsh.sh


# 2. Options ------------------------------------------------------------- {{{1

# Better globbing
setopt extendedglob


# 3. Keybindings --------------------------------------------------------- {{{1

# Search shell history
bindkey '^U' history-incremental-search-backward

# Make ^Z bring last process to foreground
bindkey -s '^Z' 'fg\n'


# 4. Path ---------------------------------------------------------------- {{{1

# EMPTY


# 5. Exports ------------------------------------------------------------- {{{1

export MYVIMRC=~/.vimrc


# 6. Aliases ------------------------------------------------------------- {{{1

alias ack='ack-grep'

alias ev='vim ~/.vimrc'
alias ez='vim ~/.zshrc'
alias et='vim ~/.tmux.conf'

alias open='xdg-open'


# 7. Functions ----------------------------------------------------------- {{{1

# EMPTY


# 8. Misc ---------------------------------------------------------------- {{{1

# Make <c-s> available for vim
stty stop undef
