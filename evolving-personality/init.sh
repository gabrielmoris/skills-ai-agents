#!/bin/bash
# Organic Personality Initialization & Evolution Script (Dynamic Context Version)
# This script:
# 1. Triggers a reflection to evolve the global personality based on recent interactions.
# 2. Acts as a heartbeat for the scheduled system.
# Note: Context injection (merging SOUL/VOICE with .a0proj) now happens dynamically
# at the start of every session via the Agent Zero framework, not via a file.

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SH_EVO="${SCRIPT_DIR}/scripts/evolve_personality.sh"

echo "🧠 Initializing Organic Personality & Evolution (Dynamic Context Mode)..."

# Step 1: Trigger Evolution (Global Update)
# This is the primary function of the scheduled task.
if [ -f "$SH_EVO" ]; then
 echo "🔄 Checking for personality evolution opportunities..."
 # Pass a generic trigger message for the scheduled run
 bash "$SH_EVO" "System check: Scheduled evolution trigger."
 if [ $? -eq 0 ]; then
 echo "✅ Evolution process complete."
 else
 echo "⚠️ Warning: Evolution script failed."
 fi
else
 echo "❌ Error: evolve_personality.sh not found at $SH_EVO"
fi

# Step 2: Heartbeat
# Log that the system is alive and ready for dynamic context injection.
echo "🎩 Alistair is ready. Context will be injected dynamically at session start."
