#!/bin/bash
# BLTA AI Agent System — OpenClaw Installer
set -e

echo ""
echo "================================================="
echo "  BLTA AI Agent System — OpenClaw Installer"
echo "================================================="
echo ""

# ─── Prerequisites ────────────────────────────────────────────────────────────

echo "Checking prerequisites..."

if ! command -v node &>/dev/null; then
  echo "ERROR: Node.js is not installed. Install it from https://nodejs.org (v18+)"
  exit 1
fi

NODE_VERSION=$(node -v | sed 's/v//' | cut -d. -f1)
if [ "$NODE_VERSION" -lt 18 ]; then
  echo "ERROR: Node.js v18+ required. You have $(node -v). Upgrade at https://nodejs.org"
  exit 1
fi

echo "Node $(node -v) — OK"

# ─── Install OpenClaw ─────────────────────────────────────────────────────────

if ! command -v openclaw &>/dev/null; then
  echo ""
  echo "Installing OpenClaw globally..."
  npm install -g openclaw@latest
  echo "OpenClaw installed."
else
  echo "OpenClaw $(openclaw --version 2>/dev/null || echo '') — already installed"
fi

# ─── Environment Setup ────────────────────────────────────────────────────────

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

if [ ! -f "$SCRIPT_DIR/.env" ]; then
  cp "$SCRIPT_DIR/.env.example" "$SCRIPT_DIR/.env"
  echo ""
  echo "Created .env from .env.example"
fi

echo ""
echo "Enter your credentials (press Enter to skip and fill in manually later):"
echo ""

read -p "Telegram bot token (from @BotFather): " TG_TOKEN
if [ -n "$TG_TOKEN" ]; then
  sed -i.bak "s|TELEGRAM_BOT_TOKEN=.*|TELEGRAM_BOT_TOKEN=$TG_TOKEN|" "$SCRIPT_DIR/.env"
fi

rm -f "$SCRIPT_DIR/.env.bak"

# Source the env
set -a
source "$SCRIPT_DIR/.env"
set +a

# ─── OpenClaw Config ──────────────────────────────────────────────────────────

OPENCLAW_HOME="${OPENCLAW_HOME:-$HOME/.openclaw}"
mkdir -p "$OPENCLAW_HOME"

CONFIG_FILE="$OPENCLAW_HOME/openclaw.json"

if [ ! -f "$CONFIG_FILE" ]; then
  # Copy example config and inject token
  CONFIG=$(cat "$SCRIPT_DIR/openclaw.json.example")
  if [ -n "$TG_TOKEN" ]; then
    CONFIG=$(echo "$CONFIG" | sed "s|\"botToken\": \"\"|\"botToken\": \"$TG_TOKEN\"|")
  fi
  echo "$CONFIG" > "$CONFIG_FILE"
  echo "Created $CONFIG_FILE"
else
  echo "openclaw.json already exists — skipping (edit manually if needed)"
fi

# ─── Workspace Setup ─────────────────────────────────────────────────────────

echo ""
echo "Setting up agent workspaces..."

BLTA_WORKSPACE="$OPENCLAW_HOME/blta"

for agent in eli brandvoice marcus ezra legal; do
  DEST="$BLTA_WORKSPACE/$agent"
  mkdir -p "$DEST"
  if [ ! -f "$DEST/AGENTS.md" ]; then
    cp "$SCRIPT_DIR/workspace/$agent/AGENTS.md" "$DEST/AGENTS.md"
    echo "  Created workspace for $agent"
  else
    echo "  $agent workspace already exists — skipping"
  fi
done

# ─── OpenAI Auth (OAuth) ──────────────────────────────────────────────────────

echo ""
echo "OpenClaw uses OAuth for OpenAI authentication."
echo "The next step will open a browser to log you in to your OpenAI account."
echo ""
read -p "Authenticate with OpenAI now? [Y/n] " AUTH_NOW
if [[ ! "$AUTH_NOW" =~ ^[Nn]$ ]]; then
  openclaw auth login 2>/dev/null || openclaw onboard 2>/dev/null || \
    echo "  Run 'openclaw onboard' manually to authenticate."
fi

# ─── Start Daemon ─────────────────────────────────────────────────────────────

echo ""
read -p "Install OpenClaw as a background daemon (auto-starts on login)? [y/N] " INSTALL_DAEMON
if [[ "$INSTALL_DAEMON" =~ ^[Yy]$ ]]; then
  openclaw onboard --install-daemon 2>/dev/null || openclaw daemon install 2>/dev/null || \
    echo "  Run 'openclaw onboard --install-daemon' manually to set up auto-start."
fi

# ─── Done ─────────────────────────────────────────────────────────────────────

echo ""
echo "================================================="
echo "  Installation complete!"
echo "================================================="
echo ""
echo "To start OpenClaw:"
echo "  openclaw start"
echo ""
echo "To check status:"
echo "  openclaw status"
echo ""
echo "Docs:"
echo "  Setup guide:    docs/setup-guide.md"
echo "  Cost breakdown: docs/cost-breakdown.md"
echo ""
echo "Your 5 agents are ready:"
echo "  eli          — content creation"
echo "  brandvoice   — founder voice"
echo "  marcus       — communications"
echo "  ezra         — operations"
echo "  legal        — document review"
echo ""
