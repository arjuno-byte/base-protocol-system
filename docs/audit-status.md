# Audit Status

BPS keeps audit status public so contributors can understand the current risk
profile.

## Current Status

| Area | Status | Notes |
| --- | --- | --- |
| Source release hygiene | Complete | Public repo excludes private keys, mnemonics, server inventory, node DBs, and logs. |
| Tokenomics visibility | Complete | Hard cap and genesis allocation are documented in `TOKENOMICS.md`. |
| Public endpoint checks | Complete | RPC, faucet, explorer, status page, and snapshot are published. |
| Independent external audit | Pending public third-party report | Do not represent the chain as externally audited until a named third party report is published. |

## Security Review Scope

Recommended third-party review scope:

- Consensus and app wiring.
- Mint hard-cap enforcement.
- Genesis and tokenomics correctness.
- Upgrade process.
- Public node operations.
- Release workflow and artifact verification.

## Reporting

Security issues should follow `SECURITY.md` and should not be opened publicly
until triaged.
