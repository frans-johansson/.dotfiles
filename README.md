# ⚙️📁
> I'm getting sick of re-installing and re-configuring everything everytime I (inevitably) brick my system...
> This is the solution!

Welcome to my personal dotfiles repository! It comes with a post-installation script tested on Ubuntu 18.04 LTS, which should also work on most modern Ubuntu flavors and derivatives.

## Quickstart
```sh
git clone https://github.com/frans-johansson/.dotfiles.git ~/.dotfiles
cd ~/.dotfiles
./setup_system.sh
```

Changes will not be noticeable until you start a new shell, e.g. by running `bash`.

## Requirements
- A [Nerd Font](https://www.nerdfonts.com/) of your choice

## Features
The setup script will set up some software I enjoy using in my Linux environments. The dotfiles subsequently setup convenient aliases for some of these (mainly replacing `ls` with `exa`).

### The "bare necessities"
Besides running `apt update` and `apt upgrade`, a number of *"bare necessities"* are installed, including `build-essential` and `stow` (utilized in the end of the script to symlink all the config files to the home directory). A few packages are installed from outside the Ubuntu repositories (mostly due to their iffy support in Ubuntu 18.04):
- The [Starship](https://starship.rs/) prompt (⚠️ This will require a compatible Nerd Font to display properly).
- The fuzzy-finder utility [fzf](https://github.com/junegunn/fzf).
- The latest stable version of [Neovim](https://neovim.io/).
- A number of Rust alternatives to core utils, including `exa`, `fd-find`, `du-dust` and `ripgrep`.

### Configuration files
Besides installing a number of packages, the script will also attempt to symlink the config files to the home directory via `stow`. If this fails due to some files already existing in the home repo, remove or back them up, then re-run `stow . --ignore *.sh` from the `.dotfiles` directory. The main highlights of the configuration brought by these dotfiles include:
- A Neovim configuration with LSP support **(Still WIP)**. Out of the box, [pylsp](https://github.com/python-lsp/python-lsp-server) and [sumneko\_lua](https://github.com/LuaLS/lua-language-server) will be installed on the system via the post-install script, more will likely be added over time.
- A `tmux` configuration **(Still WIP)** including some packages managed via [TPM](https://github.com/tmux-plugins/tpm). Note that you will likely have to run `<prefix> Shift-i` to install the plugins the first time you run `tmux`. The prefix key defaults to `Ctrl-a` in this config.

