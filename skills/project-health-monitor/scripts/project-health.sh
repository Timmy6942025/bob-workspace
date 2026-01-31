#!/bin/bash
# Project Health - Check health of a single project

PROJECT_DIR="${1:-.}"
DETAILED="${2:-}"

if [ ! -d "$PROJECT_DIR" ]; then
    echo "Error: Directory not found: $PROJECT_DIR"
    exit 1
fi

cd "$PROJECT_DIR" || exit 1
PROJECT_NAME=$(basename "$PROJECT_DIR")

# Initialize status
STATUS="🟢"
STATUS_TEXT="Healthy"
DETAILS=""

# Check if git repo
if [ -d ".git" ]; then
    # Check uncommitted changes
    UNCOMMITTED=$(git status --short 2>/dev/null | wc -l)
    if [ $UNCOMMITTED -gt 0 ]; then
        STATUS="🟡"
        STATUS_TEXT="Uncommitted changes"
        DETAILS="${DETAILS}Uncommitted: $UNCOMMITTED | "
    fi
    
    # Check last commit date
    LAST_COMMIT=$(git log -1 --format=%ct 2>/dev/null)
    if [ -n "$LAST_COMMIT" ]; then
        NOW=$(date +%s)
        DAYS_AGO=$(( (NOW - LAST_COMMIT) / 86400 ))
        
        if [ $DAYS_AGO -gt 14 ]; then
            STATUS="🔴"
            STATUS_TEXT="Stale"
            DETAILS="${DETAILS}Last commit: ${DAYS_AGO}d ago | "
        elif [ $DAYS_AGO -gt 7 ]; then
            if [ "$STATUS" = "🟢" ]; then
                STATUS="🟡"
                STATUS_TEXT="Recent"
            fi
            DETAILS="${DETAILS}Last commit: ${DAYS_AGO}d ago | "
        else
            HOURS_AGO=$(( (NOW - LAST_COMMIT) / 3600 ))
            if [ $HOURS_AGO -lt 24 ]; then
                DETAILS="${DETAILS}Last commit: ${HOURS_AGO}h ago | "
            else
                DETAILS="${DETAILS}Last commit: ${DAYS_AGO}d ago | "
            fi
        fi
    fi
    
    # Check unpushed commits
    UNPUSHED=$(git log --branches --not --remotes --oneline 2>/dev/null | wc -l)
    if [ $UNPUSHED -gt 0 ]; then
        DETAILS="${DETAILS}Unpushed: $UNPUSHED | "
    fi
else
    STATUS="⚪"
    STATUS_TEXT="No git"
    DETAILS="Not a git repository | "
fi

# Check for .sisyphus
if [ -d ".sisyphus" ]; then
    DETAILS="${DETAILS}.sisyphus ✓ | "
else
    DETAILS="${DETAILS}No .sisyphus | "
fi

# Check for tests
if [ -d "tests" ] || [ -d "__tests__" ] || [ -d "test" ]; then
    DETAILS="${DETAILS}Tests ✓"
else
    DETAILS="${DETAILS}No tests"
fi

# Output
if [ "$DETAILED" = "--detailed" ]; then
    echo ""
    echo "$STATUS $PROJECT_NAME"
    echo "   Status: $STATUS_TEXT"
    echo "   $DETAILS"
else
    echo "$STATUS $PROJECT_NAME - $DETAILS"
fi
