import '../../../core/constants/app_colors.dart';
import '../../../core/models/terminal_models.dart';
import '../../../core/utils/coin_formatters.dart';
import '../../../core/utils/dashboard_formatters.dart';
import 'bps_module_snapshot.dart';
import 'bps_rpc_snapshot.dart';

class DashboardSectionRowsFactory {
  const DashboardSectionRowsFactory._();

  static List<InfoRow> transactions(BpsRpcSnapshot snapshot) {
    return [
      InfoRow(
        'Indexed Tx Count',
        DashboardFormatters.formatInt(snapshot.indexedTxCount),
      ),
      InfoRow(
        'Mempool Tx',
        DashboardFormatters.formatInt(snapshot.mempoolTxCount),
      ),
      InfoRow(
        'Mempool Bytes',
        DashboardFormatters.formatInt(snapshot.mempoolBytes),
      ),
      InfoRow(
        'Latest Block Tx',
        DashboardFormatters.formatInt(snapshot.latestBlockTxCount),
      ),
      InfoRow(
        'Latest Tx Hash',
        DashboardFormatters.shortValue(snapshot.latestTxHash),
      ),
      InfoRow('Tx Index', snapshot.txIndex ?? 'N/A'),
    ];
  }

  static List<InfoRow> governance(BpsModuleSnapshot module) {
    return [
      InfoRow('Active/Total Proposals', module.proposalCount.toString()),
      InfoRow('Quorum', CoinFormatters.formatRatioPercent(module.govQuorum)),
      InfoRow(
        'Threshold',
        CoinFormatters.formatRatioPercent(module.govThreshold),
      ),
      InfoRow('Voting Period', module.govVotingPeriod ?? 'N/A'),
      InfoRow(
        'Min Deposit',
        CoinFormatters.formatBps(module.govMinDepositMicro),
      ),
    ];
  }

  static List<InfoRow> stakingPolicy(BpsModuleSnapshot module) {
    return [
      InfoRow('Bond Denom', module.stakingBondDenom ?? 'N/A'),
      InfoRow(
        'Max Validators',
        DashboardFormatters.formatInt(module.stakingMaxValidators),
      ),
      InfoRow('Unbonding Time', module.stakingUnbondingTime ?? 'N/A'),
      InfoRow(
        'Min Commission',
        CoinFormatters.formatRatioPercent(module.stakingMinCommissionRate),
      ),
    ];
  }

  static List<InfoRow> distributionPolicy(BpsModuleSnapshot module) {
    return [
      InfoRow(
        'Community Tax',
        CoinFormatters.formatRatioPercent(module.distributionCommunityTax),
      ),
      InfoRow(
        'Withdraw Address',
        module.distributionWithdrawAddressEnabled == true
            ? 'Enabled'
            : 'Disabled',
        valueColor: module.distributionWithdrawAddressEnabled == true
            ? AppColors.green
            : AppColors.amber,
      ),
    ];
  }

  static List<InfoRow> nodeMonitor(BpsRpcSnapshot snapshot) {
    return [
      InfoRow('P2P Listen', snapshot.p2pListenAddress ?? 'N/A'),
      InfoRow('RPC Listen', snapshot.rpcListenAddress ?? 'N/A'),
      InfoRow(
        'Latest Block Hash',
        DashboardFormatters.shortValue(snapshot.latestBlockHash),
      ),
      InfoRow(
        'Latest App Hash',
        DashboardFormatters.shortValue(snapshot.latestAppHash),
      ),
      InfoRow(
        'Validator Address',
        DashboardFormatters.shortValue(snapshot.validatorAddress),
      ),
    ];
  }

  static List<InfoRow> settings() {
    return const [
      InfoRow(
        'RPC Mode',
        'Private localhost only',
        valueColor: AppColors.green,
      ),
      InfoRow('RPC Endpoint', 'http://127.0.0.1:26657'),
      InfoRow('CLI Endpoint', 'tcp://127.0.0.1:26657'),
      InfoRow('BPSD Binary', 'BPSD_PATH, chain/bpsd.exe, or PATH'),
      InfoRow('Signing', 'Disabled in dashboard', valueColor: AppColors.green),
      InfoRow('Refresh', 'Every 5 seconds'),
    ];
  }

  static List<InfoRow> help() {
    return const [
      InfoRow('Run Node', 'Start bpsd with RPC on 127.0.0.1:26657'),
      InfoRow('Use Sidebar', 'Click any menu to inspect live data'),
      InfoRow('Validator Actions', 'Use bpsd CLI for signed tx operations'),
      InfoRow('Security', 'Never paste private keys into dashboard'),
      InfoRow('P2P Model', 'Raw TCP 26656, no Cloudflare dependency'),
    ];
  }

  static List<InfoRow> transactionUnavailable() {
    return const [InfoRow('Transactions', 'Waiting for local RPC')];
  }

  static List<InfoRow> governanceUnavailable() {
    return const [InfoRow('Governance', 'Waiting for bpsd query gov')];
  }

  static List<InfoRow> stakingUnavailable() {
    return const [InfoRow('Staking Params', 'Waiting for bpsd query staking')];
  }

  static List<InfoRow> distributionUnavailable() {
    return const [
      InfoRow('Distribution Params', 'Waiting for bpsd query distribution'),
    ];
  }
}
