import '../../../core/constants/app_colors.dart';
import '../../../core/models/terminal_models.dart';
import 'bps_module_snapshot.dart';
import 'bps_rpc_snapshot.dart';
import 'dashboard_event_factory.dart';
import 'dashboard_menu_ids.dart';
import 'dashboard_network_rows_factory.dart';
import 'dashboard_section_rows_factory.dart';
import 'dashboard_static_data.dart';
import 'dashboard_status_metrics_factory.dart';
import 'dashboard_validator_rows_factory.dart';
import 'dashboard_view_data.dart';

class DashboardViewFactory {
  const DashboardViewFactory._();
  static DashboardViewData connecting() {
    final now = DateTime.now();
    return _base(
      topMetrics: DashboardStatusMetricsFactory.offline(
        'CONNECTING',
        'Starting RPC check',
        now,
      ),
      validatorRows: DashboardValidatorRowsFactory.message(
        'Waiting for local RPC response',
      ),
      signingRows: DashboardValidatorRowsFactory.message('Waiting for /status'),
      stakeRows: DashboardValidatorRowsFactory.message(
        'Waiting for validator data',
      ),
      rewardsRows: DashboardValidatorRowsFactory.message(
        'Waiting for distribution source',
      ),
      delegationRows: DashboardValidatorRowsFactory.message(
        'Waiting for staking source',
      ),
      nodeHealthRows: DashboardValidatorRowsFactory.message(
        'Checking 127.0.0.1:26657',
      ),
      nodeProgressRows: const [],
      networkRows: DashboardValidatorRowsFactory.message(
        'Local RPC endpoint is being checked',
      ),
      events: DashboardEventFactory.single(
        now,
        'INFO',
        'Connecting to local BPS RPC',
      ),
      console: DashboardEventFactory.single(now, 'INFO', 'RPC probe started'),
    );
  }

  static DashboardViewData offline(String message) {
    final now = DateTime.now();
    return _base(
      topMetrics: DashboardStatusMetricsFactory.offline(
        'OFFLINE',
        'RPC unavailable',
        now,
      ),
      validatorRows: DashboardValidatorRowsFactory.message(
        message,
        color: AppColors.red,
      ),
      signingRows: DashboardValidatorRowsFactory.message(
        'No signing data without local RPC',
      ),
      stakeRows: DashboardValidatorRowsFactory.message(
        'Staking data requires node access',
      ),
      rewardsRows: DashboardNetworkRowsFactory.unavailable(
        'Distribution API/CLI required',
      ),
      delegationRows: DashboardNetworkRowsFactory.unavailable(
        'Staking API/CLI required',
      ),
      nodeHealthRows: DashboardValidatorRowsFactory.message(
        'Cannot reach 127.0.0.1:26657',
      ),
      nodeProgressRows: const [],
      networkRows: DashboardValidatorRowsFactory.message(
        'Start bpsd with RPC on localhost only',
      ),
      events: DashboardEventFactory.single(
        now,
        'ERROR',
        message,
        color: AppColors.red,
      ),
      console: DashboardEventFactory.single(
        now,
        'ERROR',
        message,
        color: AppColors.red,
      ),
    );
  }

  static DashboardViewData fromSnapshot(
    BpsRpcSnapshot snapshot, {
    required BpsModuleSnapshot module,
  }) {
    final now = DateTime.now();
    return _base(
      topMetrics: DashboardStatusMetricsFactory.live(snapshot, now),
      validatorRows: DashboardValidatorRowsFactory.validator(snapshot, module),
      signingRows: DashboardValidatorRowsFactory.signing(snapshot, module),
      stakeRows: DashboardValidatorRowsFactory.stake(snapshot, module),
      rewardsRows: DashboardNetworkRowsFactory.rewards(module),
      delegationRows: DashboardNetworkRowsFactory.delegation(module),
      nodeHealthRows: DashboardNetworkRowsFactory.nodeHealth(snapshot),
      nodeProgressRows: DashboardNetworkRowsFactory.progress(snapshot),
      networkRows: DashboardNetworkRowsFactory.network(snapshot, module),
      events: DashboardEventFactory.liveEvents(snapshot, now),
      console: DashboardEventFactory.console(snapshot, now),
      transactionRows: DashboardSectionRowsFactory.transactions(snapshot),
      governanceRows: DashboardSectionRowsFactory.governance(module),
      stakingPolicyRows: DashboardSectionRowsFactory.stakingPolicy(module),
      distributionPolicyRows: DashboardSectionRowsFactory.distributionPolicy(
        module,
      ),
      nodeMonitorRows: DashboardSectionRowsFactory.nodeMonitor(snapshot),
      votingPowerFraction: (snapshot.validatorPowerPercent ?? 0) / 100,
      stakeFooter: 'Derived from CometBFT /validators endpoint',
    );
  }

  static DashboardViewData _base({
    required List<StatusMetric> topMetrics,
    required List<InfoRow> validatorRows,
    required List<InfoRow> signingRows,
    required List<InfoRow> stakeRows,
    required List<InfoRow> rewardsRows,
    required List<InfoRow> delegationRows,
    required List<InfoRow> nodeHealthRows,
    required List<ProgressRow> nodeProgressRows,
    required List<InfoRow> networkRows,
    required List<EventLine> events,
    required List<EventLine> console,
    List<InfoRow>? transactionRows,
    List<InfoRow>? governanceRows,
    List<InfoRow>? stakingPolicyRows,
    List<InfoRow>? distributionPolicyRows,
    List<InfoRow>? nodeMonitorRows,
    double votingPowerFraction = 0,
    String stakeFooter = 'Live data unavailable until RPC responds',
  }) {
    return DashboardViewData(
      topMetrics: topMetrics,
      menu: DashboardStaticData.menu(DashboardMenuIds.dashboard),
      shortcuts: DashboardStaticData.shortcuts,
      validatorRows: validatorRows,
      signingRows: signingRows,
      stakeRows: stakeRows,
      rewardsRows: rewardsRows,
      delegationRows: delegationRows,
      nodeHealthRows: nodeHealthRows,
      nodeProgressRows: nodeProgressRows,
      networkRows: networkRows,
      events: events,
      quickActions: DashboardStaticData.quickActions,
      console: console,
      transactionRows:
          transactionRows ??
          DashboardSectionRowsFactory.transactionUnavailable(),
      governanceRows:
          governanceRows ?? DashboardSectionRowsFactory.governanceUnavailable(),
      stakingPolicyRows:
          stakingPolicyRows ?? DashboardSectionRowsFactory.stakingUnavailable(),
      distributionPolicyRows:
          distributionPolicyRows ??
          DashboardSectionRowsFactory.distributionUnavailable(),
      nodeMonitorRows:
          nodeMonitorRows ??
          DashboardValidatorRowsFactory.message('Waiting for local RPC'),
      runtimeSettingsRows: DashboardSectionRowsFactory.settings(),
      helpRows: DashboardSectionRowsFactory.help(),
      votingPowerFraction: votingPowerFraction.clamp(0, 1).toDouble(),
      stakeFooter: stakeFooter,
    );
  }
}
