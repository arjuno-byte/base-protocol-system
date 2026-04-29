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

Public P2P is available through the raw TCP peer published in
[`networks/bps-01/peers.json`](../networks/bps-01/peers.json). New external
validators should sync a full node first using the published `persistent_peers`
entry before creating or broadcasting validator transactions.

Current public peer:

```text
17c0469a361fe1e9ecbe11058f8d5cb030992e82@13.229.41.228:26656
```

## Validator Command Pattern

Use the Cosmos SDK `create-validator` flow after the node is synced and funded.
Exact commission and self-delegation parameters should be reviewed before
broadcasting.
