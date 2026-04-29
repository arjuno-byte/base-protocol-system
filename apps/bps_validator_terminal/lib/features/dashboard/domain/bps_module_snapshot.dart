class BpsModuleSnapshot {
  const BpsModuleSnapshot({
    required this.operatorAddress,
    required this.accountAddress,
    required this.status,
    required this.jailed,
    required this.moniker,
    required this.identity,
    required this.website,
    required this.details,
    required this.commissionRate,
    required this.selfStakeMicro,
    required this.delegatedStakeMicro,
    required this.totalStakeMicro,
    required this.unbondingMicro,
    required this.delegatorCount,
    required this.topDelegationMicro,
    required this.averageDelegationMicro,
    required this.outstandingRewardsMicro,
    required this.commissionMicro,
    required this.communityPoolMicro,
    required this.totalSupplyMicro,
    required this.bondedTokensMicro,
    required this.notBondedTokensMicro,
    required this.inflationRatio,
    required this.signingAddress,
    required this.missedBlocksCounter,
    required this.signedBlocksWindow,
    required this.minSignedPerWindow,
    required this.jailedUntil,
    required this.proposalCount,
    required this.govQuorum,
    required this.govThreshold,
    required this.govVotingPeriod,
    required this.govMinDepositMicro,
    required this.stakingBondDenom,
    required this.stakingUnbondingTime,
    required this.stakingMaxValidators,
    required this.stakingMinCommissionRate,
    required this.distributionCommunityTax,
    required this.distributionWithdrawAddressEnabled,
  });

  final String? operatorAddress;
  final String? accountAddress;
  final String? status;
  final bool? jailed;
  final String? moniker;
  final String? identity;
  final String? website;
  final String? details;
  final double? commissionRate;
  final double selfStakeMicro;
  final double delegatedStakeMicro;
  final double totalStakeMicro;
  final double unbondingMicro;
  final int delegatorCount;
  final double topDelegationMicro;
  final double averageDelegationMicro;
  final double outstandingRewardsMicro;
  final double commissionMicro;
  final double communityPoolMicro;
  final double totalSupplyMicro;
  final double bondedTokensMicro;
  final double notBondedTokensMicro;
  final double? inflationRatio;
  final String? signingAddress;
  final String? missedBlocksCounter;
  final String? signedBlocksWindow;
  final double? minSignedPerWindow;
  final String? jailedUntil;
  final int proposalCount;
  final double? govQuorum;
  final double? govThreshold;
  final String? govVotingPeriod;
  final double govMinDepositMicro;
  final String? stakingBondDenom;
  final String? stakingUnbondingTime;
  final int? stakingMaxValidators;
  final double? stakingMinCommissionRate;
  final double? distributionCommunityTax;
  final bool? distributionWithdrawAddressEnabled;

  double? get bondedRatio {
    final total = bondedTokensMicro + notBondedTokensMicro;
    if (total == 0) {
      return null;
    }
    return bondedTokensMicro / total;
  }
}
