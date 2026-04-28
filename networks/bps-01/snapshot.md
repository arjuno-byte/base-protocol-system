# BPS-01 Snapshot

This page documents the current public BPS-01 node snapshot.

## Current Snapshot

| Field | Value |
| --- | --- |
| Network | `bps-01` |
| Snapshot height | `19200` |
| Snapshot URL | `https://status.semarchain.my.id/snapshots/bps-01-rpc-snapshot-19200-20260428T212502Z.tar.gz` |
| SHA-256 | `a05c3b3394ad70091da3afa546bc7c3113f5f0e86016d3ee5c4ca87493762308` |
| SHA-256 file | `https://status.semarchain.my.id/snapshots/bps-01-rpc-snapshot-19200-20260428T212502Z.tar.gz.sha256` |
| Size | `76285294` bytes |

The snapshot contains node runtime `data/` only. It does not include validator
private keys, node keys, mnemonics, server credentials, or config files.

## Restore

Stop the node first:

```bash
sudo systemctl stop bpsd || true
```

For a user-level node, stop the matching user service instead.

Download and verify:

```bash
SNAPSHOT="bps-01-rpc-snapshot-19200-20260428T212502Z.tar.gz"
curl -L -o "$SNAPSHOT" \
  "https://status.semarchain.my.id/snapshots/$SNAPSHOT"
curl -L -o "$SNAPSHOT.sha256" \
  "https://status.semarchain.my.id/snapshots/$SNAPSHOT.sha256"
sha256sum -c "$SNAPSHOT.sha256"
```

Restore into an initialized BPS home:

```bash
export BPS_HOME="$HOME/.bpsd"
rm -rf "$BPS_HOME/data"
tar -xzf "$SNAPSHOT" -C "$BPS_HOME"
```

Then start the node again after `genesis.json`, `config.toml`, and `app.toml`
are configured for BPS-01.

## Important

A snapshot speeds up local state bootstrap, but the node still needs working P2P
peers to continue following new blocks. Public raw P2P seed publication is still
pending upstream TCP exposure.
