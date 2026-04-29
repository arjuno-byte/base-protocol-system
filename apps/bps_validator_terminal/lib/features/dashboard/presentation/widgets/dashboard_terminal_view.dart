import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../../core/constants/app_sizes.dart';
import '../../../../core/widgets/terminal_background.dart';
import '../../domain/dashboard_state.dart';
import '../../domain/dashboard_view_data.dart';
import '../../domain/dashboard_static_data.dart';
import 'app_title_bar.dart';
import 'brand_panel.dart';
import 'dashboard_section_grid.dart';
import 'shortcuts_card.dart';
import 'sidebar_menu.dart';
import 'terminal_console_panel.dart';
import 'top_status_bar.dart';

class DashboardTerminalView extends StatelessWidget {
  const DashboardTerminalView({
    super.key,
    required this.state,
    required this.activeMenuId,
    required this.onMenuSelected,
  });

  final DashboardState state;
  final String activeMenuId;
  final ValueChanged<String> onMenuSelected;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TerminalBackground(
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final width = math.max(
                constraints.maxWidth,
                AppSizes.minDesktopWidth,
              );
              final height = math.max(
                constraints.maxHeight,
                AppSizes.minDesktopHeight,
              );

              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: SingleChildScrollView(
                  child: SizedBox(
                    width: width,
                    child: ConstrainedBox(
                      constraints: BoxConstraints(minHeight: height),
                      child: _DashboardContent(
                        state: state,
                        activeMenuId: activeMenuId,
                        onMenuSelected: onMenuSelected,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class _DashboardContent extends StatelessWidget {
  const _DashboardContent({
    required this.state,
    required this.activeMenuId,
    required this.onMenuSelected,
  });

  final DashboardState state;
  final String activeMenuId;
  final ValueChanged<String> onMenuSelected;

  @override
  Widget build(BuildContext context) {
    final data = state.data;
    return Padding(
      padding: const EdgeInsets.all(AppSizes.pagePadding),
      child: Column(
        children: [
          AppTitleBar(status: state.status, errorMessage: state.errorMessage),
          const SizedBox(height: 8),
          _HeaderRow(data: data),
          const SizedBox(height: AppSizes.gap),
          _MainContent(
            data: data,
            activeMenuId: activeMenuId,
            onMenuSelected: onMenuSelected,
          ),
          const SizedBox(height: AppSizes.gap),
          TerminalConsolePanel(lines: data.console),
        ],
      ),
    );
  }
}

class _HeaderRow extends StatelessWidget {
  const _HeaderRow({required this.data});

  final DashboardViewData data;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 96,
      child: Row(
        children: [
          const BrandPanel(),
          Expanded(child: TopStatusBar(metrics: data.topMetrics)),
        ],
      ),
    );
  }
}

class _MainContent extends StatelessWidget {
  const _MainContent({
    required this.data,
    required this.activeMenuId,
    required this.onMenuSelected,
  });

  final DashboardViewData data;
  final String activeMenuId;
  final ValueChanged<String> onMenuSelected;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 760,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _LeftSidebar(
            data: data,
            activeMenuId: activeMenuId,
            onMenuSelected: onMenuSelected,
          ),
          const SizedBox(width: AppSizes.gap),
          Expanded(
            child: DashboardSectionGrid(activeMenuId: activeMenuId, data: data),
          ),
        ],
      ),
    );
  }
}

class _LeftSidebar extends StatelessWidget {
  const _LeftSidebar({
    required this.data,
    required this.activeMenuId,
    required this.onMenuSelected,
  });

  final DashboardViewData data;
  final String activeMenuId;
  final ValueChanged<String> onMenuSelected;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SidebarMenu(
            entries: DashboardStaticData.menu(activeMenuId),
            onSelected: onMenuSelected,
          ),
        ),
        const SizedBox(height: AppSizes.gap),
        ShortcutsCard(shortcuts: data.shortcuts),
      ],
    );
  }
}
