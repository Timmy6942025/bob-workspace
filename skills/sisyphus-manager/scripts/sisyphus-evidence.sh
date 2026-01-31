#!/bin/bash
# Sisyphus Evidence - List evidence files

PROJECT_DIR="${1:-.}"
SISYPHUS_DIR="$PROJECT_DIR/.sisyphus"

if [ ! -d "$SISYPHUS_DIR" ]; then
    echo "Error: No .sisyphus/ directory found in $PROJECT_DIR"
    exit 1
fi

echo "📸 Evidence Files"
echo "================="
echo ""

EVIDENCE_DIR="$SISYPHUS_DIR/evidence"

if [ ! -d "$EVIDENCE_DIR" ]; then
    echo "No evidence/ directory"
    exit 0
fi

# List files with sizes and dates
ls -lh "$EVIDENCE_DIR" | tail -n +2 | nl

echo ""
echo "Total: $(ls -1 "$EVIDENCE_DIR" | wc -l) files"

# Check git status
if [ -d "$PROJECT_DIR/.git" ]; then
    cd "$PROJECT_DIR"
    UNCOMMITTED=$(git status --short .sisyphus/evidence/ 2>/dev/null | wc -l)
    if [ $UNCOMMITTED -gt 0 ]; then
        echo ""
        echo "⚠️  Uncommitted evidence: $UNCOMMITTED files"
        git status --short .sisyphus/evidence/
    fi
fi
