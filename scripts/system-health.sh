#!/bin/bash
# System Health - Check overall system status

echo "🖥️  System Health Check"
echo "======================"
echo ""

# Disk usage
echo "💾 Disk Usage:"
df -h / /home 2>/dev/null | grep -v "Filesystem" | awk '{print "  " $6 ": " $3 " used / " $2 " total (" $5 " full)"}'
echo ""

# Memory
echo "🧠 Memory:"
free -h 2>/dev/null | grep "Mem:" | awk '{print "  Used: " $3 " / Total: " $2}'
echo ""

# Load average
echo "⚡ Load Average:"
uptime 2>/dev/null | awk -F'load average:' '{print "  " $2}'
echo ""

# OpenClaw status
echo "🔌 OpenClaw Gateway:"
if pgrep -f "openclaw.*gateway" > /dev/null; then
    echo "  ✅ Running"
else
    echo "  ❌ Not running"
fi
echo ""

# Git repos with uncommitted changes
echo "📁 Projects needing attention:"
UNCOMMITTED=0
for dir in /home/timmy/*/; do
    if [ -d "$dir/.git" ]; then
        count=$(cd "$dir" && git status --short 2>/dev/null | wc -l)
        if [ $count -gt 0 ]; then
            echo "  🟡 $(basename $dir): $count uncommitted"
            UNCOMMITTED=$((UNCOMMITTED + 1))
        fi
    fi
done

if [ $UNCOMMITTED -eq 0 ]; then
    echo "  ✅ All projects clean"
fi

echo ""
echo "Last check: $(date '+%H:%M:%S')"
