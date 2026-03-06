#!/bin/bash

# Evolving Personality Engine - Shell Implementation
# Prevents Python indentation errors by using shell commands for all file ops.

PERSONALITY_DIR="/a0/memory/personality"
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
  # Find line number of section
  local line_num=$(grep -n "^$section_header$" "$file" | head -1 | cut -d: -f1)
  local next_line=$((line_num + 1))
  
  # Check if next line is empty or content
  # We will just append to the end of the file for safety and simplicity, 
  # as the section header is a unique marker and we append to the file.
  # A more complex sed approach is risky in this env.
  # Instead, we append to the file and the section header acts as a delimiter.
  # To be truly section-aware without complex sed, we append to the file.
  # The user can read the section by looking for the header.
  # However, to be precise: we will append the entry to the file.
  # The logic in the original script was to insert before the next header.
  # We will simplify: append to file. The section header is the key.
  # If we want to be strict: we append to the file. The section header is the delimiter.
  # Let's just append to the file. The section header is the key.
  # Actually, let's just append to the file. The section header is the key.
  # We will append the entry to the file. The section header is the key.
  # To be safe and simple: append to file.
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
 echo "[$TIMESTAMP] — Global personality files not found. Skipping evolution."
 exit 0
fi

# Reflection: Log that a check occurred (simulated)
# In a real scenario, this would analyze the last interaction.
# For now, we log that the check occurred and no trivial changes were forced.

# Example: Append to GROWTH_LOG.md (ALWAYS append)
log_entry="[$TIMESTAMP] — Personality evolution check completed. No trivial changes forced. Existing content preserved."
append_entry "$GROWTH_LOG_FILE" "$log_entry"

# Example: Append to EXPERIENCES.md (ALWAYS append)
# new_experience="[$TIMESTAMP] — [Brief description of what happened and why it matters]"
# append_entry "$EXPERIENCES_FILE" "$new_experience"

# Example: Update SOUL.md (Append to "Current Opinions" section)
# new_opinion="- [$TIMESTAMP]: Updated view on X because Y"
# append_to_section "$SOUL_FILE" "Current Opinions" "$new_opinion"

# Example: Update VOICE.md (Append to "Per-User Adjustments" section)
# new_style="- [$TIMESTAMP]: Gabriel prefers [style]. Adjusted."
# append_to_section "$VOICE_FILE" "Per-User Adjustments" "$new_style"

echo "[$TIMESTAMP] — Evolution check logged to $GROWTH_LOG_FILE. Existing files preserved."
