# Run a BPS-01 Full Node

This guide prepares a BPS full node for the `bps-01` public network.

## Requirements

- Linux server with systemd
- Go `1.25.6` or newer compatible Go 1.25 patch release
- `make`, `curl`, `jq`
- Open disk space for chain data
- Public P2P seed address once announced in [`peers.json`](./peers.json)

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

## Configure Peers

Read the current public peer status:

```bash
cat networks/bps-01/peers.json | jq '.p2p'
```

If `seeds` is empty, public P2P seed access has not been announced yet. Wait for
an updated `peers.json` before expecting a new node to sync from the public
network.

When a seed is announced, set it in `config.toml`:

```bash
SEEDS="<node_id>@<public-host>:26656"
sed -i.bak -E "s|^seeds = \".*\"|seeds = \"$SEEDS\"|" "$BPS_HOME/config/config.toml"
```

Recommended base settings:

```bash
sed -i.bak -E 's|^minimum-gas-prices = ".*"|minimum-gas-prices = "0.001ubps"|' "$BPS_HOME/config/app.toml"
sed -i.bak -E 's|^indexer = ".*"|indexer = "kv"|' "$BPS_HOME/config/config.toml"
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

```bash
bpsd status --node tcp://127.0.0.1:26657
curl -fsS https://rpc.semarchain.my.id/status | jq '.result.node_info.network'
```

The expected network is:

```text
bps-01
```

## Snapshot

No public snapshot is currently published. Start from genesis unless
[`peers.json`](./peers.json) announces a snapshot URL.
