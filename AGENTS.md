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
├── scripts/
│   ├── repos.mjs               # Source of truth (reads repos.json)
│   ├── run-each.mjs            # Run a pnpm script in every sibling repo
│   └── git-each.mjs            # Run a git command in every sibling repo
├── arnaud-work.code-workspace  # Multi-root workspace + shared settings
├── repos.json                  # List of sibling repos
├── package.json                # Cross-repo orchestration scripts
├── commit-convention.json      # Full type→emoji mapping
├── scopes.json                 # Allowed commit scopes for this repo
├── AGENTS.md                   # This file (canonical org-wide rules)
├── CLAUDE.md                   # Claude Code-specific pointer
├── README.md
└── LICENSE                     # MIT
```

Sibling repos are cloned as Docker volumes inside the devcontainer — see
`.devcontainer/setup-container.sh`.

### What NOT to do here

- Do **not** add runtime code, packages, or build outputs. This repo is configuration only.
- Do **not** duplicate per-repo agent rules — they live in their own `AGENTS.md`.
- When adding a new sibling repo, update `repos.json`, `arnaud-work.code-workspace`, and
  `.devcontainer/devcontainer.json` (`ARNAUD_WORK_REPOS`) together.

## Git workflow

Arnaud Work is a solo micro-entreprise project. `.dev` is meta/config only —
push straight to `main`, no PR needed. Do the same for `website` unless/until
this stops being a one-person project.

## Inheritance

This repo's shape is reconciled from two sibling-org templates, since neither
alone was a full match:
- **`phillaire/.dev`** — the `repos.json` / `scripts/` (`git-each.mjs`,
  `run-each.mjs`, `repos.mjs`) / `package.json` orchestration shape, and the
  plain **MIT license** (`website` is a personal marketing site, not a hosted
  network service — same reasoning as phillaire and levrier-tech, not
  tuxery's AGPL).
- **`tuxery/.dev`** — the devcontainer shape (named Docker volumes + clone-on-
  first-run, Codespaces-compatible, not host bind-mounts), `CLAUDE.md` +
  `.claude/commands/commit.md` + `commit-convention.json` pairing, since
  `website` is Qwik + Cloudflare Workers like `tuxery/app`.

Deltas from both: single sibling repo (`website` only, no `.github`/app/catalog
split — this org is small enough not to need one yet), no database/Turso, no
Playwright/mistral-dev/cline-dev/nub devcontainer features — a one-page
marketing site needs none of that.
