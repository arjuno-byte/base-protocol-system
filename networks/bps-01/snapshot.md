# BPS-01 Snapshot

Snapshots are optional app-layer bootstrap artifacts. They are not part of core peer discovery and they do not replace raw TCP P2P sync.

## Current Snapshot Policy

| Field | Value |
| --- | --- |
| Network | `bps-01` |
| Status | Operator-provided optional artifact |
| Snapshot URL | Not hardcoded in core repo |
| SHA-256 | Must be published beside each snapshot |
| SHA-256 file | Must be published beside each snapshot |

A valid snapshot contains node runtime `data/` only. It must not include validator private keys, node keys, mnemonics, server credentials, or config files.

## Restore

Stop the node first:

```bash
sudo systemctl stop bpsd || true
```

For a user-level node, stop the matching user service instead.

Download and verify an operator-published snapshot:

```bash
SNAPSHOT_URL="<optional-snapshot-url>"
SHA256_URL="<optional-snapshot-sha256-url>"
SNAPSHOT="$(basename "$SNAPSHOT_URL")"

curl -L -o "$SNAPSHOT" "$SNAPSHOT_URL"
curl -L -o "$SNAPSHOT.sha256" "$SHA256_URL"
sha256sum -c "$SNAPSHOT.sha256"
```

Restore into an initialized BPS home:

```bash
export BPS_HOME="$HOME/.bpsd"
rm -rf "$BPS_HOME/data"
tar -xzf "$SNAPSHOT" -C "$BPS_HOME"
```

Then start the node again after `genesis.json`, `config.toml`, and `app.toml` are configured for BPS-01.

## Important

A snapshot speeds up local state bootstrap, but the node still needs working raw TCP P2P peers to continue following new blocks. Use `<node_id>@IP_PUBLIC:26656` peers only; do not use HTTPS, Cloudflare, public RPC, faucet, explorer, or status URLs as peers.