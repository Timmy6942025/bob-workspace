#!/bin/bash
# Analyze Logs - Parse and summarize log files

LOG_FILE="${1:-/tmp/openclaw/openclaw-$(date +%Y-%m-%d).log}"
LINES="${2:-100}"

echo "📊 Log Analysis: $LOG_FILE"
echo "=========================="
echo ""

if [ ! -f "$LOG_FILE" ]; then
    echo "❌ Log file not found: $LOG_FILE"
    echo ""
    echo "Available logs:"
    ls -lt /tmp/openclaw/*.log 2>/dev/null | head -5 || echo "  No logs found"
    exit 1
fi

# File stats
echo "📁 File Stats:"
echo "  Size: $(du -h "$LOG_FILE" | cut -f1)"
echo "  Lines: $(wc -l < "$LOG_FILE")"
echo "  Last modified: $(stat -c %y "$LOG_FILE" 2>/dev/null | cut -d'.' -f1 || stat -f %Sm "$LOG_FILE" 2>/dev/null)"
echo ""

# Recent entries
echo "📝 Recent Entries (last $LINES lines):"
tail -n "$LINES" "$LOG_FILE" | grep -E "(ERROR|WARN|INFO)" | tail -10
echo ""

# Error count
echo "📈 Summary:"
ERRORS=$(grep -c "ERROR" "$LOG_FILE" 2>/dev/null || echo 0)
WARNS=$(grep -c "WARN" "$LOG_FILE" 2>/dev/null || echo 0)
INFOS=$(grep -c "INFO" "$LOG_FILE" 2>/dev/null || echo 0)

echo "  Errors: $ERRORS"
echo "  Warnings: $WARNS"
echo "  Info: $INFOS"
echo ""

# If errors found, show them
if [ $ERRORS -gt 0 ]; then
    echo "⚠️  Recent Errors:"
    grep "ERROR" "$LOG_FILE" | tail -5
    echo ""
fi

echo "Analysis complete. Time: $(date '+%H:%M:%S')"
