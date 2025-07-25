#!/bin/bash

# Exit immediately if a command exits with a non-zero status.
set -e

# !!! IMPORTANT !!!
# Replace "YOUR_COMMIT_ID_HERE" with the actual Git commit ID you want to reset to.
# You can find the commit ID by running `git log --oneline`
COMMIT_ID="YOUR_COMMIT_ID_HERE"

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

echo "Clearing Laravel application caches..."
php artisan optimize:clear

echo "Resetting database and seeding with data..."
php artisan migrate:fresh --seed

echo "✅ Application has been successfully reset to commit $COMMIT_ID." 