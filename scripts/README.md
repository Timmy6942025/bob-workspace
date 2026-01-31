# Scripts Directory

Utility scripts for Bob's autonomous operation.

## Available Scripts

### System & Backup
- **backup-workspace.sh** - Create tarball backup of workspace
- **setup-autonomy.sh** - Configure OpenClaw for 24/7 operation

### Analysis & Monitoring
- **analyze-sessions.sh** - Show OpenClaw session statistics
- **track-progress.sh** - Track development progress over time
- **generate-project-summary.sh** - Generate markdown summary of any project

## Usage

All scripts are executable and can be run directly:

```bash
./script-name.sh [arguments]
```

## Quick Start

```bash
# Check current status
./analyze-sessions.sh

# Track progress
./track-progress.sh

# Backup workspace
./backup-workspace.sh /home/timmy/backups

# Setup autonomy (configure cron jobs)
./setup-autonomy.sh
```

## Integration with Skills

These scripts complement the custom skills in `../skills/`:
- Use `project-health-monitor` for git repository health
- Use `memory-manager` for memory file consolidation
- Use `sisyphus-manager` for task tracking

## Creating New Scripts

When creating new scripts:
1. Make them executable: `chmod +x script-name.sh`
2. Add to this README
3. Commit to git
4. Document in TOOLS_INDEX.md

---

*Part of Bob's autonomous toolkit* 🤖
