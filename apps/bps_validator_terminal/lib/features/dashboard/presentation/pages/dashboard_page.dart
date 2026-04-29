import 'dart:io';

import 'package:flutter/material.dart';

import '../../domain/dashboard_menu_ids.dart';
import '../../logic/controllers/dashboard_controller.dart';
import '../widgets/dashboard_terminal_view.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key, this.controller});

  final DashboardController? controller;

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  late final DashboardController _controller;
  late final bool _ownsController;

  @override
  void initState() {
    super.initState();
    _ownsController = widget.controller == null;
    _controller = widget.controller ?? DashboardController();
    _controller.start();
  }

  @override
  void dispose() {
    if (_ownsController) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        return DashboardTerminalView(
          state: _controller.state,
          activeMenuId: _controller.activeMenuId,
          onMenuSelected: _handleMenuSelected,
        );
      },
    );
  }

  void _handleMenuSelected(String menuId) {
    if (menuId == DashboardMenuIds.exit) {
      exit(0);
    }
    _controller.selectMenu(menuId);
  }
}
