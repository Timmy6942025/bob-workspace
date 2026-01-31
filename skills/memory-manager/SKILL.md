---
name: memory-manager
description: Manage and consolidate memory files. Archive old daily notes, update MEMORY.md with important learnings, and maintain clean memory structure. Use when reviewing memory files, consolidating daily notes, or maintaining long-term memory.
---

# Memory Manager

Manage OpenClaw memory files and maintain clean long-term memory.

## What it Does

- Consolidates daily memory files into MEMORY.md
- Archives old daily notes
- Identifies important learnings worth keeping
- Maintains memory directory structure
- Prevents memory bloat

## Usage

### Review and consolidate
```bash
./scripts/memory-consolidate.sh
```

### Archive old daily files
```bash
./scripts/memory-archive.sh --older-than 30d
```

### Check memory health
```bash
./scripts/memory-status.sh
```

## Memory Structure

```
memory/
├── 2026-01-31.md     # Daily notes (raw)
├── 2026-02-01.md     # Daily notes (raw)
└── archive/          # Old daily notes (auto-moved)
    └── 2026-01/
        └── 2026-01-15.md
```

## Consolidation Rules

**Keep in MEMORY.md:**
- Important decisions and their rationale
- Key learnings and insights
- Project status changes
- New skills or capabilities
- Boundary/priority changes
- Significant events

**Archive (don't keep):**
- Routine status checks
- Minor updates
- Temporary issues
- Exploration notes
- Duplicate information

## Resources

### scripts/
- `memory-consolidate.sh` - Review and consolidate daily notes
- `memory-archive.sh` - Archive old daily files
- `memory-status.sh` - Show memory directory status
