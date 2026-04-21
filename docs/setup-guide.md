# Setup Guide — BLTA AI Agent System (OpenClaw)

Read this once before starting.

---

## What You're Setting Up

Five AI agents that live in Telegram — Eli, BrandVoice, Marcus, Ezra, and Legal. They all share one Telegram bot and OpenClaw routes your messages to the right agent based on how you address them.

Platform: **OpenClaw** — open source, runs on your Mac or Linux machine as a background service.

---

## Step 1 — Get Your OpenAI API Key

Your ChatGPT subscription does not give you API access. You need a separate key.

1. Go to [platform.openai.com](https://platform.openai.com)
2. Sign in (same email as ChatGPT is fine)
3. Click your profile icon → "API keys"
4. "Create new secret key" — copy it immediately
5. Under "Billing", add a payment method

Estimated monthly cost at BLTA's usage level: **$40-67**.

---

## Step 2 — Create a Telegram Bot

One bot handles all five agents.

1. Open Telegram, search for **@BotFather**
2. Send `/newbot`
3. Name it (e.g., "BLTA Assistant")
4. Username (e.g., "blta_assistant_bot") — must end in "bot"
5. BotFather gives you a token like `1234567890:AAFxxxxxx`
6. Copy it

---

## Step 3 — Install

Open Terminal and run:

```bash
git clone https://github.com/averneret1-lang/openclaw-breakthrough-leadership-academy
cd openclaw-breakthrough-leadership-academy
bash scripts/install.sh
```

The installer will ask for:
- Your OpenAI API key
- Your Telegram bot token

It installs OpenClaw globally, sets up your config, copies agent workspaces, and optionally registers the service to start automatically on login.

---

## Step 4 — Start OpenClaw

```bash
openclaw start
```

Check it's running:

```bash
openclaw status
```

---

## Step 5 — Test Your Agents

Open Telegram, find the bot you created, send `/start`, then try:

```
eli: write 3 Instagram hooks about transformation
marcus: draft a follow-up for a lead who went cold
ezra: create a reminder sequence for a seminar on [date]
legal: what clauses should I have in a participant waiver?
brandvoice: I'll paste some writing samples — then write a landing page intro
```

---

## Step 6 — Customize BrandVoice

BrandVoice needs actual writing samples before it can replicate the founder's voice. Open `~/.openclaw/blta/brandvoice/AGENTS.md` and paste 3-5 examples of the founder's writing in the designated section.

---

## Troubleshooting

**Bot doesn't respond:**
- Run `openclaw status` — check the gateway is running
- Check your Telegram bot token in `~/.openclaw/openclaw.json`
- Send `/start` to the bot first

**"Invalid API key" error:**
- Run `openclaw config set providers.openai.apiKey YOUR_KEY`
- Confirm your OpenAI account has a payment method

**Agent not routing correctly:**
- Make sure you're prefixing messages with the agent name (e.g., `eli: ...`)
- Check bindings in `~/.openclaw/openclaw.json`

**Restart after changes:**
```bash
openclaw restart
```

---

## Updating Agent Instructions

Each agent's behavior is controlled by its `AGENTS.md` file. To update:

1. Edit the file at `~/.openclaw/blta/[agent]/AGENTS.md`
2. Run `openclaw restart`
