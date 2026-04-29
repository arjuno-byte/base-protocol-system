import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../models/terminal_models.dart';

class KeyValueTable extends StatelessWidget {
  const KeyValueTable({
    super.key,
    required this.rows,
    this.valueAlignEnd = false,
  });

  final List<InfoRow> rows;
  final bool valueAlignEnd;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: rows
          .map((row) => _InfoLine(row: row, alignEnd: valueAlignEnd))
          .toList(),
    );
  }
}

class _InfoLine extends StatelessWidget {
  const _InfoLine({required this.row, required this.alignEnd});

  final InfoRow row;
  final bool alignEnd;

  @override
  Widget build(BuildContext context) {
    final value = Text(
      row.value,
      textAlign: alignEnd ? TextAlign.right : TextAlign.left,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        color: row.valueColor ?? AppColors.textPrimary,
        fontSize: 13,
        fontWeight: row.valueColor == null ? FontWeight.w500 : FontWeight.w800,
      ),
    );

    return Padding(
      padding: const EdgeInsets.only(bottom: 7),
      child: Row(
        children: [
          SizedBox(
            width: 145,
            child: Text(
              row.label,
              style: const TextStyle(
                color: AppColors.textPrimary,
                fontSize: 13,
              ),
            ),
          ),
          const Text(
            ':',
            style: TextStyle(color: AppColors.textMuted, fontSize: 13),
          ),
          const SizedBox(width: 12),
          Expanded(child: value),
        ],
      ),
    );
  }
}
