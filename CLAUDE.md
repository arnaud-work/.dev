# Claude Code — Arnaud Work workspace

Full canonical rules (commit format, restrictions, language) live in
[AGENTS.md](AGENTS.md). This file adds Claude Code-specific context.

## Workspace layout

Sibling repos are cloned into named Docker volumes by
`.devcontainer/setup-container.sh`'s `postCreateCommand` (not host
bind-mounted — that's what makes the devcontainer work on GitHub Codespaces
as well as local Docker Desktop/WSL2), and open together in
`arnaud-work.code-workspace`. A plain "Rebuild Container" keeps
uncommitted/unpushed work; only a full teardown (`docker volume rm`, deleted
Codespace) resets a volume to a fresh clone of `origin/main`. `.dev` itself is
the one repo that's genuinely host bind-mounted, so it's unaffected either
way. **This is a safety net, not a substitute for pushing.**

| Path | Repo | Role |
| ---- | ---- | ---- |
| `/workspaces/arnaud-work-dev` | `.dev` | Orchestration — canonical AGENTS.md, devcontainer |
| `/workspaces/website` | `website` | arnaud.work landing page (Qwik + Cloudflare Workers) |

## Common commands (run from `website`)

```bash
pnpm install
pnpm typecheck
pnpm build
pnpm dev            # Vite dev server
pnpm serve          # wrangler dev — local Worker preview
```

## Common gotchas

**Commit scopes**: always read `scopes.json` at the active repo root before choosing a scope.
Never invent a scope that isn't listed. Full type→emoji mapping: `/workspaces/arnaud-work-dev/commit-convention.json`.
Use `/commit` (Claude Code slash command) to auto-generate a message from staged changes.

**Git workflow**: branch, commit by subject (Conventional Commits), push only once it looks safe
(human review of the diff recommended first, ask if unsure), open a PR — never merge, merging is
always a human decision. See AGENTS.md's Git Workflow section for the full policy and how a
narrow per-task carve-out (e.g. "push straight to `main` for this one fix") can be granted.

## AI persistence

`~/.claude` is bind-mounted from a **per-devcontainer** volume and symlinked at
every container start by `claude-dev` — isolated to this project, not shared
with any other org's devcontainer. Memory, credentials, and settings survive
rebuilds of this same devcontainer.
