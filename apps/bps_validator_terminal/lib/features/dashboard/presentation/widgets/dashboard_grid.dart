import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/widgets/key_value_table.dart';
import '../../../../core/widgets/terminal_button.dart';
import '../../../../core/widgets/terminal_panel.dart';
import '../../domain/dashboard_view_data.dart';
import 'info_panel.dart';
import 'node_health_panel.dart';
import 'quick_actions_panel.dart';
import 'recent_events_panel.dart';
import 'rewards_overview_panel.dart';
import 'stake_overview_panel.dart';

class DashboardGrid extends StatelessWidget {
  const DashboardGrid({super.key, required this.data});

  final DashboardViewData data;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(flex: 12, child: _TopGridRow(data: data)),
        const SizedBox(height: AppSizes.gap),
        Expanded(flex: 10, child: _MiddleGridRow(data: data)),
        const SizedBox(height: AppSizes.gap),
        Expanded(flex: 9, child: _BottomGridRow(data: data)),
      ],
    );
  }
}

class _TopGridRow extends StatelessWidget {
  const _TopGridRow({required this.data});

  final DashboardViewData data;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(flex: 7, child: _ValidatorPanel(data: data)),
        const SizedBox(width: AppSizes.gap),
        Expanded(flex: 6, child: _SigningPanel(data: data)),
        const SizedBox(width: AppSizes.gap),
        Expanded(
          flex: 6,
          child: NodeHealthPanel(
            healthRows: data.nodeHealthRows,
            progressRows: data.nodeProgressRows,
          ),
        ),
      ],
    );
  }
}

class _MiddleGridRow extends StatelessWidget {
  const _MiddleGridRow({required this.data});

  final DashboardViewData data;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 7,
          child: StakeOverviewPanel(
            rows: data.stakeRows,
            votingPowerFraction: data.votingPowerFraction,
            footerText: data.stakeFooter,
          ),
        ),
        const SizedBox(width: AppSizes.gap),
        Expanded(flex: 6, child: RewardsOverviewPanel(rows: data.rewardsRows)),
        const SizedBox(width: AppSizes.gap),
        Expanded(flex: 6, child: _DelegationPanel(data: data)),
      ],
    );
  }
}

class _BottomGridRow extends StatelessWidget {
  const _BottomGridRow({required this.data});

  final DashboardViewData data;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(flex: 7, child: RecentEventsPanel(events: data.events)),
        const SizedBox(width: AppSizes.gap),
        Expanded(flex: 6, child: _NetworkInfoPanel(data: data)),
        const SizedBox(width: AppSizes.gap),
        Expanded(flex: 6, child: QuickActionsPanel(actions: data.quickActions)),
      ],
    );
  }
}

class _ValidatorPanel extends StatelessWidget {
  const _ValidatorPanel({required this.data});

  final DashboardViewData data;

  @override
  Widget build(BuildContext context) {
    return InfoPanel(
      title: 'VALIDATOR STATUS',
      icon: Icons.shield_outlined,
      rows: data.validatorRows,
    );
  }
}

class _SigningPanel extends StatelessWidget {
  const _SigningPanel({required this.data});

  final DashboardViewData data;

  @override
  Widget build(BuildContext context) {
    return InfoPanel(
      title: 'SIGNING INFO',
      icon: Icons.edit_note_outlined,
      accent: AppColors.purple,
      rows: data.signingRows,
    );
  }
}

class _DelegationPanel extends StatelessWidget {
  const _DelegationPanel({required this.data});

  final DashboardViewData data;

  @override
  Widget build(BuildContext context) {
    return InfoPanel(
      title: 'DELEGATION SUMMARY',
      icon: Icons.groups_2_outlined,
      accent: AppColors.blue,
      rows: data.delegationRows,
      valueAlignEnd: true,
    ).withFooter(const TerminalButton(label: 'VIEW DELEGATORS', shortcut: 'D'));
  }
}

class _NetworkInfoPanel extends StatelessWidget {
  const _NetworkInfoPanel({required this.data});

  final DashboardViewData data;

  @override
  Widget build(BuildContext context) {
    return InfoPanel(
      title: 'NETWORK INFO',
      icon: Icons.language_outlined,
      rows: data.networkRows,
    );
  }
}

extension _PanelFooter on InfoPanel {
  Widget withFooter(Widget footer) {
    return TerminalPanel(
      title: title,
      icon: icon,
      accent: accent,
      children: [
        KeyValueTable(rows: rows, valueAlignEnd: valueAlignEnd),
        const SizedBox(height: 16),
        footer,
      ],
    );
  }
}
