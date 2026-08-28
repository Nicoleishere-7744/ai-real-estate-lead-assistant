$ErrorActionPreference = "Stop"

Write-Host "Checking Node.js..."
node --version
npm --version

Write-Host "Initializing Ruflo for Claude Code + Codex..."
npx ruflo@latest init --dual

Write-Host "Running Ruflo diagnostics..."
npx ruflo@latest doctor --fix

Write-Host "Creating a 5-agent specialized hierarchical swarm..."
npx ruflo@latest swarm init --topology hierarchical --max-agents 5 --strategy specialized

Write-Host "Ruflo setup complete. Read ruflo/PROJECT_AGENT_SPEC.md before assigning project tasks."
