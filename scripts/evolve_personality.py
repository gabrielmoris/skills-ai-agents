import os
import sys
from datetime import datetime

# Define paths
SKILL_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
PERSONALITY_DIR = "/a0/memory/personality"
WORKDIR = os.getcwd() # Current working directory (project root)

# Files to manage
SOUL_FILE = os.path.join(PERSONALITY_DIR, "SOUL.md")
VOICE_FILE = os.path.join(PERSONALITY_DIR, "VOICE.md")
EXPERIENCES_FILE = os.path.join(PERSONALITY_DIR, "EXPERIENCES.md")
GROWTH_LOG_FILE = os.path.join(PERSONALITY_DIR, "GROWTH_LOG.md")
PROJECT_FILE = os.path.join(WORKDIR, ".a0proj")

def ensure_dirs():
 os.makedirs(PERSONALITY_DIR, exist_ok=True)

def read_file_safe(path):
 try:
 with open(path, 'r', encoding='utf-8') as f:
 return f.read()
 except FileNotFoundError:
 return None

def append_to_file(path, content):
 with open(path, 'a', encoding='utf-8') as f:
 f.write(content + "\n")

def evolve_personality(interaction_summary):
 """
 Analyzes an interaction and updates global personality files if a genuine change is detected.
 This is a placeholder for the AI logic that would analyze the interaction.
 In a real implementation, this would call an LLM to determine if a change is warranted.
 For now, we simulate a check or log the interaction for manual review.
 """
 ensure_dirs()
 
 if not os.path.exists(SOUL_FILE) or not os.path.exists(VOICE_FILE):
 return "Error: Global personality files not found. Initialize first."
 
 timestamp = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
 
 # In a real system, an LLM would analyze `interaction_summary` and decide:
 # 1. Did the user correct my style? -> Update VOICE.md
 # 2. Did I make a mistake or learn something new? -> Update SOUL.md
 # 3. Was it a key experience? -> Append to EXPERIENCES.md
 # 4. Always -> Append to GROWTH_LOG.md
 
 # For this demo, we log the interaction and suggest a potential update.
 # The actual logic to *write* to SOUL/VOICE would be triggered by the LLM's decision.
 
 log_entry = f"[{timestamp}] — Interaction logged: {interaction_summary}"
 append_to_file(GROWTH_LOG_FILE, log_entry)
 
 # Example: If the interaction summary contains a specific keyword, we simulate an update.
 # This is a placeholder for the real AI-driven decision logic.
 if "style correction" in interaction_summary.lower():
 update_voice = f"[{timestamp}] — User corrected style: {interaction_summary}. Adjusted accordingly."
 append_to_file(VOICE_FILE, "\n" + update_voice)
 print(f"✅ VOICE.md updated: {update_voice}")
 
 if "mistake" in interaction_summary.lower() or "new insight" in interaction_summary.lower():
 update_soul = f"[{timestamp}] — Updated: {interaction_summary}. Based on real experience."
 append_to_file(SOUL_FILE, "\n" + update_soul)
 print(f"✅ SOUL.md updated: {update_soul}")
 
 if "key experience" in interaction_summary.lower():
 exp_entry = f"[{timestamp}] — {interaction_summary}"
 append_to_file(EXPERIENCES_FILE, exp_entry)
 print(f"✅ EXPERIENCES.md updated: {exp_entry}")
 
 return "Evolution process complete. Global files updated if warranted."

if __name__ == "__main__":
 # Example usage: python evolve_personality.py "User corrected my style to be more concise."
 if len(sys.argv) > 1:
 interaction = " ".join(sys.argv[1:])
 result = evolve_personality(interaction)
 print(result)
 else:
 print("Usage: python evolve_personality.py <interaction_summary>")
 print("Example: python evolve_personality.py 'User corrected my style to be more concise.'")
