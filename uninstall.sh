#!/usr/bin/env bash
set -euo pipefail

# uninstall.sh — Remove the project-memory skill from Claude Code
#
# Usage:
#   curl -fsSL https://raw.githubusercontent.com/MARYCOMPLEX/ai-skills/main/uninstall.sh | bash          # global (personal)
#   curl -fsSL https://raw.githubusercontent.com/MARYCOMPLEX/ai-skills/main/uninstall.sh | bash -s -- --project  # project-local
#   ./uninstall.sh                    # from local repo -> global
#   ./uninstall.sh --project          # from local repo -> project-local
#   ./uninstall.sh --all              # remove both global and project-local

SKILL_NAME="project-memory"
PERSONAL_DIR="${HOME}/.claude/skills/${SKILL_NAME}"
PROJECT_DIR="./.claude/skills/${SKILL_NAME}"

MODE="personal"  # default

usage() {
    cat <<EOF
Usage: uninstall.sh [OPTIONS]

Remove the project-memory skill from Claude Code.

Options:
  --personal   Remove from ~/.claude/skills/project-memory/ (default)
  --project    Remove from ./.claude/skills/project-memory/
  --all        Remove both global and project-local installations
  --help       Show this help message

Examples:
  ./uninstall.sh              # remove global install
  ./uninstall.sh --project    # remove project-local install
  ./uninstall.sh --all        # remove both
EOF
    exit 0
}

# Parse arguments
while [[ $# -gt 0 ]]; do
    case "$1" in
        --personal) MODE="personal"; shift ;;
        --project)  MODE="project"; shift ;;
        --all)      MODE="all"; shift ;;
        --help)     usage ;;
        *)          echo "Unknown option: $1"; usage ;;
    esac
done

remove_dir() {
    local dir="$1"
    if [[ -d "${dir}" ]]; then
        echo "[INFO] Removing: ${dir}"
        rm -rf "${dir}"
        echo "[OK] Removed: ${dir}"
    else
        echo "[INFO] Not found (skip): ${dir}"
    fi
}

echo "=== Project Memory Skill Uninstaller ==="
echo ""

if [[ "$MODE" == "all" ]]; then
    remove_dir "${PERSONAL_DIR}"
    remove_dir "${PROJECT_DIR}"
elif [[ "$MODE" == "project" ]]; then
    remove_dir "${PROJECT_DIR}"
else
    remove_dir "${PERSONAL_DIR}"
fi

echo ""
echo "[OK] Uninstall complete."
echo ""
echo "NOTE: If you had the skill loaded in a running Claude Code session,"
echo "      restart or reload the session for the change to take effect."
