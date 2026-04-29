import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/models/terminal_models.dart';

class SidebarMenu extends StatelessWidget {
  const SidebarMenu({
    super.key,
    required this.entries,
    required this.onSelected,
  });

  final List<MenuEntry> entries;
  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppSizes.sidebarWidth,
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.panel.withAlpha(225),
        border: Border.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(AppSizes.panelRadius),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(14, 4, 14, 8),
            child: Text(
              'MAIN MENU',
              style: TextStyle(
                color: AppColors.blue,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
          ...entries.map(
            (entry) => _MenuTile(entry: entry, onSelected: onSelected),
          ),
        ],
      ),
    );
  }
}

class _MenuTile extends StatelessWidget {
  const _MenuTile({required this.entry, required this.onSelected});

  final MenuEntry entry;
  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => onSelected(entry.id),
        child: Container(
          height: 29,
          margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            gradient: entry.active
                ? const LinearGradient(
                    colors: [
                      AppColors.menuGradientStart,
                      AppColors.menuGradientEnd,
                    ],
                  )
                : null,
          ),
          child: Row(
            children: [
              Icon(
                entry.icon,
                size: 15,
                color: entry.active ? Colors.white : AppColors.textPrimary,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  entry.label,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: entry.active ? Colors.white : AppColors.textPrimary,
                    fontSize: 12.5,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
