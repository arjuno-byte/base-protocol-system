# Release Process

BPS releases are published from Git tags.

## Release Types

- `vMAJOR.MINOR.PATCH-rcN`: release candidate / prerelease.
- `vMAJOR.MINOR.PATCH`: stable release.

## Required Checks

Before tagging:

```bash
go test ./...
make lint
```

If a tool is unavailable, document the reason in release notes.

## Assets

The GitHub release workflow builds release assets, generates `SHA256SUMS`, and
publishes Sigstore/cosign bundles when GitHub OIDC signing is available.

## Tagging

```bash
git tag v1.0.0-rc4
git push origin v1.0.0-rc4
```

## Notes

Release artifacts must not include private keys, node databases, mnemonics,
server inventory, or private deployment material.
