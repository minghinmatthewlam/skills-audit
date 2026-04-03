# Sample Scorecard

## Per-Skill Findings

### `repo-scan`

- Category: Code Quality & Review
- Agent system: codex
- Score: 5/7
- P1: Missing gotchas section. The skill explains what to do, but it does not capture common failure modes like double-counting generated files or auditing vendored directories.
- P2: Description under-triggers. It describes the skill abstractly instead of naming common prompts like "audit this repo", "review our skills", or "find gaps in our agent setup".

### `release-helper`

- Category: CI/CD & Deployment
- Agent system: claude
- Score: 4/6
- P1: Category bleed. The skill mixes deploy steps, rollback guidance, and incident triage. Split routine deployment from production runbook behavior.
- P2: Overly rigid workflow. Some steps are written as exact commands instead of goals and constraints, which makes the skill brittle when the repo uses a different release path.

## Repo-Level Gaps

- Missing Product Verification skill. The repo has end-to-end tests and UI flows but no skill that tells the agent how to verify the real user surface.
- Missing Data Fetching & Analysis skill. The repo includes monitoring references and dashboards but no reusable investigation workflow for pulling metrics or event data.

## Quick Wins

1. Add a dedicated gotchas section to every workflow-heavy skill.
2. Rewrite vague descriptions so they list trigger phrases and user intents.
3. Split skills that combine two categories into narrower, easier-to-trigger units.
