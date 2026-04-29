import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/models/terminal_models.dart';
import '../../../core/utils/dashboard_formatters.dart';
import 'bps_rpc_snapshot.dart';

class DashboardEventFactory {
  const DashboardEventFactory._();

  static List<EventLine> liveEvents(BpsRpcSnapshot snapshot, DateTime now) {
    final height = DashboardFormatters.formatInt(snapshot.latestHeight);
    return [
      _line(
        now,
        'RPC',
        'Local RPC connected: ${snapshot.rpcEndpoint}',
        AppColors.green,
      ),
      _line(now, 'BLOCK', 'Latest block observed: $height', AppColors.green),
      _line(
        now,
        'PEER',
        'Connected peers: ${snapshot.peerCount ?? 0}',
        AppColors.blue,
      ),
      _line(
        now,
        'SYNC',
        snapshot.catchingUp ? 'Node is catching up' : 'Node is synced',
        snapshot.catchingUp ? AppColors.amber : AppColors.green,
      ),
      _line(
        now,
        'NODE',
        snapshot.isValidator
            ? 'Validator consensus power detected'
            : 'Full node mode, no validator power detected',
        snapshot.isValidator ? AppColors.green : AppColors.amber,
      ),
    ];
  }

  static List<EventLine> console(BpsRpcSnapshot snapshot, DateTime now) {
    return [
      _consoleLine(now, '[INFO] Connected to local BPS RPC'),
      _consoleLine(now, '[INFO] Chain ID: ${snapshot.chainId ?? 'N/A'}'),
      _consoleLine(
        now,
        '[INFO] Height: ${DashboardFormatters.formatInt(snapshot.latestHeight)}',
      ),
      _consoleLine(now, '[INFO] Peers: ${snapshot.peerCount ?? 0}'),
    ];
  }

  static List<EventLine> single(
    DateTime now,
    String tag,
    String message, {
    Color color = AppColors.amber,
  }) {
    return [_line(now, tag, message, color)];
  }

  static EventLine _line(
    DateTime now,
    String tag,
    String message,
    Color color,
  ) {
    return EventLine(
      time: DashboardFormatters.formatClock(now),
      message: message,
      tag: tag,
      color: color,
    );
  }

  static EventLine _consoleLine(DateTime now, String message) {
    return _line(now, '', message, AppColors.green);
  }
}
