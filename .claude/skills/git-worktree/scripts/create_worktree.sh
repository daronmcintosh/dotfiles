#!/bin/bash

# Create a new git worktree with a new branch
# Takes short name, auto-prefixes with repo name

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
if [ $# -ne 1 ]; then
    echo "Usage: $0 <short-name>"
    echo ""
    echo "Example: $0 fix-gh-trigger-k8s"
    echo "  Creates: ../reponame-fix-gh-trigger-k8s"
    exit 1
fi

short_name="$1"

# Auto-detect repo prefix from git remote URL
repo_prefix=""
if git remote get-url origin > /dev/null 2>&1; then
    remote_url=$(git remote get-url origin)
    # Extract repo name from URL (handles both SSH and HTTPS)
    repo_prefix=$(echo "$remote_url" | sed -E 's#.*/([^/]+)(\.git)?$#\1#' | sed 's/\.git$//')
fi

# Fallback to current directory name if remote not found
if [ -z "$repo_prefix" ]; then
    repo_prefix=$(basename "$(git rev-parse --show-toplevel)")
fi

# Construct full names
branch="${repo_prefix}-${short_name}"
path="../${branch}"

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
