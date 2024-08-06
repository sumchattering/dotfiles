#!/usr/bin/env bash

cd "$(dirname "${BASH_SOURCE}")"
echo "Current directory: $(pwd)"
echo "Home directory: $HOME"
GIT_COMMITTER_NAME=$(git config --get user.name)
GIT_COMMITTER_EMAIL=$(git config --get user.email)
function doIt() {
    files_to_update=$(git ls-files)

    for file in $files_to_update; do
        home_dir_file="$HOME/$file"
        if [ -f $home_dir_file ]; then
            if [ "$file" == ".gitconfig" ]; then
                sed '/\[user\]/d; /\s*name = $GIT_COMMITTER_NAME/d; /\s*email = $GIT_COMMITTER_EMAIL/d' ~/"$file" >"$file"
                echo "Updated and cleaned: $file"
            else
                cp ~/"$file" "$file"
                echo "Updated: $file"
            fi
        else
            echo "Skipped: $file (not found in home directory)"
        fi
    done

    echo "Files updated from home directory to repository."
}

if [ "$1" == "--force" -o "$1" == "-f" ]; then
    doIt
else
    read -p "This may overwrite existing files in your repository. Are you sure? (y/n) " -n 1
    echo ""
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        doIt
    fi
fi
unset doIt
