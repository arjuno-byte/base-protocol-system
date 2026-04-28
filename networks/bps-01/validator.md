# Run a BPS-01 Validator

This guide is for operators who want to prepare a validator for `bps-01`.
Validator operation is security-sensitive. Do not run a validator until you have
a hardened host, secure key custody, monitoring, and a tested recovery process.

## Before You Start

- Run a fully synced full node first.
- Keep validator mnemonic and private keys offline whenever possible.
- Do not publish private keys, node keys, mnemonics, or server credentials.
- Confirm the public genesis hash before creating any validator transaction.

## Chain Parameters

| Field | Value |
| --- | --- |
| Chain ID | `bps-01` |
| Bond denom | `ubps` |
| Display denom | `BPS` |
| Genesis SHA-256 | `6ff985ebd1ab87fbf579ac81b1ef1b6c9cff059018a72c5a2af5bdb3c0a184b8` |
| Public RPC | `https://rpc.semarchain.my.id` |

## Create Operator Key

```bash
bpsd keys add validator
```

Store the mnemonic securely. Anyone with this mnemonic can control the validator
operator account.

## Create Validator Transaction

Replace the values before running:

```bash
bpsd tx staking create-validator \
  --amount 1000000ubps \
  --pubkey "$(bpsd comet show-validator)" \
  --moniker "my-bps-validator" \
  --identity "" \
  --website "" \
  --security-contact "" \
  --details "BPS validator" \
  --chain-id bps-01 \
  --commission-rate "0.10" \
  --commission-max-rate "0.20" \
  --commission-max-change-rate "0.01" \
  --min-self-delegation "1" \
  --from validator \
  --gas auto \
  --gas-adjustment 1.4 \
  --fees 5000ubps
```

## Monitor

```bash
bpsd status
bpsd query staking validator "$(bpsd keys show validator --bech val -a)"
```

## Security Checklist

- SSH root login disabled.
- Password SSH login disabled.
- Firewall only exposes required ports.
- Validator key backed up and encrypted.
- Node key and validator key are not committed to Git.
- Monitoring alerts cover missed blocks, low peers, disk usage, and service
  restarts.
