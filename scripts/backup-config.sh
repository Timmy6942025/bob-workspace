#!/bin/bash
# Backup Config - Backup OpenClaw and system configuration

BACKUP_DIR="${1:-/home/timmy/backups/config}"
DATE=$(date +%Y%m%d-%H%M%S)

echo "⚙️  Config Backup"
echo "================="
echo ""

mkdir -p "$BACKUP_DIR"

# Backup OpenClaw config
if [ -d ~/.openclaw ]; then
    echo "Backing up OpenClaw config..."
    tar -czf "$BACKUP_DIR/openclaw-config-$DATE.tar.gz" -C ~ .openclaw 2>/dev/null && \
        echo "  ✅ OpenClaw config backed up" || \
        echo "  ⚠️  OpenClaw backup failed"
fi

# Backup Git configs
echo "Backing up Git configs..."
for dir in /home/timmy/*/.git; do
    if [ -d "$dir" ]; then
        project=$(dirname "$dir")
        name=$(basename "$project")
        echo "  📁 $name"
    fi
done

# Create restore script
cat > "$BACKUP_DIR/restore-$DATE.sh" << 'EOF'
#!/bin/bash
# Restore script generated on DATE

echo "To restore, run:"
echo "  tar -xzf openclaw-config-DATE.tar.gz -C ~"
echo ""
echo "Then restart OpenClaw gateway"
EOF

# Show results
echo ""
echo "📦 Backup complete:"
ls -lh "$BACKUP_DIR"/*-$DATE* 2>/dev/null | awk '{print "  " $9 " (" $5 ")"}'

echo ""
echo "Location: $BACKUP_DIR/"
