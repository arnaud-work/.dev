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
| `/workspaces/.dev` | `.dev` | Orchestration — canonical AGENTS.md, devcontainer |
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
Never invent a scope that isn't listed. Full type→emoji mapping: `/workspaces/.dev/commit-convention.json`.
Use `/commit` (Claude Code slash command) to auto-generate a message from staged changes.

**Git workflow**: push straight to `main`, no branches/PRs — solo micro-entreprise, see
AGENTS.md's Git workflow section. Claude may commit once authorized for the session, but
never pushes on its own initiative — the user reviews and pushes.
