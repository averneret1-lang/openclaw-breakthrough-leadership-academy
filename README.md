# Breakthrough Leadership Transformation Academy — AI Agent System (OpenClaw)

Multi-agent AI system built on [OpenClaw](https://github.com/openclaw/openclaw) for BLTA operations. Five specialized agents powered by OpenAI GPT-4o, accessible via Telegram.

---

## Agents

| Agent | Role | Model |
|-------|------|-------|
| **eli** | Content — social posts, emails, seminar copy | gpt-4o-mini |
| **brandvoice** | Founder voice — landing pages, sales letters, speaker bio | gpt-4o |
| **marcus** | Communications — lead follow-up, nurture sequences, alumni outreach | gpt-4o-mini |
| **ezra** | Operations — seminar logistics, reminders, CRM hygiene | gpt-4o-mini |
| **legal** | Documents — contracts, waivers, policy templates, risk review | gpt-4o |

All agents run through a single Telegram bot, routed by OpenClaw's binding system.

---

## Prerequisites

- macOS 12+ or Ubuntu 20+
- Node.js 18+ (`node --version`)
- OpenAI API key — [platform.openai.com/api-keys](https://platform.openai.com/api-keys)
  - **Note:** Separate from your ChatGPT subscription. Pay-per-use API access.
- One Telegram bot — create via [@BotFather](https://t.me/BotFather)
- Your Telegram user ID — get from [@userinfobot](https://t.me/userinfobot)

---

## Installation

### 1. Clone the repo

```bash
git clone https://github.com/averneret1-lang/openclaw-breakthrough-leadership-academy
cd openclaw-breakthrough-leadership-academy
```

### 2. Run the installer

```bash
bash scripts/install.sh
```

The installer will:
- Install OpenClaw globally (`npm install -g openclaw`)
- Prompt for your OpenAI API key and Telegram bot token
- Copy `openclaw.json.example` to `~/.openclaw/openclaw.json`
- Set up agent workspaces at `~/.openclaw/blta/`
- Optionally register OpenClaw as a background daemon

### 3. Start OpenClaw

```bash
openclaw start
```

---

## Manual Setup

```bash
# Install OpenClaw
npm install -g openclaw@latest

# Set up config
cp openclaw.json.example ~/.openclaw/openclaw.json
# Edit ~/.openclaw/openclaw.json — add your Telegram bot token

# Set OpenAI key
openclaw config set providers.openai.apiKey YOUR_KEY

# Copy agent workspaces
for agent in eli brandvoice marcus ezra legal; do
  mkdir -p ~/.openclaw/blta/$agent
  cp workspace/$agent/AGENTS.md ~/.openclaw/blta/$agent/AGENTS.md
done

# Start
openclaw start
```

---

## How to Talk to Each Agent

OpenClaw routes your Telegram messages to agents based on the `accountId` binding. To address a specific agent, start your message with the agent's name:

```
eli: write 3 Instagram hooks about breaking through fear
brandvoice: draft a landing page intro in my voice
marcus: write a follow-up email for a lead who attended but didn't enroll
ezra: build a reminder sequence for a seminar on May 15th
legal: review this participant waiver [paste doc]
```

Or configure OpenClaw to set a default agent for your chat.

---

## Cost Estimate

| Agent | Model | Est. Monthly |
|-------|-------|-------------|
| eli | gpt-4o-mini | ~$8-12 |
| brandvoice | gpt-4o | ~$12-20 |
| marcus | gpt-4o-mini | ~$6-10 |
| ezra | gpt-4o-mini | ~$4-7 |
| legal | gpt-4o | ~$10-18 |
| **Total** | | **~$40-67/mo** |

See `docs/cost-breakdown.md` for full detail and ROI breakdown.

---

## Documentation

- [Setup Guide](docs/setup-guide.md) — step-by-step for non-technical users
- [Cost Breakdown](docs/cost-breakdown.md) — full cost model with ROI analysis
- [OpenClaw Docs](https://docs.openclaw.ai) — platform documentation
