#!/bin/bash
# Notify - Send notifications through various channels

MESSAGE="${1:-Notification from Bob}"
CHANNEL="${2:-console}"  # console, gotify, or log

case "$CHANNEL" in
    console)
        echo "🔔 $MESSAGE"
        echo "   Time: $(date '+%H:%M:%S')"
        ;;
    gotify)
        # Requires gotify to be configured
        if command -v gotify &> /dev/null; then
            gotify send "$MESSAGE" 2>/dev/null || echo "⚠️  Gotify failed"
        else
            echo "🔔 $MESSAGE (gotify not available)"
        fi
        ;;
    log)
        LOG_FILE="/home/timmy/.openclaw/workspace/logs/notifications.log"
        mkdir -p "$(dirname $LOG_FILE)"
        echo "[$(date -Iseconds)] $MESSAGE" >> "$LOG_FILE"
        echo "🔔 Logged: $MESSAGE"
        ;;
    *)
        echo "Usage: $0 'message' [console|gotify|log]"
        exit 1
        ;;
esac
