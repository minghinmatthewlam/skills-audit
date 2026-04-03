#!/usr/bin/env bash

set -euo pipefail

usage() {
  cat <<'EOF'
Usage:
  ./scripts/sync-from-agent-guards.sh --source /path/to/agent-guards [--check]

Options:
  --source PATH   Path to the agent-guards repo that owns the canonical skill
  --check         Exit non-zero if mirrored files differ from the source
  -h, --help      Show this help text
EOF
}

source_repo=""
check_only=0

while [[ $# -gt 0 ]]; do
  case "$1" in
    --source)
      [[ $# -ge 2 ]] || {
        echo "--source requires a path" >&2
        exit 2
      }
      source_repo="$2"
      shift 2
      ;;
    --check)
      check_only=1
      shift
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      echo "Unknown argument: $1" >&2
      usage >&2
      exit 2
      ;;
  esac
done

[[ -n "$source_repo" ]] || {
  echo "--source is required" >&2
  usage >&2
  exit 2
}

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source_skill_dir="$source_repo/skills/skills-audit"

[[ -f "$source_skill_dir/SKILL.md" ]] || {
  echo "Missing source skill file: $source_skill_dir/SKILL.md" >&2
  exit 1
}

[[ -d "$source_skill_dir/references" ]] || {
  echo "Missing source references directory: $source_skill_dir/references" >&2
  exit 1
}

check_diff() {
  local status=0

  if ! diff -u "$source_skill_dir/SKILL.md" "$repo_root/SKILL.md"; then
    status=1
  fi

  if ! diff -ru "$source_skill_dir/references" "$repo_root/references"; then
    status=1
  fi

  return "$status"
}

if [[ "$check_only" -eq 1 ]]; then
  if check_diff; then
    echo "skills-audit mirror is up to date."
    exit 0
  fi

  echo "skills-audit mirror is out of date." >&2
  exit 1
fi

mkdir -p "$repo_root/references"

skill_changes="$(rsync -ai "$source_skill_dir/SKILL.md" "$repo_root/")"
ref_changes="$(rsync -ai --delete "$source_skill_dir/references/" "$repo_root/references/")"

if [[ -z "$skill_changes" && -z "$ref_changes" ]]; then
  echo "skills-audit mirror already up to date."
  exit 0
fi

echo "Synced files:"
if [[ -n "$skill_changes" ]]; then
  printf '%s\n' "$skill_changes"
fi
if [[ -n "$ref_changes" ]]; then
  printf '%s\n' "$ref_changes"
fi
