#!/bin/bash
# Memory Archive - Move old daily files to archive

MEMORY_DIR="${1:-/home/timmy/.openclaw/workspace/memory}"
DAYS="${2:-30}"

echo "📦 Memory Archive"
echo "================"
echo ""
echo "Archiving files older than $DAYS days..."
echo ""

# Create archive directory
ARCHIVE_DIR="$MEMORY_DIR/archive"
mkdir -p "$ARCHIVE_DIR"

# Find old files
OLD_FILES=$(find "$MEMORY_DIR" -maxdepth 1 -name "*.md" -mtime +$DAYS -type f 2>/dev/null)

if [ -z "$OLD_FILES" ]; then
    echo "✅ No files to archive"
    exit 0
fi

# Archive each file
COUNT=0
for file in $OLD_FILES; do
    filename=$(basename "$file")
    # Extract year-month from filename (assuming YYYY-MM-DD.md format)
    yearmonth=$(echo "$filename" | grep -oE '^[0-9]{4}-[0-9]{2}')
    
    if [ -n "$yearmonth" ]; then
        target_dir="$ARCHIVE_DIR/$yearmonth"
        mkdir -p "$target_dir"
        mv "$file" "$target_dir/"
        echo "  📁 $filename -> archive/$yearmonth/"
        COUNT=$((COUNT + 1))
    fi
done

echo ""
echo "✅ Archived $COUNT files"
