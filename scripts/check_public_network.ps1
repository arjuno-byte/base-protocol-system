$ErrorActionPreference = "Stop"

$RpcUrl = $env:RPC_URL
if (-not $RpcUrl) { $RpcUrl = "http://127.0.0.1:26657" }
$ExpectedChainId = $env:EXPECTED_CHAIN_ID
if (-not $ExpectedChainId) { $ExpectedChainId = "bps-01" }
$P2PHost = $env:P2P_HOST
$P2PPort = $env:P2P_PORT
if (-not $P2PPort) { $P2PPort = "26656" }
$FaucetHealth = $env:FAUCET_HEALTH
$ExplorerHealth = $env:EXPLORER_HEALTH
$StatusHealth = $env:STATUS_HEALTH

$status = Invoke-RestMethod -Uri "$RpcUrl/status" -TimeoutSec 20
$chainId = $status.result.node_info.network
$height = $status.result.sync_info.latest_block_height
$catchingUp = $status.result.sync_info.catching_up

if ($chainId -ne $ExpectedChainId) { throw "unexpected_chain_id:$chainId" }
if ($catchingUp -ne $false) { throw "rpc_catching_up:$catchingUp" }

$netInfo = Invoke-RestMethod -Uri "$RpcUrl/net_info" -TimeoutSec 20

$p2pReachable = $null
if ($P2PHost) {
  $p2pReachable = Test-NetConnection $P2PHost -Port ([int]$P2PPort)
}

foreach ($url in @($FaucetHealth, $ExplorerHealth, $StatusHealth)) {
  if ($url) { Invoke-RestMethod -Uri $url -TimeoutSec 20 | Out-Null }
}

[PSCustomObject]@{
  chain_id = $chainId
  height = $height
  catching_up = $catchingUp
  peers = $netInfo.result.n_peers
  rpc_scope = "local_private_only"
  p2p_host = $P2PHost
  p2p_port = $P2PPort
  p2p_checked = [bool]$P2PHost
  p2p_tcp_succeeded = if ($p2pReachable) { $p2pReachable.TcpTestSucceeded } else { $null }
  ok = $true
} | ConvertTo-Json -Compress