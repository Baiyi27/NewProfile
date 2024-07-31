#!/bin/bash

rm -rf .git/refs/original .git/logs
git reflog expire --expire=now --all
git fsck --full --unreachable
git repack -A -d
git gc --aggressive --prune=now
du -h --max-depth=1
git push --force --all