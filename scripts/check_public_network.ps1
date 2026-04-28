$ErrorActionPreference = "Stop"

$RpcUrl = $env:RPC_URL
if (-not $RpcUrl) { $RpcUrl = "https://rpc.semarchain.my.id" }
$ExpectedChainId = $env:EXPECTED_CHAIN_ID
if (-not $ExpectedChainId) { $ExpectedChainId = "bps-01" }
$FaucetHealth = $env:FAUCET_HEALTH
if (-not $FaucetHealth) { $FaucetHealth = "https://faucet.semarchain.my.id/healthz" }
$ExplorerHealth = $env:EXPLORER_HEALTH
if (-not $ExplorerHealth) { $ExplorerHealth = "https://explorer.semarchain.my.id/healthz" }
$StatusHealth = $env:STATUS_HEALTH
if (-not $StatusHealth) { $StatusHealth = "https://status.semarchain.my.id/healthz" }

$status = Invoke-RestMethod -Uri "$RpcUrl/status" -TimeoutSec 20
$chainId = $status.result.node_info.network
$height = $status.result.sync_info.latest_block_height
$catchingUp = $status.result.sync_info.catching_up

if ($chainId -ne $ExpectedChainId) { throw "unexpected_chain_id:$chainId" }
if ($catchingUp -ne $false) { throw "rpc_catching_up:$catchingUp" }

$netInfo = Invoke-RestMethod -Uri "$RpcUrl/net_info" -TimeoutSec 20
Invoke-RestMethod -Uri $FaucetHealth -TimeoutSec 20 | Out-Null
Invoke-RestMethod -Uri $ExplorerHealth -TimeoutSec 20 | Out-Null
Invoke-RestMethod -Uri $StatusHealth -TimeoutSec 20 | Out-Null

[PSCustomObject]@{
  chain_id = $chainId
  height = $height
  catching_up = $catchingUp
  peers = $netInfo.result.n_peers
  ok = $true
} | ConvertTo-Json -Compress
