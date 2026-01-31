#!/bin/bash
# Sisyphus Status - Show project task tracking status

PROJECT_DIR="${1:-.}"
SISYPHUS_DIR="$PROJECT_DIR/.sisyphus"

if [ ! -d "$SISYPHUS_DIR" ]; then
    echo "Error: No .sisyphus/ directory found in $PROJECT_DIR"
    exit 1
fi

echo "📋 Sisyphus Project Status"
echo "=========================="
echo "Project: $PROJECT_DIR"
echo ""

# Check boulder.json
if [ -f "$SISYPHUS_DIR/boulder.json" ]; then
    echo "🎯 Active Plan:"
    cat "$SISYPHUS_DIR/boulder.json" | python3 -c "
import json, sys
data = json.load(sys.stdin)
print(f\"  Plan: {data.get('active_plan', 'N/A').split('/')[-1]}\")
print(f\"  Started: {data.get('started_at', 'N/A')}\")
print(f\"  Sessions: {len(data.get('session_ids', []))}\")
"
    echo ""
fi

# Count plans
PLAN_COUNT=$(ls -1 "$SISYPHUS_DIR/plans/" 2>/dev/null | wc -l)
echo "📄 Plans: $PLAN_COUNT"

# Count evidence
EVIDENCE_COUNT=$(ls -1 "$SISYPHUS_DIR/evidence/" 2>/dev/null | wc -l)
echo "📸 Evidence: $EVIDENCE_COUNT"

# Check for uncommitted changes
if [ -d "$PROJECT_DIR/.git" ]; then
    cd "$PROJECT_DIR"
    UNCOMMITTED=$(git status --short .sisyphus/ 2>/dev/null | wc -l)
    if [ $UNCOMMITTED -gt 0 ]; then
        echo "⚠️  Uncommitted changes in .sisyphus/: $UNCOMMITTED files"
    else
        echo "✅ .sisyphus/ committed"
    fi
fi

echo ""
echo "Use sisyphus-read-plan.sh to see detailed task breakdown"
