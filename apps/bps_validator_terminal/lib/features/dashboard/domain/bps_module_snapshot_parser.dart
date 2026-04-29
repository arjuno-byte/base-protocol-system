import '../../../core/utils/coin_formatters.dart';
import 'bps_module_snapshot.dart';
import 'bps_module_snapshot_parse_helpers.dart';
import 'bps_rpc_snapshot.dart';
import 'rpc_value_parser.dart';

class BpsModuleSnapshotParser {
  const BpsModuleSnapshotParser._();

  static BpsModuleSnapshot parse({
    required BpsRpcSnapshot rpcSnapshot,
    required Map<String, Object?> validators,
    required Map<String, Object?> delegations,
    required Map<String, Object?> unbonding,
    required Map<String, Object?> rewards,
    required Map<String, Object?> commission,
    required Map<String, Object?> communityPool,
    required Map<String, Object?> supply,
    required Map<String, Object?> inflation,
    required Map<String, Object?> stakingPool,
    required Map<String, Object?> signingInfos,
    required Map<String, Object?> slashingParams,
    required Map<String, Object?> proposals,
    required Map<String, Object?> govParams,
    required Map<String, Object?> stakingParams,
    required Map<String, Object?> distributionParams,
    required String? signingAddress,
  }) {
    final validator = BpsModuleSnapshotParseHelpers.findValidator(
      validators,
      rpcSnapshot.validatorPubKeyValue,
    );
    final operator = RpcValueParser.string(validator['operator_address']);
    final delegator = BpsModuleSnapshotParseHelpers.operatorToDelegator(
      operator,
    );
    final delegationRows = RpcValueParser.list(
      delegations['delegation_responses'],
    );
    final delegationAmounts = delegationRows
        .map(BpsModuleSnapshotParseHelpers.delegationAmount)
        .toList();
    final totalDelegated = delegationAmounts.fold<double>(
      0,
      (sum, item) => sum + item,
    );
    final pool = RpcValueParser.map(stakingPool['pool']);
    final description = BpsModuleSnapshotParseHelpers.description(validator);
    final signingInfo = BpsModuleSnapshotParseHelpers.signingInfo(
      signingInfos,
      signingAddress,
    );
    final slashing = BpsModuleSnapshotParseHelpers.params(slashingParams);
    final gov = BpsModuleSnapshotParseHelpers.params(govParams);
    final staking = BpsModuleSnapshotParseHelpers.params(stakingParams);
    final distribution = BpsModuleSnapshotParseHelpers.params(
      distributionParams,
    );

    return BpsModuleSnapshot(
      operatorAddress: operator,
      accountAddress: delegator,
      status: RpcValueParser.string(validator['status']),
      jailed: RpcValueParser.boolOrNull(validator['jailed']),
      moniker: RpcValueParser.string(description['moniker']),
      identity: RpcValueParser.string(description['identity']),
      website: RpcValueParser.string(description['website']),
      details: RpcValueParser.string(description['details']),
      commissionRate: BpsModuleSnapshotParseHelpers.commissionRate(validator),
      selfStakeMicro: BpsModuleSnapshotParseHelpers.selfStake(
        delegationRows,
        delegator,
      ),
      delegatedStakeMicro: totalDelegated,
      totalStakeMicro:
          RpcValueParser.doubleValue(validator['tokens']) ?? totalDelegated,
      unbondingMicro: BpsModuleSnapshotParseHelpers.unbondingAmount(unbonding),
      delegatorCount: delegationRows.length,
      topDelegationMicro: delegationAmounts.isEmpty
          ? 0
          : delegationAmounts.reduce((a, b) => a > b ? a : b),
      averageDelegationMicro: delegationAmounts.isEmpty
          ? 0
          : totalDelegated / delegationAmounts.length,
      outstandingRewardsMicro: BpsModuleSnapshotParseHelpers.nestedCoinList(
        rewards,
        ['rewards', 'rewards'],
      ),
      commissionMicro: BpsModuleSnapshotParseHelpers.nestedCoinList(
        commission,
        ['commission', 'commission'],
      ),
      communityPoolMicro: CoinFormatters.microAmountFromCoinList(
        communityPool['pool'],
      ),
      totalSupplyMicro: CoinFormatters.microAmountFromCoinList(
        supply['supply'],
      ),
      bondedTokensMicro: RpcValueParser.doubleValue(pool['bonded_tokens']) ?? 0,
      notBondedTokensMicro:
          RpcValueParser.doubleValue(pool['not_bonded_tokens']) ?? 0,
      inflationRatio: RpcValueParser.doubleValue(inflation['inflation']),
      signingAddress:
          signingAddress ?? RpcValueParser.string(signingInfo['address']),
      missedBlocksCounter: RpcValueParser.string(
        signingInfo['missed_blocks_counter'],
      ),
      signedBlocksWindow: RpcValueParser.string(
        slashing['signed_blocks_window'],
      ),
      minSignedPerWindow: RpcValueParser.doubleValue(
        slashing['min_signed_per_window'],
      ),
      jailedUntil: RpcValueParser.string(signingInfo['jailed_until']),
      proposalCount: RpcValueParser.list(proposals['proposals']).length,
      govQuorum: RpcValueParser.doubleValue(gov['quorum']),
      govThreshold: RpcValueParser.doubleValue(gov['threshold']),
      govVotingPeriod: RpcValueParser.string(gov['voting_period']),
      govMinDepositMicro: CoinFormatters.microAmountFromCoinList(
        gov['min_deposit'],
      ),
      stakingBondDenom: RpcValueParser.string(staking['bond_denom']),
      stakingUnbondingTime: RpcValueParser.string(staking['unbonding_time']),
      stakingMaxValidators: RpcValueParser.intValue(staking['max_validators']),
      stakingMinCommissionRate: RpcValueParser.doubleValue(
        staking['min_commission_rate'],
      ),
      distributionCommunityTax: RpcValueParser.doubleValue(
        distribution['community_tax'],
      ),
      distributionWithdrawAddressEnabled: RpcValueParser.boolOrNull(
        distribution['withdraw_addr_enabled'],
      ),
    );
  }
}
