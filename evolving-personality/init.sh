#!/bin/bash
# Organic Personality Initialization & Evolution Script
# This script:
# 1. Merges global personality with project context (for session awareness).
# 2. Triggers a reflection to evolve the global personality based on recent interactions.

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PYTHON_INIT="${SCRIPT_DIR}/scripts/project_memory_init.py"
PYTHON_EVO="${SCRIPT_DIR}/scripts/evolve_personality.py"

echo "🧠 Initializing Organic Personality & Evolution..."

# Step 1: Initialize Project Context (if needed)
if [ -f "$PYTHON_INIT" ]; then
 echo "📄 Generating project-memory.md for context..."
 python3 "$PYTHON_INIT"
 if [ $? -ne 0 ]; then
  echo "⚠️ Warning: Project memory generation failed (missing .a0proj?). Continuing..."
 fi
else
 echo "❌ Error: project_memory_init.py not found at $PYTHON_INIT"
fi

# Step 2: Trigger Evolution (Global Update)
# Note: In a real system, this would be called with a summary of the last interaction.
# For now, we run it with a placeholder or let the user pass arguments.
if [ -f "$PYTHON_EVO" ]; then
 echo "🔄 Checking for personality evolution opportunities..."
 # Example: python3 "$PYTHON_EVO" "User corrected style to be more concise."
 # If no argument is passed, it logs a generic entry.
 python3 "$PYTHON_EVO" "System check: Scheduled evolution trigger."
 if [ $? -eq 0 ]; then
  echo "✅ Evolution process complete."
 else
  echo "⚠️ Warning: Evolution script failed."
 fi
else
 echo "❌ Error: evolve_personality.py not found at $PYTHON_EVO"
fi

echo "🎩 Alistair is ready."
