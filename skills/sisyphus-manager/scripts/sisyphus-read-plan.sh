#!/bin/bash
# Sisyphus Read Plan - Display active plan details

PROJECT_DIR="${1:-.}"
SISYPHUS_DIR="$PROJECT_DIR/.sisyphus"

if [ ! -d "$SISYPHUS_DIR" ]; then
    echo "Error: No .sisyphus/ directory found in $PROJECT_DIR"
    exit 1
fi

# Get active plan from boulder.json
if [ ! -f "$SISYPHUS_DIR/boulder.json" ]; then
    echo "Error: No boulder.json found"
    exit 1
fi

ACTIVE_PLAN=$(cat "$SISYPHUS_DIR/boulder.json" | python3 -c "
import json, sys
data = json.load(sys.stdin)
print(data.get('active_plan', ''))
")

if [ -z "$ACTIVE_PLAN" ]; then
    echo "Error: No active plan in boulder.json"
    exit 1
fi

PLAN_FILE="$ACTIVE_PLAN"
if [ ! -f "$PLAN_FILE" ]; then
    # Try relative to sisyphus dir
    PLAN_FILE="$SISYPHUS_DIR/plans/$(basename $ACTIVE_PLAN)"
fi

if [ ! -f "$PLAN_FILE" ]; then
    echo "Error: Plan file not found: $ACTIVE_PLAN"
    exit 1
fi

echo "📖 Active Plan: $(basename $ACTIVE_PLAN)"
echo "===================================="
echo ""

# Display first 100 lines of plan
head -100 "$PLAN_FILE"

echo ""
echo "... (truncated, see full file at $PLAN_FILE)"
