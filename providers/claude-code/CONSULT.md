# Consult Kit — Claude Code

This repository includes a consultant engagement kit.

## Available commands

| Command | What it does |
|---------|-------------|
| `/engagement` | Full engagement flow — audit + milestones + client timeline |
| `/audit` | Brownfield audit only |
| `/estimate` | Estimate only (requires audit output to exist) |

## Quick start

```
/engagement
```

Then describe the client project and what they want done. The kit will:
1. Audit the codebase
2. Break the work into milestones with complexity and time estimates
3. Write three files to `outputs/` — two internal, one for the client

## Output files

| File | Audience | Purpose |
|------|----------|---------|
| `outputs/audit/asis-snapshot.md` | Consultant | Brownfield audit |
| `outputs/estimate/milestones.md` | Consultant | Detailed milestone breakdown |
| `outputs/estimate/client-timeline.md` | Client | Project estimate to share |

## Canonical definitions

Agent procedures and templates live in `.consult-kit/`.
Do not edit the provider files directly — edit the canonical layer.
