# skills-audit

Audit agent skills in a repo against practical skill-design best practices.

`skills-audit` scans installed or repo-local skills, classifies them, scores them against a checklist, flags missing categories, and returns a prioritized scorecard with concrete fixes.

## Install

### Vercel `skills`

```bash
npx skills add minghinmatthewlam/skills-audit
```

To target a specific agent:

```bash
npx skills add minghinmatthewlam/skills-audit -a codex -y
```

### OpenSkills

```bash
npx openskills install minghinmatthewlam/skills-audit
```

If you use a shared `AGENTS.md` setup across multiple agents:

```bash
npx openskills install minghinmatthewlam/skills-audit --universal
```

## What It Does

- discovers skills across Claude Code, Codex, and repo-local skill folders
- classifies each skill into a clear category
- scores skill quality against an explicit checklist
- identifies repo-level gaps based on the codebase surface
- outputs a prioritized scorecard with actionable recommendations

## When To Use It

Use `skills-audit` when you want to:

- review a repo's existing skills before publishing them
- improve trigger quality, gotchas, or folder structure in a skill
- find missing high-value skills for a codebase
- compare a team's skill set against practical field-tested patterns

## Example Prompt

```text
Audit the skills in this repo. Check both .claude/skills and .agents/skills, score each one, and tell me the top fixes plus the highest-value missing skills.
```

Example scorecard output: [examples/sample-scorecard.md](examples/sample-scorecard.md)

## Example Input

A minimal example task brief is in [examples/sample-input.md](examples/sample-input.md).

## Background

This skill is informed by public guidance from Anthropic on how effective skills are designed in practice, especially around:

- gotchas as the highest-signal part of a skill
- progressive disclosure through files and folders
- trigger-oriented descriptions
- avoiding brittle, over-prescriptive instructions

Relevant reading:

- Thariq Shihipar, "Lessons from Building Claude Code: How We Use Skills" on X: <https://x.com/trq212/status/2033949937936085378>

`skills-audit` is an independent OSS skill. It is not affiliated with or endorsed by Anthropic.

## Repo Layout

```text
skills-audit/
├── SKILL.md
├── references/
├── examples/
└── scripts/
```

## Maintainer Sync

If you also maintain `agent-guards`, you can mirror the shared skill payload into this repo.

Mirrored files:

- `SKILL.md`
- `references/`

OSS-only files in this repo:

- `README.md`
- `LICENSE`
- `examples/`
- `scripts/`

To resync from `agent-guards`:

```bash
./scripts/sync-from-agent-guards.sh --source /path/to/agent-guards
```

To verify the mirrored payload is up to date without changing files:

```bash
./scripts/sync-from-agent-guards.sh --source /path/to/agent-guards --check
```

## How To Contribute

- improve the checklist with concrete failure modes
- refine category boundaries when skills clearly straddle them
- add better sample outputs and repo examples
- tighten the wording so the skill triggers more reliably

## License

MIT
