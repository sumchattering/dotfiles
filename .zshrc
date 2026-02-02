# Enable Powerlevel10k instant prompt (should stay at the top of .zshrc)
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

[ -n "$PS1" ] && source ~/.bash_profile

if [ -d "$HOME/.cargo" ]; then
    . "$HOME/.cargo/env"
fi

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
if [ -d "$HOME/.rvm/bin" ]; then
    export PATH="$PATH:$HOME/.rvm/bin"
fi

if [ -d "$HOME/.nvm" ]; then
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"                   # This loads nvm
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion
fi

# Created by `pipx` on 2024-07-23 14:52:22
export PATH="$PATH:$HOME/.local/bin"

# opencode
export PATH=/Users/sumeru.chatterjee/.opencode/bin:$PATH

# Disable glob expansion errors - allow commands with ? and * to pass through
setopt nonomatch

# Python alias
alias python='python3'

# Powerlevel10k theme
source ~/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# iTerm2 shell integration (must be AFTER Powerlevel10k to preserve working directory reporting)
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# Added by Antigravity
export PATH="/Users/sumeru.chatterjee/.antigravity/antigravity/bin:$PATH"
