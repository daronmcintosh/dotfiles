#!/bin/bash

# Delete a git worktree

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
    echo "Usage: $0 <path>"
    echo ""
    echo "Example: $0 ../feature-x"
    exit 1
fi

path="$1"

# Check if path exists as a worktree
if ! git worktree list | grep -q "$path"; then
    echo -e "${RED}Error: '$path' is not a registered worktree${NC}"
    echo ""
    echo -e "${GREEN}Git Worktrees:${NC}"
    git worktree list
    exit 1
fi

echo -e "${YELLOW}Deleting worktree at '$path'...${NC}"
git worktree remove "$path"
echo -e "${GREEN}✓ Worktree deleted successfully${NC}"
echo ""
echo -e "${GREEN}Git Worktrees:${NC}"
git worktree list
