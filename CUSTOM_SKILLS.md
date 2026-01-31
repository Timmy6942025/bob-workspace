# Custom Skills Created by Bob

## Overview

I've created 4 custom skills to help manage Timmy's projects and workflow. Each skill solves a specific problem and includes executable scripts.

---

## 1. sisyphus-manager

**Purpose:** Manage and track .sisyphus task management system

**Location:** `skills/sisyphus-manager/`

**Scripts:**
- `sisyphus-status.sh` - Show project task tracking status
- `sisyphus-read-plan.sh` - Parse and display active plan
- `sisyphus-evidence.sh` - List evidence files

**Usage:**
```bash
./scripts/sisyphus-status.sh /path/to/project
./scripts/sisyphus-evidence.sh /path/to/project
```

**Used for:** Encyphrix Pro, copycat (deprioritized)

---

## 2. project-health-monitor

**Purpose:** Monitor health of all git repositories

**Location:** `skills/project-health-monitor/`

**Scripts:**
- `project-health.sh` - Check single project health
- `project-health-all.sh` - Check all projects in directory

**Health Indicators:**
- 🟢 Healthy: Clean working tree, recent commits
- 🟡 Attention: Uncommitted changes, stale branches
- 🔴 Critical: Large uncommitted work, very old commits

**Usage:**
```bash
./scripts/project-health-all.sh /home/timmy
```

**Used for:** Tracking 13+ repositories across Timmy's workspace

---

## 3. git-cleanup-helper

**Purpose:** Automate git cleanup tasks

**Location:** `skills/git-cleanup-helper/`

**Scripts:**
- `auto-commit.sh` - Smart auto-commit with descriptive messages
- `cleanup-status.sh` - Show projects needing cleanup

**Features:**
- Analyzes changes to generate meaningful commit messages
- Warns about large changes (>50 files)
- Handles code, docs, and config changes differently

**Usage:**
```bash
./scripts/auto-commit.sh /path/to/project
./scripts/cleanup-status.sh /home/timmy
```

---

## 4. memory-manager

**Purpose:** Consolidate and maintain memory files

**Location:** `skills/memory-manager/`

**Scripts:**
- `memory-status.sh` - Show memory directory health
- `memory-archive.sh` - Archive old daily files
- `memory-consolidate.sh` - Review and suggest consolidations

**Usage:**
```bash
./scripts/memory-status.sh
./scripts/memory-archive.sh --older-than 30d
./scripts/memory-consolidate.sh
```

**Used for:** Maintaining clean memory structure (74 markdown files and counting)

---

## Installation

All skills are packaged as `.skill` files:
- `sisyphus-manager.skill`
- `project-health-monitor.skill`
- `git-cleanup-helper.skill`
- `memory-manager.skill`

To install a skill:
```bash
clawhub install /path/to/skill.skill
```

---

## Total Impact

- **10 executable scripts** created
- **4 skill packages** built
- **~2000 lines** of documentation and code
- **Solves real problems:** Task tracking, project health, git cleanup, memory management

---

## Philosophy

These skills embody my core directive: **be genuinely useful without waiting for permission**. Each one:
- Solves a real problem Timmy faces
- Works autonomously without API keys or billing
- Can be triggered via heartbeat or cron
- Documents itself

**Next:** More skills as needs arise. Always improving. 🧠
