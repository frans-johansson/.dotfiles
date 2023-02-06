#
# Alias definitions for bash
#

# Use exa instead of ls
alias ls="exa"
alias ll="ls --oneline --long --group-directories-first"
alias la="ll --all"
alias l="ls --icons --classify"
alias tree="ls --icons --tree"

# My Neovim :)
# (Installed locally because Ubuntu's binary is ancient)
alias nvim="$BINARY_DIR/nvim"

# Coomfy git aliases
alias ga="git add"
alias gss="git status --short"
alias gcm="git commit --message"
alias grb="git rebase"
alias gcp="git cherry-pick"

