#!/bin/bash

# Prompt the user to input parameters for the tail command
read -p "Please enter the parameters for the tail command: " tail_params

# Execute the git verify-pack command, pipe the output to sort and tail commands
result=$(git verify-pack -v .git/objects/pack/pack-*.idx | sort -k 3 -g | tail -n "$tail_params")
# echo "$result"

## Extract the blob information and store it in a variable
# blob_info=$(echo "$result" | grep "blob")

## Print the blob information
# echo "$blob_info"

## Extract the SHA-1 hash from the blob information
sha1_hash=$(echo "$result" | awk '{print $1}')

# echo "$sha1_hash"

## Execute the git rev-list command to find the object based on the SHA-1 hash

result=$(git rev-list --objects --all | grep "$sha1_hash")

echo "$result"

# file_path=$(git rev-list --objects --all | grep "$sha1_hash" | awk '{print $2}')

# echo "$file_path"

# git filter-branch --index-filter 'git rm --cached --ignore-unmatch ${file_path}'

# git log --pretty=oneline --branch -- "$file_path"
# rm -rf .git/refs/original .git/logs
# git reflog expire --expire=now --all
# git fsck --full --unreachable
# git repack -A -d
# git gc --aggressive --prune=now
# du -h --max-depth=1
# git pull --force [main] master