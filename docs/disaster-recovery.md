# Disaster Recovery And Incident Policy

This policy defines the first response for BPS-01 incidents.

## Incident Types

- Chain halt.
- RPC outage.
- Snapshot corruption.
- Public endpoint abuse.
- Validator key compromise.
- Suspected consensus bug.
- Secret exposure.

## Immediate Actions

1. Preserve logs and current state.
2. Avoid deleting evidence.
3. Identify impact: read-only outage, transaction impact, consensus risk, or key compromise.
4. Communicate status to operators.
5. Apply the smallest safe mitigation.
6. Publish a post-incident note after resolution.

## Recovery Priorities

1. Protect keys and funds.
2. Restore consensus safety.
3. Restore public RPC/status visibility.
4. Restore faucet/explorer convenience services.
5. Publish clear operator instructions.

## Secret Exposure

Any leaked mnemonic, validator key, node key, server credential, or API token is
considered compromised and must be rotated.
