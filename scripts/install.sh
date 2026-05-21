#!/usr/bin/env bash
# install.sh — installs consult-kit into the current repository
# Usage:
#   ./install.sh            first install
#   ./install.sh --update   update an existing install (preserves outputs/)

set -euo pipefail

# ── Configuration ────────────────────────────────────────────────────────────
REPO_URL="https://github.com/YOUR_USERNAME/consult-kit"
BRANCH="main"
# ─────────────────────────────────────────────────────────────────────────────

UPDATE=false
if [[ "${1:-}" == "--update" ]]; then
  UPDATE=true
fi

# ── Helpers ───────────────────────────────────────────────────────────────────
green()  { echo -e "\033[0;32m$1\033[0m"; }
yellow() { echo -e "\033[0;33m$1\033[0m"; }
red()    { echo -e "\033[0;31m$1\033[0m"; }
step()   { echo -e "\n\033[1m$1\033[0m"; }

# ── Preflight ─────────────────────────────────────────────────────────────────
step "Checking dependencies..."

if ! command -v git &>/dev/null; then
  red "Error: git is required but not installed."
  exit 1
fi

if [[ "$REPO_URL" == *"YOUR_USERNAME"* ]]; then
  red "Error: REPO_URL has not been configured."
  yellow "Edit the REPO_URL variable at the top of this script before running."
  exit 1
fi

# ── Download ──────────────────────────────────────────────────────────────────
step "Downloading consult-kit from GitHub..."

TEMP_DIR=$(mktemp -d)
trap 'rm -rf "$TEMP_DIR"' EXIT

git clone --depth 1 --branch "$BRANCH" "$REPO_URL" "$TEMP_DIR" --quiet
green "  Downloaded successfully."

# ── Install kit files ─────────────────────────────────────────────────────────
step "Installing kit files..."

# These are always overwritten — they are the tool itself
cp -r "$TEMP_DIR/.consult-kit" .
green "  .consult-kit/ → updated"

cp -r "$TEMP_DIR/.github" .
green "  .github/ → updated"

cp -r "$TEMP_DIR/providers" .
green "  providers/ → updated"

# README only on first install
if [[ ! -f README.md ]] || [[ "$UPDATE" == false ]]; then
  cp "$TEMP_DIR/README.md" . 2>/dev/null || true
  green "  README.md → installed"
fi

# ── Output directories ────────────────────────────────────────────────────────
step "Setting up output directories..."

mkdir -p outputs/audit outputs/estimate

if [[ ! -f outputs/audit/.gitkeep ]]; then
  touch outputs/audit/.gitkeep
  green "  outputs/audit/ → created"
else
  green "  outputs/audit/ → already exists, skipped"
fi

if [[ ! -f outputs/estimate/.gitkeep ]]; then
  touch outputs/estimate/.gitkeep
  green "  outputs/estimate/ → created"
else
  green "  outputs/estimate/ → already exists, skipped"
fi

# ── .gitignore ────────────────────────────────────────────────────────────────
step "Checking .gitignore..."

GITIGNORE_BLOCK="# consult-kit outputs
outputs/audit/*
outputs/estimate/*
!outputs/audit/.gitkeep
!outputs/estimate/.gitkeep"

if [[ ! -f .gitignore ]]; then
  cp "$TEMP_DIR/.gitignore" .
  green "  .gitignore → created"
elif ! grep -q "consult-kit outputs" .gitignore; then
  echo "" >> .gitignore
  echo "$GITIGNORE_BLOCK" >> .gitignore
  green "  .gitignore → consult-kit rules appended"
else
  green "  .gitignore → already contains consult-kit rules, skipped"
fi

# ── Done ──────────────────────────────────────────────────────────────────────
echo ""
green "✅ consult-kit installed successfully."
echo ""
echo "  Copilot:    @engagement-orchestrator"
echo "  Claude Code: /engagement"
echo ""
echo "  Describe the client project and brief to get started."