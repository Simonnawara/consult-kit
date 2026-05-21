# Consult Kit

> Drop into any client repo. Describe the brief. Get a client-ready estimate.

A lightweight agentic toolkit for consultants. Works with GitHub Copilot and Claude Code.

---

## Setup

1. Copy this kit into the root of the client's repo:
   ```bash
   cp -r consult-kit/. ./
   ```

2. Open Copilot or Claude Code in that repo.

3. Start an engagement.

---

## Usage

### GitHub Copilot

Open the Copilot chat panel and use the prompt:

```
@engagement-orchestrator

I have just been given this project. Here is what the client wants:
[your brief here]

Please audit the codebase and produce a project estimate.
```

Or load the built-in prompt: `.github/prompts/start-engagement.prompt.md`

### Claude Code

```
/engagement

[your brief here]
```

---

## What gets produced

| File | For | Description |
|------|-----|-------------|
| `outputs/audit/asis-snapshot.md` | You | Full brownfield audit of the codebase |
| `outputs/estimate/milestones.md` | You | Milestones with complexity levels, time ranges, tasks, assumptions |
| `outputs/estimate/client-timeline.md` | Client | Clean project timeline — ready to send |

---

## Structure

```
.consult-kit/
├── agents/
│   ├── engagement-orchestrator.md   ← main entry point
│   ├── auditor.md                   ← reads the codebase
│   └── estimator.md                 ← produces milestones + timeline
├── templates/
│   ├── tpl-audit.md
│   ├── tpl-milestones.md
│   └── tpl-client-timeline.md
└── workflows/
    └── engagement.md

.github/                             ← Copilot runtime (auto-discovered)
├── agents/
│   └── engagement-orchestrator.agent.md
└── prompts/
    └── start-engagement.prompt.md

providers/claude-code/               ← Claude Code runtime
├── CONSULT.md
└── commands/
    ├── engagement.md
    ├── audit.md
    └── estimate.md

outputs/                             ← generated files (gitignore or commit)
├── audit/
└── estimate/
```

---

## The three output files

**`asis-snapshot.md`** — internal. What the codebase is today: stack, architecture, code quality signals, and how the client's brief maps to what exists.

**`milestones.md`** — internal. Every milestone with its complexity score, time range estimate, key tasks, assumptions, and risks. This is the working document.

**`client-timeline.md`** — send to client. Milestones with complexity indicators and time estimates, written in plain language. Includes assumptions, out-of-scope items, and next steps. No implementation detail.

---

## Complexity levels

| Level | Meaning |
|-------|---------|
| 🟢 Low | Additive, well-understood, no unknowns |
| 🟡 Medium | Some ambiguity or integration risk |
| 🟠 High | Architectural impact or significant unknowns |
| 🔴 Critical | Requires a discovery session before estimating |
