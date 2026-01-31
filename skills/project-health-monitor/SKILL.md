---
name: project-health-monitor
description: Monitor health of all projects - git status, disk usage, uncommitted changes, test status. Use when checking project status, monitoring multiple repositories, or identifying projects needing attention.
---

# Project Health Monitor

Monitor the health and status of all development projects.

## What it Monitors

### Git Status
- Uncommitted changes
- Unpushed commits
- Branch status
- Last commit date

### Project Metadata
- Presence of .sisyphus task tracking
- Test availability
- Documentation completeness
- Disk usage per project

### Health Indicators
- 🟢 Healthy: Clean working tree, recent activity
- 🟡 Attention: Uncommitted changes, stale branches
- 🔴 Critical: Large uncommitted work, very old commits

## Usage

### Check all projects
```bash
./scripts/project-health-all.sh /path/to/projects
```

### Check single project
```bash
./scripts/project-health.sh /path/to/single-project
```

### Check with details
```bash
./scripts/project-health-all.sh /path/to/projects --detailed
```

## Output Format

```
📊 Project Health Report
========================

🟢 encyphrix-pro
   Clean | Last commit: 2 hours ago | .sisyphus ✓

🟡 bugchat
   3 uncommitted | Last commit: 3 days ago | No .sisyphus

🔴 polymr
   12 uncommitted + 2 untracked | Last commit: 2 weeks ago
```

## Resources

### scripts/
- `project-health-all.sh` - Check all projects in directory
- `project-health.sh` - Check single project
