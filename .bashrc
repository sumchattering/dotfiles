# Source .bash_profile if in an interactive shell
[ -n "$PS1" ] && source ~/.bash_profile

# Load Cargo environment if available
if [ -d "$HOME/.cargo" ]; then
    . "$HOME/.cargo/env"
fi

# Add RVM to PATH for scripting, make sure this is the last PATH variable change
if [ -d "$HOME/.rvm/bin" ]; then
    export PATH="$PATH:$HOME/.rvm/bin"
fi

# Load NVM and its bash completion if available
if [ -d "$HOME/.nvm" ]; then
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"                   # This loads nvm
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion
fi
