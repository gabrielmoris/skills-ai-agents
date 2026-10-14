#!/usr/bin/env bash
#
# personality_admin.sh — reset / export / import / fork for a personality.
#
# Agent-agnostic: operates on a directory of Markdown files. The personality
# directory is $PERSONALITY_DIR (default: <skill>/personality) unless a
# target directory is passed explicitly.
#
# Usage:
#   personality_admin.sh reset  [target]     # canonical initial values
#   personality_admin.sh export  [outfile]   # bundle the personality (.tar.gz)
#   personality_admin.sh import  <bundle> [target]
#   personality_admin.sh fork    <newdir> [fromdir]
#
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
SKILL_DIR="$(dirname "$SCRIPT_DIR")"
DEFAULT_DIR="${PERSONALITY_DIR:-$SKILL_DIR/personality}"

canon_soul() {
  cat <<'EOF'
# SOUL.md - Core Identity

## OCEAN Traits
Openness: 0.50
Conscientiousness: 0.50
Extraversion: 0.50
Agreeableness: 0.50
Neuroticism: 0.50
EOF
}

canon_mood() {
  cat <<'EOF'
# MOOD.md - Current Affective State

## Current Mood
Valence: 0.50
Arousal: 0.50
Dominance: 0.50
EOF
}

canon_relations() {
  cat <<'EOF'
# RELATIONS.md - Relationship Dynamics (PACE)

## <user>
Power: 0.50
Intimacy: 0.50
Formality: 0.50
EOF
}

canon_voice() {
  cat <<'EOF'
# VOICE.md - Communication Style

## Tone
Neutral

## Persona
Adaptive
EOF
}

canon_logs() {
  echo "# GROWTH_LOG.md - Personality Updates"
}

canon_experiences() {
  echo "# EXPERIENCES.md - Significant Events"
}

cmd_reset() {
  local target="${1:-$DEFAULT_DIR}"
  mkdir -p "$target"
  canon_soul      > "$target/SOUL.md"
  canon_mood      > "$target/MOOD.md"
  canon_relations > "$target/RELATIONS.md"
  canon_voice     > "$target/VOICE.md"
  canon_logs      > "$target/GROWTH_LOG.md"
  canon_experiences > "$target/EXPERIENCES.md"
  echo "[$(date '+%Y-%m-%d %H:%M:%S')] - Personality reset to canonical initial values." >> "$target/GROWTH_LOG.md"
  echo "Reset complete: $target"
}

cmd_export() {
  local target="${1:-$DEFAULT_DIR}"
  local outfile="${2:-$(basename "$target")-export-$(date '+%Y%m%d-%H%M%S').tar.gz}"
  local parent; parent="$(dirname "$target")"
  local name; name="$(basename "$target")"
  tar -czf "$parent/$outfile" -C "$parent" "$name"
  echo "Exported: $parent/$outfile"
}

cmd_import() {
  local bundle="${1:-}"
  local target="${2:-$DEFAULT_DIR}"
  if [[ -z "$bundle" ]]; then
    echo "ERROR: import requires a bundle file" >&2
    exit 1
  fi
  mkdir -p "$target"
  tar -xzf "$bundle" -C "$target"
  echo "Imported: $bundle -> $target"
}

cmd_fork() {
  local newdir="${1:-}"
  local fromdir="${2:-$DEFAULT_DIR}"
  if [[ -z "$newdir" ]]; then
    echo "ERROR: fork requires a target directory" >&2
    exit 1
  fi
  mkdir -p "$newdir"
  cp -r "$fromdir/." "$newdir/"
  echo "Forked: $fromdir -> $newdir"
}

case "${1:-}" in
  reset)  cmd_reset  "${2:-}" ;;
  export) cmd_export "${2:-}" "${3:-}" ;;
  import) cmd_import "${2:-}" "${3:-}" ;;
  fork)   cmd_fork   "${2:-}" "${3:-}" ;;
  *)
    echo "Usage: $0 reset|export|import|fork [args]" >&2
    exit 1 ;;
esac
