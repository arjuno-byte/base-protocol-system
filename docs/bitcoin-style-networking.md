# BPS Core Networking Model

BPS core networking follows a Bitcoin-style separation between the node network and public application services.

## Core Rules

- Node-to-node communication uses raw TCP only.
- P2P must be reachable as `IP_PUBLIC:26656`.
- RPC is private and bound to localhost only.
- Public RPC, faucet, explorer, snapshots, and status pages are optional app-layer services.
- Domains, HTTPS, reverse proxies, and Cloudflare are not used for P2P, peer discovery, persistent peers, genesis peers, or node sync.

## Final Core Config

`config.toml`:

```toml
[rpc]
laddr = "tcp://127.0.0.1:26657"

[p2p]
laddr = "tcp://0.0.0.0:26656"
external_address = "IP_PUBLIC:26656"
seeds = ""
persistent_peers = ""
```

`app.toml`:

```toml
minimum-gas-prices = "0.001ubps"
```

If a public seed or peer is announced, it must use CometBFT raw TCP format:

```text
<node_id>@IP_PUBLIC:26656
```

Do not use `https://...`, DNS-only HTTPS endpoints, Cloudflare Tunnel URLs, or public RPC URLs as P2P peers.

## Firewall

On the node host:

```bash
sudo ufw allow 26656/tcp comment 'BPS core P2P'
sudo ufw deny 26657/tcp comment 'BPS core RPC private only'
sudo ufw reload
```

If the node is behind NAT, forward:

```text
IP_PUBLIC:26656/tcp -> NODE_LAN_IP:26656/tcp
```

## Tests

From outside the node network:

```bash
nc -vz IP_PUBLIC 26656
```

PowerShell from outside the node network:

```powershell
Test-NetConnection IP_PUBLIC -Port 26656
```

On the node host:

```bash
bpsd status --node tcp://127.0.0.1:26657
curl -fsS http://127.0.0.1:26657/status
```

Expected result:

- External `26656/tcp` succeeds.
- External `26657/tcp` fails or is blocked.
- Local RPC health checks succeed on `127.0.0.1:26657`.