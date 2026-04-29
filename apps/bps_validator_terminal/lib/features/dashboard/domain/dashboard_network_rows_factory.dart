import '../../../core/constants/app_colors.dart';
import '../../../core/models/terminal_models.dart';
import '../../../core/utils/coin_formatters.dart';
import '../../../core/utils/dashboard_formatters.dart';
import 'bps_module_snapshot.dart';
import 'bps_rpc_snapshot.dart';

class DashboardNetworkRowsFactory {
  const DashboardNetworkRowsFactory._();

  static List<InfoRow> nodeHealth(BpsRpcSnapshot snapshot) {
    return [
      InfoRow(
        'Sync Status',
        snapshot.catchingUp ? 'CATCHING UP' : 'SYNCED',
        valueColor: snapshot.catchingUp ? AppColors.amber : AppColors.green,
      ),
      InfoRow(
        'Latest Block',
        DashboardFormatters.formatInt(snapshot.latestHeight),
      ),
      InfoRow(
        'Block Delay',
        DashboardFormatters.formatAgo(snapshot.latestBlockTime),
      ),
      InfoRow('Peers', DashboardFormatters.formatInt(snapshot.peerCount)),
      InfoRow(
        'RPC Latency',
        DashboardFormatters.formatDuration(snapshot.rpcLatency),
      ),
    ];
  }

  static List<ProgressRow> progress(BpsRpcSnapshot snapshot) {
    final peerProgress = ((snapshot.peerCount ?? 0) / 50)
        .clamp(0, 1)
        .toDouble();
    final powerProgress = ((snapshot.validatorPowerPercent ?? 0) / 100)
        .clamp(0, 1)
        .toDouble();
    return [
      ProgressRow(
        label: 'Peer Capacity',
        value: '${snapshot.peerCount ?? 0}/50',
        progress: peerProgress,
      ),
      ProgressRow(
        label: 'Power Share',
        value: DashboardFormatters.formatPercent(
          snapshot.validatorPowerPercent,
        ),
        progress: powerProgress,
      ),
      ProgressRow(
        label: 'Sync Health',
        value: snapshot.catchingUp ? '0%' : '100%',
        progress: snapshot.catchingUp ? 0.0 : 1.0,
      ),
    ];
  }

  static List<InfoRow> rewards(BpsModuleSnapshot module) {
    return [
      InfoRow(
        'Outstanding',
        CoinFormatters.formatBps(module.outstandingRewardsMicro),
      ),
      InfoRow('Commission', CoinFormatters.formatBps(module.commissionMicro)),
      InfoRow(
        'Community Pool',
        CoinFormatters.formatBps(module.communityPoolMicro),
      ),
      InfoRow(
        'Inflation',
        CoinFormatters.formatRatioPercent(module.inflationRatio),
      ),
    ];
  }

  static List<InfoRow> delegation(BpsModuleSnapshot module) {
    return [
      InfoRow('Total Delegators', module.delegatorCount.toString()),
      InfoRow(
        'Total Delegations',
        CoinFormatters.formatBps(module.delegatedStakeMicro),
      ),
      InfoRow(
        'Self Delegation',
        CoinFormatters.formatBps(module.selfStakeMicro),
      ),
      InfoRow(
        'Top Delegation',
        CoinFormatters.formatBps(module.topDelegationMicro),
      ),
      InfoRow(
        'Average Delegation',
        CoinFormatters.formatBps(module.averageDelegationMicro),
      ),
      InfoRow('Unbonding', CoinFormatters.formatBps(module.unbondingMicro)),
    ];
  }

  static List<InfoRow> network(
    BpsRpcSnapshot snapshot,
    BpsModuleSnapshot module,
  ) {
    return [
      InfoRow('Chain ID', snapshot.chainId ?? 'N/A'),
      InfoRow('Node ID', DashboardFormatters.shortValue(snapshot.nodeId)),
      InfoRow('RPC Endpoint', snapshot.rpcEndpoint),
      InfoRow('CometBFT Version', snapshot.version ?? 'N/A'),
      InfoRow(
        'Total Supply',
        CoinFormatters.formatBps(module.totalSupplyMicro),
      ),
      InfoRow(
        'Bonded Ratio',
        CoinFormatters.formatRatioPercent(module.bondedRatio),
      ),
      InfoRow(
        'Inflation',
        CoinFormatters.formatRatioPercent(module.inflationRatio),
      ),
      InfoRow('Gov Proposals', module.proposalCount.toString()),
    ];
  }

  static List<InfoRow> unavailable(String reason) {
    return [
      InfoRow('Source', reason, valueColor: AppColors.amber),
      const InfoRow(
        'Private Keys',
        'Never stored in dashboard',
        valueColor: AppColors.green,
      ),
    ];
  }
}
