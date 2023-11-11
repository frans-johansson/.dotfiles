# ⚙️📁
> I'm getting sick of re-installing and re-configuring everything everytime I (inevitably) brick my system...
> This is the solution!

Welcome to my personal dotfiles repository! It comes with a post-installation script tested on Ubuntu 22.04 LTS, which should also work on most modern Ubuntu flavors and derivatives.

## Quickstart
```sh
git clone https://github.com/frans-johansson/.dotfiles.git ~/.dotfiles
cd ~/.dotfiles
git submodule update --init --recursive
./install
```

Changes will not be noticeable until you start a new shell, e.g. by running `bash`.

In case of errors to the tune of *"stowing ... would cause conflicts"*, you probably need to move your existing config files out of your home directory. This is likely to happen even on a freshly set up system since a default .bashrc is likely to exist in your home directory.

## Requirements
- A [Nerd Font](https://www.nerdfonts.com/) of your choice

## Features
The setup script will set up some software I enjoy using in my Linux environments. The dotfiles subsequently setup convenient aliases for some of these (mainly replacing `ls` with `exa`).

### The "bare necessities"
Besides running `apt update` and `apt upgrade`, a number of *"bare necessities"* are installed, including `build-essential` and `stow` (utilized in the end of the script to symlink all the config files to the home directory).

- A custom bash PS1 with woodland critters 🦝 (This will require a compatible Nerd Font to display properly).
- The fuzzy-finder utility [fzf](https://github.com/junegunn/fzf).
- The latest stable version of [Neovim](https://neovim.io/).
- A number of Rust alternatives to core utils, including `exa`, `fd-find`, `du-dust` and `ripgrep`.

### Configuration files
Besides installing a number of packages, the script will also attempt to symlink the config files to the home directory via `stow`. Each part can be individually stowed and unstowed as separate modules.

- My `nvim` configuration, available in a [stand-alone repository](https://github.com/frans-johansson/.dotfiles-nvim).
- My `tmux` configuration, available in a [stand-alone repository](https://github.com/frans-johansson/.dotfiles-tmux).
- My personal `git` configuration (probably not very interesting to anyone else)
- My `bash` configuration
