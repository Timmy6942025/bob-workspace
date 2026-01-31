#!/bin/bash
# Memory Status - Show memory directory health

MEMORY_DIR="${1:-/home/timmy/.openclaw/workspace/memory}"

echo "🧠 Memory Status"
echo "==============="
echo ""

if [ ! -d "$MEMORY_DIR" ]; then
    echo "❌ Memory directory not found: $MEMORY_DIR"
    exit 1
fi

# Count files
DAILY_COUNT=$(find "$MEMORY_DIR" -maxdepth 1 -name "*.md" -type f 2>/dev/null | wc -l)
ARCHIVE_COUNT=$(find "$MEMORY_DIR/archive" -name "*.md" -type f 2>/dev/null | wc -l)
TOTAL_SIZE=$(du -sh "$MEMORY_DIR" 2>/dev/null | cut -f1)

echo "📊 Statistics:"
echo "  Daily files: $DAILY_COUNT"
echo "  Archived files: $ARCHIVE_COUNT"
echo "  Total size: $TOTAL_SIZE"
echo ""

# List recent daily files
echo "📅 Recent daily files:"
ls -lt "$MEMORY_DIR"/*.md 2>/dev/null | head -5 | awk '{print "  " $9 " (" $6, $7, $8 ")"}'
echo ""

# Check for old files (>30 days)
OLD_FILES=$(find "$MEMORY_DIR" -maxdepth 1 -name "*.md" -mtime +30 -type f 2>/dev/null)
OLD_COUNT=$(echo "$OLD_FILES" | grep -v "^$" | wc -l)

if [ $OLD_COUNT -gt 0 ]; then
    echo "⚠️  Old files (>30 days): $OLD_COUNT"
    echo "   Run memory-archive.sh to archive them"
else
    echo "✅ No old files needing archive"
fi

echo ""
echo "Use memory-consolidate.sh to review and consolidate"
