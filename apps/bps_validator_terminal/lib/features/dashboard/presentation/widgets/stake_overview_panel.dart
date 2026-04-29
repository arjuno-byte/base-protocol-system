import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/models/terminal_models.dart';
import '../../../../core/widgets/progress_meter.dart';
import '../../../../core/widgets/terminal_panel.dart';

class StakeOverviewPanel extends StatelessWidget {
  const StakeOverviewPanel({
    super.key,
    required this.rows,
    required this.votingPowerFraction,
    required this.footerText,
  });

  final List<InfoRow> rows;
  final double votingPowerFraction;
  final String footerText;

  @override
  Widget build(BuildContext context) {
    return TerminalPanel(
      title: 'STAKE OVERVIEW',
      icon: Icons.storage_outlined,
      accent: AppColors.blue,
      children: [
        ...rows.map((row) => _StakeLine(row)),
        const SizedBox(height: 4),
        ProgressMeter(
          value: votingPowerFraction,
          height: 17,
          color: AppColors.green,
        ),
        const SizedBox(height: 8),
        Text(
          footerText,
          style: const TextStyle(color: AppColors.textMuted, fontSize: 12),
        ),
      ],
    );
  }
}

class _StakeLine extends StatelessWidget {
  const _StakeLine(this.row);

  final InfoRow row;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 7),
      child: Row(
        children: [
          SizedBox(
            width: 170,
            child: Text(row.label, style: const TextStyle(fontSize: 13)),
          ),
          const Text(':', style: TextStyle(color: AppColors.textMuted)),
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
