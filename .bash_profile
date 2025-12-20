if [ "$(uname)" = "Darwin" ]; then

	# Check if brew is in path
	if ! command -v brew &>/dev/null; then
		# Add Homebrew to the path
		export PATH="/usr/local/bin:/usr/local/sbin:/opt/homebrew/bin:$PATH"
	fi

	# Add `~/bin` to the `$PATH`
	export PATH="$HOME/bin:$PATH"

	# Load NVM if installed
	if command -v brew &>/dev/null && [ -f "$(brew --prefix nvm)/nvm.sh" ]; then
		export NVM_DIR=~/.nvm
		source $(brew --prefix nvm)/nvm.sh
	fi

	export PATH=~/miniconda/bin:$PATH
	# export PATH="/usr/local/anaconda3/bin:$PATH"  # commented out by conda initialize

	# Add ruby to the path
	export PATH="/usr/local/opt/ruby/bin:$PATH"
	# Load the shell dotfiles, and then some:

	# * ~/.path can be used to extend `$PATH`.
	# * ~/.extra can be used for other settings you don’t want to commit.

	for file in ~/.{path,bash_prompt,exports,aliases,functions,extra,ai_functions}; do
		[ -r "$file" ] && [ -f "$file" ] && source "$file"
	done
	unset file

	# Shell-specific options
	if [ -n "$BASH_VERSION" ]; then
		# Bash-specific settings
		# Case-insensitive globbing (used in pathname expansion)
		shopt -s nocaseglob

		# Append to the Bash history file, rather than overwriting it
		shopt -s histappend

		# Autocorrect typos in path names when using `cd`
		shopt -s cdspell

		# Enable some Bash 4 features when possible:
		# * `autocd`, e.g. `**/qux` will enter `./foo/bar/baz/qux`
		# * Recursive globbing, e.g. `echo **/*.txt`
		for option in autocd globstar; do
			shopt -s "$option" 2>/dev/null
		done

		# Add tab completion for SSH hostnames based on ~/.ssh/config, ignoring wildcards
		[ -e "$HOME/.ssh/config" ] && complete -o "default" -o "nospace" -W "$(grep "^Host" ~/.ssh/config | grep -v "[?*]" | cut -d " " -f2- | tr ' ' '\n')" scp sftp ssh

		# Add tab completion for `defaults read|write NSGlobalDomain`
		# You could just use `-g` instead, but I like being explicit
		complete -W "NSGlobalDomain" defaults

		# Add `killall` tab completion for common apps
		complete -o "nospace" -W "Contacts Calendar Dock Finder Mail Safari iTunes SystemUIServer Terminal Twitter" killall

		# Add tab completion for many Bash commands
		if [[ -r "$(brew --prefix)/etc/profile.d/bash_completion.sh" ]]; then
			. "$(brew --prefix)/etc/profile.d/bash_completion.sh"
			echo "Bash completions installed"
		elif [ -f $(brew --prefix)/etc/bash_completion ]; then
			. $(brew --prefix)/etc/bash_completion
			echo "Bash completions installed"
		elif [ -f /etc/bash_completion ]; then
			source /etc/bash_completion
			echo "Bash completions installed"
		else
			echo "Bash completions not installed"
		fi

		# Load the git completion script
		if [ -f ~/.git-completion.sh ]; then
			source ~/.git-completion.sh
			#echo "Git completions installed"
		else
			echo "Git completions not installed"
		fi

		# Enable tab completion for `g` by marking it as an alias for `git`
		if type _git &>/dev/null; then
			complete -o default -o nospace -F _git g
		fi
	elif [ -n "$ZSH_VERSION" ]; then
		# Zsh-specific settings
		# Case-insensitive globbing
		setopt NO_CASE_GLOB

		# Append to the history file
		setopt APPEND_HISTORY
		setopt SHARE_HISTORY

		# Autocorrect typos in path names when using `cd`
		setopt CORRECT
		setopt CORRECT_ALL

		# Enable extended globbing (** for recursive)
		setopt EXTENDED_GLOB

		# Auto cd into directories
		setopt AUTO_CD

		# Enable completion system
		autoload -Uz compinit
		compinit

		# History substring search - up/down arrows search by prefix
		autoload -U history-search-end
		zle -N history-beginning-search-backward-end history-search-end
		zle -N history-beginning-search-forward-end history-search-end
		bindkey "^[[A" history-beginning-search-backward-end
		bindkey "^[[B" history-beginning-search-forward-end

		# Load git completions for zsh
		if [ -f ~/.git-completion.sh ]; then
			zstyle ':completion:*:*:git:*' script ~/.git-completion.sh
			#echo "Git completions installed"
		else
			echo "Git completions not installed"
		fi

		# Enable completion for g alias
		compdef g=git
	fi

	# Append the dynamic paths
	export PATH=$(cat $HOME/.dynamicpaths)$PATH

	HOMEBREW_PATH="$(brew --prefix)/bin"
	eval "$($HOMEBREW_PATH/brew shellenv)"

	export PATH="$HOME/.ebcli-virtual-env/executables:$PATH"

	# The next line updates PATH for the Google Cloud SDK.
	if [ -f '$HOME/google-cloud-sdk/path.bash.inc' ]; then . '$HOME/google-cloud-sdk/path.bash.inc'; fi

	# The next line enables shell command completion for gcloud.
	if [ -f '$HOME/google-cloud-sdk/completion.bash.inc' ]; then . '$HOME/google-cloud-sdk/completion.bash.inc'; fi

	#pyenv
	export PYENV_ROOT="$HOME/.pyenv"
	export PATH="$PYENV_ROOT/bin:$PATH"
	if command -v pyenv 1>/dev/null 2>&1; then
		eval "$(pyenv init -)"
	fi

	# >>> conda initialize >>>
	# !! Contents within this block are managed by 'conda init' !!
	if [ -n "$BASH_VERSION" ]; then
		__conda_setup="$('/usr/local/anaconda3/bin/conda' 'shell.bash' 'hook' 2>/dev/null)"
	elif [ -n "$ZSH_VERSION" ]; then
		__conda_setup="$('/usr/local/anaconda3/bin/conda' 'shell.zsh' 'hook' 2>/dev/null)"
	fi
	if [ $? -eq 0 ]; then
		eval "$__conda_setup"
	else
		if [ -f "/usr/local/anaconda3/etc/profile.d/conda.sh" ]; then
			. "/usr/local/anaconda3/etc/profile.d/conda.sh"
		else
			export PATH="/usr/local/anaconda3/bin:$PATH"
		fi
	fi
	unset __conda_setup
# <<< conda initialize <<<

else
	# Linux
	if [ -n "$BASH_VERSION" ]; then
		# Bash-specific settings
		if [ -f ~/.git-completion.sh ]; then
			source ~/.git-completion.sh
			#echo "Git completions installed"
		else
			echo "Git completions not installed"
		fi

		if ! shopt -oq posix; then
			if [ -f /usr/share/bash-completion/bash_completion ]; then
				. /usr/share/bash-completion/bash_completion
				echo "Bash completions installed"
			elif [ -f /etc/bash_completion ]; then
				. /etc/bash_completion
				echo "Bash completions installed"
			fi
		fi

		# Case-insensitive globbing (used in pathname expansion)
		shopt -s nocaseglob

		# Append to the Bash history file, rather than overwriting it
		shopt -s histappend

		# Autocorrect typos in path names when using `cd`
		shopt -s cdspell

		# Enable some Bash 4 features when possible:
		# * `autocd`, e.g. `**/qux` will enter `./foo/bar/baz/qux`
		# * Recursive globbing, e.g. `echo **/*.txt`
		for option in autocd globstar; do
			shopt -s "$option" 2>/dev/null
		done

		# Add tab completion for SSH hostnames based on ~/.ssh/config, ignoring wildcards
		[ -e "$HOME/.ssh/config" ] && complete -o "default" -o "nospace" -W "$(grep "^Host" ~/.ssh/config | grep -v "[?*]" | cut -d " " -f2- | tr ' ' '\n')" scp sftp ssh

		if type _git &>/dev/null; then
			complete -o default -o nospace -F _git g
		fi
	elif [ -n "$ZSH_VERSION" ]; then
		# Zsh-specific settings
		# Case-insensitive globbing
		setopt NO_CASE_GLOB

		# Append to the history file
		setopt APPEND_HISTORY
		setopt SHARE_HISTORY

		# Autocorrect typos in path names when using `cd`
		setopt CORRECT
		setopt CORRECT_ALL

		# Enable extended globbing (** for recursive)
		setopt EXTENDED_GLOB

		# Auto cd into directories
		setopt AUTO_CD

		# Enable completion system
		autoload -Uz compinit
		compinit

		# History substring search - up/down arrows search by prefix
		autoload -U history-search-end
		zle -N history-beginning-search-backward-end history-search-end
		zle -N history-beginning-search-forward-end history-search-end
		bindkey "^[[A" history-beginning-search-backward-end
		bindkey "^[[B" history-beginning-search-forward-end

		# Load git completions for zsh
		if [ -f ~/.git-completion.sh ]; then
			zstyle ':completion:*:*:git:*' script ~/.git-completion.sh
			#echo "Git completions installed"
		else
			echo "Git completions not installed"
		fi

		# Enable completion for g alias
		compdef g=git
	fi

	# Append the dynamic paths
	if [ -f $HOME/.dynamicpaths ]; then
		export PATH=$(cat $HOME/.dynamicpaths)$PATH
	fi
fi

# Created by `pipx` on 2024-07-23 14:52:22
export PATH="$PATH:$HOME/.local/bin"
