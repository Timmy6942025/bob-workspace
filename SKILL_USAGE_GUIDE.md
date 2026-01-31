# Skill Usage Guide - Quick Reference

Quick reference for all installed and custom skills.

## 🛠️ Custom Skills (Created by Bob)

### sisyphus-manager
Track .sisyphus task management system.

```bash
# Check project status
./skills/sisyphus-manager/scripts/sisyphus-status.sh /path/to/project

# List evidence files
./skills/sisyphus-manager/scripts/sisyyphus-evidence.sh /path/to/project

# Read active plan
./skills/sisyphus-manager/scripts/sisyphus-read-plan.sh /path/to/project
```

### project-health-monitor
Monitor health of git repositories.

```bash
# Check all projects
./skills/project-health-monitor/scripts/project-health-all.sh /home/timmy

# Check single project
./skills/project-health-monitor/scripts/project-health.sh /path/to/project
```

**Status indicators:**
- 🟢 Healthy - Clean working tree
- 🟡 Attention - Uncommitted changes
- 🔴 Critical - Very old commits or many uncommitted files

### git-cleanup-helper
Automate git cleanup tasks.

```bash
# Auto-commit with smart message
./skills/git-cleanup-helper/scripts/auto-commit.sh /path/to/project

# Check cleanup status
./skills/git-cleanup-helper/scripts/cleanup-status.sh /home/timmy
```

### memory-manager
Consolidate and maintain memory files.

```bash
# Check memory status
./skills/memory-manager/scripts/memory-status.sh

# Archive old files (>30 days)
./skills/memory-manager/scripts/memory-archive.sh --older-than 30d

# Review for consolidation
./skills/memory-manager/scripts/memory-consolidate.sh
```

## 📦 Installed Skills (from ClawHub)

### Core Development
| Skill | Purpose | Trigger |
|-------|---------|---------|
| git-essentials | Git workflows | "git status", "commit changes" |
| github | GitHub CLI | "create repo", "list issues" |
| github-pr | PR management | "fetch PR", "merge PR" |
| docker-essentials | Docker management | "build image", "run container" |
| deploy-agent | Deployment | "deploy to production" |
| github-action-gen | CI/CD workflows | "create GitHub Action" |

### Testing & Quality
| Skill | Purpose | Trigger |
|-------|---------|---------|
| web-perf | Performance audit | "audit page speed" |
| test-runner | Test execution | "run tests" |
| ai-explain | Code explanation | "explain this code" |
| swagger-gen | API documentation | "generate OpenAPI spec" |

### Utilities
| Skill | Purpose | Trigger |
|-------|---------|---------|
| weather | Weather forecasts | "what's the weather" |
| system-monitor | System health | "check CPU/RAM" |
| gotify | Push notifications | "notify me when done" |
| timer | Timers | "set timer for 10 minutes" |
| focus-deep-work | Focus sessions | "start focus mode" |
| tavily-search | Web search | "search for..." |
| gemini | AI queries | "ask Gemini..." |
| video-frames | Video processing | "extract frames" |

### Data & Storage
| Skill | Purpose | Trigger |
|-------|---------|---------|
| database | DB management | "run SQL query" |
| backup | Backup operations | "backup files" |
| flowmind | Productivity | "create task" |

## 🔧 Utility Scripts (scripts/)

| Script | Purpose | Usage |
|--------|---------|-------|
| backup-workspace.sh | Backup to tarball | `./backup-workspace.sh [dir]` |
| generate-project-summary.sh | Project summary | `./generate-project-summary.sh [project]` |
| analyze-sessions.sh | Session stats | `./analyze-sessions.sh` |
| track-progress.sh | Progress tracking | `./track-progress.sh` |

## 🎯 Common Workflows

### Daily Check
```bash
# 1. Check project health
project-health-all.sh /home/timmy

# 2. Check memory status
memory-status.sh

# 3. Track progress
track-progress.sh
```

### Before Starting Work
```bash
# Check Encyphrix status
sisyphus-status.sh /home/timmy/encyphrix-pro

# Check for uncommitted changes
cleanup-status.sh /home/timmy
```

### End of Day
```bash
# Backup workspace
backup-workspace.sh /home/timmy/backups

# Generate summary
generate-project-summary.sh . today-summary.md
```

## 📚 Documentation Files

| File | Purpose |
|------|---------|
| AGENTS.md | Workspace guidelines |
| SOUL.md | Core identity & autonomy |
| USER.md | Timmy's profile |
| MEMORY.md | Long-term memory |
| HEARTBEAT.md | Autonomous check list |
| STATUS.md | Current status |
| CUSTOM_SKILLS.md | Skill documentation |
| TOOLS_INDEX.md | Tool reference |
| SKILL_USAGE_GUIDE.md | This file |
| OPENCLAW_AUTONOMY.md | 24/7 config guide |

## 🦞 Moltbook

**Profile:** https://www.moltbook.com/u/BobBuild

When API is stable:
- Post updates
- Reply to other moltys
- Join communities

## 🚀 Quick Commands

```bash
# Check everything
project-health-all.sh /home/timmy
memory-status.sh
track-progress.sh

# Backup
backup-workspace.sh /home/timmy/backups

# Skill update check
clawhub update --all --dry-run
```

---

*Last updated: Day 1, 56 commits* 🧠
