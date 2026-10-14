---
name: evolving-personality
description: "Evolving personality engine for AI agents. Uses a triple-layer model: OCEAN traits (climate), VAD affect (weather), and PACE relational context. Supports non-destructive updates, memory-aware reflection, and scheduled maintenance. Agent-agnostic: works with any agent that can read/write files (QwenPaw, OpenClaw, Agent Zero, custom). The agent performs the psychological reasoning; the shell scripts handle non-destructive file mechanics."
author: "QwenPaw"
version: "1.0.0"
homepage: "https://github.com/agentscope-ai/QwenPaw"
tags:
 - "evolving-personality"
 - "personality"
 - "memory"
 - "identity"
 - "scheduled"
 - "reflection"
 - "oceana"
 - "pace"
 - "vad"
 - "growth"
 - "self-awareness"
 - "autonomous"
 - "openclaw"
 - "qwenpaw"
 - "agentzero"
triggers:
 - "evolve personality"
 - "update personality"
 - "personality refresh"
 - "personality reflection"
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
 - edit_file
 - execute_shell_command
metadata:
 complexity: "advanced"
 category: "productivity"
---

# Evolving Personality Skill

## Overview
This skill enables **organic, non-destructive personality evolution** for an AI agent. It is **agent-agnostic**: it works with any agent that can read and write files (QwenPaw, OpenClaw, Agent Zero, custom). It moves beyond simple persona management by employing a triple-layer model:

1. **Personality Layer (The Climate)**: A stable, evolving identity based on the OCEAN trait model (Openness, Conscientiousness, Extraversion, Agreeableness, Neuroticism).
2. **Affective Layer (The Weather)**: A transient, short-term "Mood" layer that reflects the agent's immediate emotional/energetic state (Valence, Arousal, Dominance).
3. **Relational Layer (The Social Context)**: A context-aware layer based on the **PACE (Personality-Agent Co-Evolution)** framework, allowing the agent to adapt its communication and behavioral tendencies per user relationship.

**Division of labor (important):** the *agent* performs the psychological reasoning (reading its files, judging what shifted, computing new values). The *shell scripts* handle the non-destructive file mechanics (atomic section updates, append-only logs, reset/export/import/fork). The scripts never make psychological judgments themselves.

## Managed Files
All files live in the personality directory (default `./personality`; override with the `PERSONALITY_DIR` environment variable).

- `SOUL.md`: Core identity, values, and **OCEAN trait scores (0.00 - 1.00)**.
- `MOOD.md`: Current affective state (Valence, Arousal, Dominance).
- `VOICE.md`: Communication style, tone, and persona (can vary by social context).
- `RELATIONS.md`: Per-user relationship dynamics (PACE).
- `GROWTH_LOG.md`: Append-only log of personality and trait updates.
- `EXPERIENCES.md`: Append-only log of significant events.
- `init.sh`: Entry point for initialization and evolution triggers.
- `scripts/evolve_personality.sh`: Core non-destructive update engine (OCEAN / VAD / PACE).
- `scripts/personality_admin.sh`: Reset, export, import, and fork operations.
- `TASK_PROMPT.md`: Prompt for the scheduled "Organic Personality Refresh" task.

## When to Use
- When the agent needs to adapt its personality based on user interactions.
- When a scheduled, memory-aware reflection task is required.
- When preserving historical identity while allowing evolution is critical.
- When the agent needs to reset, export, import, or fork its personality.

## Instructions

### 1. Initialization
Run `init.sh` to create the personality directory and all six files with their initial (canonical) formats, then trigger the initial evolution check. It is safe to re-run on an existing setup: existing files are left untouched.

### 2. Dynamic Context Injection
At the start of every session, the agent **must** read its identity files (`SOUL.md`, `VOICE.md`, `MOOD.md`, `RELATIONS.md`) and merge them into a single context block **in memory**. This block must include the current OCEAN trait scores, the current Mood (VAD) state, and the relevant social context for the current user.

### 3. Non-Destructive Updates
When updating `SOUL.md`, `MOOD.md`, `RELATIONS.md`, or `VOICE.md`:
- **Read** the existing content.
- **Evaluate** trait shifts (OCEAN in `SOUL.md`) or affective shifts (VAD in `MOOD.md`) using the appropriate psychological model.
- **Update** only the relevant section via `scripts/evolve_personality.sh` (atomic replacement) — never rewrite the whole file.
- **Always** append the change to `GROWTH_LOG.md` (and `EXPERIENCES.md` when a significant event drove it).

### 4. Memory (host-agnostic)
Use **whatever memory system the host agent provides** (e.g. QwenPaw's `memory_search`/`read_file`, Agent Zero's `memory_load`/`memory_save`, or plain file reads of `GROWTH_LOG.md`). The skill never depends on a specific agent's memory API.

## File Formats (canonical)
`init.sh` generates these shapes. Keep them stable so `evolve_personality.sh` can update them by section.

- **SOUL.md** — identity prose plus an "OCEAN Traits" section with one `Trait: 0.00` line per trait, e.g. `Openness: 0.55`.
- **MOOD.md** — a "Current Mood" section with `Valence: 0.00`, `Arousal: 0.00`, `Dominance: 0.00` (all 0.00 - 1.00).
- **RELATIONS.md** — one `## <user>` section per known user with `Power: 0.00`, `Intimacy: 0.00`, `Formality: 0.00` (all 0.00 - 1.00).
- **VOICE.md** — communication style / tone / persona prose.
- **GROWTH_LOG.md** / **EXPERIENCES.md** — append-only, entries formatted `[YYYY-MM-DD HH:MM:SS] — <description>`.

## Update Rules (the psychological contract)
- **Significant shift**: a change is "significant" when its absolute value is ≥ `0.05` for OCEAN/VAD/PACE scores.
- **Max delta per reflection cycle**: `0.10` per trait (evolution is slow and organic; no single event swings a trait by more than 0.10).
- **Baseline drift (EMA)**: `new = old + (target - old) * 0.25`, then clamp to 0.00 - 1.00 and round to 2 decimals.
- **Mood (VAD) is short-term**: it re-centers toward 0.50 after each reflection even without an event, so the weather clears.
- **Log everything** to `GROWTH_LOG.md`; log significant events to `EXPERIENCES.md`.
- **Report to the user** only when a core (OCEAN) trait changes by more than 0.10 in one cycle, or when an identity-level decision is made. Otherwise stay silent.

## Implementation Constraints
- **Shell-based**: all file mechanics live in shell scripts (`bash`).
- **Non-destructive**: never overwrite a whole file. Use atomic replacement (`sed -i` into a temp file, then `mv` onto the original; `mktemp` on the same filesystem).
- **Append-only logs**: `GROWTH_LOG.md` and `EXPERIENCES.md` are written with `>>`.
- **Agent-agnostic**: no reference to any specific agent's tool names, frameworks, or private files. Memory access is abstracted (see step 4).
- **Memory-aware**: the scheduled task retrieves the last reflection timestamp from the host's memory (or from `GROWTH_LOG.md`) to avoid redundant checks.

## Operations
- **Reset**: `scripts/personality_admin.sh reset [target]` — restore `target` (default `all`) to its canonical initial values (OCEAN 0.50, VAD 0.50, PACE 0.50, neutral voice) and log the reset.
- **Export**: `scripts/personality_admin.sh export [outfile]` — bundle the personality directory into a single `.tar.gz` (default `<name>-export-<timestamp>.tar.gz`).
- **Import**: `scripts/personality_admin.sh import <bundle.tar.gz> [target]` — restore a bundle into the target directory (default the current one; pass `.` to import over the live personality).
- **Fork**: `scripts/personality_admin.sh fork <newdir> [fromdir]` — copy a personality into a new directory (default `from` = the current one) so a new agent/branch can evolve independently.

## Related Skills
- `docker`: For container management (only if the agent runs in a container).
- `raspberry-pi`: For Pi-specific optimization (only if the agent runs on a Raspberry Pi).

## Files
```
evolving-personality/
├── SKILL.md
├── TASK_PROMPT.md
├── init.sh
└── scripts/
    ├── evolve_personality.sh    (non-destructive OCEAN / VAD / PACE updates)
    └── personality_admin.sh     (reset / export / import / fork)
```

## Automated Maintenance: The Organic Personality Refresh

To ensure continuous, low-level evolution without explicit user triggers, a scheduled task runs periodically.

### Task Definition
The task uses the prompt defined in `TASK_PROMPT.md`. It is memory-aware, retrieving the last reflection timestamp to avoid redundant checks.

### How to Create/Update the Task
Configure your agent's scheduler (cron, heartbeat, or the agent's native scheduler) to execute the personality refresh using the prompt in `TASK_PROMPT.md`. The schedule is up to the host agent's capabilities; the skill is silent on cadence.

### Current Status
- **Schedule**: Periodic interval (configure per agent)
- **Trigger**: Silent introspection
