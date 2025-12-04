#!/bin/bash

# Create a new git worktree with a new branch

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

# Check if we're in a git repository
if ! git rev-parse --git-dir > /dev/null 2>&1; then
    echo -e "${RED}Error: Not in a git repository${NC}"
    exit 1
fi

# Check arguments
if [ $# -ne 2 ]; then
    echo "Usage: $0 <path> <branch>"
    echo ""
    echo "Example: $0 ../feature-x feature-x"
    exit 1
fi

path="$1"
branch="$2"

# Check if path already exists
if [ -e "$path" ]; then
    echo -e "${RED}Error: Path '$path' already exists${NC}"
    exit 1
fi

# Check if branch already exists
if git show-ref --verify --quiet "refs/heads/$branch"; then
    echo -e "${RED}Error: Branch '$branch' already exists${NC}"
    echo -e "${YELLOW}Tip: Use 'git worktree add $path $branch' to create worktree from existing branch${NC}"
    exit 1
fi

echo -e "${GREEN}Creating worktree at '$path' with new branch '$branch'...${NC}"
git worktree add -b "$branch" "$path"
echo -e "${GREEN}✓ Worktree created successfully${NC}"
echo ""
echo -e "${GREEN}Git Worktrees:${NC}"
git worktree list
