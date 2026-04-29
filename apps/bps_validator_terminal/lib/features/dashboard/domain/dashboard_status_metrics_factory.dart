import '../../../core/constants/app_colors.dart';
import '../../../core/models/terminal_models.dart';
import '../../../core/utils/dashboard_formatters.dart';
import 'bps_rpc_snapshot.dart';

class DashboardStatusMetricsFactory {
  const DashboardStatusMetricsFactory._();

  static List<StatusMetric> live(BpsRpcSnapshot snapshot, DateTime now) {
    final syncLabel = snapshot.catchingUp ? 'CATCHING UP' : 'SYNCED';
    return [
      StatusMetric(
        label: 'NETWORK',
        primary: snapshot.chainId ?? 'Unknown Chain',
        secondary: 'Connected',
        accent: AppColors.green,
      ),
      StatusMetric(
        label: 'NODE',
        primary: snapshot.moniker ?? 'Unknown Node',
        secondary: snapshot.version ?? 'version N/A',
      ),
      StatusMetric(
        label: 'HEIGHT',
        primary: DashboardFormatters.formatInt(snapshot.latestHeight),
        secondary:
            'Last Block: ${DashboardFormatters.formatAgo(snapshot.latestBlockTime)}',
      ),
      StatusMetric(
        label: 'PEERS',
        primary: DashboardFormatters.formatInt(snapshot.peerCount),
        secondary: 'Connected',
      ),
      StatusMetric(
        label: 'SYNC',
        primary: syncLabel,
        secondary: DashboardFormatters.formatDuration(snapshot.rpcLatency),
        accent: snapshot.catchingUp ? AppColors.amber : AppColors.green,
      ),
      StatusMetric(
        label: 'TIME',
        primary: DashboardFormatters.formatClock(now),
        secondary: DashboardFormatters.formatDate(now),
        accent: AppColors.green,
      ),
    ];
  }

  static List<StatusMetric> offline(
    String status,
    String detail,
    DateTime now,
  ) {
    return [
      StatusMetric(
        label: 'NETWORK',
        primary: status,
        secondary: detail,
        accent: status == 'OFFLINE' ? AppColors.red : AppColors.amber,
      ),
      const StatusMetric(
        label: 'NODE',
        primary: 'Local Node',
        secondary: '127.0.0.1',
      ),
      const StatusMetric(
        label: 'HEIGHT',
        primary: 'N/A',
        secondary: 'No RPC data',
      ),
      const StatusMetric(
        label: 'PEERS',
        primary: 'N/A',
        secondary: 'No RPC data',
      ),
      const StatusMetric(
        label: 'RPC',
        primary: 'LOCAL',
        secondary: '26657',
        accent: AppColors.amber,
      ),
      StatusMetric(
        label: 'TIME',
        primary: DashboardFormatters.formatClock(now),
        secondary: DashboardFormatters.formatDate(now),
        accent: AppColors.green,
      ),
    ];
  }
}
