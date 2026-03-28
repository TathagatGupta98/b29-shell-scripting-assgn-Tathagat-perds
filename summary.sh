#!/bin/bash

# Colors
GREEN='\033[0;32m'
CYAN='\033[0;36m'
RESET='\033[0m'

# Bonus: accept GitHub URL

if [ -n "$1" ]; then
    echo "Cloning repository..."
    git clone "$1" _tmp_repo 2>/dev/null
    if [ $? -ne 0 ]; then
        echo "Error: Could not clone repository."
        exit 1
    fi
    cd _tmp_repo
fi

# Check if inside a git repo
if ! git rev-parse --git-dir > /dev/null 2>&1; then
    echo "Error: Not a git repository."
    exit 1
fi

# Gather data
BRANCH=$(git branch --show-current)
COMMITS=$(git rev-list --count HEAD 2>/dev/null || echo "0")
CONTRIBUTORS=$(git shortlog -sn --no-merges | head -5)
FILES=$(git log --name-only --pretty=format: | sort | uniq -c | sort -rn | head -5)

# Print report
echo
echo -e "${CYAN}Git Repository Summary${RESET}"
echo
echo -e "Branch  : ${GREEN}$BRANCH${RESET}"
echo "Commits : $COMMITS"
echo
echo -e "${CYAN}Top Contributors:${RESET}"
echo "$CONTRIBUTORS"
echo
echo -e "${CYAN}Top Modified Files:${RESET}"
echo "$FILES"
echo