#
# A minimal .bashrc
#

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

HISTCONTROL=ignoreboth   # Handle duplicate entries
HISTSIZE= HISTFILESIZE=  # Very very big history files
shopt -s histappend      # Only append, never overwrite, the history file
			 # (this preserves the history across terminals)

# Check for window size updates
shopt -s checkwinsize

[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# Source environment variables
if [ -f ~/.bash_env ]; then
    . ~/.bash_env
fi

# Source aliases
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# Set up additional third-party functionality
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
source "$HOME/.cargo/env"
eval "$(starship init bash)"
eval "$(zoxide init bash)"
