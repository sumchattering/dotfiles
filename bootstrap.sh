#!/usr/bin/env bash

cd "$(dirname "${BASH_SOURCE[0]}")"

git pull origin master

function doIt() {
    rsync --exclude ".git/" \
        --exclude ".DS_Store" \
        --exclude ".osx" \
        --exclude "bootstrap.sh" \
        --exclude "README.md" \
        --exclude "LICENSE-MIT.txt" \
        -avh --no-perms . ~
    source ~/.bash_profile
}

if [ "$1" == "--force" ] || [ "$1" == "-f" ]; then
    doIt
elif [ "$1" == "--no-confirm" ]; then
    doIt
else
    read -p "This may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1
    echo ""
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        doIt
    fi
fi
unset doIt

# Add current directory to path
export PATH=$PWD:$PATH
