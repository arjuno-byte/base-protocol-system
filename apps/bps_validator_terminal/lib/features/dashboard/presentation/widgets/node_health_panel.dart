import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/models/terminal_models.dart';
import '../../../../core/widgets/key_value_table.dart';
import '../../../../core/widgets/progress_meter.dart';
import '../../../../core/widgets/terminal_panel.dart';

class NodeHealthPanel extends StatelessWidget {
  const NodeHealthPanel({
    super.key,
    required this.healthRows,
    required this.progressRows,
  });

  final List<InfoRow> healthRows;
  final List<ProgressRow> progressRows;

  @override
  Widget build(BuildContext context) {
    return TerminalPanel(
      title: 'NODE HEALTH',
      icon: Icons.monitor_heart_outlined,
      accent: AppColors.purple,
      children: [
        KeyValueTable(rows: healthRows),
        const SizedBox(height: 2),
        ...progressRows.map((row) => _HealthProgress(row: row)),
      ],
    );
  }
}

class _HealthProgress extends StatelessWidget {
  const _HealthProgress({required this.row});

  final ProgressRow row;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 7),
      child: Row(
        children: [
          SizedBox(
            width: 145,
            child: Text(row.label, style: const TextStyle(fontSize: 13)),
          ),
          const Text(
            ':',
            style: TextStyle(color: AppColors.textMuted, fontSize: 13),
          ),
          const SizedBox(width: 12),
          SizedBox(
            width: 48,
            child: Text(row.value, style: const TextStyle(fontSize: 13)),
          ),
          Expanded(
            child: ProgressMeter(
              value: row.progress,
              height: 10,
              color: AppColors.blueDeep,
            ),
          ),
        ],
      ),
    );
  }
}
