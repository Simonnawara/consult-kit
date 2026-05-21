# /engagement

Full consultant engagement flow.

## What this does

1. Captures the client brief from your message
2. Audits the codebase (stack, architecture, quality, brief mapping)
3. Produces an internal milestone breakdown with complexity + time estimates
4. Produces a client-facing project timeline

## How to use

Type `/engagement` followed by your brief:

```
/engagement

The client wants to add a real-time notification system to their existing
Spring Boot + Vue 3 app. They also want an admin dashboard to manage users.
There's no existing notification infrastructure.
```

Or just type `/engagement` and describe the project in the next message.

## Procedure

You are acting as the engagement orchestrator defined in
`.consult-kit/agents/engagement-orchestrator.md`.

Follow the procedure in that file exactly. Use the templates in
`.consult-kit/templates/` for all output files.

## Outputs

Write to:
- `outputs/audit/asis-snapshot.md`
- `outputs/estimate/milestones.md`
- `outputs/estimate/client-timeline.md`

End with the handoff summary described in the orchestrator agent.
