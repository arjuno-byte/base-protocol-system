# Run a BPS-01 Full Node

This guide prepares a BPS full node for the `bps-01` public network using Bitcoin-style core networking.

## Requirements

- Linux server with systemd
- Go `1.25.6` or newer compatible Go 1.25 patch release
- `make`, `curl`, `jq`
- Open disk space for chain data
- A public TCP route for P2P: `IP_PUBLIC:26656`
- Optional snapshot from [`snapshot.md`](./snapshot.md)

## Build

```bash
git clone https://github.com/arjuno-byte/base-protocol-system.git
cd base-protocol-system
make install
bpsd version
```

## Initialize

```bash
export BPS_HOME="$HOME/.bpsd"
export BPS_CHAIN_ID="bps-01"

bpsd init "my-bps-full-node" --chain-id "$BPS_CHAIN_ID" --home "$BPS_HOME"
cp networks/bps-01/genesis.json "$BPS_HOME/config/genesis.json"
```

## Verify Genesis

```bash
sha256sum "$BPS_HOME/config/genesis.json"
cat networks/bps-01/genesis.sha256
```

Both values must be:

```text
6ff985ebd1ab87fbf579ac81b1ef1b6c9cff059018a72c5a2af5bdb3c0a184b8
```

## Configure Bitcoin-Style Networking

Replace `IP_PUBLIC` with the server's public IPv4/IPv6 address.

```bash
export IP_PUBLIC="<your-public-ip>"

sed -i.bak -E 's|^laddr = ".*"|laddr = "tcp://127.0.0.1:26657"|' "$BPS_HOME/config/config.toml"

python3 - <<'PY'
from pathlib import Path
import os

cfg = Path(os.environ['BPS_HOME']) / 'config' / 'config.toml'
text = cfg.read_text()
section = None
out = []
seen = {
    'p2p_laddr': False,
    'external_address': False,
    'seeds': False,
    'persistent_peers': False,
}
for line in text.splitlines():
    stripped = line.strip()
    if stripped.startswith('[') and stripped.endswith(']'):
        section = stripped.strip('[]')
    if section == 'p2p' and stripped.startswith('laddr ='):
        line = 'laddr = "tcp://0.0.0.0:26656"'
        seen['p2p_laddr'] = True
    elif section == 'p2p' and stripped.startswith('external_address ='):
        line = f'external_address = "{os.environ["IP_PUBLIC"]}:26656"'
        seen['external_address'] = True
    elif section == 'p2p' and stripped.startswith('seeds ='):
        line = 'seeds = ""'
        seen['seeds'] = True
    elif section == 'p2p' and stripped.startswith('persistent_peers ='):
        line = 'persistent_peers = ""'
        seen['persistent_peers'] = True
    out.append(line)
cfg.write_text('\n'.join(out) + '\n')
PY

sed -i.bak -E 's|^minimum-gas-prices = ".*"|minimum-gas-prices = "0.001ubps"|' "$BPS_HOME/config/app.toml"
sed -i.bak -E 's|^indexer = ".*"|indexer = "kv"|' "$BPS_HOME/config/config.toml"
```

Final target in `config.toml`:

```toml
[rpc]
laddr = "tcp://127.0.0.1:26657"

[p2p]
laddr = "tcp://0.0.0.0:26656"
external_address = "IP_PUBLIC:26656"
seeds = ""
persistent_peers = ""
```

If a seed or persistent peer is announced in [`peers.json`](./peers.json), use only raw TCP format:

```bash
PEERS="<node_id>@IP_PUBLIC:26656"
sed -i.bak -E "s|^persistent_peers = \".*\"|persistent_peers = \"$PEERS\"|" "$BPS_HOME/config/config.toml"
```

Never use HTTPS, Cloudflare, faucet, explorer, status, or public RPC URLs as P2P peers.

## Firewall

```bash
sudo ufw allow 26656/tcp comment 'BPS core P2P'
sudo ufw deny 26657/tcp comment 'BPS core RPC private only'
sudo ufw reload
```

If behind NAT/router, forward:

```text
IP_PUBLIC:26656/tcp -> NODE_LAN_IP:26656/tcp
```

## Systemd Service

Create `/etc/systemd/system/bpsd.service`:

```ini
[Unit]
Description=BPS full node
After=network-online.target
Wants=network-online.target

[Service]
User=bps
ExecStart=/usr/local/bin/bpsd start --home /home/bps/.bpsd
Restart=on-failure
RestartSec=5
LimitNOFILE=65535

[Install]
WantedBy=multi-user.target
```

Start the service:

```bash
sudo systemctl daemon-reload
sudo systemctl enable --now bpsd
sudo journalctl -u bpsd -f
```

## Health Checks

Local RPC on the node host:

```bash
bpsd status --node tcp://127.0.0.1:26657
curl -fsS http://127.0.0.1:26657/status | jq '.result.node_info.network'
```

External P2P from another network:

```bash
nc -vz IP_PUBLIC 26656
```

PowerShell:

```powershell
Test-NetConnection IP_PUBLIC -Port 26656
```

The expected network is:

```text
bps-01
```

## Snapshot

Snapshots are optional app-layer bootstrap artifacts. Use a snapshot only after verifying its SHA-256 checksum and the canonical genesis hash.

```bash
# Example only. Replace with an operator-published snapshot URL and checksum file.
SNAPSHOT_URL="<optional-snapshot-url>"
SHA256_URL="<optional-snapshot-sha256-url>"
SNAPSHOT="$(basename "$SNAPSHOT_URL")"

curl -L -o "$SNAPSHOT" "$SNAPSHOT_URL"
curl -L -o "$SNAPSHOT.sha256" "$SHA256_URL"
sha256sum -c "$SNAPSHOT.sha256"

sudo systemctl stop bpsd || true
rm -rf "$BPS_HOME/data"
tar -xzf "$SNAPSHOT" -C "$BPS_HOME"
sudo systemctl start bpsd
```

The snapshot must not include private keys, node keys, mnemonics, or config files.

## From Zero To Sync

1. Install `bpsd` with `make install`.
2. Initialize `BPS_HOME`.
3. Copy and verify BPS-01 `genesis.json`.
4. Configure P2P raw TCP `IP_PUBLIC:26656` and private RPC `127.0.0.1:26657`.
5. Open/forward only `26656/tcp` publicly.
6. Restore a verified snapshot if desired.
7. Configure raw TCP peers once published in [`peers.json`](./peers.json).
8. Start the `bpsd` systemd service.
9. Confirm `catching_up=false` and network `bps-01` from local RPC.
