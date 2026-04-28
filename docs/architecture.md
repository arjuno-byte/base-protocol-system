# Architecture Overview

BPS Chain is structured as a Cosmos SDK application with CometBFT consensus.
The repository keeps the chain application, CLI entrypoint, custom module, and
protocol definitions in separate areas so each layer can evolve with a clear
responsibility.

## Core Components

- `app/` wires Cosmos SDK modules, keepers, stores, parameters, and application
  lifecycle hooks.
- `cmd/bpsd/` provides the node binary entrypoint and CLI commands.
- `x/bps/` contains the custom BPS module, including keeper logic, message
  handling, queries, and module registration.
- `proto/` defines the public protobuf API used by generated Go types and
  client integrations.
- `docs/static/openapi.json` contains generated OpenAPI metadata for API
  consumers.

## Execution Model

Transactions enter through the node RPC or CLI, are checked by CometBFT and the
Cosmos SDK transaction pipeline, then execute against deterministic application
state. Module keepers own state transitions and must preserve validation,
authorization, and invariant boundaries.

## Security Boundaries

- Consensus and state transitions must remain deterministic.
- Private keys, node keys, validator keys, and mnemonics must never be committed
  to the repository.
- Governance-controlled parameters should be reviewed as protocol changes, not
  as simple configuration edits.
- Local development accounts in `config.yml` are not production identities.

## Operator Boundary

This source package does not include production infrastructure, private topology,
or runtime node data. Operators should manage deployment configuration, keys,
snapshots, monitoring, and incident response outside the public source tree.
