import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/widgets/terminal_panel.dart';

class ActionListPanel extends StatelessWidget {
  const ActionListPanel({
    super.key,
    required this.title,
    required this.actions,
    this.icon = Icons.terminal_outlined,
    this.accent = AppColors.amber,
  });

  final String title;
  final List<String> actions;
  final IconData icon;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return TerminalPanel(
      title: title,
      icon: icon,
      accent: accent,
      children: actions.map((action) => _ActionLine(action: action)).toList(),
    );
  }
}

class _ActionLine extends StatelessWidget {
  const _ActionLine({required this.action});

  final String action;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 9),
      child: Text(
        action,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(
          color: AppColors.textPrimary,
          fontSize: 12,
          height: 1.25,
        ),
      ),
    );
  }
}
