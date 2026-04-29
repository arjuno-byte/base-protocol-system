import 'package:flutter/material.dart';

import '../features/dashboard/presentation/pages/dashboard_page.dart';
import '../core/theme/app_theme.dart';

class BpsValidatorTerminalApp extends StatelessWidget {
  const BpsValidatorTerminalApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BPS Validator Terminal',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTerminalTheme,
      home: const DashboardPage(),
    );
  }
}
