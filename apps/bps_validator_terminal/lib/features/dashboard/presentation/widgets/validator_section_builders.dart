import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../domain/dashboard_view_data.dart';
import 'action_list_panel.dart';
import 'dashboard_section_actions.dart';
import 'info_panel.dart';
import 'recent_events_panel.dart';
import 'rewards_overview_panel.dart';
import 'section_column.dart';
import 'stake_overview_panel.dart';

class ValidatorSectionBuilders {
  const ValidatorSectionBuilders._();

  static Widget validator(DashboardViewData data) {
    return SectionColumn(
      rows: [
        [
          InfoPanel(
            title: 'VALIDATOR DETAILS',
            icon: Icons.verified_user_outlined,
            rows: data.validatorRows,
          ),
          InfoPanel(
            title: 'SIGNING INFO',
            icon: Icons.edit_note_outlined,
            accent: AppColors.purple,
            rows: data.signingRows,
          ),
          InfoPanel(
            title: 'VALIDATOR NODE',
            icon: Icons.monitor_heart_outlined,
            rows: data.nodeMonitorRows,
          ),
        ],
        [
          StakeOverviewPanel(
            rows: data.stakeRows,
            votingPowerFraction: data.votingPowerFraction,
            footerText: data.stakeFooter,
          ),
          RewardsOverviewPanel(rows: data.rewardsRows),
          InfoPanel(
            title: 'STAKING POLICY',
            icon: Icons.policy_outlined,
            rows: data.stakingPolicyRows,
          ),
        ],
      ],
    );
  }

  static Widget staking(DashboardViewData data) => SectionColumn(
    rows: [
      [
        StakeOverviewPanel(
          rows: data.stakeRows,
          votingPowerFraction: data.votingPowerFraction,
          footerText: data.stakeFooter,
        ),
        InfoPanel(
          title: 'DELEGATION SUMMARY',
          icon: Icons.groups_2_outlined,
          rows: data.delegationRows,
          valueAlignEnd: true,
        ),
        InfoPanel(
          title: 'STAKING PARAMS',
          icon: Icons.account_tree_outlined,
          rows: data.stakingPolicyRows,
        ),
      ],
      [
        const ActionListPanel(
          title: 'CLI ACTIONS',
          actions: DashboardSectionActions.staking,
        ),
        RecentEventsPanel(events: data.events),
      ],
    ],
  );

  static Widget rewards(DashboardViewData data) => SectionColumn(
    rows: [
      [
        RewardsOverviewPanel(rows: data.rewardsRows),
        InfoPanel(
          title: 'DISTRIBUTION POLICY',
          icon: Icons.card_giftcard_outlined,
          accent: AppColors.purple,
          rows: data.distributionPolicyRows,
        ),
        InfoPanel(
          title: 'VALIDATOR COMMISSION',
          icon: Icons.percent_outlined,
          rows: data.validatorRows,
        ),
      ],
      [
        const ActionListPanel(
          title: 'REWARD CLI',
          actions: DashboardSectionActions.rewards,
        ),
        RecentEventsPanel(events: data.events),
      ],
    ],
  );
}
