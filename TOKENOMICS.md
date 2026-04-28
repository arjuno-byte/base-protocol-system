# BPS Tokenomics

This document summarizes the public token parameters for BPS (Base Protocol
System). It is intended to help node operators, contributors, and reviewers
understand the supply rules that are visible in the source code and canonical
network genesis.

## Token

| Field | Value |
| --- | --- |
| Display denom | `BPS` |
| Base denom | `ubps` |
| Precision | `1 BPS = 1,000,000 ubps` |
| Public network | `bps-01` |
| Genesis file | [`networks/bps-01/genesis.json`](./networks/bps-01/genesis.json) |
| Genesis SHA-256 | `6ff985ebd1ab87fbf579ac81b1ef1b6c9cff059018a72c5a2af5bdb3c0a184b8` |

## Supply

| Metric | BPS | ubps | Notes |
| --- | ---: | ---: | --- |
| Maximum supply hard cap | 100,000,000 | 100,000,000,000,000 | Enforced by application mint logic |
| Genesis supply | 75,000,000 | 75,000,000,000,000 | Recorded in BPS-01 genesis |
| Remaining mintable supply | 25,000,000 | 25,000,000,000,000 | Available only until the hard cap is reached |

The maximum supply hard cap is enforced in
[`app/mint_hardcap.go`](./app/mint_hardcap.go). The mint function clamps block
provisions so total `ubps` supply cannot exceed `100,000,000 BPS`.

## Minting Parameters

The BPS-01 genesis uses the Cosmos SDK mint module with `ubps` as the mint
denom. Current public genesis parameters are:

| Parameter | Value |
| --- | ---: |
| Initial inflation | `0.130000000000000000` |
| Minimum inflation | `0.070000000000000000` |
| Maximum inflation | `0.200000000000000000` |
| Inflation rate change | `0.130000000000000000` |
| Goal bonded ratio | `0.670000000000000000` |
| Blocks per year | `6311520` |

Actual issuance depends on chain activity, staking conditions, and block
production. Regardless of the inflation calculation, new minting is bounded by
the hard cap.

## Genesis Allocation

The canonical genesis file records balances by address. This document does not
assign labels such as team, founder, treasury, investor, or community unless
those labels are explicitly published by maintainers or governance. This keeps
the public record accurate while avoiding wallet mislabeling.

| Address | BPS | % of genesis supply | % of max supply |
| --- | ---: | ---: | ---: |
| `bps1x0r56d4et4kkg9z9r8pep3cfurq8h2hn75zz35` | 1,000 | 0.001333% | 0.001000% |
| `bps1tr3fgaj5ledretx8qy0cc2gq9kgyzt0czazu3p` | 19,998,000 | 26.664000% | 19.998000% |
| `bps1tjzre8eatkem8n24h6j9phn6p5vnz5zj4hd729` | 15,000,000 | 20.000000% | 15.000000% |
| `bps137qezcxmeu0ly0ndeuw6lxgh6nxr2hah90pkwd` | 1,000 | 0.001333% | 0.001000% |
| `bps1mlzq2carm82y8cfmws7sxxf9lz74d0kvlaz7ef` | 40,000,000 | 53.333333% | 40.000000% |
| Total | 75,000,000 | 100.000000% | 75.000000% |

## Network Integrity

Public node operators verify the official network by matching:

- Chain ID: `bps-01`
- Genesis file: [`networks/bps-01/genesis.json`](./networks/bps-01/genesis.json)
- Genesis SHA-256:
  `6ff985ebd1ab87fbf579ac81b1ef1b6c9cff059018a72c5a2af5bdb3c0a184b8`

Anyone can modify the source code or genesis file in their own copy, but that
creates a separate fork unless the change is adopted by the official network
through a coordinated upgrade path.

## Security Boundary

Tokenomics data is public by design. This document does not include private
keys, mnemonics, validator signing keys, server credentials, private topology,
or operator-only deployment material.
