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

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
