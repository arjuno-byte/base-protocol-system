import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

class AppTheme {
  static ThemeData get darkTerminalTheme {
    final base = ThemeData.dark(useMaterial3: true);
    return base.copyWith(
      scaffoldBackgroundColor: AppColors.background,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.blue,
        secondary: AppColors.green,
        surface: AppColors.panel,
      ),
      textTheme: base.textTheme.apply(
        fontFamily: 'Consolas',
        bodyColor: AppColors.textPrimary,
        displayColor: AppColors.textPrimary,
      ),
      visualDensity: VisualDensity.compact,
    );
  }
}
