# Monitoring

BPS-01 public monitoring focuses on chain liveness and endpoint availability.

## Public Checks

```bash
curl -fsS https://rpc.semarchain.my.id/status
curl -fsS https://rpc.semarchain.my.id/net_info
curl -fsS https://faucet.semarchain.my.id/healthz
curl -fsS https://explorer.semarchain.my.id/healthz
curl -fsS https://status.semarchain.my.id/healthz
```

## Key Metrics

- Latest block height.
- `catching_up` status.
- Peer count.
- RPC availability.
- Faucet health.
- Explorer health.
- Snapshot availability.

## Operator Alert Suggestions

- RPC down for more than 2 minutes.
- Block height not increasing for more than 5 minutes.
- `catching_up=true` on public RPC.
- Peer count drops unexpectedly.
- Disk usage above 80%.
- Validator missed blocks above the local threshold.
