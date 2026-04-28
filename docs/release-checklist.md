# Release Checklist

Use this checklist before publishing a release candidate or production release.

## Source Quality

- `go test ./...` passes.
- `make lint` passes or known findings are documented.
- Generated protobuf and OpenAPI files are up to date.
- The working tree is clean before tagging.

## Security

- No private keys, mnemonics, `.env` files, snapshots, logs, or node databases
  are included.
- Dependency vulnerability scans have been reviewed.
- Security-impacting changes are called out in release notes.

## Chain Safety

- Genesis-impacting changes are documented.
- Parameter changes are reviewed by maintainers.
- State migration requirements are documented.
- Local development config remains clearly separated from production config.

## Release Assets

- Release tag follows the `vMAJOR.MINOR.PATCH` or `vMAJOR.MINOR.PATCH-rcN`
  format.
- Built binaries are attached to the GitHub release when applicable.
- Checksums are generated for release assets.
- Sigstore/cosign bundles are generated for release assets when GitHub OIDC is
  available.
- Release notes include upgrade notes and known limitations.

## Post Release

- CI status is green for the published tag.
- Issues and discussions are monitored for regressions.
- Any discovered secret exposure is treated as an incident and rotated
  immediately.
