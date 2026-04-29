import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/models/terminal_models.dart';
import '../../../../core/widgets/key_value_table.dart';
import '../../../../core/widgets/terminal_panel.dart';

class InfoPanel extends StatelessWidget {
  const InfoPanel({
    super.key,
    required this.title,
    required this.icon,
    required this.rows,
    this.accent = AppColors.blue,
    this.valueAlignEnd = false,
  });

  final String title;
  final IconData icon;
  final List<InfoRow> rows;
  final Color accent;
  final bool valueAlignEnd;

  @override
  Widget build(BuildContext context) {
    return TerminalPanel(
      title: title,
      icon: icon,
      accent: accent,
      children: [KeyValueTable(rows: rows, valueAlignEnd: valueAlignEnd)],
    );
  }
}
