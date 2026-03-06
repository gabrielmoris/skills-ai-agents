import os
import sys
from datetime import datetime
import re

PERSONALITY_DIR = "/a0/memory/personality"
SOUL_FILE = os.path.join(PERSONALITY_DIR, "SOUL.md")
VOICE_FILE = os.path.join(PERSONALITY_DIR, "VOICE.md")
GROWTH_LOG_FILE = os.path.join(PERSONALITY_DIR, "GROWTH_LOG.md")
EXPERIENCES_FILE = os.path.join(PERSONALITY_DIR, "EXPERIENCES.md")

def ensure_dirs():
    os.makedirs(PERSONALITY_DIR, exist_ok=True)

def read_file_safe(path):
    try:
        with open(path, "r", encoding="utf-8") as f:
            return f.read()
    except FileNotFoundError:
        return None

def append_to_file(path, text):
    ensure_dirs()
    with open(path, "a", encoding="utf-8") as f:
        f.write(text + "\n")

def update_section_in_file(path, section_header, new_entry):
    """Reads file, finds section, appends new entry to it, and writes back."""
    content = read_file_safe(path)
    if not content:
        append_to_file(path, f"{section_header}\n\n{new_entry}")
        return

    # Find the section
    pattern = re.compile(rf"^{re.escape(section_header)}$", re.MULTILINE)
    match = pattern.search(content)
    
    if match:
        # Find the end of the section (next header or end of file)
        next_header_start = match.end()
        lines_content = content[next_header_start:].splitlines()
        insert_pos = next_header_start
        
        for i, line in enumerate(lines_content):
            # Check for next header (e.g., "##" or "###")
            if line.strip().startswith("#") and not line.strip().startswith("# "):
                # Found next header
                insert_pos = next_header_start + sum(len(l)+1 for l in lines_content[:i])
                break
        
        # Insert the new entry before the next header
        new_content = content[:insert_pos] + "\n" + new_entry + "\n" + content[insert_pos:]
        with open(path, "w", encoding="utf-8") as f:
            f.write(new_content)
    else:
        # Section not found, append at end
        append_to_file(path, f"\n{section_header}\n\n{new_entry}")

def evolve_personality():
    timestamp = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    
    # Read current files
    soul_content = read_file_safe(SOUL_FILE)
    voice_content = read_file_safe(VOICE_FILE)
    
    if not soul_content or not voice_content:
        print("Global personality files not found. Skipping evolution.")
        return
    
    # SIMULATED REFLECTION: In a real scenario, this would analyze the last interaction
    # For now, we log that the check occurred and no trivial changes were forced.
    
    # Example of APPENDING to EXPERIENCES.md (ALWAYS append):
    # new_experience = f"[{timestamp}] — [Brief description of what happened and why it matters]"
    # append_to_file(EXPERIENCES_FILE, new_experience)
    
    # Example of APPENDING to GROWTH_LOG.md (ALWAYS append):
    log_entry = f"[{timestamp}] — Personality evolution check completed. No trivial changes forced. Existing content preserved."
    append_to_file(GROWTH_LOG_FILE, log_entry)
    
    # Example of UPDATING SOUL.md (Append to "Current Opinions" section):
    # new_opinion = f"- [{timestamp}]: Updated view on X because Y"
    # update_section_in_file(SOUL_FILE, "Current Opinions", new_opinion)
    
    # Example of UPDATING VOICE.md (Append to "Per-User Adjustments" section):
    # new_style = f"- [{timestamp}]: Gabriel prefers [style]. Adjusted."
    # update_section_in_file(VOICE_FILE, "Per-User Adjustments", new_style)
    
    print(f"Evolution check logged to {GROWTH_LOG_FILE}. Existing files preserved.")

if __name__ == "__main__":
    evolve_personality()