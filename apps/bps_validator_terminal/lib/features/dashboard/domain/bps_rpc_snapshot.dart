import 'rpc_value_parser.dart';
import 'validator_set_parser.dart';

class BpsRpcSnapshot {
  const BpsRpcSnapshot({
    required this.rpcEndpoint,
    required this.rpcLatency,
    required this.chainId,
    required this.moniker,
    required this.nodeId,
    required this.version,
    required this.p2pListenAddress,
    required this.rpcListenAddress,
    required this.txIndex,
    required this.latestHeight,
    required this.latestBlockTime,
    required this.latestBlockHash,
    required this.latestAppHash,
    required this.latestBlockTxCount,
    required this.catchingUp,
    required this.validatorAddress,
    required this.validatorPubKeyValue,
    required this.validatorVotingPower,
    required this.peerCount,
    required this.totalValidators,
    required this.totalVotingPower,
    required this.validatorRank,
    required this.validatorPowerPercent,
    required this.indexedTxCount,
    required this.mempoolTxCount,
    required this.mempoolBytes,
    required this.latestTxHash,
  });

  final String rpcEndpoint;
  final Duration rpcLatency;
  final String? chainId;
  final String? moniker;
  final String? nodeId;
  final String? version;
  final String? p2pListenAddress;
  final String? rpcListenAddress;
  final String? txIndex;
  final int? latestHeight;
  final DateTime? latestBlockTime;
  final String? latestBlockHash;
  final String? latestAppHash;
  final int? latestBlockTxCount;
  final bool catchingUp;
  final String? validatorAddress;
  final String? validatorPubKeyValue;
  final int? validatorVotingPower;
  final int? peerCount;
  final int? totalValidators;
  final int? totalVotingPower;
  final int? validatorRank;
  final double? validatorPowerPercent;
  final int? indexedTxCount;
  final int? mempoolTxCount;
  final int? mempoolBytes;
  final String? latestTxHash;

  bool get isValidator => (validatorVotingPower ?? 0) > 0;

  factory BpsRpcSnapshot.fromRpc({
    required String rpcEndpoint,
    required Duration rpcLatency,
    required Map<String, Object?> status,
    Map<String, Object?>? netInfo,
    Map<String, Object?>? validators,
    Map<String, Object?>? block,
    Map<String, Object?>? txSearch,
    Map<String, Object?>? mempool,
  }) {
    final statusResult = RpcValueParser.map(status['result']);
    final syncInfo = RpcValueParser.map(statusResult['sync_info']);
    final nodeInfo = RpcValueParser.map(statusResult['node_info']);
    final nodeOther = RpcValueParser.map(nodeInfo['other']);
    final protocolVersion = RpcValueParser.map(nodeInfo['protocol_version']);
    final validatorInfo = RpcValueParser.map(statusResult['validator_info']);
    final validatorPubKey = RpcValueParser.map(validatorInfo['pub_key']);
    final blockResult = RpcValueParser.map(block?['result']);
    final blockData = RpcValueParser.map(blockResult['block']);
    final blockId = RpcValueParser.map(blockResult['block_id']);
    final blockHeader = RpcValueParser.map(blockData['header']);
    final blockTxData = RpcValueParser.map(blockData['data']);
    final txResult = RpcValueParser.map(txSearch?['result']);
    final txRows = RpcValueParser.list(txResult['txs']);
    final mempoolResult = RpcValueParser.map(mempool?['result']);
    final validatorSet = ValidatorSetParser.parse(validators);
    final validatorAddress = RpcValueParser.string(validatorInfo['address']);
    final matchedValidator = ValidatorSetParser.find(
      validatorSet,
      validatorAddress,
    );
    final totalVotingPower = validatorSet.fold<int>(
      0,
      (sum, validator) => sum + validator.votingPower,
    );
    final validatorPower =
        matchedValidator?.votingPower ??
        RpcValueParser.intValue(validatorInfo['voting_power']);

    return BpsRpcSnapshot(
      rpcEndpoint: rpcEndpoint,
      rpcLatency: rpcLatency,
      chainId: RpcValueParser.string(nodeInfo['network']),
      moniker: RpcValueParser.string(nodeInfo['moniker']),
      nodeId: RpcValueParser.string(nodeInfo['id']),
      version:
          RpcValueParser.string(nodeInfo['version']) ??
          RpcValueParser.string(protocolVersion['app']),
      p2pListenAddress: RpcValueParser.string(nodeInfo['listen_addr']),
      rpcListenAddress: RpcValueParser.string(nodeOther['rpc_address']),
      txIndex: RpcValueParser.string(nodeOther['tx_index']),
      latestHeight: RpcValueParser.intValue(syncInfo['latest_block_height']),
      latestBlockTime: DateTime.tryParse(
        RpcValueParser.string(syncInfo['latest_block_time']) ?? '',
      ),
      latestBlockHash: RpcValueParser.string(blockId['hash']),
      latestAppHash: RpcValueParser.string(blockHeader['app_hash']),
      latestBlockTxCount: RpcValueParser.list(blockTxData['txs']).length,
      catchingUp: RpcValueParser.boolValue(syncInfo['catching_up']),
      validatorAddress: validatorAddress,
      validatorPubKeyValue: RpcValueParser.string(validatorPubKey['value']),
      validatorVotingPower: validatorPower,
      peerCount: ValidatorSetParser.peerCount(netInfo),
      totalValidators:
          ValidatorSetParser.totalValidators(validators) ?? validatorSet.length,
      totalVotingPower: totalVotingPower == 0 ? null : totalVotingPower,
      validatorRank: ValidatorSetParser.rank(validatorSet, validatorAddress),
      validatorPowerPercent: ValidatorSetParser.powerPercent(
        validatorPower,
        totalVotingPower,
      ),
      indexedTxCount: RpcValueParser.intValue(txResult['total_count']),
      mempoolTxCount:
          RpcValueParser.intValue(mempoolResult['n_txs']) ??
          RpcValueParser.intValue(mempoolResult['total']),
      mempoolBytes: RpcValueParser.intValue(mempoolResult['total_bytes']),
      latestTxHash: _latestTxHash(txRows),
    );
  }

  static String? _latestTxHash(List<Object?> rows) => rows.isEmpty
      ? null
      : RpcValueParser.string(RpcValueParser.map(rows.first)['hash']);
}
