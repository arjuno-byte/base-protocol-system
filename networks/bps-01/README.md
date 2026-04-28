# BPS-01 Public Network

`bps-01` is the first public BPS network profile. This folder is the canonical place for public node operators to find the chain ID, genesis file, checksum, peer metadata, and operator guides.

## Network Profile

| Field | Value |
| --- | --- |
| Network name | BPS-01 |
| Chain ID | `bps-01` |
| Native display denom | `BPS` |
| Base denom | `ubps` |
| Denom precision | `1 BPS = 1,000,000 ubps` |
| Core P2P | raw TCP `IP_PUBLIC:26656` |
| Core RPC | private/local only `tcp://127.0.0.1:26657` |
| Public RPC | Disabled from core; optional app layer only |
| Cloudflare/HTTPS | Not used for P2P/core node sync |
| Genesis file | [`genesis.json`](./genesis.json) |
| Genesis SHA-256 | `6ff985ebd1ab87fbf579ac81b1ef1b6c9cff059018a72c5a2af5bdb3c0a184b8` |
| Tokenomics | [`../../TOKENOMICS.md`](../../TOKENOMICS.md) |
| Public snapshot | [`snapshot.md`](./snapshot.md) |

## Current Join Model

BPS uses Bitcoin-style networking for the core node layer:

- Full nodes join through raw CometBFT TCP peers, formatted as `<node_id>@IP_PUBLIC:26656`.
- RPC stays local on the node host for operator tooling and optional app services.
- Faucet, explorer, status page, public RPC proxy, and snapshots are optional external services.
- Domains, HTTPS, Cloudflare Tunnel, and reverse proxies are never used as P2P seeds or persistent peers.

When public peers are announced, they will appear in [`peers.json`](./peers.json) as raw TCP addresses only.

## Files

- [`genesis.json`](./genesis.json): canonical BPS-01 genesis.
- [`genesis.sha256`](./genesis.sha256): SHA-256 checksum for `genesis.json`.
- [`peers.json`](./peers.json): current public peer/seed status.
- [`endpoints.json`](./endpoints.json): machine-readable core/app-layer endpoint model.
- [`snapshot.md`](./snapshot.md): optional snapshot policy and restore steps.
- [`full-node.md`](./full-node.md): full node setup guide.
- [`validator.md`](./validator.md): validator setup guide.
- [`../../docs/bitcoin-style-networking.md`](../../docs/bitcoin-style-networking.md): core networking rules.

## Verify Genesis

Linux or macOS:

```bash
sha256sum networks/bps-01/genesis.json
cat networks/bps-01/genesis.sha256
```

Windows PowerShell:

```powershell
Get-FileHash .\networks\bps-01\genesis.json -Algorithm SHA256
Get-Content .\networks\bps-01\genesis.sha256
```

The hash must match:

```text
6ff985ebd1ab87fbf579ac81b1ef1b6c9cff059018a72c5a2af5bdb3c0a184b8
```

## Local Health Check

Run on the node host:

```bash
bpsd status --node tcp://127.0.0.1:26657
curl -fsS http://127.0.0.1:26657/status
```

Expected chain ID:

```text
bps-01
```

## P2P Connectivity Check

Run from outside the node network after firewall/NAT is open:

```bash
nc -vz IP_PUBLIC 26656
```

PowerShell:

```powershell
Test-NetConnection IP_PUBLIC -Port 26656
```

## Operator Notes

- Do not expose validator RPC publicly.
- Do not use public RPC URLs as P2P peers.
- Do not use domains, HTTPS, or Cloudflare as core node dependencies.
- Do not reuse example keys or local development wallets for production or validator operations.
- Keep validator keys offline or on a hardened host.
- Treat any leaked mnemonic, private key, or node key as compromised.