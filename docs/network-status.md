# Network Status

This document summarizes the BPS-01 core networking status and optional app-layer service model.

## Core Services

| Service | Address | Status |
| --- | --- | --- |
| P2P | `13.229.41.228:26656` raw TCP | Online public BPS-01 peer |
| RPC | `tcp://127.0.0.1:26657` | Private/local only |
| Public RPC | Disabled from core | Optional app layer only |
| Cloudflare/HTTPS | Not used for P2P/core | App layer only if operator enables it |

## Optional App Layer

Faucet, explorer, public RPC proxy, status page, and snapshots may be published by operators, but they are not dependencies for node-to-node sync or peer discovery.

## P2P Status

Current public P2P metadata is tracked in [`networks/bps-01/peers.json`](../networks/bps-01/peers.json). Peers must be published in raw CometBFT format:

```text
<node_id>@IP_PUBLIC:26656
```

Current BPS-01 public peer:

```text
17c0469a361fe1e9ecbe11058f8d5cb030992e82@13.229.41.228:26656
```

## Verification Commands

Local RPC on the node host:

```bash
bpsd status --node tcp://127.0.0.1:26657
curl -fsS http://127.0.0.1:26657/status
curl -fsS http://127.0.0.1:26657/net_info
```

External P2P from another network:

```bash
nc -vz IP_PUBLIC 26656
nc -vz 13.229.41.228 26656
```

PowerShell:

```powershell
Test-NetConnection IP_PUBLIC -Port 26656
Test-NetConnection 13.229.41.228 -Port 26656
```
