# Exports

if test $TMUX
	set -x TERM screen-256color
else
	set -x TERM xterm-256color
end

set -x EDITOR vim


# Virtaulfish

eval (python -m virtualfish)


# Aliases

alias ll='ls -alhF --group-directories-first'
alias la='la -A --group-directories-first'
alias l='ls -CF --group-directories-first'

alias tfak='ssh limag@login.informatik.uni-freiburg.de'
alias tmux='tmux -2'  # enables 256 color support for tmux
alias ack='ack-grep'

alias tmat='tmux -2 attach -t'
alias tmks='tmux -2 kill-server'
alias tml='tmuxp load'

alias ev='vim ~/.vimrc'
alias ez='vim ~/.zshrc'
alias et='vim ~/.tmux.conf'
alias ep='vim ~/.dotfiles/etc/packages.txt'

alias nopyc='rm *.pyc'

alias cb='xclip -selection c -i'  # thanks to firstdoit
