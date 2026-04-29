class DashboardSectionActions {
  const DashboardSectionActions._();

  static const staking = [
    'Delegate: bpsd tx staking delegate <valoper> <amount>ubps --from <key>',
    'Undelegate: bpsd tx staking unbond <valoper> <amount>ubps --from <key>',
    'Redelegate: bpsd tx staking redelegate <src> <dst> <amount>ubps --from <key>',
  ];

  static const rewards = [
    'Claim rewards: bpsd tx distribution withdraw-rewards <valoper> --from <key>',
    'Claim commission: add --commission when validator key is available',
    'Dashboard mode: read-only, no private key is loaded',
  ];

  static const transactions = [
    'Search tx: bpsd query tx <hash> --node tcp://127.0.0.1:26657',
    'Mempool: curl http://127.0.0.1:26657/unconfirmed_txs',
    'Broadcast signed tx only from trusted CLI or wallet',
  ];

  static const governance = [
    'List proposals: bpsd query gov proposals',
    'Vote: bpsd tx gov vote <proposal-id> yes --from <key>',
    'Submit proposal only from secured operator key environment',
  ];

  static const help = [
    'Start local node first, then open this dashboard',
    'Keep RPC private on 127.0.0.1:26657',
    'Use raw TCP 26656 for P2P node networking',
  ];
}
