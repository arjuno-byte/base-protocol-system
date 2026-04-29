import '../../../core/models/terminal_models.dart';

class DashboardViewData {
  const DashboardViewData({
    required this.topMetrics,
    required this.menu,
    required this.shortcuts,
    required this.validatorRows,
    required this.signingRows,
    required this.stakeRows,
    required this.rewardsRows,
    required this.delegationRows,
    required this.nodeHealthRows,
    required this.nodeProgressRows,
    required this.networkRows,
    required this.events,
    required this.quickActions,
    required this.console,
    required this.transactionRows,
    required this.governanceRows,
    required this.stakingPolicyRows,
    required this.distributionPolicyRows,
    required this.nodeMonitorRows,
    required this.runtimeSettingsRows,
    required this.helpRows,
    required this.votingPowerFraction,
    required this.stakeFooter,
  });

  final List<StatusMetric> topMetrics;
  final List<MenuEntry> menu;
  final List<ShortcutEntry> shortcuts;
  final List<InfoRow> validatorRows;
  final List<InfoRow> signingRows;
  final List<InfoRow> stakeRows;
  final List<InfoRow> rewardsRows;
  final List<InfoRow> delegationRows;
  final List<InfoRow> nodeHealthRows;
  final List<ProgressRow> nodeProgressRows;
  final List<InfoRow> networkRows;
  final List<EventLine> events;
  final List<String> quickActions;
  final List<EventLine> console;
  final List<InfoRow> transactionRows;
  final List<InfoRow> governanceRows;
  final List<InfoRow> stakingPolicyRows;
  final List<InfoRow> distributionPolicyRows;
  final List<InfoRow> nodeMonitorRows;
  final List<InfoRow> runtimeSettingsRows;
  final List<InfoRow> helpRows;
  final double votingPowerFraction;
  final String stakeFooter;
}
