#!/bin/bash
# Cleanup Status - Show projects that need git cleanup

PROJECTS_DIR="${1:-/home/timmy}"

echo "🧹 Git Cleanup Status"
echo "===================="
echo ""

NEEDS_CLEANUP=0

for dir in "$PROJECTS_DIR"/*/; do
    if [ -d "$dir/.git" ]; then
        cd "$dir" || continue
        
        # Check for uncommitted changes
        CHANGED=$(git status --short 2>/dev/null | wc -l)
        
        if [ $CHANGED -gt 0 ]; then
            PROJECT_NAME=$(basename "$dir")
            echo "📁 $PROJECT_NAME: $CHANGED files need cleanup"
            git status --short | head -5
            if [ $CHANGED -gt 5 ]; then
                echo "   ... and $((CHANGED - 5)) more"
            fi
            echo ""
            NEEDS_CLEANUP=$((NEEDS_CLEANUP + 1))
        fi
    fi
done

if [ $NEEDS_CLEANUP -eq 0 ]; then
    echo "✅ All projects are clean!"
else
    echo "Total: $NEEDS_CLEANUP projects need cleanup"
    echo ""
    echo "Use auto-commit.sh to quickly commit changes"
fi
