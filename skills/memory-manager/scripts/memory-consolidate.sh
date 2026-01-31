#!/bin/bash
# Memory Consolidate - Review and suggest consolidations

MEMORY_DIR="${1:-/home/timmy/.openclaw/workspace/memory}"
MAIN_MEMORY="${2:-/home/timmy/.openclaw/workspace/MEMORY.md}"

echo "🧠 Memory Consolidation Review"
echo "============================="
echo ""

# Check for daily files
DAILY_FILES=$(find "$MEMORY_DIR" -maxdepth 1 -name "*.md" -type f 2>/dev/null | sort)

if [ -z "$DAILY_FILES" ]; then
    echo "✅ No daily files to review"
    exit 0
fi

echo "📅 Daily files to review:"
echo "$DAILY_FILES" | while read file; do
    filename=$(basename "$file")
    lines=$(wc -l < "$file")
    echo "  - $filename ($lines lines)"
done
echo ""

echo "📝 Suggested consolidation process:"
echo ""
echo "1. Read each daily file"
echo "2. Identify important items:"
echo "   - Decisions made"
echo "   - Key learnings"
echo "   - New capabilities"
echo "   - Status changes"
echo ""
echo "3. Update MEMORY.md with distilled learnings"
echo "4. Remove daily files after consolidation"
echo ""
echo "⚠️  Important: Only keep what matters long-term"
echo "   Routine updates can be archived, not added to MEMORY.md"
echo ""

# Show MEMORY.md stats
if [ -f "$MAIN_MEMORY" ]; then
    mem_lines=$(wc -l < "$MAIN_MEMORY")
    mem_size=$(du -h "$MAIN_MEMORY" | cut -f1)
    echo "📊 Current MEMORY.md: $mem_lines lines ($mem_size)"
fi
