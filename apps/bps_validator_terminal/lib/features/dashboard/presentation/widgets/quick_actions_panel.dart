import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/widgets/terminal_panel.dart';

class QuickActionsPanel extends StatelessWidget {
  const QuickActionsPanel({super.key, required this.actions});

  final List<String> actions;

  @override
  Widget build(BuildContext context) {
    return TerminalPanel(
      title: 'QUICK ACTIONS',
      icon: Icons.bolt_outlined,
      accent: AppColors.amber,
      children: [
        ...actions.indexed.map(
          (entry) => Padding(
            padding: const EdgeInsets.only(bottom: 7),
            child: Row(
              children: [
                Text(
                  '[ ${entry.$1 + 1} ]',
                  style: const TextStyle(color: AppColors.amber, fontSize: 13),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    entry.$2,
                    style: const TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 13,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
