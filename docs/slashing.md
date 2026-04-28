# Slashing And Validator Risk

Validators are responsible for key safety and uptime.

## Main Risks

- Double signing.
- Extended downtime.
- Validator key compromise.
- Misconfigured sentry or P2P topology.
- Running unreviewed binaries.

## Operator Controls

- Use one active signing instance per validator key.
- Back up keys offline and encrypted.
- Monitor missed blocks.
- Keep the host patched.
- Test upgrades before production use.
- Do not expose validator private infrastructure unnecessarily.

## Incident Response

If a validator key is suspected compromised:

1. Stop the validator process.
2. Preserve logs for investigation.
3. Rotate infrastructure credentials.
4. Coordinate with maintainers before restarting.
5. Consider replacing the validator key through the appropriate chain process.
