#!/usr/bin/env bash

set -euo pipefail

INSTALL_DIR="$HOME/.claude/agents"
REPO_RAW="https://raw.githubusercontent.com/Codemode001/claude-agents/main/agents"
ALL_AGENTS=(bug-surgeon code-explainer codebase-explorer refactor-planner standup-writer ticket-planner)

# Detect whether we're running from a local clone or piped via curl
if [[ -n "${BASH_SOURCE[0]:-}" ]] && [[ -f "${BASH_SOURCE[0]}" ]]; then
  LOCAL_AGENTS_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/agents" && pwd)"
  MODE="local"
else
  MODE="remote"
fi

install_agent() {
  local name="$1"
  local dest="$INSTALL_DIR/${name}.md"

  if [[ "$MODE" == "local" ]]; then
    local src="$LOCAL_AGENTS_DIR/${name}.md"
    if [[ ! -f "$src" ]]; then
      echo "Error: agent '$name' not found." >&2
      echo "" >&2
      echo "Available agents:" >&2
      for a in "${ALL_AGENTS[@]}"; do echo "  $a" >&2; done
      exit 1
    fi
    cp "$src" "$dest"
  else
    local url="$REPO_RAW/${name}.md"
    if ! curl -fsSL "$url" -o "$dest" 2>/dev/null; then
      echo "Error: agent '$name' not found or download failed." >&2
      echo "" >&2
      echo "Available agents:" >&2
      for a in "${ALL_AGENTS[@]}"; do echo "  $a" >&2; done
      exit 1
    fi
  fi

  echo "  installed: $name"
}

mkdir -p "$INSTALL_DIR"

if [[ $# -eq 0 ]]; then
  echo "Installing all agents to $INSTALL_DIR ..."
  for name in "${ALL_AGENTS[@]}"; do
    install_agent "$name"
  done
  echo ""
  echo "Done. ${#ALL_AGENTS[@]} agents installed."
else
  install_agent "$1"
fi
