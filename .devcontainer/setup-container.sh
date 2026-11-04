#!/usr/bin/env bash
set -euo pipefail

# /workspaces itself, and every named-volume mount point declared in
# devcontainer.json's "mounts" (shell-history, .vscode-server), come out
# root:root — only `.dev` (the bind-mounted workspaceFolder) inherits node
# ownership from the mount. Without this, `node` gets "Permission denied" writing into any of them.
sudo chown node:node /workspaces /workspaces/.shell-history \
  /home/node/.vscode-server 2>/dev/null || true

# ── Git commit signing (SSH format) ─────────────────────────────────────────────
# The devcontainer doesn't bind-mount ~/.ssh from the host, so the public-key
# file that user.signingkey points at never lands in the container — even
# though VS Code/Codespaces still forward the host's ssh-agent (SSH_AUTH_SOCK)
# for the actual signing operation. Recover just that one public key — it
# isn't sensitive — from whatever the forwarded agent already has loaded,
# matched to git's configured user.email.
if [ "$(git config --get gpg.format 2>/dev/null || true)" = "ssh" ]; then
  signingkey_path="$(git config --get user.signingkey 2>/dev/null || true)"
  signingkey_path="${signingkey_path/#\~/$HOME}"
  user_email="$(git config --get user.email 2>/dev/null || true)"
  if [ -n "$signingkey_path" ] && [ ! -f "$signingkey_path" ] && [ -n "$user_email" ] \
    && command -v ssh-add >/dev/null 2>&1; then
    if pubkey="$(ssh-add -L 2>/dev/null | grep " ${user_email}\$")" && [ -n "$pubkey" ]; then
      mkdir -p "$(dirname "$signingkey_path")"
      echo "$pubkey" > "$signingkey_path"
      chmod 644 "$signingkey_path"
      echo "✓ Recovered SSH signing public key for commit signing ($signingkey_path)."
    else
      echo "! Commit signing key missing ($signingkey_path) and no matching key in ssh-agent — commits will fail to sign."
    fi
  fi
fi

echo "✓ Arnaud Work workspace ready."
