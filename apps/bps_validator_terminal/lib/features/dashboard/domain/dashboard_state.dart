import 'dashboard_view_data.dart';

class DashboardState {
  const DashboardState({
    required this.status,
    required this.data,
    this.errorMessage,
    this.updatedAt,
  });

  final DashboardLoadStatus status;
  final DashboardViewData data;
  final String? errorMessage;
  final DateTime? updatedAt;

  bool get isLoading => status == DashboardLoadStatus.loading;
  bool get hasError => status == DashboardLoadStatus.error;
}

enum DashboardLoadStatus { loading, success, error }
