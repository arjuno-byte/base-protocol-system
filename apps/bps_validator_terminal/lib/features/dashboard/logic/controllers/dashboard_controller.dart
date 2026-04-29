import 'dart:async';

import 'package:flutter/foundation.dart';

import '../../domain/dashboard_menu_ids.dart';
import '../../domain/dashboard_state.dart';
import '../../domain/dashboard_view_factory.dart';
import '../../remote/dashboard_repository.dart';

class DashboardController extends ChangeNotifier {
  DashboardController({
    DashboardRepository? repository,
    this.refreshInterval = const Duration(seconds: 5),
  }) : _repository = repository ?? DashboardRepository(),
       _state = DashboardState(
         status: DashboardLoadStatus.loading,
         data: DashboardViewFactory.connecting(),
       );

  final DashboardRepository _repository;
  final Duration refreshInterval;
  DashboardState _state;
  Timer? _refreshTimer;
  bool _disposed = false;
  bool _started = false;
  String _activeMenuId = DashboardMenuIds.dashboard;

  DashboardState get state => _state;
  String get activeMenuId => _activeMenuId;

  void start() {
    if (_started) {
      return;
    }
    _started = true;
    unawaited(refresh());
    _refreshTimer = Timer.periodic(refreshInterval, (_) => refresh());
  }

  Future<void> refresh() async {
    if (_disposed) {
      return;
    }

    if (_state.status != DashboardLoadStatus.success) {
      _setState(
        DashboardState(
          status: DashboardLoadStatus.loading,
          data: _state.data,
          updatedAt: _state.updatedAt,
        ),
      );
    }

    try {
      final data = await _repository.fetchDashboard();
      _setState(
        DashboardState(
          status: DashboardLoadStatus.success,
          data: data,
          updatedAt: DateTime.now(),
        ),
      );
    } catch (error) {
      final fallback = _state.status == DashboardLoadStatus.success
          ? _state.data
          : DashboardViewFactory.offline(error.toString());
      _setState(
        DashboardState(
          status: DashboardLoadStatus.error,
          data: fallback,
          errorMessage: error.toString(),
          updatedAt: DateTime.now(),
        ),
      );
    }
  }

  void selectMenu(String menuId) {
    if (_activeMenuId == menuId || _disposed) {
      return;
    }
    _activeMenuId = menuId;
    notifyListeners();
  }

  void _setState(DashboardState nextState) {
    if (_disposed) {
      return;
    }
    _state = nextState;
    notifyListeners();
  }

  @override
  void dispose() {
    _disposed = true;
    _refreshTimer?.cancel();
    _repository.dispose();
    super.dispose();
  }
}
