#!/usr/bin/env bash
set -euo pipefail

RPC_URL="${RPC_URL:-http://127.0.0.1:26657}"
P2P_HOST="${P2P_HOST:-}"
P2P_PORT="${P2P_PORT:-26656}"
FAUCET_HEALTH="${FAUCET_HEALTH:-}"
EXPLORER_HEALTH="${EXPLORER_HEALTH:-}"
STATUS_HEALTH="${STATUS_HEALTH:-}"
EXPECTED_CHAIN_ID="${EXPECTED_CHAIN_ID:-bps-01}"

check_optional_url() {
  local name="$1"
  local url="$2"
  if [[ -z "${url}" ]]; then
    echo "SKIP_${name}=not_configured_optional_app_layer"
    return
  fi
  curl -fsS "${url}" >/dev/null
  echo "OK_${name}=${url}"
}

echo "[bps] checking local/private RPC"
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
echo "RPC_SCOPE=local_private_only"

echo "[bps] checking local net_info"
curl -fsS "${RPC_URL}/net_info" | jq -r '"LISTENING=" + (.result.listening|tostring), "N_PEERS=" + .result.n_peers'

if [[ -n "${P2P_HOST}" ]]; then
  echo "[bps] checking external raw TCP P2P ${P2P_HOST}:${P2P_PORT}"
  nc -vz "${P2P_HOST}" "${P2P_PORT}"
else
  echo "SKIP_P2P_EXTERNAL=P2P_HOST_not_set"
fi

echo "[bps] checking optional app-layer services"
check_optional_url FAUCET "${FAUCET_HEALTH}"
check_optional_url EXPLORER "${EXPLORER_HEALTH}"
check_optional_url STATUS "${STATUS_HEALTH}"

echo "OK=core_network_checks_passed"