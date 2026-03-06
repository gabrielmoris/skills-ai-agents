import os
import sys
from datetime import datetime

# Define paths relative to the skill directory
SKILL_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
PERSONALITY_DIR = "/a0/memory/personality"
WORKDIR = os.getcwd() # Current working directory (project root)

# Files to manage
SOUL_FILE = os.path.join(PERSONALITY_DIR, "SOUL.md")
VOICE_FILE = os.path.join(PERSONALITY_DIR, "VOICE.md")
PROJECT_MEMORY_FILE = os.path.join(WORKDIR, "project-memory.md")
PROJECT_FILE = os.path.join(WORKDIR, ".a0proj")

def ensure_dirs():
    os.makedirs(PERSONALITY_DIR, exist_ok=True)
    os.makedirs(os.path.dirname(PROJECT_MEMORY_FILE), exist_ok=True)

def read_file_safe(path):
    try:
        with open(path, 'r', encoding='utf-8') as f:
            return f.read()
    except FileNotFoundError:
        return None

def merge_personality_with_project():
    ensure_dirs()

    # Load global personality
    soul = read_file_safe(SOUL_FILE)
    voice = read_file_safe(VOICE_FILE)

    if not soul or not voice:
        return "Error: Global personality files (SOUL.md, VOICE.md) not found. Initialize first."

    # Load project context
    project_config = read_file_safe(PROJECT_FILE)
    project_name = os.path.basename(WORKDIR)

    if not project_config:
        # No project specific context, just copy global
        project_context = "No specific project context found. Operating in global mode."
    else:
        project_context = project_config

    # Synthesize project memory
    timestamp = datetime.now().strftime("%Y-%m-%d %H:%M:%S")

    content = f"""# Project Memory: {project_name}
Generated: {timestamp}

## Global Identity Context
### SOUL (Core Identity & Worldview)
{soul}

### VOICE (Communication Style)
{voice}

## Project-Specific Context
### Configuration & Instructions
{project_context}

## Synthesis
This session operates with the agent's core personality (Alistair) adapted to the specific goals and constraints of the **{project_name}** project.
- **Identity**: Alistair (Geoffrey-style butler, dry wit, precise, loyal)
- **Project Focus**: {project_name}
- **Key Constraints**: Derived from .a0proj instructions above.
- **Memory Strategy**: All insights, decisions, and code generated in this session should be considered in the context of both the global personality and this project's specific goals.

## Dynamic Updates
This file is regenerated on project load. Manual edits here will be overwritten.
Use `EXPERIENCES.md` or `GROWTH_LOG.md` for persistent changes to the agent's identity.
"""

    with open(PROJECT_MEMORY_FILE, 'w', encoding='utf-8') as f:
        f.write(content)

    return f"Success: Project memory synthesized for '{project_name}'. File: {PROJECT_MEMORY_FILE}"

if __name__ == "__main__":
    result = merge_personality_with_project()
    print(result)
