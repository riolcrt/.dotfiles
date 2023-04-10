#!/bin/zsh

if [ -z "$1" ]; then
        echo "Please provide a directory path."
        return 1
    fi

    # Create the base directory if it doesn't exist
    mkdir -p "$1"

    # Change to the base directory
    cd "$1" || return

    # Create the desired directory structure
    mkdir -p src/controller src/views src/model public/css public/images public/js
    touch src/index.js public/index.html package.json package-lock.json .gitignore

    # Output the created directory tree
    tree "$1"