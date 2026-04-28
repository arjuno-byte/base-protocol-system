# RPC And API Policy

BPS core RPC is private by default.

## Core RPC

- Bind address: `tcp://127.0.0.1:26657`
- Scope: local operator tooling and local app-layer services
- Public exposure from core: disabled

Do not expose validator RPC directly to the internet.

## Optional Public RPC

A public RPC endpoint may be operated as an app-layer service with rate limits, body limits, CORS allowlists, monitoring, and abuse controls. It is not required for node sync and must not be used as a P2P seed or persistent peer.

## Recommended Production Setup

Production apps should run their own full node or use multiple RPC providers with failover. Critical services should not depend on a single public RPC endpoint.