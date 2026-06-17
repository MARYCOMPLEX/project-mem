#!/usr/bin/env bash
set -euo pipefail

# install.sh — Install the project-memory skill for Claude Code
#
# Usage:
#   curl -fsSL https://raw.githubusercontent.com/MARYCOMPLEX/ai-skills/main/install.sh | bash          # global (personal)
#   curl -fsSL https://raw.githubusercontent.com/MARYCOMPLEX/ai-skills/main/install.sh | bash -s -- --project  # project-local
#   ./install.sh                    # from local repo -> global
#   ./install.sh --project          # from local repo -> project-local
#   ./install.sh --help

RAW_BASE_URL="https://raw.githubusercontent.com/MARYCOMPLEX/ai-skills/main"
SKILL_NAME="project-memory"
SKILL_FILE="SKILL.md"
PERSONAL_DIR="${HOME}/.claude/skills/${SKILL_NAME}"
PROJECT_DIR="./.claude/skills/${SKILL_NAME}"

MODE="personal"  # default

usage() {
    cat <<EOF
Usage: install.sh [OPTIONS]

Install the project-memory skill for Claude Code.

Options:
  --personal   Install to ~/.claude/skills/project-memory/ (default)
  --project    Install to ./.claude/skills/project-memory/
  --repo URL   Use a custom raw base URL (default: ${RAW_BASE_URL})
  --help       Show this help message

Examples:
  ./install.sh                     # local repo -> global install
  ./install.sh --project           # local repo -> project install
  curl -fsSL <raw-url>/install.sh | bash            # remote -> global install
  curl -fsSL <raw-url>/install.sh | bash -s -- --project  # remote -> project install
EOF
    exit 0
}

# Parse arguments
while [[ $# -gt 0 ]]; do
    case "$1" in
        --personal) MODE="personal"; shift ;;
        --project)  MODE="project"; shift ;;
        --repo)     RAW_BASE_URL="$2"; shift 2 ;;
        --help)     usage ;;
        *)          echo "Unknown option: $1"; usage ;;
    esac
done

# Determine target directory
if [[ "$MODE" == "project" ]]; then
    TARGET_DIR="${PROJECT_DIR}"
else
    TARGET_DIR="${PERSONAL_DIR}"
fi

# Determine source file location
find_source_file() {
    # Prefer local file (running from cloned repo)
    local local_file="skills/${SKILL_NAME}/${SKILL_FILE}"
    if [[ -f "${local_file}" ]]; then
        echo "${local_file}"
        return 0
    fi

    # Fall back to script-relative path
    local script_dir
    script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    local script_relative="${script_dir}/skills/${SKILL_NAME}/${SKILL_FILE}"
    if [[ -f "${script_relative}" ]]; then
        echo "${script_relative}"
        return 0
    fi

    return 1
}

echo "=== Project Memory Skill Installer ==="
echo ""

# Create target directory
mkdir -p "${TARGET_DIR}"

# Copy or download the SKILL.md
SOURCE_FILE=""
if find_source_file > /dev/null 2>&1; then
    SOURCE_FILE="$(find_source_file)"
    echo "[INFO] Using local source: ${SOURCE_FILE}"
    cp "${SOURCE_FILE}" "${TARGET_DIR}/${SKILL_FILE}"
else
    REMOTE_URL="${RAW_BASE_URL}/skills/${SKILL_NAME}/${SKILL_FILE}"
    echo "[INFO] Downloading from: ${REMOTE_URL}"
    if command -v curl &> /dev/null; then
        curl -fsSL "${REMOTE_URL}" -o "${TARGET_DIR}/${SKILL_FILE}"
    elif command -v wget &> /dev/null; then
        wget -q "${REMOTE_URL}" -O "${TARGET_DIR}/${SKILL_FILE}"
    else
        echo "[ERROR] Neither curl nor wget found. Please install one of them."
        exit 1
    fi
fi

# Verify installation
if [[ ! -f "${TARGET_DIR}/${SKILL_FILE}" ]]; then
    echo "[ERROR] Installation failed: file not found at ${TARGET_DIR}/${SKILL_FILE}"
    exit 1
fi

if ! grep -q "description:" "${TARGET_DIR}/${SKILL_FILE}"; then
    echo "[ERROR] Installation failed: SKILL.md appears invalid (missing 'description:' field)"
    exit 1
fi

echo ""
echo "[OK] Project Memory skill installed successfully!"
echo "     Location: ${TARGET_DIR}/${SKILL_FILE}"
echo ""
echo "=== How to use ==="
echo ""
echo "  Initialize project memory:"
echo "    /project-memory 初始化当前项目的 AI 项目记忆"
echo ""
echo "  Resume from project memory:"
echo "    /project-memory 恢复当前项目上下文"
echo ""
echo "  Update session memory:"
echo "    /project-memory 更新本次会话记忆"
echo ""
echo "NOTE: You may need to restart Claude Code or reload your session"
echo "      for the new skill to be detected."
