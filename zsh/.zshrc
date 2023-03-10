# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=1000
setopt extendedglob
unsetopt beep
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/frans/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

if [ -e /home/frans/.nix-profile/etc/profile.d/nix.sh ]; then . /home/frans/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer

source $HOME/.config/aliases.zsh
source $HOME/.config/env.zsh
source $HOME/.config/plugins.zsh

source $(fzf-share)/key-bindings.zsh
source $(fzf-share)/completion.zsh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
