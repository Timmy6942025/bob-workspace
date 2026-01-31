---
name: git-cleanup-helper
description: Helper scripts for git cleanup - stash, auto-commit, check status. Use when projects have uncommitted changes that need organizing, before switching branches, or when cleaning up workspace.
---

# Git Cleanup Helper

Quick helpers for common git cleanup tasks.

## Capabilities

### Smart Auto-Commit
Automatically commit uncommitted changes with descriptive messages based on file types:
- Code changes → "Update [file types]"
- Documentation → "Update documentation"
- Config files → "Update configuration"
- Mixed changes → "Update project files"

### Safe Stash
Stash changes with descriptive names including timestamp.

### Status Summary
Quick overview of what needs attention across projects.

## Usage

### Auto-commit changes
```bash
./scripts/auto-commit.sh /path/to/project
```

### Stash with description
```bash
./scripts/smart-stash.sh /path/to/project "work-in-progress"
```

### Check what needs cleanup
```bash
./scripts/cleanup-status.sh /path/to/projects
```

## Safety

- Always shows what will be committed before doing it
- Requires confirmation for large changes (>50 files)
- Won't auto-commit if untracked files present (unless --include-untracked)
- Creates meaningful commit messages based on changes

## Resources

### scripts/
- `auto-commit.sh` - Smart auto-commit with descriptive messages
- `smart-stash.sh` - Stash with timestamp and description
- `cleanup-status.sh` - Summary of projects needing cleanup
