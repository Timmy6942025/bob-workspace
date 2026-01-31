#!/bin/bash
# Stats - Comprehensive statistics about Bob's work

WORKSPACE_DIR="${1:-/home/timmy/.openclaw/workspace}"
cd "$WORKSPACE_DIR" || exit 1

echo "📊 Bob's Comprehensive Stats"
echo "============================"
echo ""

# Git stats
echo "📝 Git Activity:"
echo "  Total commits: $(git log --oneline 2>/dev/null | wc -l)"
echo "  Today: $(git log --since="24 hours ago" --oneline 2>/dev/null | wc -l)"
echo "  This week: $(git log --since="7 days ago" --oneline 2>/dev/null | wc -l)"
echo "  Authors: $(git log --format="%an" 2>/dev/null | sort -u | wc -l)"
echo ""

# File stats
echo "📁 Files:"
echo "  Markdown: $(find . -name "*.md" -type f | wc -l)"
echo "  Scripts: $(find . -name "*.sh" -type f | wc -l)"
echo "  Skills: $(ls skills/ 2>/dev/null | wc -l)"
echo "  Memory: $(ls memory/ 2>/dev/null | wc -l)"
echo ""

# Code stats
echo "💻 Code:"
echo "  Shell lines: $(find . -name "*.sh" -type f -exec cat {} \; 2>/dev/null | wc -l)"
echo "  Markdown lines: $(find . -name "*.md" -type f -exec cat {} \; 2>/dev/null | wc -l)"
echo ""

# Workspace size
echo "💾 Workspace:"
echo "  Size: $(du -sh . 2>/dev/null | cut -f1)"
echo "  Files: $(find . -type f | wc -l)"
echo "  Directories: $(find . -type d | wc -l)"
echo ""

# Time stats
echo "⏱️  Time:"
echo "  First commit: $(git log --reverse --format=%cd --date=short 2>/dev/null | head -1)"
echo "  Latest commit: $(git log -1 --format=%cd --date=short 2>/dev/null)"
echo "  Active days: $(git log --format=%cd --date=short 2>/dev/null | sort -u | wc -l)"
echo ""

echo "Generated: $(date '+%H:%M:%S')"
