#!/bin/bash
#
# ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┑
# ┃ Setup script for Ubuntu environments. Tailored to work for Ubuntu 18.04 LTS. ┃
# ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛ 
#
#  Note: This script is part of my personal .dotfiles repository. The final step
#        utilizing stow to set up all the config files will only work if this is
#        cloned from my repository, or if you're running this script from your
#        own .dotfiles directory.
#

# Print each command being run. Exit on the first error.
set -ex

# If these variables are not set in the environment, we have defaults
[[ -z $SOURCE_DIR ]] && SOURCE_DIR="$HOME/Source" 
[[ -z $BINARY_DIR ]] && BINARY_DIR="$HOME/Binaries" 


## Ensure all the directories exist
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
mkdir -p $SOURCE_DIR
mkdir -p $BINARY_DIR


## Update apt and install some bare necessities
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
sudo apt update -y
sudo apt upgrade -y

sudo apt install build-essential -y           # Literally essential to install
sudo apt install python3-pip python3-dev -y   # Get Python up and running
sudo apt install python3.8  python3.8-dev -y  # Ensure a relatively recent version of Python is available too
sudo apt install tmuxinator -y                # Neat project handler for tmux
sudo apt install tig -y                       # A pretty cool and feature-rich text-interface for git
sudo apt install stow -y                      # Sets up symbolic links to all the configuration files


## Download and install non-repository software
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# A better prompt
[[ ! -f $BINARY_DIR/starship ]] \
    && curl -Ss https://starship.rs/install.sh | sh -s -- -y -b $BINARY_DIR
# A better editor
[[ ! -f $BINARY_DIR/nvim ]] \
    && curl -L https://github.com/neovim/neovim/releases/download/stable/nvim.appimage > $BINARY_DIR/nvim \
    && chmod +x $BINARY_DIR/nvim
# A better fuzzy finder
[[ ! -d $SOURCE_DIR/fzf ]] \
    && git clone https://github.com/junegunn/fzf.git $SOURCE_DIR/fzf \
    && yes | $SOURCE_DIR/fzf/install


## Set up TMP for tmux
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
[[ ! -d $HOME/.tmux ]] && git clone https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm


## Rust stuff
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
if ! command -v rustup &> /dev/null
then
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y 
fi

source "$HOME/.cargo/env"
cargo install exa fd-find du-dust bottom bat ripgrep zoxide  # Some nice alternatives to the core utils


## Python stuff
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
python3 -m pip install -U pip
python3 -m pip install pipenv     # Environment handling
python3 -m pip install ipython    # For a better REPL experience
python3 -m pip install ipykernel  # In case I ever want to work with notebooks

python3.8 -m pip install neovim   # Specically required to make Neovim stop complaining


## Set up LSPs
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# pylsp
python3 -m pip install python-lsp-server

# sumneko_lua
if [[ ! -f $BINARY_DIR/lua-language-server ]]
then
    mkdir -p $SOURCE_DIR/sumneko_lua
    curl -L https://github.com/LuaLS/lua-language-server/releases/download/3.6.9/lua-language-server-3.6.9-linux-x64.tar.gz \
        | tar -xz -C $SOURCE_DIR/sumneko_lua
    ln -s $SOURCE_DIR/sumneko_lua/bin/lua-language-server $BINARY_DIR/lua-language-server
fi

## Set up DAPs
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# debugpy
python3 -m pip install debugpy

## Use stow to finalize the system config
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
stow . --ignore .*\.sh

