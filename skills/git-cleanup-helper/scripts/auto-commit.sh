#!/bin/bash
# Auto Commit - Smart auto-commit with descriptive messages

PROJECT_DIR="${1:-.}"
shift

# Flags
INCLUDE_UNTRACKED=""
FORCE=""

while [[ $# -gt 0 ]]; do
    case $1 in
        --include-untracked)
            INCLUDE_UNTRACKED="1"
            shift
            ;;
        --force)
            FORCE="1"
            shift
            ;;
        *)
            shift
            ;;
    esac
done

cd "$PROJECT_DIR" || exit 1

if [ ! -d ".git" ]; then
    echo "❌ Not a git repository: $PROJECT_DIR"
    exit 1
fi

# Check for changes
CHANGED=$(git status --short | wc -l)
if [ $CHANGED -eq 0 ]; then
    echo "✅ Nothing to commit in $(basename $PROJECT_DIR)"
    exit 0
fi

echo "📦 Auto-Commit: $(basename $PROJECT_DIR)"
echo "=================="
echo ""

# Show what will be committed
echo "Changes to commit:"
git status --short
echo ""

# Warn about large changes
if [ $CHANGED -gt 50 ] && [ -z "$FORCE" ]; then
    echo "⚠️  Large change detected ($CHANGED files). Use --force to proceed."
    exit 1
fi

# Analyze changes for commit message
DOCS=$(git diff --name-only | grep -E "\.(md|txt|rst)$" | wc -l)
CODE=$(git diff --name-only | grep -E "\.(js|ts|py|go|rs|java|cpp|c|h)$" | wc -l)
CONFIG=$(git diff --name-only | grep -E "\.(json|yaml|yml|toml|ini|conf)$" | wc -l)

# Build commit message
if [ $DOCS -gt 0 ] && [ $CODE -eq 0 ] && [ $CONFIG -eq 0 ]; then
    MSG="Update documentation"
elif [ $CODE -gt 0 ] && [ $DOCS -eq 0 ] && [ $CONFIG -eq 0 ]; then
    MSG="Update code"
elif [ $CONFIG -gt 0 ] && [ $CODE -eq 0 ] && [ $DOCS -eq 0 ]; then
    MSG="Update configuration"
else
    MSG="Update project files"
fi

# Add files
if [ -n "$INCLUDE_UNTRACKED" ]; then
    git add -A
    MSG="$MSG (with new files)"
else
    git add -u
fi

# Commit
echo "Committing with message: '$MSG'"
git commit -m "$MSG"

echo ""
echo "✅ Committed $CHANGED files"
