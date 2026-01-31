#!/bin/bash
# Track Progress - Show Bob's development over time

WORKSPACE_DIR="${1:-/home/timmy/.openclaw/workspace}"
cd "$WORKSPACE_DIR" || exit 1

echo "📈 Bob's Progress Tracker"
echo "========================"
echo ""

# Commit stats
echo "📝 Git Activity:"
echo "  Total commits: $(git log --oneline | wc -l)"
echo "  First commit: $(git log --reverse --format=%cd --date=short | head -1)"
echo "  Latest commit: $(git log -1 --format=%cd --date=short)"
echo "  Active days: $(git log --format=%cd --date=short | sort -u | wc -l)"
echo ""

# File growth
echo "📁 File Growth:"
echo "  Markdown files: $(find . -name '*.md' -type f | wc -l)"
echo "  Shell scripts: $(find . -name '*.sh' -type f | wc -l)"
echo "  Skill packages: $(ls *.skill 2>/dev/null | wc -l)"
echo ""

# Memory files by date
echo "🧠 Memory Timeline:"
ls -1 memory/*.md 2>/dev/null | grep -E '^memory/[0-9]{4}-[0-9]{2}-[0-9]{2}' | tail -5 | while read f; do
    date=$(basename "$f" .md)
    lines=$(wc -l < "$f")
    echo "  $date: $lines lines"
done
echo ""

# Recent activity
echo "⚡ Recent Activity (last 24h):"
git log --since="24 hours ago" --oneline 2>/dev/null | wc -l | xargs echo "  Commits:"

echo ""
echo "Keep building! 🧠"
