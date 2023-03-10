# ⚙️📁
> I'm getting sick of re-installing and re-configuring everything everytime I (inevitably) brick my system...
> This is the solution!

Welcome to my personal dotfiles repository! It comes with a post-installation script tested on Ubuntu 22.04 LTS, which should also work on most modern Ubuntu flavors and derivatives since it uses [Nix](https://nixos.org/).

## Quickstart
```sh
git clone https://github.com/frans-johansson/.dotfiles.git ~/.dotfiles
cd ~/.dotfiles
./install
```

This will ensure everything is installed appropriately. Then, to synchronize all the configuration files, run:

```sh
stow shell git nvim tmux
```

Changes will not be noticeable until you start a new shell, e.g. by running `bash`.

In case of errors to the tune of *"stowing ... would cause conflicts"*, you probably need to move your existing config files out of your home directory, or outright delete them (not recommended).

## Requirements
- A [Nerd Font](https://www.nerdfonts.com/) of your choice

