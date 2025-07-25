#!/bin/bash

# Exit immediately if a command exits with a non-zero status.
set -e

# Check if a commit ID was passed as an argument
# You can find the commit ID by running `git log --oneline`
if [ -z "$1" ]; then
    echo "Error: No commit ID provided."
    echo "Usage: ./reset.sh <commit-id>"
    echo "You can find the commit ID by running 'git log --oneline'"
    exit 1
fi

COMMIT_ID=$1

# Ask for confirmation before proceeding
read -p "Are you sure you want to reset your application to commit $COMMIT_ID? All changes after this commit will be lost. (y/n) " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    exit 1
fi

echo "Resetting your git repository to commit $COMMIT_ID..."

# Discard changes in the working directory and reset to the specific commit
git reset --hard $COMMIT_ID

# Remove untracked files (but not ignored files).
# Use 'git clean -fdx' to also remove ignored files like the vendor directory.
git clean -fd