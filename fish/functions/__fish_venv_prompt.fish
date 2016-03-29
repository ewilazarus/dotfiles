function __fish_venv_prompt
	if set -q VIRTUAL_ENV
	    echo -n -s "[" (basename "$VIRTUAL_ENV") "] "
	end
end
