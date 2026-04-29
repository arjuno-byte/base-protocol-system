import 'package:flutter/material.dart';

import '../../domain/dashboard_view_data.dart';
import 'action_list_panel.dart';
import 'dashboard_section_actions.dart';
import 'info_panel.dart';
import 'node_health_panel.dart';
import 'recent_events_panel.dart';
import 'section_column.dart';

class ChainSectionBuilders {
  const ChainSectionBuilders._();

  static Widget transactions(DashboardViewData data) => SectionColumn(
    rows: [
      [
        InfoPanel(
          title: 'TRANSACTION INDEX',
          icon: Icons.receipt_long_outlined,
          rows: data.transactionRows,
        ),
        InfoPanel(
          title: 'LATEST BLOCK',
          icon: Icons.view_in_ar_outlined,
          rows: data.nodeMonitorRows,
        ),
        NodeHealthPanel(
          healthRows: data.nodeHealthRows,
          progressRows: data.nodeProgressRows,
        ),
      ],
      [
        const ActionListPanel(
          title: 'TX QUERIES',
          actions: DashboardSectionActions.transactions,
        ),
      ],
    ],
  );

  static Widget governance(DashboardViewData data) => SectionColumn(
    rows: [
      [
        InfoPanel(
          title: 'GOVERNANCE',
          icon: Icons.how_to_vote_outlined,
          rows: data.governanceRows,
        ),
        InfoPanel(
          title: 'NETWORK INFO',
          icon: Icons.language_outlined,
          rows: data.networkRows,
        ),
        RecentEventsPanel(events: data.events),
      ],
      [
        const ActionListPanel(
          title: 'GOV CLI',
          actions: DashboardSectionActions.governance,
        ),
      ],
    ],
  );

  static Widget nodeMonitor(DashboardViewData data) => SectionColumn(
    rows: [
      [
        NodeHealthPanel(
          healthRows: data.nodeHealthRows,
          progressRows: data.nodeProgressRows,
        ),
        InfoPanel(
          title: 'NODE RUNTIME',
          icon: Icons.monitor_heart_outlined,
          rows: data.nodeMonitorRows,
        ),
        RecentEventsPanel(events: data.events),
      ],
    ],
  );

  static Widget network(DashboardViewData data) => SectionColumn(
    rows: [
      [
        InfoPanel(
          title: 'NETWORK',
          icon: Icons.hub_outlined,
          rows: data.networkRows,
        ),
        InfoPanel(
          title: 'P2P / RPC',
          icon: Icons.settings_ethernet_outlined,
          rows: data.nodeMonitorRows,
        ),
        NodeHealthPanel(
          healthRows: data.nodeHealthRows,
          progressRows: data.nodeProgressRows,
        ),
      ],
    ],
  );

  static Widget logs(DashboardViewData data) => SectionColumn(
    rows: [
      [RecentEventsPanel(events: data.events)],
      [
        ActionListPanel(
          title: 'LIVE CONSOLE',
          actions: data.console.map((line) => line.message).toList(),
        ),
      ],
    ],
  );

  static Widget settings(DashboardViewData data) => SectionColumn(
    rows: [
      [
        InfoPanel(
          title: 'SETTINGS',
          icon: Icons.settings_outlined,
          rows: data.runtimeSettingsRows,
        ),
        InfoPanel(
          title: 'NETWORK',
          icon: Icons.hub_outlined,
          rows: data.networkRows,
        ),
      ],
    ],
  );

  static Widget help(DashboardViewData data) => SectionColumn(
    rows: [
      [
        InfoPanel(title: 'HELP', icon: Icons.help_outline, rows: data.helpRows),
        const ActionListPanel(
          title: 'SAFE COMMANDS',
          actions: DashboardSectionActions.help,
        ),
      ],
    ],
  );
}
