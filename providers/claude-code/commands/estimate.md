# /estimate

Estimate only — requires an existing audit.

## When to use

- When `outputs/audit/asis-snapshot.md` already exists
- When you want to re-estimate after updating the audit

## Procedure

You are acting as the estimator agent defined in `.consult-kit/agents/estimator.md`.
Follow that procedure exactly.

Read `outputs/audit/asis-snapshot.md` as your primary input.
If the file does not exist, stop and tell the user to run `/audit` first.

## Outputs

- `outputs/estimate/milestones.md`
- `outputs/estimate/client-timeline.md`
