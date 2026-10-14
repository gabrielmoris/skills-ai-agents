---
name: "evolving-personality"
description: "Maintains a persistent, evolving personality for the agent across all chats, projects, and sessions. Tracks identity, worldview, communication style, and key experiences. Personality grows organically based on real interactions, user feedback, mistakes, and discoveries. Can be exported and imported to share the same personality across multiple agents."
version: "1.1.0"
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
This skill enables **organic, non-destructive personality evolution** for an AI agent. It allows the agent to adapt its identity (stored in files like `SOUL.md`, `VOICE.md`) based on interactions, while preserving historical context and ensuring system stability.

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
At the start of every session, the agent **must** read its identity files (e.g., `SOUL.md`, `VOICE.md`) and merge them into a single context block **in memory**. This block is injected into the LLM prompt.

### 3. Non-Destructive Updates
When updating `SOUL.md` or `VOICE.md`:
- **Read** the existing content.
- **Check** for conflicts or redundancy.
- **Evaluate** if a change is necessary.
- **Update** only the relevant section (e.g., 'Current Opinions', 'Per-User Adjustments').
- **Never** overwrite the entire file.
- **Always** log the change to `GROWTH_LOG.md`.

## Implementation Constraints
- **Shell-Based**: All logic must be in shell scripts (`bash`).
- **Non-Destructive**: Never overwrite files entirely. Use atomic replacement (`echo > temp && mv temp file`).
- **Append-Only Logs**: `GROWTH_LOG.md` and `EXPERIENCES.md` must be written with `>>`.
- **Memory-Aware**: The scheduled task must use the agent's available memory system to track its state.

## Related Skills
- `docker`: For container management.
- `raspberry-pi`: For Pi-specific optimization.

## Files
```
/skills/evolving-personality/
├── scripts/
│ └── evolve_personality.sh
├── SKILL.md
├── init.sh
└── TASK_PROMPT.md
```

## Automated Maintenance: The Organic Personality Refresh

To ensure continuous, low-level evolution without explicit user triggers, a scheduled task runs periodically.

### Task Definition
The task uses the prompt defined in `TASK_PROMPT.md`. It is memory-aware, retrieving the last reflection timestamp to avoid redundant checks.

### How to Create/Update the Task
Configure your agent's scheduler to execute the personality refresh using the prompt in `TASK_PROMPT.md`.

### Current Status
- **Schedule**: Periodic interval (Configure based on agent capabilities)
- **Trigger**: Silent introspection
