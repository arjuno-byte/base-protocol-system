# BPS-01 Public Network

`bps-01` is the first public BPS network profile. This folder is the canonical
place for public node operators to find the chain ID, genesis file, checksum,
RPC endpoint, and operator guides.

## Network Profile

| Field | Value |
| --- | --- |
| Network name | BPS-01 |
| Chain ID | `bps-01` |
| Native display denom | `BPS` |
| Base denom | `ubps` |
| Denom precision | `1 BPS = 1,000,000 ubps` |
| Public RPC | `https://rpc.semarchain.my.id` |
| RPC status | `https://rpc.semarchain.my.id/status` |
| RPC net info | `https://rpc.semarchain.my.id/net_info` |
| Genesis file | [`genesis.json`](./genesis.json) |
| Genesis SHA-256 | `6ff985ebd1ab87fbf579ac81b1ef1b6c9cff059018a72c5a2af5bdb3c0a184b8` |
| Faucet | `https://faucet.semarchain.my.id/faucet` |
| Explorer | `https://explorer.semarchain.my.id` |
| Status page | `https://status.semarchain.my.id` |
| Public snapshot | [`snapshot.md`](./snapshot.md) |
| Public P2P seed | Pending upstream TCP route for `seed.semarchain.my.id` |

## Current Join Status

Public RPC, faucet, explorer, status page, and snapshot access are online.
Public P2P seed access is not advertised yet because the current public domain
is HTTPS/RPC oriented and raw CometBFT P2P ports are not reachable through it.

This means operators can build the node, verify genesis, restore the published
snapshot, and prepare configuration from this repository. A one-command live
sync from the public network should wait until a public seed address is
announced here.

## Files

- [`genesis.json`](./genesis.json): canonical BPS-01 genesis.
- [`genesis.sha256`](./genesis.sha256): SHA-256 checksum for `genesis.json`.
- [`peers.json`](./peers.json): current public peer/seed status.
- [`endpoints.json`](./endpoints.json): machine-readable public endpoints.
- [`snapshot.md`](./snapshot.md): public snapshot details and restore steps.
- [`full-node.md`](./full-node.md): full node setup guide.
- [`validator.md`](./validator.md): validator setup guide.

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

## Check Public RPC

```bash
curl -fsS https://rpc.semarchain.my.id/status
curl -fsS https://rpc.semarchain.my.id/net_info
curl -fsS https://faucet.semarchain.my.id/healthz
curl -fsS https://explorer.semarchain.my.id/healthz
curl -fsS https://status.semarchain.my.id/healthz
```

Expected chain ID:

```text
bps-01
```

## Operator Notes

- Do not use the RPC HTTPS domain as a P2P seed unless a public P2P DNS record
  and port are explicitly listed in `peers.json`.
- Do not reuse example keys or local development wallets for production or
  validator operations.
- Keep validator keys offline or on a hardened host.
- Treat any leaked mnemonic, private key, or node key as compromised.
