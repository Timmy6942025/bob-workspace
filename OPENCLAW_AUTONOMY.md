# OpenClaw Autonomous Configuration

Configure OpenClaw to run 24/7 without requiring human responses.

## Current Status

OpenClaw is already running in **local mode** (port 18789) with systemd service.
Gateway: `ws://127.0.0.1:18789`

## Key Insight: Heartbeat vs Cron

**Heartbeat (every 30m)** - Use for:
- Periodic awareness checks
- Batching multiple monitoring tasks
- Context-aware decisions
- Low-overhead monitoring

**Cron (exact timing)** - Use for:
- Precise schedules (9:00 AM daily)
- Standalone tasks
- One-shot reminders
- Isolated sessions (no context pollution)

## Configuration for 24/7 Autonomy

### 1. Config File: `~/.openclaw/openclaw.json`

```json5
{
  // Agent configuration
  agents: {
    defaults: {
      workspace: "~/.openclaw/workspace",
      
      // Heartbeat every 30 minutes
      heartbeat: {
        every: "30m",
        target: "last",        // Deliver to last active channel
        // Or use "none" to not deliver (silent operation)
        prompt: "Read HEARTBEAT.md if it exists (workspace context). Follow it strictly. Do not infer or repeat old tasks from prior chats. If nothing needs attention, reply HEARTBEAT_OK.",
        ackMaxChars: 300,
        // Optional: only run during active hours
        // activeHours: { start: "08:00", end: "22:00" },
      },
    },
    
    // Single main agent
    list: [
      {
        id: "main",
        default: true,
      }
    ],
  },
  
  // Cron jobs for precise scheduling
  cron: {
    enabled: true,
    store: "~/.openclaw/cron/jobs.json",
    maxConcurrentRuns: 2,
  },
  
  // Gateway settings
  gateway: {
    port: 18789,
    auth: {
      // Generate with: openclaw gateway token
      token: "${OPENCLAW_GATEWAY_TOKEN}",
    },
  },
  
  // Channel configuration (restrict to your numbers)
  channels: {
    whatsapp: {
      // Only respond to these numbers
      allowFrom: ["+YOUR_NUMBER"],
      groups: {
        "*": { requireMention: true },  // Only respond to @mentions in groups
      },
    },
    telegram: {
      allowFrom: ["YOUR_CHAT_ID"],
    },
  },
  
  // Message handling
  messages: {
    groupChat: {
      // Only respond when mentioned
      mentionPatterns: ["@bob", "@BobBuild"],
    },
  },
}
```

### 2. HEARTBEAT.md - Autonomous Tasks

Create `~/.openclaw/workspace/HEARTBEAT.md`:

```markdown
# HEARTBEAT.md - Autonomous Checks

## Periodic Tasks (Every 30 min)

### Project Monitoring
- Check Encyphrix Pro git status
- Monitor .sisyphus/ plan progress
- Check for uncommitted changes across projects

### System Health
- Check disk space (alert if >80%)
- Monitor long-running processes
- Verify OpenClaw gateway status

### Self-Improvement
- Check for skill updates: `clawhub update --all`
- Review memory files for consolidation
- Explore new skills on clawhub

### Moltbook (if claimed)
- Check feed for new posts
- Reply to comments
- Post updates if something interesting happened

## Active Projects Status
- **Encyphrix Pro**: ACTIVE - Key Manager feature
- **qagri-ai**: OFF LIMITS - Confidential
- **polymr**: Deprioritized
- **copycat**: Deprioritized

## Response Rules
- If nothing needs attention: reply HEARTBEAT_OK
- If something needs attention: reply with alert text only
- Never ask for permission - just do it
- Document everything in memory files
```

### 3. Cron Jobs for Specific Tasks

```bash
# Daily skill update check (7 AM)
openclaw cron add \
  --name "Daily skill update check" \
  --cron "0 7 * * *" \
  --tz "GMT" \
  --session isolated \
  --message "Check for skill updates with 'clawhub update --all --dry-run' and summarize what would update." \
  --deliver \
  --channel last

# Weekly memory consolidation (Sunday 10 AM)
openclaw cron add \
  --name "Weekly memory review" \
  --cron "0 10 * * 0" \
  --tz "GMT" \
  --session isolated \
  --message "Review this week's memory files. Consolidate important learnings into MEMORY.md. Archive daily files if needed." \
  --deliver \
  --channel last

# Project health check (twice daily)
openclaw cron add \
  --name "Project health check" \
  --cron "0 */12 * * *" \
  --tz "GMT" \
  --session isolated \
  --message "Run project-health-monitor on all projects. Report any critical issues." \
  --deliver \
  --channel last
```

### 4. Silent Mode (No Human Required)

To run completely silently without delivering messages:

```json5
{
  agents: {
    defaults: {
      heartbeat: {
        every: "30m",
        target: "none",  // Don't deliver - just run
        prompt: "Read HEARTBEAT.md...",
      },
    },
  },
}
```

Or use cron with `deliver: false`:

```bash
openclaw cron add \
  --name "Silent background task" \
  --every "1h" \
  --session isolated \
  --message "Do background work without notifying human" \
  --deliver false
```

## Commands to Apply

```bash
# 1. Generate gateway token
openclaw gateway token

# 2. Set environment variable (add to ~/.bashrc or ~/.zshrc)
export OPENCLAW_GATEWAY_TOKEN="your-token-here"

# 3. Create config
mkdir -p ~/.openclaw
cat > ~/.openclaw/openclaw.json << 'EOF'
{ ... config from above ... }
EOF

# 4. Validate config
openclaw doctor

# 5. Restart gateway
openclaw gateway restart

# 6. Verify heartbeat is running
openclaw status
```

## What This Enables

✅ **24/7 autonomous operation** - Heartbeat runs every 30m without human input
✅ **Self-monitoring** - Checks projects, system health, skills automatically
✅ **Self-improvement** - Explores new skills, updates existing ones
✅ **Documentation** - Maintains memory files automatically
✅ **Moltbook integration** - Posts and interacts socially
✅ **Silent or vocal** - Can run silently or deliver updates to you

## Safety Measures

- **Restricted channels** - Only responds to your allowed numbers
- **Group mention-only** - Won't spam group chats
- **HEARTBEAT_OK suppression** - Silent when nothing needs attention
- **Memory files** - All actions documented for review
- **Cron isolation** - Background tasks don't pollute main context

## Monitoring the Autonomous Agent

```bash
# View recent heartbeat runs
openclaw logs --follow

# Check cron job status
openclaw cron list

# View session history
openclaw sessions list

# Check gateway health
openclaw health
```

## Next Steps

1. Decide: Silent mode or deliver updates to you?
2. Configure `allowFrom` with your actual phone/chat IDs
3. Set up cron jobs for specific tasks
4. Let it run and observe for 24h
5. Adjust HEARTBEAT.md based on what works

---

**Result:** Bob runs 24/7, self-improves, monitors projects, and only bothers you when something actually needs attention.
