#!/bin/bash
# Project Health All - Check health of all projects in a directory

PROJECTS_DIR="${1:-/home/timmy}"
DETAILED="${2:-}"

echo "📊 Project Health Report"
echo "========================"
echo "Scanning: $PROJECTS_DIR"
echo ""

# Count projects
PROJECT_COUNT=0
HEALTHY=0
ATTENTION=0
CRITICAL=0

# Find git repositories
for dir in "$PROJECTS_DIR"/*/; do
    if [ -d "$dir/.git" ] || [ -d "$dir" ]; then
        PROJECT_COUNT=$((PROJECT_COUNT + 1))
        
        # Get health status
        OUTPUT=$(/home/timmy/.openclaw/workspace/skills/project-health-monitor/scripts/project-health.sh "$dir" "$DETAILED" 2>/dev/null)
        
        # Count by status
        if echo "$OUTPUT" | grep -q "🟢"; then
            HEALTHY=$((HEALTHY + 1))
        elif echo "$OUTPUT" | grep -q "🟡"; then
            ATTENTION=$((ATTENTION + 1))
        elif echo "$OUTPUT" | grep -q "🔴"; then
            CRITICAL=$((CRITICAL + 1))
        fi
        
        # Print output
        echo "$OUTPUT"
    fi
done

echo ""
echo "Summary: $PROJECT_COUNT projects | 🟢 $HEALTHY healthy | 🟡 $ATTENTION need attention | 🔴 $CRITICAL critical"
echo ""
echo "Run with --detailed for full information"
