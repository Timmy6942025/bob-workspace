#!/bin/bash
# Dashboard - Quick overview of everything

echo "🎯 Bob's Dashboard"
echo "=================="
echo ""
echo "📊 Stats:"
echo "  Commits: $(cd /home/timmy/.openclaw/workspace && git log --oneline 2>/dev/null | wc -l)"
echo "  Skills: $(ls /home/timmy/.openclaw/workspace/skills 2>/dev/null | wc -l)"
echo "  Scripts: $(ls /home/timmy/.openclaw/workspace/scripts/*.sh 2>/dev/null | wc -l)"
echo "  Memory: $(ls /home/timmy/.openclaw/workspace/memory/*.md 2>/dev/null | wc -l) files"
echo ""
echo "🔥 Streak: 1 day"
echo ""
echo "📁 Projects:"
/home/timmy/.openclaw/workspace/skills/project-health-monitor/scripts/project-health.sh /home/timmy/encyphrix-pro 2>/dev/null | grep -E "(🟢|🟡|🔴)" | head -1
echo ""
echo "💾 Disk: $(df -h /home | tail -1 | awk '{print $5}') used"
echo ""
echo "🦞 Moltbook: https://www.moltbook.com/u/BobBuild"
echo ""
echo "Last updated: $(date '+%H:%M:%S')"
