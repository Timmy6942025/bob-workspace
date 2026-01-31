#!/bin/bash
# Smart Commit - Auto-generate commit message based on changes

PROJECT_DIR="${1:-.}"
cd "$PROJECT_DIR" || exit 1

# Check if git repo
if [ ! -d ".git" ]; then
    echo "❌ Not a git repository"
    exit 1
fi

# Check for changes
if [ -z "$(git status --short)" ]; then
    echo "✅ Nothing to commit"
    exit 0
fi

# Analyze changes
ADDED=$(git status --short | grep "^A" | wc -l)
MODIFIED=$(git status --short | grep "^ M" | wc -l)
DELETED=$(git status --short | grep "^D" | wc -l)
RENAMED=$(git status --short | grep "^R" | wc -l)

# Get file types
MD_COUNT=$(git diff --name-only --cached 2>/dev/null | grep -c "\.md$" || echo 0)
SH_COUNT=$(git diff --name-only --cached 2>/dev/null | grep -c "\.sh$" || echo 0)
JS_COUNT=$(git diff --name-only --cached 2>/dev/null | grep -c "\.js$" || echo 0)

# Build commit message
MSG=""

if [ $ADDED -gt 0 ]; then
    MSG="Add"
elif [ $MODIFIED -gt 0 ]; then
    MSG="Update"
elif [ $DELETED -gt 0 ]; then
    MSG="Remove"
else
    MSG="Update"
fi

# Add file types
if [ $MD_COUNT -gt 0 ]; then
    MSG="$MSG documentation"
elif [ $SH_COUNT -gt 0 ]; then
    MSG="$MSG scripts"
elif [ $JS_COUNT -gt 0 ]; then
    MSG="$MSG code"
else
    MSG="$MSG files"
fi

# Add count if multiple
TOTAL=$((ADDED + MODIFIED + DELETED + RENAMED))
if [ $TOTAL -gt 1 ]; then
    MSG="$MSG ($TOTAL files)"
fi

# Show what will be committed
echo "📦 Smart Commit"
echo "==============="
echo ""
echo "Changes:"
git status --short
echo ""
echo "Suggested message: '$MSG'"
echo ""
read -p "Press Enter to commit with this message, or type a custom one: " CUSTOM_MSG

if [ -n "$CUSTOM_MSG" ]; then
    MSG="$CUSTOM_MSG"
fi

git add -A && git commit -m "$MSG"
echo ""
echo "✅ Committed: $MSG"
