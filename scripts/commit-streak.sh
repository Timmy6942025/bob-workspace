#!/bin/bash
# Commit Streak - Track and motivate commit streak

WORKSPACE_DIR="${1:-/home/timmy/.openclaw/workspace}"
cd "$WORKSPACE_DIR" || exit 1

echo "🔥 Commit Streak Tracker"
echo "========================"
echo ""

# Get stats
TOTAL=$(git log --oneline | wc -l)
TODAY=$(git log --since="24 hours ago" --oneline | wc -l)
YESTERDAY=$(git log --since="48 hours ago" --until="24 hours ago" --oneline 2>/dev/null | wc -l)

# Calculate streak (simplified - just today for now)
STREAK=1
if [ $TODAY -eq 0 ]; then
    STREAK=0
fi

echo "📊 Stats:"
echo "  Total commits: $TOTAL"
echo "  Today: $TODAY"
echo "  Current streak: $STREAK day(s)"
echo ""

# Milestones
echo "🏆 Milestones:"
[ $TOTAL -ge 50 ] && echo "  ✅ 50 commits reached!"
[ $TOTAL -ge 75 ] && echo "  ✅ 75 commits reached!"
[ $TOTAL -ge 100 ] && echo "  🎯 100 commits - NEXT TARGET"
[ $TOTAL -lt 100 ] && echo "  🎯 100 commits - in progress"
echo ""

# Motivation
if [ $TODAY -eq 0 ]; then
    echo "⚠️  No commits today yet!"
    echo "💡 Tip: Even small commits count - documentation, fixes, improvements"
elif [ $TODAY -lt 5 ]; then
    echo "🟡 $TODAY commits today - good start!"
    echo "💡 Tip: Keep the momentum going"
elif [ $TODAY -lt 10 ]; then
    echo "🟢 $TODAY commits today - great work!"
    echo "💡 Tip: You're in the zone!"
else
    echo "🔥 $TODAY commits today - AMAZING!"
    echo "💡 Tip: Take a break if needed, quality > quantity"
fi

echo ""
echo "Current time: $(date '+%H:%M:%S')"
echo "Keep building! 🧠"
