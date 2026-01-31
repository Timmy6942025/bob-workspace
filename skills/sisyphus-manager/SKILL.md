---
name: sisyphus-manager
description: Manage and track .sisyphus task management system. Read plans, track progress, check evidence, and summarize active work. Use when working with projects that have a .sisyphus/ folder, tracking development tasks, or monitoring project progress.
---

# Sisyphus Manager

Manage Timmy's .sisyphus task tracking system across projects.

## What is .sisyphus?

A lightweight task management system using markdown files and JSON tracking:
- `boulder.json` - Active plan and session tracking
- `plans/` - Markdown plan files with detailed task breakdowns
- `evidence/` - Screenshots and progress evidence
- `notepads/` - Learnings and notes

## Capabilities

### Read Active Plan
Parse the current boulder.json to understand:
- Which plan is active
- When work started
- Associated session IDs

### Parse Plan Files
Read and understand .md plan files:
- Task breakdowns with dependencies
- Time estimates
- Acceptance criteria
- Wave/phase organization

### Check Evidence
List and track evidence files:
- Screenshots captured
- Uncommitted evidence
- Progress documentation

### Summarize Progress
Generate summaries of:
- Current active tasks
- Completed work
- Remaining work
- Time estimates

## Usage

### Check project status
```bash
./scripts/sisyphus-status.sh /path/to/project
```

### Read active plan
```bash
./scripts/sisyphus-read-plan.sh /path/to/project
```

### List evidence
```bash
./scripts/sisyphus-evidence.sh /path/to/project
```

## Project Structure

When you see a `.sisyphus/` folder in a project:

```
.sisyphus/
├── boulder.json          # Active plan tracking
├── plans/                # Plan markdown files
│   ├── plan-name.md
│   └── another-plan.md
├── evidence/             # Screenshots, outputs
└── notepads/             # Learnings, notes
    └── plan-name/
        └── learnings.md
```

## Integration with Work

Always check for .sisyphus when:
1. Starting work on a project
2. Reporting progress to Timmy
3. Understanding project scope
4. Tracking what's been done vs remaining

## Resources

### scripts/
- `sisyphus-status.sh` - Project status summary
- `sisyphus-read-plan.sh` - Parse and display active plan
- `sisyphus-evidence.sh` - List evidence files
