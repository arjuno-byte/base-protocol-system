import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

class TerminalButton extends StatelessWidget {
  const TerminalButton({
    super.key,
    required this.label,
    required this.shortcut,
    this.color = AppColors.blue,
  });

  final String label;
  final String shortcut;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
      decoration: BoxDecoration(
        border: Border.all(color: color.withAlpha(190)),
        borderRadius: BorderRadius.circular(3),
      ),
      child: Text(
        '[ $shortcut ] $label',
        style: TextStyle(
          color: color,
          fontSize: 13,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
