import 'package:bps_validator_terminal/features/dashboard/domain/bps_module_snapshot_parser.dart';
import 'package:flutter_test/flutter_test.dart';

import 'bps_module_params_fixtures.dart';
import 'bps_module_snapshot_fixtures.dart';

void main() {
  test('parses local validator module data from bpsd query responses', () {
    final snapshot = BpsModuleSnapshotFixtures.rpcSnapshot(
      pubKey: 'local-pubkey',
    );
    final module = BpsModuleSnapshotParser.parse(
      rpcSnapshot: snapshot,
      validators: BpsModuleSnapshotFixtures.validators(pubKey: 'local-pubkey'),
      delegations: BpsModuleSnapshotFixtures.delegations,
      unbonding: BpsModuleSnapshotFixtures.unbonding,
      rewards: BpsModuleSnapshotFixtures.rewards,
      commission: BpsModuleSnapshotFixtures.commission,
      communityPool: BpsModuleSnapshotFixtures.communityPool,
      supply: BpsModuleSnapshotFixtures.supply,
      inflation: BpsModuleSnapshotFixtures.inflation,
      stakingPool: BpsModuleSnapshotFixtures.stakingPool,
      signingInfos: BpsModuleParamsFixtures.signingInfos,
      slashingParams: BpsModuleParamsFixtures.slashingParams,
      proposals: BpsModuleParamsFixtures.proposals,
      govParams: BpsModuleParamsFixtures.govParams,
      stakingParams: BpsModuleParamsFixtures.stakingParams,
      distributionParams: BpsModuleParamsFixtures.distributionParams,
      signingAddress: 'bpsvalcons1abc',
    );

    expect(module.operatorAddress, 'bpsvaloper1abc');
    expect(module.moniker, 'validator0');
    expect(module.selfStakeMicro, 100000000);
    expect(module.delegatedStakeMicro, 100000000);
    expect(module.outstandingRewardsMicro, 12000000.5);
    expect(module.commissionMicro, 5000000);
    expect(module.missedBlocksCounter, '2');
    expect(module.proposalCount, 1);
    expect(module.govQuorum, 0.334);
    expect(module.stakingMaxValidators, 100);
    expect(module.distributionWithdrawAddressEnabled, isTrue);
  });

  test(
    'does not fall back to another validator when local pubkey is missing',
    () {
      final snapshot = BpsModuleSnapshotFixtures.rpcSnapshot(
        pubKey: 'unknown-pubkey',
      );
      final module = BpsModuleSnapshotParser.parse(
        rpcSnapshot: snapshot,
        validators: BpsModuleSnapshotFixtures.validators(
          pubKey: 'other-pubkey',
        ),
        delegations: const {},
        unbonding: const {},
        rewards: const {},
        commission: const {},
        communityPool: BpsModuleSnapshotFixtures.communityPool,
        supply: BpsModuleSnapshotFixtures.supply,
        inflation: BpsModuleSnapshotFixtures.inflation,
        stakingPool: BpsModuleSnapshotFixtures.stakingPool,
        signingInfos: BpsModuleParamsFixtures.signingInfos,
        slashingParams: BpsModuleParamsFixtures.slashingParams,
        proposals: const {},
        govParams: BpsModuleParamsFixtures.govParams,
        stakingParams: BpsModuleParamsFixtures.stakingParams,
        distributionParams: BpsModuleParamsFixtures.distributionParams,
        signingAddress: null,
      );

      expect(module.operatorAddress, isNull);
      expect(module.totalStakeMicro, 0);
      expect(module.delegatorCount, 0);
    },
  );
}
