<p align="center">
  <img src="docs/assets/bps-coin.png" width="108" alt="BPS coin icon">
</p>

<h1 align="center">BPS (BASE PROTOCOL SYSTEM)</h1>

<p align="center">
  BPS Chain public blockchain source.
</p>

BPS Chain is a sovereign Layer 1 blockchain built with the Cosmos SDK and
CometBFT. This repository contains the public node source, protocol definitions,
and core application modules needed to build, test, and run the chain locally.

The goal of this package is simple: keep the public codebase clean, auditable,
and easy for contributors to approach.

## Public Network

Public BPS-01 network information is published in
[`networks/bps-01/`](./networks/bps-01/):

- Chain ID: `bps-01`
- Genesis: [`networks/bps-01/genesis.json`](./networks/bps-01/genesis.json)
- Genesis SHA-256:
  `6ff985ebd1ab87fbf579ac81b1ef1b6c9cff059018a72c5a2af5bdb3c0a184b8`
- Public RPC: `https://rpc.semarchain.my.id`
- Full node guide: [`networks/bps-01/full-node.md`](./networks/bps-01/full-node.md)
- Validator guide: [`networks/bps-01/validator.md`](./networks/bps-01/validator.md)

## What Is Included

- Chain application wiring in `app/`
- Node command entrypoint in `cmd/bpsd/`
- Custom module code in `x/bps/`
- Protocol definitions in `proto/`
- OpenAPI generation output in `docs/static/openapi.json`
- Build, test, lint, issue, and release automation
- Local development helper scripts in `scripts/`

## What Is Not Included

This repository intentionally excludes operational material that should not live
in a public source tree:

- Private keys, validator keys, mnemonics, or node key material
- Production server inventory, private topology, and deployment credentials
- Runtime node databases, snapshots, logs, and local build artifacts
- Wallet applications, public infrastructure services, and operator-only notes

## Requirements

- Go `1.25.6` or newer compatible Go 1.25 patch release
- `make`
- A C toolchain supported by Cosmos SDK dependencies
- Ignite CLI for protobuf regeneration and scaffold-oriented development

## Quick Start

Install the node binary:

```bash
make install
bpsd version
```

Run the test suite:

```bash
go test ./...
```

Run the standard project checks:

```bash
make test
make lint
```

Start a local development chain:

```bash
bash scripts/run_local_node.sh
```

On Windows PowerShell:

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\run_local_node.ps1
```

## Repository Layout

```text
app/                 Cosmos SDK application wiring
cmd/bpsd/            Node binary entrypoint and CLI commands
docs/                Generated API docs and templates
proto/               Protobuf service and message definitions
scripts/             Local development helpers
testutil/            Test helpers
x/bps/               BPS module keeper, types, and module registration
```

## Local Configuration

`config.yml` is intended for local development only. The sample accounts and
validators are not production identities.

`.env.example` documents optional environment variables for local tooling. Copy
it to `.env` only for local experiments, and never commit real secrets.

Helpful references:

- `docs/architecture.md` for a high-level system overview
- `docs/release-checklist.md` for release preparation
- `docs/static/openapi.json` for generated API metadata
- `networks/bps-01/README.md` for public network join information

## Security

Security reports are welcome and should be handled privately. Please read
`SECURITY.md` before reporting a vulnerability.

Do not open public issues for untriaged security findings.

## Contributing

Contributions are welcome. Please read `CONTRIBUTING.md` for the expected
workflow, validation steps, and pull request quality bar.

## License

BPS Chain is licensed under the MIT License. See `LICENSE` for details.
