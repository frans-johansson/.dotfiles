#
# A minimal and robust .bashrc
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

# Make sure any Cargo binaries are visible from this point
source "$HOME/.cargo/env"

# If we have access to bat, use it as the manpager
if command -v bat &> /dev/null; then
    export MANPAGER="sh -c 'col -bx | bat -l man -p'"  
fi

# Source environment variables
if [[ -f ~/.config/.bash_env ]]; then
    source ~/.config/.bash_env
fi

# Source aliases
if [[ -f ~/.config/.bash_aliases ]]; then
    source ~/.config/.bash_aliases
fi

# Set up fzf
if [[ -f /usr/share/doc/fzf/examples/key-bindings.bash ]]; then
    source /usr/share/doc/fzf/examples/key-bindings.bash
fi
 
# Set up additional third-party functionality
if command -v starship &> /dev/null; then
    eval "$(starship init bash)"
fi

if command -v zoxide &> /dev/null; then
    eval "$(zoxide init bash)"
fi

if command -v direnv &> /dev/null; then
    eval "$(direnv hook bash)"
fi
