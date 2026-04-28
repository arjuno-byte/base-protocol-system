# Public Network Status

This document summarizes public BPS-01 services.

## Live Services

| Service | URL | Status |
| --- | --- | --- |
| RPC | `https://rpc.semarchain.my.id` | Online |
| RPC status | `https://rpc.semarchain.my.id/status` | Online |
| RPC net info | `https://rpc.semarchain.my.id/net_info` | Online |
| Faucet | `https://faucet.semarchain.my.id/faucet` | Online |
| Faucet health | `https://faucet.semarchain.my.id/healthz` | Online |
| Explorer | `https://explorer.semarchain.my.id` | Online |
| Explorer health | `https://explorer.semarchain.my.id/healthz` | Online |
| Status page | `https://status.semarchain.my.id` | Online |
| Status health | `https://status.semarchain.my.id/healthz` | Online |
| Snapshot | `https://status.semarchain.my.id/snapshots/bps-01-rpc-snapshot-19200-20260428T212502Z.tar.gz` | Published |

## P2P Status

Raw CometBFT P2P is not the same as HTTPS RPC. The BPS host firewall has seed
and RPC P2P ports prepared, but public raw TCP still requires an upstream port
forward, public VPS, or equivalent TCP ingress.

Current public P2P status is tracked in
[`networks/bps-01/peers.json`](../networks/bps-01/peers.json).

## Verification Commands

```bash
curl -fsS https://rpc.semarchain.my.id/status
curl -fsS https://rpc.semarchain.my.id/net_info
curl -fsS https://faucet.semarchain.my.id/healthz
curl -fsS https://explorer.semarchain.my.id/healthz
curl -fsS https://status.semarchain.my.id/healthz
```
