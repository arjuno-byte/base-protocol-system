#!/usr/bin/env bash
set -euo pipefail

if ! command -v ignite >/dev/null 2>&1; then
  echo "ignite CLI is required. Install: https://docs.ignite.com"
  exit 1
fi

echo "Starting local development chain..."
ignite chain serve
