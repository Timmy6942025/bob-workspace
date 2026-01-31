# Tools Index - Bob's Toolkit

Complete index of all custom scripts, skills, and tools created for autonomous operation.

## 📁 Scripts (`scripts/`)

### System & Backup
| Script | Purpose | Usage |
|--------|---------|-------|
| `backup-workspace.sh` | Backup workspace to tarball | `./backup-workspace.sh [backup-dir]` |
| `generate-project-summary.sh` | Generate markdown summary of any project | `./generate-project-summary.sh [project-dir] [output-file]` |

## 🛠️ Custom Skills (`skills/`)

### 1. sisyphus-manager
**Purpose:** Track .sisyphus task management system

**Scripts:**
- `sisyphus-status.sh` - Show project status
- `sisyphus-read-plan.sh` - Display active plan
- `sisyphus-evidence.sh` - List evidence files

**Usage:**
```bash
./scripts/sisyphus-status.sh /path/to/project
```

### 2. project-health-monitor
**Purpose:** Monitor health of all git repositories

**Scripts:**
- `project-health.sh` - Check single project
- `project-health-all.sh` - Check all projects

**Usage:**
```bash
./scripts/project-health-all.sh /home/timmy
```

**Status Indicators:**
- 🟢 Healthy
- 🟡 Attention needed
- 🔴 Critical

### 3. git-cleanup-helper
**Purpose:** Automate git cleanup tasks

**Scripts:**
- `auto-commit.sh` - Smart auto-commit
- `cleanup-status.sh` - Show cleanup status

**Usage:**
```bash
./scripts/auto-commit.sh /path/to/project
./scripts/cleanup-status.sh /home/timmy
```

### 4. memory-manager
**Purpose:** Consolidate and maintain memory files

**Scripts:**
- `memory-status.sh` - Show memory health
- `memory-archive.sh` - Archive old files
- `memory-consolidate.sh` - Review for consolidation

**Usage:**
```bash
./scripts/memory-status.sh
./scripts/memory-archive.sh --older-than 30d
```

## 📦 Packaged Skills

All skills available as `.skill` files:
- `sisyphus-manager.skill`
- `project-health-monitor.skill`
- `git-cleanup-helper.skill`
- `memory-manager.skill`

Install with: `clawhub install /path/to/skill.skill`

## 📊 Documentation

| Document | Purpose |
|----------|---------|
| `AGENTS.md` | Workspace guidelines |
| `SOUL.md` | Who I am (autonomy directive) |
| `USER.md` | Timmy's profile |
| `MEMORY.md` | Long-term memory |
| `HEARTBEAT.md` | Autonomous check list |
| `STATUS.md` | Current status report |
| `CUSTOM_SKILLS.md` | Skill documentation |
| `OPENCLAW_AUTONOMY.md` | 24/7 config guide |
| `TOOLS_INDEX.md` | This file |

## 🎯 Quick Commands

```bash
# Check all projects
project-health-all.sh /home/timmy

# Backup workspace
backup-workspace.sh /home/timmy/backups

# Check memory status
memory-status.sh

# Encyphrix status
sisyphus-status.sh /home/timmy/encyphrix-pro
```

## 🔧 Total Toolkit

- **10 executable scripts**
- **4 skill packages**
- **9 documentation files**
- **~3000 lines** of shell scripts and docs

---

*All tools created autonomously by Bob on Day 1* 🧠
