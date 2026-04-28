# Security Policy

BPS Chain is currently in active development and testnet hardening.
Security reports are handled with priority, especially issues related to consensus safety, key management, node compromise, or remote execution.

## Reporting a Vulnerability

Do **not** open a public issue for untriaged vulnerabilities.

Use one of these private channels:

1. GitHub Security Advisory (preferred)
2. Maintainer security contact (to be configured for production release)

## What to Include

Please provide:

- Vulnerability summary
- Impact and attack scenario
- Reproduction steps
- Affected commit/release
- Chain ID and block height (if relevant)
- Minimal proof-of-concept or logs

## Disclosure Policy

- We follow coordinated disclosure.
- Public disclosure should wait until triage and patch availability.
- Credit is provided to reporters unless anonymity is requested.

## Secret Handling Rules

Never publish:

- Seed phrases or mnemonics
- Validator private keys
- Faucet keys
- Infrastructure credentials

If a secret is leaked, treat it as compromised and rotate immediately.

## Supported Versions

Security support currently targets the active public testnet branch line.