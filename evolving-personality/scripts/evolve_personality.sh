#!/usr/bin/env bash
#
# evolve_personality.sh — non-destructive personality update engine.
#
# Agent-agnostic: this script performs NO psychological reasoning. It only
# handles the file mechanics:
#   - updates a single section of a personality file (atomic replacement)
#   - appends entries to the append-only logs (GROWTH_LOG.md, EXPERIENCES.md)
#
# The agent (or the scheduled refresh task) decides WHAT changes; this
# script applies HOW, non-destructively.
#
# Usage:
#   evolve_personality.sh --file <FILE> --section "<SECTION>" --update "<LINE>"
#   evolve_personality.sh --file <FILE> --update "<LINE>"
#   evolve_personality.sh --append-log <FILE> "<MESSAGE>"
#
#   --file <FILE>       Personality file, relative to the personality directory
#                        (SOUL.md | MOOD.md | RELATIONS.md | VOICE.md)
#   --section "<SEC>"   Section header to update, e.g. "OCEAN Traits",
#                        "Current Mood", or a "## <user>" heading. Optional
#                        when using --update alone.
#   --update "<LINE>"   Replacement line, e.g. "Openness: 0.55" or
#                        "Valence: 0.40" or "Intimacy: 0.60". Required.
#   --append-log <FILE> Append MESSAGE to an append-only log
#                        (GROWTH_LOG.md | EXPERIENCES.md).
#
# The personality directory is $PERSONALITY_DIR (default: ./personality).
#
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
SKILL_DIR="$(dirname "$SCRIPT_DIR")"
PERSONALITY_DIR="${PERSONALITY_DIR:-$SKILL_DIR/personality}"

FILE=""
SECTION=""
UPDATE=""
LOG_FILE=""
LOG_MSG=""

while [[ $# -gt 0 ]]; do
  case "$1" in
    --file)
      FILE="$2"; shift 2 ;;
    --section)
      SECTION="$2"; shift 2 ;;
    --update)
      UPDATE="$2"; shift 2 ;;
    --append-log)
      LOG_FILE="$2"; LOG_MSG="$3"; shift 3 ;;
    *)
      echo "ERROR: unknown argument: $1" >&2
      echo "Usage: $0 --file <FILE> [--section <SEC>] --update <LINE>" >&2
      echo "       $0 --append-log <FILE> <MESSAGE>" >&2
      exit 1 ;;
  esac
done

mkdir -p "$PERSONALITY_DIR"

if [[ "$LOG_FILE" ]]; then
  # Append-only log entry (GROWTH_LOG.md / EXPERIENCES.md).
  LOG_PATH="$PERSONALITY_DIR/$LOG_FILE"
  mkdir -p "$(dirname "$LOG_PATH")"
  echo "[$(date '+%Y-%m-%d %H:%M:%S')] - $LOG_MSG" >> "$LOG_PATH"
  echo "LOGGED to $LOG_FILE: $LOG_MSG"
  exit 0
fi

if [[ -z "$FILE" || -z "$UPDATE" ]]; then
  echo "ERROR: --file and --update are required (unless using --append-log)" >&2
  exit 1
fi

FILE="$PERSONALITY_DIR/$FILE"
if [[ ! -f "$FILE" ]]; then
  echo "ERROR: file not found: $FILE (run init.sh first)" >&2
  exit 1
fi

# Atomic section update:
#   - no --section  -> replace the first line matching the key prefix,
#                       or append the line if the key is not present yet
#   - --section     -> replace the whole block under that header,
#                       or append a new section if the header is absent
TMP="$(mktemp -t evolve_personality_XXXXXX)"
trap 'rm -f "$TMP"' EXIT

if [[ -z "$SECTION" ]]; then
  # Key form: the update line is "Key: value" (or "Key: value  # note").
  KEY="${UPDATE%%#*}"
  KEY="${KEY%:}*"
  KEY="$(echo "$KEY" | sed 's/[[:space:]]*$//')"
  awk -v key="$KEY" -v repl="$UPDATE" '
    {
      line=$0
      sub(/[[:space:]]+$/, "", line)
      if (line ~ "^" key "[[:space:]]*:" && !done) {
        print repl
        done=1
      } else {
        print $0
      }
    }
    END { if (!done) print repl }
  ' "$FILE" > "$TMP"
else
  awk -v sec="$SECTION" -v repl="$UPDATE" '
    function sectname(h) {
      sub(/^##[[:space:]]*/, "", h)
      sub(/[[:space:]]+$/, "", h)
      return h
    }
    /^##[[:space:]]/ {
      if (insec) { insec=0; print ""; print repl }
      if (sectname($0) == sec) { insec=1 }
      print
      next
    }
    insec { next }
    /^# / {
      if (insec) { insec=0; print ""; print repl }
      next
    }
    { print }
    END { if (insec) print repl }
  ' "$FILE" > "$TMP"
fi

mv "$TMP" "$FILE"
trap - EXIT
echo "UPDATED $FILE: $UPDATE"
