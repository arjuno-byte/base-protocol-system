# BPS Validator Terminal

Windows desktop validator dashboard for BPS Chain.

This app provides a terminal-style operator interface for monitoring validator
status, node health, staking, rewards, delegations, recent events, and quick
validator query status.

## Current Status

- UI shell is implemented with Flutter Windows.
- Dashboard reads local BPS/CometBFT RPC from `http://127.0.0.1:26657`.
- Live panels use `/status`, `/net_info`, and `/validators`.
- Staking, rewards, commission, jailed status, delegation, slashing, supply,
  inflation, and governance counts are read through local `bpsd query` commands.
- No private keys, mnemonics, node keys, RPC credentials, or production secrets
  are stored in this app.

## Run Locally

```bash
flutter pub get
flutter run -d windows
```

## Build Release

```bash
flutter build windows
```

The release executable is generated at:

```text
build/windows/x64/runner/Release/bps_validator_terminal.exe
```

## RPC Requirement

Run the BPS node with private localhost RPC:

```text
rpc.laddr = "tcp://127.0.0.1:26657"
```

Do not expose this RPC directly to the public internet.

## CLI Requirement

The dashboard needs the BPS node binary so it can run read-only Cosmos queries:

```bash
bpsd query staking validators --node tcp://127.0.0.1:26657 --output json
```

The app resolves `bpsd` in this order:

- `BPSD_PATH` environment variable
- `chain/bpsd.exe` in this repository tree
- `bpsd.exe` or `bpsd` from `PATH`

All CLI calls are read-only. The dashboard does not sign transactions and does
not load wallet keys.
