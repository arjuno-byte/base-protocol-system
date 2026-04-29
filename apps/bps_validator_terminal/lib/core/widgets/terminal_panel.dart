import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../constants/app_sizes.dart';

class TerminalPanel extends StatelessWidget {
  const TerminalPanel({
    super.key,
    required this.title,
    required this.icon,
    required this.children,
    this.accent = AppColors.blue,
    this.trailing,
    this.padding = const EdgeInsets.all(14),
  });

  final String title;
  final IconData icon;
  final List<Widget> children;
  final Color accent;
  final Widget? trailing;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final hasBoundedHeight = constraints.maxHeight.isFinite;
        final panelBody = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: children,
        );

        return Container(
          decoration: BoxDecoration(
            color: AppColors.panel.withAlpha(222),
            border: Border.all(color: AppColors.border),
            borderRadius: BorderRadius.circular(AppSizes.panelRadius),
            boxShadow: [
              BoxShadow(
                color: accent.withAlpha(18),
                blurRadius: 18,
                spreadRadius: 1,
              ),
            ],
          ),
          child: Padding(
            padding: padding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(icon, color: accent, size: 18),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        title,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: accent,
                          fontSize: 14,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 0.6,
                        ),
                      ),
                    ),
                    ?trailing,
                  ],
                ),
                const SizedBox(height: 10),
                Divider(color: AppColors.border.withAlpha(190), height: 1),
                const SizedBox(height: 10),
                if (hasBoundedHeight)
                  Expanded(child: SingleChildScrollView(child: panelBody))
                else
                  panelBody,
              ],
            ),
          ),
        );
      },
    );
  }
}
