#!/usr/bin/env bash

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE}")" && pwd)"

git -C "$DOTFILES_DIR" pull origin main

# Install/update Powerlevel10k
if [ -d ~/powerlevel10k ]; then
	echo "Updating Powerlevel10k..."
	git -C ~/powerlevel10k pull
else
	echo "Installing Powerlevel10k..."
	git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k
fi

# Files/directories to skip (not symlinked)
SKIP_FILES=(
	".git"
	".DS_Store"
	".osx"
	"bootstrap.sh"
	"README.md"
	"LICENSE-MIT.txt"
	"update.sh"
	"brew.sh"
	"update-git-completion.sh"
	"bin"
)

function should_skip() {
	local file="$1"
	for skip in "${SKIP_FILES[@]}"; do
		if [[ "$file" == "$skip" ]]; then
			return 0
		fi
	done
	return 1
}

function doIt() {
	echo "Creating symlinks..."

	for file in "$DOTFILES_DIR"/.*; do
		filename="$(basename "$file")"

		# Skip . and ..
		[[ "$filename" == "." || "$filename" == ".." ]] && continue

		# Skip files in SKIP_FILES
		should_skip "$filename" && continue

		target="$HOME/$filename"

		# Remove existing file/symlink if it exists
		if [[ -e "$target" || -L "$target" ]]; then
			rm -rf "$target"
		fi

		# Create symlink
		ln -sf "$file" "$target"
		echo "  $filename -> $file"
	done

	# Also symlink bin directory
	if [[ -d "$DOTFILES_DIR/bin" ]]; then
		if [[ -e "$HOME/bin" || -L "$HOME/bin" ]]; then
			rm -rf "$HOME/bin"
		fi
		ln -sf "$DOTFILES_DIR/bin" "$HOME/bin"
		echo "  bin -> $DOTFILES_DIR/bin"
	fi

	echo "Done!"
	source ~/.bash_profile
}

if [ "$1" == "--force" -o "$1" == "-f" ]; then
	doIt
else
	read -p "This will replace existing dotfiles with symlinks. Are you sure? (y/n) " -n 1
	echo ""
	if [[ $REPLY =~ ^[Yy]$ ]]; then
		doIt
	fi
fi
