# Arnaud Work — `.dev`

Dev workspace orchestrator for the [Arnaud Work](https://github.com/arnaud-work) organization
(Bérenger's solo micro-entreprise, [arnaud.work](https://arnaud.work)).

## What's in here

| File / folder | Purpose |
| --- | --- |
| `.devcontainer/` | Devcontainer (`org-workspace` clones the org repos) |
| `.claude/commands/commit.md` | `/commit` slash command |
| `.vscode/settings.json` | Shared editor settings |
| `arnaud-work.code-workspace` | Multi-root VS Code workspace |
| `AGENTS.md` | Canonical AI / agent rules for all arnaud-work repos |

## Quick start — GitHub Codespaces (recommended)

Open a Codespace on `arnaud-work/.dev` directly from GitHub. The `org-workspace` feature clones the org's repos (see
`.devcontainer/devcontainer.json`) into `/workspaces/<repo>` automatically.

Secrets (`GH_TOKEN`, …) come from OpenBao — `kv/orgs/arnaud-work`, plus `kv/shared/*` — through the
[`openbao-env`](https://github.com/helpers4/devcontainer/tree/main/src/openbao-env) feature, into
every process of the container (VS Code included). On fajro, `devc up arnaud-work` hands the
container its credentials. In GitHub Codespaces, set the Codespaces secrets `BAO_ROLE_ID` and
`BAO_SECRET_ID` (AppRole `arnaud-work`) and give the codespace Tailscale access: OpenBao is only
reachable on the tailnet.

## Quick start — local (Docker Desktop / WSL2)

```bash
mkdir arnaud-work && cd arnaud-work
gh repo clone arnaud-work/.dev
code .dev/arnaud-work.code-workspace
```

Reopen `.dev` in the devcontainer — sibling repos are cloned automatically by
the `org-workspace` feature. The secrets come from OpenBao (see above).

## Verifying the environment

```bash
bash .devcontainer/test-container.sh
```

When a new repository is added to the organization, the `org-workspace` options in
`.devcontainer/devcontainer.json` are enough: the repos are discovered from the org and
`arnaud-work.code-workspace` is updated for you.
