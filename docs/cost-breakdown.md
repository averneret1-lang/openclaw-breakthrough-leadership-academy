# Cost Breakdown — BLTA AI Agent System (OpenClaw)

Honest numbers. No surprises.

---

## Monthly API Costs

Pay-per-use (OpenAI API). Not a subscription.

| Agent | Model | Low | Normal | Heavy |
|-------|-------|-----|--------|-------|
| eli | gpt-4o-mini | $5 | $10 | $15 |
| brandvoice | gpt-4o | $8 | $15 | $25 |
| marcus | gpt-4o-mini | $4 | $8 | $12 |
| ezra | gpt-4o-mini | $2 | $5 | $8 |
| legal | gpt-4o | $6 | $12 | $20 |
| **Total** | | **~$25** | **~$50** | **~$80** |

Normal = daily tasks, moderate volume, typical seminar cycle.
Heavy = active launch month, multiple seminars, high content output.

---

## OpenClaw vs ClaudeClaw (Same Agents)

| | ClaudeClaw | OpenClaw |
|-|------------|----------|
| Light agents | Claude Haiku | gpt-4o-mini |
| Heavy agents | Claude Sonnet | gpt-4o |
| Est. monthly | $75-95 | $40-67 |
| Savings | — | ~$35-40/mo |

Same agents, same roles, ~40% lower API spend.

---

## ROI

At $50/month:

| Task | Hours Saved/Mo | Value (@$50/hr) |
|------|---------------|-----------------|
| Content creation (Eli) | ~20 hrs | $1,000 |
| Lead follow-up (Marcus) | ~14 hrs | $700 |
| Seminar logistics (Ezra) | ~10 hrs | $500 |
| Legal document prep (Legal) | ~6 hrs | $300 |
| Brand copy (BrandVoice) | ~8 hrs | $400 |
| **Total** | **~58 hrs** | **~$2,900/mo** |

**~58x ROI.** Pays for itself in the first hour of use every month.

---

## Scaling (If Costs Exceed $100/mo)

Add a Mac Mini M4 (16GB, ~$700 one-time) and run lighter agents on local Ollama models:

- Eli + Ezra → `llama3.2:3b` or `gemma3:4b` — free
- Marcus → `mistral:7b` — free
- Keep BrandVoice + Legal on GPT-4o for quality

Hybrid target cost: **~$25-35/mo** (BrandVoice + Legal only on API).
Mac Mini payback: ~10 months vs. full API.

---

## What You Don't Pay For

- OpenClaw platform — open source, free
- Telegram — free
- Local storage — runs on your machine
