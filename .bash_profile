
# Check if brew is in path
if ! command -v brew &> /dev/null; then
	# Add Homebrew to the path
	export PATH="/usr/local/bin:/usr/local/sbin:/opt/homebrew/bin:$PATH";
fi;

export PATH="$(brew --prefix llvm@15)/bin":$PATH
export LDFLAGS="$LDFLAGS -L$(brew --prefix llvm@15)/lib"
export CPPFLAGS="$CPPFLAGS -I$(brew --prefix llvm@15)/include"

# Add `~/bin` to the `$PATH`
export PATH="$HOME/bin:$PATH";

export NVM_DIR=~/.nvm
source $(brew --prefix nvm)/nvm.sh

export PATH=~/miniconda/bin:$PATH

# Add ruby to the path
export PATH="/usr/local/opt/ruby/bin:$PATH"
# Load the shell dotfiles, and then some:

# * ~/.path can be used to extend `$PATH`.
# * ~/.extra can be used for other settings you don’t want to commit.

for file in ~/.{path,bash_prompt,exports,aliases,functions,extra}; do
	[ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
unset file;

# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob;

# Append to the Bash history file, rather than overwriting it
shopt -s histappend;

# Autocorrect typos in path names when using `cd`
shopt -s cdspell;

# Enable some Bash 4 features when possible:
# * `autocd`, e.g. `**/qux` will enter `./foo/bar/baz/qux`
# * Recursive globbing, e.g. `echo **/*.txt`
for option in autocd globstar; do
	shopt -s "$option" 2> /dev/null;
done;

# Add tab completion for SSH hostnames based on ~/.ssh/config, ignoring wildcards
[ -e "$HOME/.ssh/config" ] && complete -o "default" -o "nospace" -W "$(grep "^Host" ~/.ssh/config | grep -v "[?*]" | cut -d " " -f2- | tr ' ' '\n')" scp sftp ssh;

# Add tab completion for `defaults read|write NSGlobalDomain`
# You could just use `-g` instead, but I like being explicit
complete -W "NSGlobalDomain" defaults;

# Add `killall` tab completion for common apps
complete -o "nospace" -W "Contacts Calendar Dock Finder Mail Safari iTunes SystemUIServer Terminal Twitter" killall;

# Append the dynamic paths
export PATH=$(cat $HOME/.dynamicpaths)$PATH

# Add tab completion for many Bash commands
if [ -f $(brew --prefix)/etc/bash_completion ]; then
    . $(brew --prefix)/etc/bash_completion
elif [ -f /etc/bash_completion ]; then
	source /etc/bash_completion;
else	
	echo "Bash completions not installed"
fi;

# Load the git completion script
if [ -f ~/.git-completion.bash ]; then
	source ~/.git-completion.bash;
else
	echo "Git completions not installed"
fi;

# Enable tab completion for `g` by marking it as an alias for `git`
if type _git &> /dev/null; then
	complete -o default -o nospace -F _git g;
fi;

eval "$(/opt/homebrew/bin/brew shellenv)"

export PATH="/Users/sumeruchatterjee/.ebcli-virtual-env/executables:$PATH"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/sumeruchatterjee/google-cloud-sdk/path.bash.inc' ]; then . '/Users/sumeruchatterjee/google-cloud-sdk/path.bash.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/sumeruchatterjee/google-cloud-sdk/completion.bash.inc' ]; then . '/Users/sumeruchatterjee/google-cloud-sdk/completion.bash.inc'; fi

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

#pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

export PATH="/Users/sumeruchatterjee/.local/share/solana/install/active_release/bin:$PATH"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/sumeruchatterjee/miniconda/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/sumeruchatterjee/miniconda/etc/profile.d/conda.sh" ]; then
        . "/Users/sumeruchatterjee/miniconda/etc/profile.d/conda.sh"
    else
        export PATH="/Users/sumeruchatterjee/miniconda/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<


