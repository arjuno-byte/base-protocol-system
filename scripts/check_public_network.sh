#!/usr/bin/env bash
set -euo pipefail

RPC_URL="${RPC_URL:-https://rpc.semarchain.my.id}"
FAUCET_HEALTH="${FAUCET_HEALTH:-https://faucet.semarchain.my.id/healthz}"
EXPLORER_HEALTH="${EXPLORER_HEALTH:-https://explorer.semarchain.my.id/healthz}"
STATUS_HEALTH="${STATUS_HEALTH:-https://status.semarchain.my.id/healthz}"
EXPECTED_CHAIN_ID="${EXPECTED_CHAIN_ID:-bps-01}"

echo "[bps] checking RPC status"
status_json="$(curl -fsS "${RPC_URL}/status")"
chain_id="$(printf '%s' "${status_json}" | jq -r '.result.node_info.network')"
catching_up="$(printf '%s' "${status_json}" | jq -r '.result.sync_info.catching_up')"
height="$(printf '%s' "${status_json}" | jq -r '.result.sync_info.latest_block_height')"

if [[ "${chain_id}" != "${EXPECTED_CHAIN_ID}" ]]; then
  echo "ERROR=unexpected_chain_id:${chain_id}"
  exit 1
fi
if [[ "${catching_up}" != "false" ]]; then
  echo "ERROR=rpc_catching_up:${catching_up}"
  exit 1
fi

echo "CHAIN_ID=${chain_id}"
echo "HEIGHT=${height}"
echo "CATCHING_UP=${catching_up}"

echo "[bps] checking net_info"
curl -fsS "${RPC_URL}/net_info" | jq -r '"LISTENING=" + (.result.listening|tostring), "N_PEERS=" + .result.n_peers'

echo "[bps] checking public services"
curl -fsS "${FAUCET_HEALTH}" >/dev/null
curl -fsS "${EXPLORER_HEALTH}" >/dev/null
curl -fsS "${STATUS_HEALTH}" >/dev/null

echo "OK=public_network_checks_passed"
