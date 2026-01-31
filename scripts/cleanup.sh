#!/bin/bash
# Cleanup - Remove unnecessary files from workspace

WORKSPACE_DIR="${1:-/home/timmy/.openclaw/workspace}"
cd "$WORKSPACE_DIR" || exit 1

echo "🧹 Workspace Cleanup"
echo "==================="
echo ""

# Check size before
echo "Before: $(du -sh . | cut -f1)"
echo ""

# Find and list potential cleanup targets
echo "📋 Potential cleanup targets:"

# Old backup files
OLD_BACKUPS=$(find . -name "*.tar.gz" -mtime +7 2>/dev/null | wc -l)
echo "  Old backups (>7 days): $OLD_BACKUPS"

# Temporary files
TMP_FILES=$(find . -name "*.tmp" -o -name "*.temp" 2>/dev/null | wc -l)
echo "  Temporary files: $TMP_FILES"

# Empty directories
EMPTY_DIRS=$(find . -type d -empty 2>/dev/null | wc -l)
echo "  Empty directories: $EMPTY_DIRS"

echo ""

# Safety check
read -p "Proceed with cleanup? (y/N): " CONFIRM
if [[ $CONFIRM =~ ^[Yy]$ ]]; then
    # Remove old backups
    find . -name "*.tar.gz" -mtime +7 -delete 2>/dev/null && echo "✅ Old backups removed"
    
    # Remove temp files
    find . -name "*.tmp" -delete 2>/dev/null
    find . -name "*.temp" -delete 2>/dev/null && echo "✅ Temp files removed"
    
    # Remove empty dirs (except .git)
    find . -type d -empty -not -path "*/.git/*" -delete 2>/dev/null && echo "✅ Empty directories removed"
    
    echo ""
    echo "After: $(du -sh . | cut -f1)"
else
    echo "Cleanup cancelled"
fi
