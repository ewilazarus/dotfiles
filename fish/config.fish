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

alias ll="ls -alhF"
alias la="la -A"
alias l="ls -CF"

alias tmux="tmux -2"  # enables 256 color support for tmux

alias tmat="tmux -2 attach -t"
alias tmks="tmux -2 kill-server"
alias tml="tmuxp load"

alias ev="vim ~/.vimrc"
alias ez="vim ~/.zshrc"
alias et="vim ~/.tmux.conf"
alias ep="vim ~/.dotfiles/etc/packages.txt"

alias nopyc="rm *.pyc"

alias cb="xclip -selection c -i"  # thanks to firstdoit
