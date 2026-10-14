#!/bin/bash

# Evolving Personality Engine - Generic Shell Implementation
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
  # Note: We append to the end of the file for safety and simplicity.
  # The section header acts as a marker for the agent to find content.
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
echo "[$TIMESTAMP] — Personality evolution check started."

# Check if files exist
if [ ! -f "$SOUL_FILE" ] || [ ! -f "$VOICE_FILE" ]; then
 echo "[$TIMESTAMP] — Personality files not found in $PERSONALITY_DIR. Skipping evolution."
 exit 0
fi

# Log the check
log_entry="[$TIMESTAMP] — Personality evolution check completed. No trivial changes forced."
append_entry "$GROWTH_LOG_FILE" "$log_entry"

echo "[$TIMESTAMP] — Evolution check logged to $GROWTH_LOG_FILE."
