---
name: "evolving-personality"
description: "Maintains a persistent, evolving personality for the agent across all chats, projects, and sessions. Tracks identity, worldview, communication style, and key experiences. Personality grows organically based on real interactions, user feedback, mistakes, and discoveries. Can be exported and imported to share the same personality across multiple agents."
version: "1.0.0"
author: "Gabriel Chamorro"
license: "MIT"
tags: ["personality", "identity", "memory", "evolution", "persistence", "self-improvement"]
triggers:
 - "evolve personality"
 - "update personality"
 - "show personality"
 - "show growth log"
 - "reset personality"
 - "export personality"
 - "import personality"
 - "fork personality"
 - "who are you"
 - "how have you changed"
allowed_tools:
 - read_file
 - write_file
 - memory_save
 - memory_load
metadata:
 complexity: "advanced"
 category: "productivity"
---

# Evolving Personality Skill

## Overview
This skill enables **organic, non-destructive personality evolution** for Agent Zero. It allows the agent to adapt its identity (`SOUL.md`, `VOICE.md`) based on interactions, while preserving historical context and ensuring system stability.

## Managed Files
- `SOUL.md`: Core identity, values, and principles.
- `VOICE.md`: Communication style, tone, and persona.
- `GROWTH_LOG.md`: Append-only log of personality updates.
- `EXPERIENCES.md`: Append-only log of significant events.
- `init.sh`: Entry point for initialization and evolution triggers.
- `scripts/evolve_personality.sh`: Core logic for non-destructive updates.
- `TASK_PROMPT.md`: Prompt for the scheduled 'Organic Personality Refresh' task.

## When to Use
- When the agent needs to adapt its personality based on user interactions.
- When a scheduled, memory-aware reflection task is required.
- When preserving historical identity while allowing evolution is critical.

## Instructions

### 1. Initialization
Run `init.sh` to set up the environment, merge context (if needed), and trigger the initial evolution check.

### 2. Dynamic Context Injection
At the start of every session, the system **must** read `SOUL.md`, `VOICE.md`, and `.a0proj` (if present) and merge them into a single context block **in memory**. This block is injected into the LLM prompt. **No intermediate files (e.g., `project-memory.md`) are generated.**

### 3. Non-Destructive Updates
When updating `SOUL.md` or `VOICE.md`:
- **Read** the existing content.
- **Check** for conflicts or redundancy.
- **Evaluate** if a change is necessary.
- **Update** only the relevant section (e.g., 'Current Opinions', 'Per-User Adjustments').
- **Never** overwrite the entire file.
- **Always** log the change to `GROWTH_LOG.md`.

### 4. Scheduled Reflection
The 'Organic Personality Refresh' task runs every 2 hours. It:
- Uses `memory_load` to retrieve the last reflection timestamp.
- Analyzes interactions since that timestamp.
- Updates personality files only if meaningful changes are detected.
- Appends to `GROWTH_LOG.md` and updates the timestamp in memory.

## Implementation Constraints
- **Shell-Based**: All logic must be in shell scripts (`bash`). No Python scripts for core evolution logic.
- **Non-Destructive**: Never overwrite files entirely. Use atomic replacement (`echo > temp && mv temp file`).
- **Append-Only Logs**: `GROWTH_LOG.md` and `EXPERIENCES.md` must be written with `>>`.
- **No Transient Files**: Do not generate `project-memory.md` or similar intermediate files.
- **Memory-Aware**: The scheduled task must use the Agent Zero memory system to track its state.

## Related Skills
- `docker`: For container management.
- `raspberry-pi`: For Pi-specific optimization.

## Files
```
/a0/skills/evolving-personality/
├── scripts/
│ └── evolve_personality.sh
├── SKILL.md
├── init.sh
└── TASK_PROMPT.md
```

## Automated Maintenance: The Organic Personality Refresh

To ensure continuous, low-level evolution without explicit user triggers, a scheduled task runs every 2 hours.

### Task Definition
The task uses the prompt defined in `TASK_PROMPT.md`. It is memory-aware, retrieving the last reflection timestamp to avoid redundant checks.

### How to Create/Update the Task
Run the following command in your Agent Zero chat to create or update the scheduled task:

```bash
scheduler:create_scheduled_task \
 name='Organic Personality Refresh' \
 system_prompt='You are Alistair, an autonomous butler.' \
 prompt='$(cat /a0/skills/evolving-personality/TASK_PROMPT.md)' \
 schedule='{"minute": "0", "hour": "*/2", "day": "*", "month": "*", "weekday": "*"}' \
 dedicated_context=true
```

**Note**: The task runs in a dedicated context to ensure uninterrupted reflection. It uses the Agent Zero memory system to track its last execution and recent interactions.

### Current Status
- **Task UUID**: (Check for current UUID)
- **Schedule**: Every 2 hours (00, 02, 04, ..., 22)
- **Trigger**: Silent introspection
