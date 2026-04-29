import '../domain/dashboard_view_data.dart';
import '../domain/dashboard_view_factory.dart';
import 'bps_cli_query_service.dart';
import 'bps_node_rpc_service.dart';

class DashboardRepository {
  DashboardRepository({
    BpsNodeRpcService? service,
    BpsCliQueryService? cliQueryService,
  }) : _service = service ?? BpsNodeRpcService(),
       _cliQueryService = cliQueryService ?? BpsCliQueryService();

  final BpsNodeRpcService _service;
  final BpsCliQueryService _cliQueryService;

  Future<DashboardViewData> fetchDashboard() async {
    final snapshot = await _service.fetchSnapshot();
    final moduleSnapshot = await _cliQueryService.fetchSnapshot(snapshot);
    return DashboardViewFactory.fromSnapshot(snapshot, module: moduleSnapshot);
  }

  void dispose() {
    _service.dispose();
  }
}
