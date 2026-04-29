import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/models/terminal_models.dart';
import '../../../../core/widgets/terminal_button.dart';
import '../../../../core/widgets/terminal_panel.dart';

class RewardsOverviewPanel extends StatelessWidget {
  const RewardsOverviewPanel({super.key, required this.rows});

  final List<InfoRow> rows;

  @override
  Widget build(BuildContext context) {
    return TerminalPanel(
      title: 'REWARDS OVERVIEW',
      icon: Icons.card_giftcard_outlined,
      accent: AppColors.purple,
      children: [
        ...rows.map((row) => _RewardLine(row: row)),
        const SizedBox(height: 7),
        const Wrap(
          spacing: 14,
          runSpacing: 8,
          children: [
            TerminalButton(
              label: 'CLAIM REWARDS',
              shortcut: 'C',
              color: AppColors.green,
            ),
            TerminalButton(
              label: 'HISTORY',
              shortcut: 'H',
              color: AppColors.textMuted,
            ),
          ],
        ),
      ],
    );
  }
}

class _RewardLine extends StatelessWidget {
  const _RewardLine({required this.row});

  final InfoRow row;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 7),
      child: Row(
        children: [
          SizedBox(
            width: 140,
            child: Text(
              row.label,
              style: TextStyle(
                color: row.valueColor ?? AppColors.textPrimary,
                fontSize: 13,
              ),
            ),
          ),
          Text(
            ':',
            style: TextStyle(
              color: row.valueColor ?? AppColors.textMuted,
              fontSize: 13,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              row.value,
              textAlign: TextAlign.right,
              style: TextStyle(
                color: row.valueColor ?? AppColors.textPrimary,
                fontSize: 13,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
