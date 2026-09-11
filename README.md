# Arnaud Work — `.dev`

Dev workspace orchestrator for the [Arnaud Work](https://github.com/arnaud-work) organization
(Bérenger's solo micro-entreprise, [arnaud.work](https://arnaud.work)).

## What's in here

| File / folder | Purpose |
| --- | --- |
| `.devcontainer/` | Devcontainer (clones sibling repos into named volumes) |
| `.claude/commands/commit.md` | `/commit` slash command |
| `.vscode/settings.json` | Shared editor settings |
| `arnaud-work.code-workspace` | Multi-root VS Code workspace |
| `AGENTS.md` | Canonical AI / agent rules for all arnaud-work repos |

## Quick start — GitHub Codespaces (recommended)

Open a Codespace on `arnaud-work/.dev` directly from GitHub. `postCreateCommand`
clones every sibling repo listed in `.devcontainer/devcontainer.json`'s
`ARNAUD_WORK_REPOS` into `/workspaces/<repo>` automatically.

Set a Codespaces secret or export a token on the host named
`GH_TOKEN_FOR_ARNAUD_WORK` (not `GH_TOKEN`) before creating/reopening the
codespace, so `gh`/`git` can clone and push:

```bash
export GH_TOKEN_FOR_ARNAUD_WORK="$(gh auth token)"
```

## Quick start — local (Docker Desktop / WSL2)

```bash
mkdir arnaud-work && cd arnaud-work
gh repo clone arnaud-work/.dev
code .dev/arnaud-work.code-workspace
```

Reopen `.dev` in the devcontainer — sibling repos are cloned automatically by
`postCreateCommand`. Export `GH_TOKEN_FOR_ARNAUD_WORK` first (see above).

## Verifying the environment

```bash
bash .devcontainer/test-container.sh
```

When a new repository is added to the organization, update
`arnaud-work.code-workspace` and `.devcontainer/devcontainer.json`
(`ARNAUD_WORK_REPOS`) together.
