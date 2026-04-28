# Monitoring

Core BPS monitoring should read local/private RPC and raw TCP P2P status.

## Local Node Checks

```bash
bpsd status --node tcp://127.0.0.1:26657
curl -fsS http://127.0.0.1:26657/status
curl -fsS http://127.0.0.1:26657/net_info
```

## External P2P Check

Run from outside the node network:

```bash
nc -vz IP_PUBLIC 26656
```

PowerShell:

```powershell
Test-NetConnection IP_PUBLIC -Port 26656
```

## Optional App Checks

If an operator publishes optional app-layer services, monitor those service URLs separately. They are not used for P2P sync, seed discovery, persistent peers, or genesis configuration.