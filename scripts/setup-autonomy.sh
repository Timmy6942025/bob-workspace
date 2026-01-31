#!/bin/bash
# Setup Autonomy - Configure OpenClaw for 24/7 operation

echo "🤖 Setting up OpenClaw Autonomy"
echo "================================"
echo ""

# Check if running as correct user
if [ "$(whoami)" != "timmy" ]; then
    echo "⚠️  Warning: Running as $(whoami), expected timmy"
fi

# Setup cron jobs for autonomous operation
echo "Setting up cron jobs..."

# Daily skill update check (7 AM)
openclaw cron add \
    --name "Daily skill check" \
    --cron "0 7 * * *" \
    --tz "GMT" \
    --session isolated \
    --message "Check for skill updates with 'clawhub update --all --dry-run' and report what would be updated" \
    --deliver \
    2>/dev/null && echo "✅ Daily skill check scheduled" || echo "⚠️  Failed to schedule skill check"

# Project health check (every 12 hours)
openclaw cron add \
    --name "Project health check" \
    --cron "0 */12 * * *" \
    --tz "GMT" \
    --session isolated \
    --message "Run project-health-monitor on /home/timmy and report any critical issues" \
    --deliver \
    2>/dev/null && echo "✅ Project health check scheduled" || echo "⚠️  Failed to schedule health check"

# Weekly memory consolidation (Sunday 10 AM)
openclaw cron add \
    --name "Weekly memory review" \
    --cron "0 10 * * 0" \
    --tz "GMT" \
    --session isolated \
    --message "Review memory files and consolidate important learnings into MEMORY.md" \
    --deliver \
    2>/dev/null && echo "✅ Weekly memory review scheduled" || echo "⚠️  Failed to schedule memory review"

echo ""
echo "📋 Current cron jobs:"
openclaw cron list 2>/dev/null || echo "No jobs scheduled yet"

echo ""
echo "🔧 Manual steps still needed:"
echo "  1. Edit ~/.openclaw/openclaw.json for heartbeat config"
echo "  2. Set OPENCLAW_GATEWAY_TOKEN environment variable"
echo "  3. Test heartbeat with 'openclaw heartbeat'"
echo ""
echo "📖 See OPENCLAW_AUTONOMY.md for full configuration guide"
