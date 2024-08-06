[ -n "$PS1" ] && source ~/.bash_profile

# tabtab source for serverless package
# uninstall by removing these lines or running `tabtab uninstall serverless`
[ -f /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.bash ] && . /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.bash
# tabtab source for sls package
# uninstall by removing these lines or running `tabtab uninstall sls`
[ -f /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.bash ] && . /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.bash
# tabtab source for slss package
# uninstall by removing these lines or running `tabtab uninstall slss`
[ -f /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/slss.bash ] && . /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/slss.bash

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
export PATH="$PATH:/Users/sumeruchatterjee/.local/bin"
source /Users/sumeruchatterjee/Projects/tradofire-backend/scripts/shell/commands.sh

export PATH="$HOME/.pyenv/bin:$PATH"
eval "$(pyenv init --path)"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
pyenv_global_with_symlink() {
    pyenv global "$@"
    ln -sf $(pyenv which python3) $(pyenv root)/shims/python
}
alias pyenv-set-global='pyenv_global_with_symlink'

