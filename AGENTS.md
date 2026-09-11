# AGENTS.md — Arnaud Work organization (canonical)

This is the **canonical, org-wide** agent guidance for the Arnaud Work organization.
Every arnaud-work repository inherits these rules. Per-repo `AGENTS.md` files only add
project-specific details on top of what is defined here.

## Language

**Everything in English** — code, comments, commits, documentation, logs, PR
descriptions. The one exception: visible product copy (e.g. `website`'s page
text) is written in French for its actual audience — see that repo's own
`AGENTS.md`.

## Organization Context

**Arnaud Work** (domain: [arnaud.work](https://arnaud.work)) is Bérenger's solo
freelance micro-entreprise.

Repositories in this organization:

| Repo | Purpose |
| --- | --- |
| [`.dev`](https://github.com/arnaud-work/.dev) | Orchestration workspace + devcontainer + canonical agent rules |
| [`website`](https://github.com/arnaud-work/website) | arnaud.work landing page (Qwik + Cloudflare Workers) |

## Commit Messages

All repos follow [Conventional Commits](https://www.conventionalcommits.org/) with a **gitmoji** between the scope and the description.

**Format:** `<type>(<scope>): <emoji> <description>`

**Rules:**
- Description ≤72 chars, lowercase, imperative mood, no trailing period
- Always include exactly ONE emoji
- Multiple logical changes → bullet list in body
- Allowed scopes are repo-specific — see `scopes.json` at each repo's root

**Type / emoji table:**

| Type | Primary | When to use |
| --- | --- | --- |
| feat | ✨ | New feature |
| fix | 🐛 | Bug fix |
| docs | 📝 | Documentation |
| refactor | ♻️ | Code refactoring |
| chore | 🔧 | Maintenance |
| perf | ⚡️ | Performance |
| style | 💄 | Code style / UI |
| ci | 👷 | CI/CD |
| build | 📦️ | Build system / deps |
| revert | ⏪️ | Revert |

Full type→emoji mapping with alternatives: `commit-convention.json` at this repo's root.

## This Repository (.dev)

**Purpose:** Orchestrate the Arnaud Work organization — multi-root VS Code workspace,
devcontainer, canonical agent rules, cross-repo scripts.

### Project Structure

```
.dev/
├── .devcontainer/
│   ├── devcontainer.json       # Cross-repo dev environment
│   └── setup-container.sh      # postCreateCommand: clones siblings into named volumes
├── .claude/commands/commit.md  # /commit slash command
├── .vscode/settings.json       # Shared editor settings
├── arnaud-work.code-workspace  # Multi-root workspace + shared settings
├── commit-convention.json      # Full type→emoji mapping
├── scopes.json                 # Allowed commit scopes for this repo
├── AGENTS.md                   # This file (canonical org-wide rules)
├── CLAUDE.md                   # Claude Code-specific pointer
├── README.md
└── LICENSE                     # MIT
```

Sibling repos are cloned as Docker volumes inside the devcontainer — see
`.devcontainer/setup-container.sh`. No `repos.json`/`scripts/`/`package.json`
orchestration layer — the sibling list lives only in `ARNAUD_WORK_REPOS`
(`.devcontainer/devcontainer.json`), same thin pattern as `brig-id/roots` and
`tuxery/.dev`.

### What NOT to do here

- Do **not** add runtime code, packages, or build outputs. This repo is configuration only.
- Do **not** duplicate per-repo agent rules — they live in their own `AGENTS.md`.
- When adding a new sibling repo, update `arnaud-work.code-workspace` and
  `.devcontainer/devcontainer.json` (`ARNAUD_WORK_REPOS`) together.

## Git Workflow

Default policy — nuanced, not a hard rule: ask if a specific task calls for
something different, but absent other instructions:

1. **Branch** — work on a branch, never directly on `main`. Group related
   changes on the same branch instead of opening a new one per small change.
2. **Commit** — one commit per subject, Conventional Commits format mandatory
   (see Commit Messages below).
3. **Push** — only once it looks safe to do so; a human review of the diff
   first is recommended for anything non-trivial. Ask if unsure.
4. **Pull Request** — open one once pushed.
5. **Merge** — never merge. Merging is always a human decision.

A narrow, temporary carve-out (e.g. "push straight to `main` for this one fix")
may be granted in conversation for a specific piece of work — treat it as
scoped to exactly what was said, never as a standing precedent to reuse
elsewhere or later without asking again.

## Code Comments

Write comments for someone reading the code cold — they never see the diff or the previous
version, only what's in front of them. Describe what the code *is* and *why* it's that way,
never what changed to get there.

- ❌ `contents: write # was read-only — this job now also commits X`
- ✅ `contents: write # commits X`

If a comment needs "was"/"before"/"previously"/"now" (or a timestamp: "as of writing", "since
last month") to make sense, that content belongs in the commit message or PR description, not
the code — it rots the moment someone reads the file without the diff in front of them.

## Inheritance

This repo's shape is ported from
[helpers4/.dev](https://github.com/helpers4/.dev)'s canonical setup
(`CLAUDE.md`, `scopes.json`, `commit-convention.json`,
`.claude/commands/commit.md`, Git Workflow, Code Comments). Deltas from that
shape:
- **License: plain MIT**, not helpers4's LGPL-3.0-or-later — `website` is a
  personal marketing site, not a hosted network service (same reasoning as
  `phillaire`/`levrier-tech`, not `tuxery`'s AGPL).
- **Devcontainer**: named Docker volumes + clone-on-first-run in
  `postCreateCommand` (Codespaces-compatible, not host bind-mounts), matching
  `brig-id/roots`/`tuxery/.dev`'s thin pattern — no `repos.json`/`scripts/`/
  `package.json` orchestration layer, unlike most other sibling orgs. The
  sibling list lives only in `ARNAUD_WORK_REPOS`.
- **Stack**: Qwik + Cloudflare Workers (`website`), like `tuxery/app` — no
  database/Turso, no Playwright/mistral-dev/cline-dev/nub devcontainer
  features, a one-page marketing site needs none of that.
- Single sibling repo (`website` only, no `.github`/app/catalog split — this
  org is small enough not to need one yet).
