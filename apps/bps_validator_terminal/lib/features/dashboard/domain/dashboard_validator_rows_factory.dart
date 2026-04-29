import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/models/terminal_models.dart';
import '../../../core/utils/coin_formatters.dart';
import '../../../core/utils/dashboard_formatters.dart';
import 'bps_module_snapshot.dart';
import 'bps_rpc_snapshot.dart';

class DashboardValidatorRowsFactory {
  const DashboardValidatorRowsFactory._();

  static List<InfoRow> validator(
    BpsRpcSnapshot snapshot,
    BpsModuleSnapshot module,
  ) {
    final isValidator =
        snapshot.isValidator && module.status == 'BOND_STATUS_BONDED';
    return [
      InfoRow(
        'Status',
        isValidator
            ? 'ACTIVE VALIDATOR'
            : module.status ?? 'FULL NODE / NO POWER',
        valueColor: isValidator ? AppColors.green : AppColors.amber,
      ),
      InfoRow(
        'Validator Address',
        DashboardFormatters.shortValue(module.operatorAddress),
      ),
      InfoRow(
        'Voting Power',
        DashboardFormatters.formatPercent(snapshot.validatorPowerPercent),
      ),
      InfoRow(
        'Rank',
        _rankText(snapshot.validatorRank, snapshot.totalValidators),
      ),
      InfoRow(
        'Raw Power',
        DashboardFormatters.formatInt(snapshot.validatorVotingPower),
      ),
      InfoRow(
        'Commission',
        CoinFormatters.formatRatioPercent(module.commissionRate),
      ),
      InfoRow(
        'Jailed',
        module.jailed == true ? 'Yes' : 'No',
        valueColor: module.jailed == true ? AppColors.red : AppColors.green,
      ),
      InfoRow('Moniker', module.moniker ?? snapshot.moniker ?? 'N/A'),
      InfoRow('Identity', module.identity ?? 'N/A'),
      InfoRow('Website', module.website ?? 'N/A', valueColor: AppColors.blue),
      InfoRow('Details', module.details ?? 'N/A'),
    ];
  }

  static List<InfoRow> signing(
    BpsRpcSnapshot snapshot,
    BpsModuleSnapshot module,
  ) {
    return [
      InfoRow('Last Block Observed', _heightAgo(snapshot)),
      InfoRow(
        'Sync Status',
        snapshot.catchingUp ? 'CATCHING UP' : 'SYNCED',
        valueColor: snapshot.catchingUp ? AppColors.amber : AppColors.green,
      ),
      InfoRow(
        'Consensus Power',
        DashboardFormatters.formatInt(snapshot.validatorVotingPower),
      ),
      InfoRow(
        'RPC Latency',
        DashboardFormatters.formatDuration(snapshot.rpcLatency),
      ),
      InfoRow('Missed Blocks', module.missedBlocksCounter ?? '0'),
      InfoRow('Signed Window', module.signedBlocksWindow ?? 'N/A'),
      InfoRow(
        'Min Sign Rate',
        CoinFormatters.formatRatioPercent(module.minSignedPerWindow),
      ),
      InfoRow(
        'Jailed Until',
        module.jailedUntil ?? 'N/A',
        valueColor: module.jailed == true ? AppColors.red : AppColors.green,
      ),
    ];
  }

  static List<InfoRow> stake(
    BpsRpcSnapshot snapshot,
    BpsModuleSnapshot module,
  ) {
    return [
      InfoRow('Self Stake', CoinFormatters.formatBps(module.selfStakeMicro)),
      InfoRow(
        'Delegated Stake',
        CoinFormatters.formatBps(module.delegatedStakeMicro),
      ),
      InfoRow('Total Stake', CoinFormatters.formatBps(module.totalStakeMicro)),
      InfoRow('Unbonding', CoinFormatters.formatBps(module.unbondingMicro)),
      InfoRow('Delegators', module.delegatorCount.toString()),
      InfoRow(
        'Voting Power',
        DashboardFormatters.formatPercent(snapshot.validatorPowerPercent),
      ),
    ];
  }

  static List<InfoRow> message(
    String message, {
    Color color = AppColors.amber,
  }) {
    return [InfoRow('Status', message, valueColor: color)];
  }

  static String _heightAgo(BpsRpcSnapshot snapshot) {
    final height = DashboardFormatters.formatInt(snapshot.latestHeight);
    final ago = DashboardFormatters.formatAgo(snapshot.latestBlockTime);
    return '$height ($ago)';
  }

  static String _rankText(int? rank, int? total) {
    if (rank == null) {
      return 'N/A';
    }
    return '#$rank / ${total ?? '?'}';
  }
}
