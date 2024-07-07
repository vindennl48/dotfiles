#!/bin/bash

# Check if the current directory is a git repository
if ! git rev-parse --is-inside-work-tree > /dev/null 2>&1; then
    echo "Error: Not a git repository. Exiting."
    exit 1
fi

# Get the current remote origin URL
remote_url=$(git config --get remote.origin.url)

# Check if remote URL is already using SSH (git@github.com)
if [[ $remote_url == git@github.com:* ]]; then
    echo "Remote origin is already using SSH. No changes needed."
    exit 0
fi

# Check if remote URL is using HTTPS
if [[ $remote_url == https://github.com/* ]]; then
    # Extract the repository path
    repo_path=$(echo $remote_url | sed 's|https://github.com/||')

    # Create the new SSH URL
    new_url="git@github.com:$repo_path"

    # Update the remote URL
    git remote set-url origin "$new_url"
    echo "Remote origin updated to use SSH: $new_url"
else
    echo "Error: Unsupported remote URL format. Exiting."
    exit 1
fi
