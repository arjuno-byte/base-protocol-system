# Security Policy

Security reports are taken seriously, especially issues that may affect
consensus safety, transaction validity, key management, node availability, or
remote code execution.

## Reporting a Vulnerability

Please do not open a public GitHub issue for an untriaged vulnerability.

Preferred private reporting channel:

- GitHub Security Advisory for this repository

If Security Advisories are not available in your fork or mirror, contact the
maintainers through the private security contact configured by the repository
owner.

## What to Include

Please include as much of the following as possible:

- Short vulnerability summary
- Impact and attack scenario
- Reproduction steps
- Affected commit, tag, or release
- Chain ID and block height, if relevant
- Minimal proof of concept, logs, or transaction data
- Suggested mitigation, if you already have one

Clear reports help maintainers triage faster.

## Disclosure Policy

- We use coordinated disclosure.
- Public disclosure should wait until the issue has been triaged and a patch or
  mitigation is available.
- Reporter credit is welcome unless anonymity is requested.
- If exploitation is active, maintainers may prioritize emergency mitigation
  over a normal release cadence.

## Secret Handling Rules

Never publish:

- Seed phrases or mnemonics
- Validator private keys or node keys
- Faucet keys or operator credentials
- Private infrastructure details

If a secret is leaked, treat it as compromised, rotate it immediately, and audit
recent activity.

## Supported Versions

Security support currently targets the active testnet and release-candidate
branch line. Older experimental branches are not guaranteed to receive fixes.
