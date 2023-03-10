# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Settings
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=1000
setopt extendedglob
unsetopt beep
bindkey -v

# Use nix
[[ -e /home/frans/.nix-profile/etc/profile.d/nix.sh ]] && source /home/frans/.nix-profile/etc/profile.d/nix.sh

# Source environment stuff
source $HOME/.config/aliases.zsh
source $HOME/.config/env.zsh
source $HOME/.config/plugins.zsh

# Source third party stuff
source $(fzf-share)/key-bindings.zsh
source $(fzf-share)/completion.zsh
eval "$(direnv hook zsh)"
eval "$(zoxide init zsh)"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
