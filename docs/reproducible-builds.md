# Reproducible Builds

This guide documents a repeatable local build process for `bpsd`.

## Requirements

- Go `1.25.6` or newer compatible Go 1.25 patch release
- Git
- `make`
- Clean working tree

## Source Verification

```bash
git clone https://github.com/arjuno-byte/base-protocol-system.git
cd base-protocol-system
git fetch --tags
git checkout <release-tag>
git status --short
```

The working tree should be clean.

## Deterministic Go Build Inputs

Use stable build flags:

```bash
export CGO_ENABLED=0
export GOFLAGS="-buildvcs=false -trimpath"
export VERSION="$(git describe --tags --always)"
export COMMIT="$(git rev-parse HEAD)"
```

Build Linux amd64:

```bash
GOOS=linux GOARCH=amd64 go build \
  -trimpath \
  -ldflags "-s -w -X github.com/cosmos/cosmos-sdk/version.Name=bps -X github.com/cosmos/cosmos-sdk/version.AppName=bpsd -X github.com/cosmos/cosmos-sdk/version.Version=${VERSION} -X github.com/cosmos/cosmos-sdk/version.Commit=${COMMIT}" \
  -o dist/bpsd-linux-amd64 ./cmd/bpsd
```

Generate checksums:

```bash
cd dist
sha256sum * > SHA256SUMS
```

## Release Verification

For official releases, verify:

1. Git tag matches the release notes.
2. `SHA256SUMS` matches downloaded assets.
3. Sigstore/cosign bundles are present when published by GitHub Actions.
4. `bpsd version` reports the expected version and commit.
