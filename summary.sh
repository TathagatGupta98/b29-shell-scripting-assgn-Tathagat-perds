#!/bin/bash

if ! git rev-parse --is-inside-work-tree > /dev/null 2>&1; then
    echo "Error: Not a Git repository."
    exit 1
fi

echo "Git Repository Summary"

echo -e "\nCurrent Branch:"
git branch --show-current

echo -e "\nTotal Commits:"
git rev-list --count HEAD

echo -e "\nTop Contributors:"
git shortlog -sn | head -n 5

echo -e "\nTop 5 Recently Modified Files:"
git log -n 10 --name-only --format="" | grep -v '^$' | sort | uniq | head -n 5