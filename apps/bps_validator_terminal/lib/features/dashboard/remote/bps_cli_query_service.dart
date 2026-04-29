import '../domain/bps_module_snapshot.dart';
import '../domain/bps_module_snapshot_parser.dart';
import '../domain/bps_rpc_snapshot.dart';
import 'bps_cli_query_client.dart';

class BpsCliQueryService {
  BpsCliQueryService({BpsCliQueryClient? client})
    : _client = client ?? BpsCliQueryClient();

  final BpsCliQueryClient _client;

  Future<BpsModuleSnapshot> fetchSnapshot(BpsRpcSnapshot rpcSnapshot) async {
    final validators = await _client.query(['staking', 'validators']);
    final operator = _operatorForLocalNode(
      validators,
      rpcSnapshot.validatorPubKeyValue,
    );
    final signingAddress = await _client.consensusAddressFromHex(
      rpcSnapshot.validatorAddress,
    );
    final operatorData = operator == null
        ? const _OperatorQueryData.empty()
        : await _fetchOperatorData(operator);
    final chainData = await _fetchChainData();

    return BpsModuleSnapshotParser.parse(
      rpcSnapshot: rpcSnapshot,
      validators: validators,
      delegations: operatorData.delegations,
      unbonding: operatorData.unbonding,
      rewards: operatorData.rewards,
      commission: operatorData.commission,
      communityPool: chainData.communityPool,
      supply: chainData.supply,
      inflation: chainData.inflation,
      stakingPool: chainData.stakingPool,
      signingInfos: chainData.signingInfos,
      slashingParams: chainData.slashingParams,
      proposals: chainData.proposals,
      govParams: chainData.govParams,
      stakingParams: chainData.stakingParams,
      distributionParams: chainData.distributionParams,
      signingAddress: signingAddress,
    );
  }

  Future<_OperatorQueryData> _fetchOperatorData(String operator) async {
    final delegations = await _client.query([
      'staking',
      'delegations-to',
      operator,
    ]);
    final unbonding = await _client.query([
      'staking',
      'unbonding-delegations-from',
      operator,
    ]);
    final rewards = await _client.query([
      'distribution',
      'validator-outstanding-rewards',
      operator,
    ]);
    final commission = await _client.query([
      'distribution',
      'commission',
      operator,
    ]);
    return _OperatorQueryData(
      delegations: delegations,
      unbonding: unbonding,
      rewards: rewards,
      commission: commission,
    );
  }

  Future<_ChainQueryData> _fetchChainData() async {
    final communityPool = await _client.query([
      'distribution',
      'community-pool',
    ]);
    final supply = await _client.query(['bank', 'total']);
    final inflation = await _client.query(['mint', 'inflation']);
    final stakingPool = await _client.query(['staking', 'pool']);
    final signingInfos = await _client.query(['slashing', 'signing-infos']);
    final slashingParams = await _client.query(['slashing', 'params']);
    final proposals = await _client.query(['gov', 'proposals']);
    final govParams = await _client.query(['gov', 'params']);
    final stakingParams = await _client.query(['staking', 'params']);
    final distributionParams = await _client.query(['distribution', 'params']);
    return _ChainQueryData(
      communityPool: communityPool,
      supply: supply,
      inflation: inflation,
      stakingPool: stakingPool,
      signingInfos: signingInfos,
      slashingParams: slashingParams,
      proposals: proposals,
      govParams: govParams,
      stakingParams: stakingParams,
      distributionParams: distributionParams,
    );
  }

  String? _operatorForLocalNode(
    Map<String, Object?> validators,
    String? pubKeyValue,
  ) {
    if (pubKeyValue == null || pubKeyValue.isEmpty) {
      return null;
    }
    final rows = validators['validators'];
    if (rows is! List) {
      return null;
    }
    for (final item in rows.cast<Object?>().whereType<Map>()) {
      final key = item['consensus_pubkey'];
      if (key is Map && key['value']?.toString() == pubKeyValue) {
        final operator = item['operator_address']?.toString() ?? '';
        return operator.isEmpty ? null : operator;
      }
    }
    return null;
  }
}

class _OperatorQueryData {
  const _OperatorQueryData({
    required this.delegations,
    required this.unbonding,
    required this.rewards,
    required this.commission,
  });

  const _OperatorQueryData.empty()
    : delegations = const {},
      unbonding = const {},
      rewards = const {},
      commission = const {};

  final Map<String, Object?> delegations;
  final Map<String, Object?> unbonding;
  final Map<String, Object?> rewards;
  final Map<String, Object?> commission;
}

class _ChainQueryData {
  const _ChainQueryData({
    required this.communityPool,
    required this.supply,
    required this.inflation,
    required this.stakingPool,
    required this.signingInfos,
    required this.slashingParams,
    required this.proposals,
    required this.govParams,
    required this.stakingParams,
    required this.distributionParams,
  });

  final Map<String, Object?> communityPool;
  final Map<String, Object?> supply;
  final Map<String, Object?> inflation;
  final Map<String, Object?> stakingPool;
  final Map<String, Object?> signingInfos;
  final Map<String, Object?> slashingParams;
  final Map<String, Object?> proposals;
  final Map<String, Object?> govParams;
  final Map<String, Object?> stakingParams;
  final Map<String, Object?> distributionParams;
}
