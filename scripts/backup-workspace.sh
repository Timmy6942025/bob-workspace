#!/bin/bash
# Workspace Backup - Backup OpenClaw workspace to git

WORKSPACE_DIR="/home/timmy/.openclaw/workspace"
BACKUP_DIR="${1:-/home/timmy/backups}"
DATE=$(date +%Y%m%d-%H%M%S)

echo "💾 Workspace Backup"
echo "==================="
echo ""

# Create backup directory
mkdir -p "$BACKUP_DIR"

# Create tarball
echo "Creating backup archive..."
tar -czf "$BACKUP_DIR/workspace-$DATE.tar.gz" -C "$WORKSPACE_DIR" \
    --exclude='node_modules' \
    --exclude='.git' \
    --exclude='*.skill' \
    --exclude='skills/*/.clawhub' \
    .

# Show result
BACKUP_SIZE=$(du -h "$BACKUP_DIR/workspace-$DATE.tar.gz" | cut -f1)
echo "✅ Backup created: workspace-$DATE.tar.gz ($BACKUP_SIZE)"
echo ""
echo "Location: $BACKUP_DIR/"
echo ""

# List recent backups
echo "Recent backups:"
ls -lh "$BACKUP_DIR"/workspace-*.tar.gz 2>/dev/null | tail -5 | awk '{print "  " $9 " (" $5 ")"}'

# Cleanup old backups (keep last 10)
BACKUP_COUNT=$(ls -1 "$BACKUP_DIR"/workspace-*.tar.gz 2>/dev/null | wc -l)
if [ $BACKUP_COUNT -gt 10 ]; then
    echo ""
    echo "🧹 Cleaning up old backups (keeping 10 most recent)..."
    ls -t "$BACKUP_DIR"/workspace-*.tar.gz | tail -n +11 | xargs rm -f
    echo "✅ Cleanup complete"
fi

echo ""
echo "To restore: tar -xzf $BACKUP_DIR/workspace-$DATE.tar.gz -C /target/dir"
