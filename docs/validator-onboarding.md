# Validator Onboarding

This guide defines the public onboarding expectations for BPS validators.

## Minimum Requirements

- Dedicated Linux host or hardened VPS.
- SSH key login only.
- Firewall enabled.
- Time sync enabled.
- Secure validator key handling.
- Monitoring and alerting for missed blocks and disk usage.

## Before Joining

1. Build `bpsd` from a tagged release.
2. Verify BPS-01 genesis SHA-256.
3. Sync a full node first.
4. Keep validator mnemonic offline.
5. Never publish `priv_validator_key.json`, `node_key.json`, or mnemonic.

## Public Join Status

Public P2P seed publication is still pending upstream raw TCP exposure. New
external validators should wait for `seeds` or `persistent_peers` in
[`networks/bps-01/peers.json`](../networks/bps-01/peers.json) before expecting
live sync from the public network.

## Validator Command Pattern

Use the Cosmos SDK `create-validator` flow after the node is synced and funded.
Exact commission and self-delegation parameters should be reviewed before
broadcasting.
