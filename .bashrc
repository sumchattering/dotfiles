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

# Unlock login keychain on SSH login (runs unconditionally — if already unlocked, it's a no-op)
if [[ -n "$SSH_CONNECTION" ]]; then
    security unlock-keychain ~/Library/Keychains/login.keychain-db 2>/dev/null || true
fi



# >>> claude-config >>>
# Managed by claude-config bootstrap - do not edit manually
[ -f ~/.claude-shell-config.sh ] && source ~/.claude-shell-config.sh
# <<< claude-config <<<
