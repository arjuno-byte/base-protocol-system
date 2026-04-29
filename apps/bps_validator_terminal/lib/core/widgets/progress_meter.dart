import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

class ProgressMeter extends StatelessWidget {
  const ProgressMeter({
    super.key,
    required this.value,
    this.height = 16,
    this.color = AppColors.blueDeep,
  });

  final double value;
  final double height;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(2),
      child: Stack(
        children: [
          Container(
            height: height,
            decoration: BoxDecoration(
              color: const Color(0xFF151A24),
              border: Border.all(color: AppColors.border),
            ),
          ),
          FractionallySizedBox(
            widthFactor: value.clamp(0, 1),
            child: Container(
              height: height,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [color, AppColors.green.withAlpha(210)],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
