import 'package:bps_validator_terminal/features/dashboard/domain/bps_rpc_snapshot.dart';

class BpsModuleSnapshotFixtures {
  const BpsModuleSnapshotFixtures._();

  static BpsRpcSnapshot rpcSnapshot({required String pubKey}) {
    return BpsRpcSnapshot(
      rpcEndpoint: 'http://127.0.0.1:26657/',
      rpcLatency: const Duration(milliseconds: 20),
      chainId: 'bps-test',
      moniker: 'validator0',
      nodeId: 'node-id',
      version: '0.38.0',
      p2pListenAddress: 'tcp://0.0.0.0:26656',
      rpcListenAddress: 'tcp://127.0.0.1:26657',
      txIndex: 'on',
      latestHeight: 100,
      latestBlockTime: DateTime.utc(2026),
      latestBlockHash: 'BLOCKHASH',
      latestAppHash: 'APPHASH',
      latestBlockTxCount: 0,
      catchingUp: false,
      validatorAddress: 'ABCDEF',
      validatorPubKeyValue: pubKey,
      validatorVotingPower: 100,
      peerCount: 1,
      totalValidators: 1,
      totalVotingPower: 100,
      validatorRank: 1,
      validatorPowerPercent: 100,
      indexedTxCount: 0,
      mempoolTxCount: 0,
      mempoolBytes: 0,
      latestTxHash: null,
    );
  }

  static Map<String, Object?> validators({required String pubKey}) => {
    'validators': [
      {
        'operator_address': 'bpsvaloper1abc',
        'consensus_pubkey': {'value': pubKey},
        'status': 'BOND_STATUS_BONDED',
        'tokens': '100000000',
        'jailed': false,
        'description': {'moniker': 'validator0'},
        'commission': {
          'commission_rates': {'rate': '0.050000000000000000'},
        },
      },
    ],
  };

  static const delegations = {
    'delegation_responses': [
      {
        'delegation': {'delegator_address': 'bps1abc'},
        'balance': {'denom': 'ubps', 'amount': '100000000'},
      },
    ],
  };

  static const unbonding = {'unbonding_responses': []};
  static const rewards = {
    'rewards': {
      'rewards': ['12000000.5ubps'],
    },
  };
  static const commission = {
    'commission': {
      'commission': [
        {'denom': 'ubps', 'amount': '5000000'},
      ],
    },
  };
  static const communityPool = {
    'pool': ['1000000ubps'],
  };
  static const supply = {
    'supply': [
      {'denom': 'ubps', 'amount': '1000000000'},
    ],
  };
  static const inflation = {'inflation': '0.13'};
  static const stakingPool = {
    'pool': {'bonded_tokens': '100000000', 'not_bonded_tokens': '0'},
  };
}
