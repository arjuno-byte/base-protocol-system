import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../domain/dashboard_state.dart';
import 'bps_logo_mark.dart';

class AppTitleBar extends StatelessWidget {
  const AppTitleBar({super.key, required this.status, this.errorMessage});

  final DashboardLoadStatus status;
  final String? errorMessage;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 28,
      child: Row(
        children: [
          const BpsLogoMark(size: 18),
          const SizedBox(width: 10),
          const Text(
            AppStrings.appTitle,
            style: TextStyle(color: AppColors.textPrimary, fontSize: 13),
          ),
          const SizedBox(width: 16),
          _RpcStateBadge(status: status, errorMessage: errorMessage),
          const Spacer(),
        ],
      ),
    );
  }
}

class _RpcStateBadge extends StatelessWidget {
  const _RpcStateBadge({required this.status, this.errorMessage});

  final DashboardLoadStatus status;
  final String? errorMessage;

  @override
  Widget build(BuildContext context) {
    final (label, color) = switch (status) {
      DashboardLoadStatus.loading => ('RPC CONNECTING', AppColors.amber),
      DashboardLoadStatus.success => (
        'RPC LIVE 127.0.0.1:26657',
        AppColors.green,
      ),
      DashboardLoadStatus.error => ('RPC ERROR', AppColors.red),
    };

    return Tooltip(
      message: errorMessage ?? label,
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 11,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
