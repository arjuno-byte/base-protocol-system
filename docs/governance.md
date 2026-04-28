# Governance And Upgrade Policy

BPS-01 is operated with conservative upgrade rules.

## Upgrade Principles

- Security fixes can be expedited when user funds or chain safety are at risk.
- Consensus-breaking changes require a coordinated release and validator notice.
- Genesis changes are not applied to a running network. They create a new
  network unless explicitly handled through an accepted upgrade path.
- Tokenomics changes require public rationale and maintainer approval.

## Upgrade Flow

1. Open an issue or proposal describing the change.
2. Include risk, migration, rollback, and validation notes.
3. Publish a release candidate.
4. Validators test on non-production nodes.
5. Announce activation height or manual upgrade window.
6. Monitor chain health after activation.

## Emergency Flow

If a critical vulnerability is found, use private security disclosure first.
Public details should wait until operators have a safe mitigation path.
