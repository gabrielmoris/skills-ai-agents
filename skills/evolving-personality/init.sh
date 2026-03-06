#!/bin/bash
# Organic Personality Initialization Script
# This script merges global personality (SOUL.md, VOICE.md) with project context (.a0proj)
# to generate a dynamic project-memory.md for the current session.

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PYTHON_SCRIPT="${SCRIPT_DIR}/scripts/project_memory_init.py"

echo "🧠 Initializing Organic Personality for current project..."

if [ ! -f "$PYTHON_SCRIPT" ]; then
 echo "❌ Error: project_memory_init.py not found at $PYTHON_SCRIPT"
 exit 1
fi

python3 "$PYTHON_SCRIPT"

if [ $? -eq 0 ]; then
 echo "✅ Organic personality initialized successfully."
 echo "📄 Generated: $(pwd)/project-memory.md"
else
 echo "❌ Failed to initialize personality."
 exit 1
fi
