#
# Environment variables for bash
#

# These are used by the setup_system.sh script
export SOFTWARE_DIR="$HOME/Software"
export BINARY_DIR="$HOME/Binaries"

# Append to the PATH variable
PATH="$PATH:$HOME/.local/bin"
PATH="$PATH:$BINARY_DIR"
export PATH

# My weapon of choice
[[ -f $BINARY_DIR/nvim ]] && EDITOR=$BINARY_DIR/nvim || EDITOR=/usr/bin/vim
export EDITOR

