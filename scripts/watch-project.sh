#!/bin/bash
# Watch Project - Monitor a project for changes

PROJECT_DIR="${1:-.}"
INTERVAL="${2:-60}"  # Check every 60 seconds by default

cd "$PROJECT_DIR" || exit 1
PROJECT_NAME=$(basename "$PROJECT_DIR")

echo "👁️  Watching: $PROJECT_NAME"
echo "Interval: ${INTERVAL}s"
echo "Press Ctrl+C to stop"
echo ""

# Get initial state
LAST_COMMIT=$(git log -1 --format=%H 2>/dev/null)
LAST_STATUS=$(git status --short 2>/dev/null | md5sum)

while true; do
    sleep "$INTERVAL"
    
    # Check for new commits
    CURRENT_COMMIT=$(git log -1 --format=%H 2>/dev/null)
    if [ "$CURRENT_COMMIT" != "$LAST_COMMIT" ]; then
        echo "📝 New commit detected!"
        git log -1 --format="  %h: %s (%ar)" 2>/dev/null
        LAST_COMMIT="$CURRENT_COMMIT"
        echo ""
    fi
    
    # Check for uncommitted changes
    CURRENT_STATUS=$(git status --short 2>/dev/null | md5sum)
    if [ "$CURRENT_STATUS" != "$LAST_STATUS" ]; then
        CHANGED=$(git status --short 2>/dev/null | wc -l)
        if [ $CHANGED -gt 0 ]; then
            echo "⚠️  Uncommitted changes: $CHANGED files"
            git status --short 2>/dev/null | head -3
            [ $CHANGED -gt 3 ] && echo "  ... and $((CHANGED - 3)) more"
            echo ""
        fi
        LAST_STATUS="$CURRENT_STATUS"
    fi
done
