# Ruflo setup for this project

Ruflo is used here as a development/orchestration layer for Claude Code and/or OpenAI Codex. The customer-facing runtime remains the existing n8n webhook + OpenAI + Supabase + Telegram workflow.

## Prerequisites

- Node.js 20+
- npm 9+
- Git
- Claude Code and/or OpenAI Codex if you want Ruflo to orchestrate coding agents through those clients

## Recommended setup (dual Claude Code + Codex)

From the repository root:

```powershell
npx ruflo@latest init --dual
npx ruflo@latest doctor --fix
```

For a Ruflo swarm tailored to this project:

```powershell
npx ruflo@latest swarm init --topology hierarchical --max-agents 5 --strategy specialized
```

Useful checks:

```powershell
npx ruflo@latest swarm status
npx ruflo@latest agent list
npx ruflo@latest memory stats
```

## Project-specific agent roles

Use `PROJECT_AGENT_SPEC.md` as the project brief after Ruflo initialization. It defines the coordinator and specialist responsibilities, safety boundaries, expected files, and acceptance tests.

## Important architecture boundary

Do not replace the n8n production webhook just to "use Ruflo". Ruflo is best used to coordinate development, testing, refactoring, security review, prompt evaluation, and future multi-agent expansion. Keep customer request handling deterministic and observable through n8n unless a deliberate runtime migration is chosen later.
