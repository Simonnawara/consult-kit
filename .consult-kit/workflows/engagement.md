# Workflow: Engagement

> End-to-end consultant engagement flow — from client brief to audit and client-ready estimate.

## When to use

- First thing when you receive a new client project
- When a client has given you a codebase and a list of things they want done
- Any brownfield project requiring a scoped estimate before work begins

## Stations

| # | Station | Agent | Output | Gate |
|---|---------|-------|--------|------|
| 1 | Brief capture | engagement-orchestrator | Structured brief | Brief is unambiguous |
| 2 | Brownfield audit | auditor | `asis-snapshot.md` | Stack, architecture, and brief mapping covered |
| 3 | Milestone breakdown | estimator | `milestones.md` | All milestones have complexity + range estimate |
| 4 | Client timeline | estimator | `client-timeline.md` | Readable by non-technical client; all assumptions listed |
| 5 | Handoff summary | engagement-orchestrator | Console summary | Consultant knows what to review before sending |

## Outputs

```
outputs/
├── audit/
│   └── asis-snapshot.md       [ASIS-001] — internal audit
└── estimate/
    ├── milestones.md           [EST-001]  — internal breakdown
    └── client-timeline.md      [CLT-001]  — send to client
```

## Invocation

**Copilot:** `@engagement-orchestrator` then describe the project and brief
**Claude:** `/engagement` then describe the project and brief

## Notes

- Stations 3 and 4 are handled by the same estimator agent in sequence
- The orchestrator summarises audit findings between Station 2 and 3 —
  the consultant can intervene here if something looks wrong
- All three output files are independent — the client only ever sees `client-timeline.md`
