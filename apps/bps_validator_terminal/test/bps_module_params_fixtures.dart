class BpsModuleParamsFixtures {
  const BpsModuleParamsFixtures._();

  static const signingInfos = {
    'info': [
      {'address': 'bpsvalcons1abc', 'missed_blocks_counter': '2'},
    ],
  };

  static const slashingParams = {
    'params': {
      'signed_blocks_window': '100',
      'min_signed_per_window': '0.500000000000000000',
    },
  };

  static const proposals = {
    'proposals': [
      {'id': '1'},
    ],
  };

  static const govParams = {
    'params': {
      'quorum': '0.334000000000000000',
      'threshold': '0.500000000000000000',
      'voting_period': '48h0m0s',
      'min_deposit': [
        {'denom': 'ubps', 'amount': '10000000'},
      ],
    },
  };

  static const stakingParams = {
    'params': {
      'bond_denom': 'ubps',
      'unbonding_time': '504h0m0s',
      'max_validators': 100,
      'min_commission_rate': '0.000000000000000000',
    },
  };

  static const distributionParams = {
    'params': {
      'community_tax': '0.020000000000000000',
      'withdraw_addr_enabled': true,
    },
  };
}
