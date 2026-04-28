$ErrorActionPreference = "Stop"

if (-not (Get-Command ignite -ErrorAction SilentlyContinue)) {
  Write-Error "ignite CLI is required. Install: https://docs.ignite.com"
}

Write-Host "Starting local development chain..."
ignite chain serve
