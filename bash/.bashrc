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

# If we have access to bat, use it as the manpager
if ! command -v bat &> /dev/null; then
    export MANPAGER="sh -c 'col -bx | bat -l man -p'"  
fi

# Source environment variables
if [[ -f ~/.bash_env ]]; then
    . ~/.bash_env
fi

# Source aliases
if [[ -f ~/.bash_aliases ]]; then
    . ~/.bash_aliases
fi

# Set up Nix
[ -e /home/frans/.nix-profile/etc/profile.d/nix.sh ] && source /home/frans/.nix-profile/etc/profile.d/nix.sh

# Set up additional third-party functionality
[ -f ~/.local/fzf/keys.bash ] && source ~/.local/fzf/keys.bash
eval "$(starship init bash)"
eval "$(zoxide init bash)"
eval "$(direnv hook bash)"
