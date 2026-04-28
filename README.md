# BPS Chain

BPS Chain is a sovereign Layer-1 blockchain built with Cosmos SDK and CometBFT.
This repository is the public source package for the chain node and core modules.

## Repository Scope

This repository intentionally contains source code only:

- Chain application and modules (`app/`, `x/`)
- Node command and runtime entrypoints (`cmd/`)
- Protocol definitions (`proto/`)
- Build/test/lint configuration

Excluded from this repository:

- Production server IP addresses
- Infrastructure inventory and private topology
- Secrets, keys, and operator credentials
- Runtime node data and local build artifacts

## Requirements

- Go `1.25+`
- Ignite CLI (optional, for local scaffold/dev workflows)

## Quick Start

```bash
make install
bpsd version
```

Run unit tests:

```bash
go test ./...
```

Run project checks via Makefile:

```bash
make test
make lint
```

Start local chain with helper scripts:

```bash
bash scripts/run_local_node.sh
```

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\run_local_node.ps1
```

## Development

Local development config lives in `config.yml`.
No production endpoint or infrastructure IP is embedded in this repository.
Optional environment variable placeholders are provided in `.env.example`.

## Security

Please read `SECURITY.md` before reporting vulnerabilities.
Do not open public issues for untriaged security findings.

## Contributing

Please read `CONTRIBUTING.md` for coding, review, and validation expectations.

## License

Licensed under the MIT License. See `LICENSE` for details.

---

Package generated from a private monorepo and sanitized for public open-source release.
Date: 2026-04-28.
