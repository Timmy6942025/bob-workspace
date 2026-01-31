#!/bin/bash
# Analyze Sessions - Show OpenClaw session statistics

WORKSPACE_DIR="${1:-/home/timmy/.openclaw/workspace}"

echo "📊 OpenClaw Session Analysis"
echo "==========================="
echo ""

# Count memory files
MEMORY_COUNT=$(find "$WORKSPACE_DIR/memory" -name "*.md" -type f 2>/dev/null | wc -l)
echo "📝 Memory files: $MEMORY_COUNT"

# Count skills
SKILL_COUNT=$(ls -1 "$WORKSPACE_DIR/skills" 2>/dev/null | wc -l)
echo "🛠️  Custom skills: $SKILL_COUNT"

# Count scripts
SCRIPT_COUNT=$(find "$WORKSPACE_DIR/scripts" -name "*.sh" -type f 2>/dev/null | wc -l)
echo "🔧 Scripts: $SCRIPT_COUNT"

# Git stats
cd "$WORKSPACE_DIR" 2>/dev/null || exit 1
COMMITS=$(git log --oneline 2>/dev/null | wc -l)
echo "📦 Git commits: $COMMITS"

# Show last 5 commits
echo ""
echo "Recent activity:"
git log --oneline -5 2>/dev/null | nl

echo ""
echo "Workspace size: $(du -sh "$WORKSPACE_DIR" 2>/dev/null | cut -f1)"
