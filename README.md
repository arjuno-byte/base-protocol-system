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
- Core P2P: raw TCP `IP_PUBLIC:26656`
- Public P2P peer:
  `17c0469a361fe1e9ecbe11058f8d5cb030992e82@13.229.41.228:26656`
- Core RPC: private/local only `tcp://127.0.0.1:26657`
- Public RPC/faucet/explorer/status: optional app layer, not required for core sync
- Snapshot: [`networks/bps-01/snapshot.md`](./networks/bps-01/snapshot.md)
- Tokenomics: [`TOKENOMICS.md`](./TOKENOMICS.md)
- Networking model: [`docs/bitcoin-style-networking.md`](./docs/bitcoin-style-networking.md)
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
- Public network, tokenomics, release, and operator policy documents
- Optional Windows validator dashboard in `apps/bps_validator_terminal/`

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

Join the public BPS-01 network from your own machine or server:

```bash
git clone https://github.com/arjuno-byte/base-protocol-system.git
cd base-protocol-system
make install

export BPS_HOME="$HOME/.bpsd"
export BPS_CHAIN_ID="bps-01"
export BPS_PUBLIC_PEER="17c0469a361fe1e9ecbe11058f8d5cb030992e82@13.229.41.228:26656"

bpsd init "my-bps-node" --chain-id "$BPS_CHAIN_ID" --home "$BPS_HOME"
cp networks/bps-01/genesis.json "$BPS_HOME/config/genesis.json"
sha256sum "$BPS_HOME/config/genesis.json"
cat networks/bps-01/genesis.sha256
```

Continue with the full node guide:
[`networks/bps-01/full-node.md`](./networks/bps-01/full-node.md).

## Repository Layout

```text
app/                 Cosmos SDK application wiring
apps/                Optional desktop tools for node operators
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
- `docs/bitcoin-style-networking.md` for raw TCP P2P and private RPC rules
- `docs/network-status.md` for public endpoint status
- `docs/reproducible-builds.md` for repeatable local builds
- `docs/release-process.md` for release and artifact rules
- `docs/governance.md` for upgrade policy
- `docs/validator-onboarding.md` for validator requirements
- `docs/slashing.md` for validator risk notes
- `docs/rpc-policy.md` for public RPC usage rules
- `docs/monitoring.md` for operator monitoring checks
- `docs/disaster-recovery.md` for incident response policy
- `docs/audit-status.md` for current audit status
- `docs/chain-registry.md` for ecosystem metadata
- `docs/release-checklist.md` for release preparation
- `docs/static/openapi.json` for generated API metadata
- `apps/bps_validator_terminal/README.md` for the Windows validator dashboard
- `TOKENOMICS.md` for public BPS supply and genesis allocation details
- `networks/bps-01/README.md` for public network join information
- `BUG_BOUNTY.md` for responsible disclosure scope

## Security

Security reports are welcome and should be handled privately. Please read
`SECURITY.md` before reporting a vulnerability.

Do not open public issues for untriaged security findings.

## Contributing

Contributions are welcome. Please read `CONTRIBUTING.md` for the expected
workflow, validation steps, and pull request quality bar.

## License

BPS Chain is licensed under the MIT License. See `LICENSE` for details.
