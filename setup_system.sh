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

## Utilities
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

# Color codes
INFO="\033[1;36m"
ERROR="\033[0;31m"
WARNING="\033[1;33m"
SUCCESS="\033[1;32m"
NC="\033[0m"

# Utility function to handle each step of the set up
# Takes a function evaluating the step as its first input and
# a boolean value indicating whether to run the step as its second argument
function handle_step()
{
    if [[ -z $2 ]]
    then
        $1
    else
        printf "${WARNING}SKIPPING!${NC}\n\n"
        return
    fi

    # Print results
    if [[ $? -eq 0 ]]
    then
        printf "${SUCCESS}SUCCESS!${NC}\n\n"
    else
        printf "${ERROR}FAILED!${NC}\n\n"
    fi
}

# Runs a command with its arguments in silence
function silently()
{
    $@ &> /dev/null
}


# Informs the user a step has already been peformed
function skipping()
{
    printf " - ${INFO}$1${NC} already installed\n"
}

# Informs the user about how the script works
function print_usage()
{
    printf "Setup script tailored for Ubuntu 18.04\n\n"
    printf "Usage:\n"
    printf "  ./setup_system.sh [options]\n\n"
    printf "OPTIONS\n"
    printf "  -h, --help        Show this help message\n"
    printf "  --no-external     Skip installing external (non-repository) packages\n"
    printf "  --no-rust         Skip installing Rust and related utilites\n"
    printf "  --no-python       Skip installing Python 3.6\n"
    printf "  --no-lsp          Skip installing language servers\n"
    printf "  --no-dap          Skip installing debug adapters\n"
    printf "  --no-stow         Skip stowing the config files into HOME\n"
}


## Handle arguments
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
while [[ $# -gt 0 ]]; do
  case $1 in
    --help|-h)
      print_usage
      exit 0
      ;;
    --no-external)
      SKIP_EXTERNAL=1
      shift
      ;;
    --no-rust)
      SKIP_RUST=1
      shift
      ;;
    --no-python)
      SKIP_PYTHON=1
      shift
      ;;
    --no-lsp)
      SKIP_LSP=1
      shift
      ;;
    --no-dap)
      SKIP_DAP=1
      shift
      ;;
    --no-stow)
      SKIP_STOW=1
      shift
      ;;
    -*|--*)
      print_usage
      printf "\n${ERROR}Unknown option $1${NC}\n"
      exit 1
      ;;
    *)
      print_usage
      printf "\n${ERROR}Unexpected positional argument $1${NC}\n"
      exit 1
      ;;
  esac
done


## Set up the environment and home directory
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

# If these variables are not set in the environment, we have defaults
[[ -z $SOURCE_DIR ]] && SOURCE_DIR="$HOME/Source" 
[[ -z $BINARY_DIR ]] && BINARY_DIR="$HOME/Binaries" 

mkdir -p $SOURCE_DIR
mkdir -p $BINARY_DIR


## Update apt and install some bare necessities
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
function update_and_upgrade()
{
    silently sudo apt update -y
    silently sudo apt upgrade -y
}
printf "Updating and upgrading Ubuntu repository packages...\n"
handle_step update_and_upgrade 


function install_apt_packages()
{
    silently sudo apt install build-essential -y           # Literally essential to install
    silently sudo apt install python3-pip python3-dev -y   # Get Python up and running
    silently sudo apt install python3.8  python3.8-dev -y  # Ensure a relatively recent version of Python is available too
    silently sudo apt install tmuxinator -y                # Neat project handler for tmux
    silently sudo apt install tig -y                       # A pretty cool and feature-rich text-interface for git
    silently sudo apt install stow -y                      # Sets up symbolic links to all the configuration files
}
printf "Installing packages from the Ubuntu repositories...\n"
handle_step install_apt_packages


## Download and install non-repository software
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
function non_apt_packages()
{
    # A better prompt
    if [[ ! -f $BINARY_DIR/starship ]]
    then
        curl -Ss https://starship.rs/install.sh | sh -s -- -y -b $BINARY_DIR
    else
        skipping starship
    fi

    # A better editor
    if [[ ! -f $BINARY_DIR/nvim ]]
    then
        curl -Ls https://github.com/neovim/neovim/releases/download/stable/nvim.appimage > $BINARY_DIR/nvim
        chmod +x $BINARY_DIR/nvim
    else
        skipping nvim
    fi

    # A better fuzzy finder
    if [[ ! -d $SOURCE_DIR/fzf ]]
    then
        silently git clone https://github.com/junegunn/fzf.git $SOURCE_DIR/fzf
        yes | $SOURCE_DIR/fzf/install
    else
        skipping fzf
    fi
}
printf "Installing additional external packages...\n"
handle_step non_apt_packages $SKIP_EXTERNAL


## Set up TMP for tmux
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
function setup_tpm()
{
    if [[ ! -d $HOME/.tmux ]]
    then
        silently git clone https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm
    else
        skipping TPM
    fi
}
printf "Setting up TPM for tmux...\n"
handle_step setup_tpm $SKIP_EXTERNAL


## Rust stuff
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
function rust_stuff()
{
    if ! command -v rustup &> /dev/null
    then
        curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | silently sh -s -- -y 
    else
        skipping rustup
    fi

    source "$HOME/.cargo/env"
    silently cargo install exa fd-find du-dust bottom bat ripgrep zoxide  # Some nice alternatives to the core utils
}
printf "Setting up Rust and installing some utilities with cargo...\n"
handle_step rust_stuff $SKIP_RUST


## Python stuff
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
function python_stuff()
{
    silently python3 -m pip install -U pip
    silently python3 -m pip install pipenv     # Environment handling
    silently python3 -m pip install ipython    # For a better REPL experience
    silently python3 -m pip install ipykernel  # In case I ever want to work with notebooks

    silently python3.8 -m pip install neovim   # Specically required to make Neovim stop complaining
}
printf "Setting up Python 3...\n"
handle_step python_stuff $SKIP_PYTHON


## Set up LSPs
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
function setup_lsp()
{
    # pylsp
    if ! command -v pylsp &> /dev/null
    then
        silently python3 -m pip install python-lsp-server
    else
        skipping pylsp
    fi

    # sumneko_lua
    if [[ ! -f $BINARY_DIR/lua-language-server ]]
    then
        mkdir -p $SOURCE_DIR/sumneko_lua
        # Cannot run this through silently since that suppresses all stdout activity
        curl -Ls https://github.com/LuaLS/lua-language-server/releases/download/3.6.9/lua-language-server-3.6.9-linux-x64.tar.gz \
            | tar -xz -C $SOURCE_DIR/sumneko_lua
        ln -s $SOURCE_DIR/sumneko_lua/bin/lua-language-server $BINARY_DIR/lua-language-server
    else
        skipping lua-language-server
    fi

    # clangd-15
    if [[ ! -f $BINARY_DIR/clangd ]]
    then
        # Cannot run this through silently since that suppresses all stdout activity
        curl -Ls https://github.com/clangd/clangd/releases/download/15.0.0/clangd-linux-15.0.0.zip > $SOURCE_DIR/clangd.zip
        silently unzip $SOURCE_DIR/clangd.zip -d $SOURCE_DIR
        ln -s $(find $SOURCE_DIR -type f -name clangd) $BINARY_DIR/clangd
        rm $SOURCE_DIR/clangd.zip
    else
        skipping clangd
    fi

    # rust-analyzer
    if [[ ! -f $BINARY_DIR/rust-analyzer ]]
    then
        # Cannot run this through silently since that suppresses all stdout activity
        curl -Ls https://github.com/rust-lang/rust-analyzer/releases/download/2023-02-13/rust-analyzer-x86_64-unknown-linux-gnu.gz \
            | gunzip > $BINARY_DIR/rust-analyzer
        chmod +x $BINARY_DIR/rust-analyzer
    else
        skipping rust-analyzer
    fi

    # bashls
    if ! command -v bash-language-server &> /dev/null
    then
        curl -fsSL https://deb.nodesource.com/setup_14.x | silently sudo -E bash - &&\
        if [[ $? -eq 0 ]]
        then
            silently sudo apt install nodejs -y
            silently sudo npm i -g bash-language-server
            silently sudo apt install shellcheck
        else
            printf "${WARNING}WARNING: Unable to install NodeJS v.14 which is required by bash-language-server!${NC}\n"
        fi
    else
        skipping bash-language-server
    fi
}
printf "Installing language servers...\n"
handle_step setup_lsp $SKIP_LSP


## Set up DAPs
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
function setup_dap()
{
    # debugpy
    if python3 -m pip freeze | grep -q debugpy
    then
        skipping debugpy
    else
        silently python3 -m pip install debugpy
    fi
}
printf "Installing debug adapters...\n"
handle_step setup_dap $SKIP_DAP


## Use stow to finalize the system config
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
function stow_dotfiles()
{
    silently stow . --ignore .*\.sh
}
printf "Stowing dotfiles...\n"
handle_step stow_dotfiles $SKIP_STOW

