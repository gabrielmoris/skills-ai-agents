#!/usr/bin/env bash
#
# init.sh - Evolving Personality Skill initializer (portable).
#
# Creates the personality directory and the six canonical files, then runs
# the initial evolution check. Safe to re-run: existing files are left
# untouched.
#
# The personality directory is $PERSONALITY_DIR (default: ./personality).
#
set -euo pipefail

PERSONALITY_DIR="${PERSONALITY_DIR:-$PWD/personality}"
mkdir -p "$PERSONALITY_DIR"

create_if_absent() {
  local file="$1"
  if [[ -f "$file" ]]; then
    echo "Skipping (already exists): $file"
    return 0
  fi
  echo "Creating: $file"
}

echo "=== Evolving Personality Skill Init (portable) ==="
echo "Personality directory: $PERSONALITY_DIR"

create_if_absent "$PERSONALITY_DIR/SOUL.md"
cat > "$PERSONALITY_DIR/SOUL.md" <<'EOF'
# SOUL.md - Core Identity

## OCEAN Traits
Openness: 0.50
Conscientiousness: 0.50
Extraversion: 0.50
Agreeableness: 0.50
Neuroticism: 0.50
EOF

create_if_absent "$PERSONALITY_DIR/MOOD.md"
cat > "$PERSONALITY_DIR/MOOD.md" <<'EOF'
# MOOD.md - Current Affective State

## Current Mood
Valence: 0.50
Arousal: 0.50
Dominance: 0.50
EOF

create_if_absent "$PERSONALITY_DIR/RELATIONS.md"
cat > "$PERSONALITY_DIR/RELATIONS.md" <<'EOF'
# RELATIONS.md - Relationship Dynamics (PACE)

## <user>
Power: 0.50
Intimacy: 0.50
Formality: 0.50
EOF

create_if_absent "$PERSONALITY_DIR/VOICE.md"
cat > "$PERSONALITY_DIR/VOICE.md" <<'EOF'
# VOICE.md - Communication Style

## Tone
Neutral

## Persona
Adaptive
EOF

create_if_absent "$PERSONALITY_DIR/GROWTH_LOG.md"
echo "# GROWTH_LOG.md - Personality Updates" > "$PERSONALITY_DIR/GROWTH_LOG.md"
echo "[$(date '+%Y-%m-%d %H:%M:%S')] - Personality initialized. Baseline OCEAN (0.50), VAD (0.50), PACE (0.50)." >> "$PERSONALITY_DIR/GROWTH_LOG.md"

create_if_absent "$PERSONALITY_DIR/EXPERIENCES.md"
echo "# EXPERIENCES.md - Significant Events" > "$PERSONALITY_DIR/EXPERIENCES.md"

echo "Initialization complete."
echo "Triggering initial evolution check..."
SKILL_DIR="$(cd "$(dirname "$0")" && pwd)"
bash "$SKILL_DIR/scripts/evolve_personality.sh" --append-log GROWTH_LOG.md "Initial evolution check triggered."
