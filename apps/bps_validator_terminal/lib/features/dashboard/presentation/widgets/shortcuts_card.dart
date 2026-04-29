import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/models/terminal_models.dart';

class ShortcutsCard extends StatelessWidget {
  const ShortcutsCard({super.key, required this.shortcuts});

  final List<ShortcutEntry> shortcuts;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppSizes.sidebarWidth,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.panel.withAlpha(225),
        border: Border.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(AppSizes.panelRadius),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'SHORTCUTS',
            style: TextStyle(
              color: AppColors.purple,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 10),
          ...shortcuts.map(
            (item) => Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Row(
                children: [
                  Text(
                    '[${item.keyLabel}]',
                    style: const TextStyle(
                      color: AppColors.green,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      item.label,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
