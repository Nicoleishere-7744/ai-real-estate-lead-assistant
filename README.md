# Atlas Property Group — AI Real Estate Lead Assistant

English-market demo of an AI lead qualification and viewing-request assistant for real estate agencies.

## Stack
n8n · OpenAI · Supabase · Telegram · HTML/JavaScript · Ruflo (development/orchestration)

## Capabilities
- Handles buying, renting, selling, and investment inquiries
- Captures location, property type, budget, bedrooms, size, financing, and contact details
- Detects viewing intent and high-intent leads
- Stores and updates lead history in Supabase
- Sends qualified leads to agents via Telegram
- Prevents duplicate notifications
- Avoids inventing listings, prices, mortgage terms, or live availability

## Files
- `workflow/atlas-property-ai-lead-assistant-en.json` — n8n workflow, credentials removed
- `setup/supabase.sql` — database schema
- `demo/index.html` — English live-demo frontend
- `ruflo/SETUP.md` — Ruflo setup instructions
- `ruflo/PROJECT_AGENT_SPEC.md` — project-specific multi-agent responsibilities and QA gates
- `ruflo/bootstrap-ruflo.ps1` — optional Windows PowerShell bootstrap

## Runtime architecture

```text
Website demo
   ↓
n8n webhook
   ↓
AI conversation + structured lead extraction
   ↓
Supabase lead memory/history
   ↓
Qualification / handoff gates
   ↓
Telegram sales notification (once per actionable lead)
```

Ruflo does **not** replace the production n8n webhook in this version. It is added as the agent orchestration layer for development, testing, security review, prompt refinement, and future multi-agent expansion.

## Quick setup — production demo
1. Run `setup/supabase.sql` in a dedicated Supabase project.
2. Import the workflow JSON into n8n.
3. Reconnect your own OpenAI, Supabase, and Telegram credentials.
4. Add your Telegram Chat ID.
5. Publish the workflow.
6. If needed, update the webhook in `demo/index.html`.
7. Deploy the demo to Netlify, Vercel, GitHub Pages, or another static host.

## Quick setup — Ruflo-assisted development

Ruflo requires Node.js 20+ and npm 9+. For Claude Code + Codex dual setup, run from the repository root:

```powershell
npx ruflo@latest init --dual
npx ruflo@latest doctor --fix
npx ruflo@latest swarm init --topology hierarchical --max-agents 5 --strategy specialized
```

On Windows, you can alternatively run:

```powershell
powershell -ExecutionPolicy Bypass -File .\ruflo\bootstrap-ruflo.ps1
```

Then give the orchestrated agents `ruflo/PROJECT_AGENT_SPEC.md` as the project brief.

## Security
No API keys, Supabase secrets, Telegram bot tokens, or n8n credential references are included in this public package.

## Production use
Replace the demo agency information and listings with the client's approved data or connect the workflow to a maintained listing database/CRM.
