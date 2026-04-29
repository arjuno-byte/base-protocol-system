import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/models/terminal_models.dart';
import '../../../../core/widgets/terminal_panel.dart';

class TerminalConsolePanel extends StatelessWidget {
  const TerminalConsolePanel({super.key, required this.lines});

  final List<EventLine> lines;

  @override
  Widget build(BuildContext context) {
    return TerminalPanel(
      title: 'TERMINAL CONSOLE',
      icon: Icons.terminal_outlined,
      accent: AppColors.purple,
      trailing: const Text(
        "Press 'Q' to exit . 'H' for help",
        style: TextStyle(color: AppColors.purple, fontSize: 12),
      ),
      children: lines.map((line) => _ConsoleLine(line: line)).toList(),
    );
  }
}

class _ConsoleLine extends StatelessWidget {
  const _ConsoleLine({required this.line});

  final EventLine line;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Row(
        children: [
          SizedBox(
            width: 76,
            child: Text(
              line.time,
              style: TextStyle(color: line.color, fontSize: 12),
            ),
          ),
          Expanded(
            child: Text(
              line.message,
              style: const TextStyle(
                color: AppColors.textPrimary,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
