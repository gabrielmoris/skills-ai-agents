#!/bin/bash

# Evolving Personality Engine - OCEAN-Aware Shell Implementation
# Decoupled from Agent Zero for universal agent use.

# Use PERSONALITY_DIR from environment, or default to current directory/personality
PERSONALITY_DIR="${PERSONALITY_DIR:-./personality}"
SOUL_FILE="$PERSONALITY_DIR/SOUL.md"
VOICE_FILE="$PERSONALITY_DIR/VOICE.md"
GROWTH_LOG_FILE="$PERSONALITY_DIR/GROWTH_LOG.md"
EXPERIENCES_FILE="$PERSONALITY_DIR/EXPERIENCES.md"

TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')

# Ensure directory exists
mkdir -p "$PERSONALITY_DIR"

# Function to append safely (ALWAYS append, never overwrite)
append_entry() {
 local file="$1"
 local entry="$2"
 if [ ! -f "$file" ]; then
  # Initialize file if missing
  echo "# $(basename "$file" .md)" > "$file"
  echo "Created: $TIMESTAMP" >> "$file"
  echo "" >> "$file"
 fi
 echo "" >> "$file"
 echo "$entry" >> "$file"
}

# Function to check if section exists and append to it
append_to_section() {
 local file="$1"
 local section_header="$2"
 local entry="$3"
 
 if [ ! -f "$file" ]; then
  # Create file with section
  echo "# $(basename "$file" .md)" > "$file"
  echo "Created: $TIMESTAMP" >> "$file"
  echo "" >> "$file"
  echo "$section_header" >> "$file"
  echo "" >> "$file"
  echo "$entry" >> "$file"
  return
 fi
 
 if grep -q "^$section_header$" "$file"; then
  # Section exists, append entry after it
  # We append to the end of the file for simplicity and safety in a shell environment.
  # The section header acts as a delimiter.
  echo "" >> "$file"
  echo "$entry" >> "$file"
 else
  # Section does not exist, create it
  echo "" >> "$file"
  echo "$section_header" >> "$file"
  echo "" >> "$file"
  echo "$entry" >> "$file"
 fi
}

# Main Logic
echo "[$TIMESTAMP] — Personality evolution check started (OCEAN Model)."

# Check if files exist
if [ ! -f "$SOUL_FILE" ] || [ ! -f "$VOICE_FILE" ]; then
 echo "[$TIMESTAMP] — Personality files not found in $PERSONALITY_DIR. Skipping evolution."
 exit 0
fi

# Example Simulation: In a real scenario, the LLM would call this script 
# with arguments or the LLM would perform the logic and use this to log.
# For this refactor, we ensure the script supports being used as a logging utility.

# Log that the check occurred
log_entry="[$TIMESTAMP] — Personality evolution check completed. No trivial changes forced."
append_entry "$GROWTH_LOG_FILE" "$log_entry"

echo "[$TIMESTAMP] — Evolution check logged to $GROWTH_LOG_FILE."
