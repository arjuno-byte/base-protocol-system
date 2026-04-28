# Public RPC And API Policy

BPS public RPC is provided for developer and operator convenience.

## Endpoint

- RPC: `https://rpc.semarchain.my.id`
- Status: `https://rpc.semarchain.my.id/status`
- Net info: `https://rpc.semarchain.my.id/net_info`

## Usage Guidelines

- Cache repeated reads when possible.
- Avoid unbounded polling loops.
- Use your own full node for production applications.
- Do not depend on public RPC as the only backend for critical services.

## Abuse Controls

Public RPC may use rate limits, body size limits, CORS allowlists, and temporary
IP blocking to protect the network.

## Recommended Production Setup

Production apps should run their own full node or use multiple RPC providers
with failover.
