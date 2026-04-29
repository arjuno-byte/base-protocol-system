import 'package:flutter/material.dart';

import '../../../core/models/terminal_models.dart';
import 'dashboard_menu_ids.dart';

class DashboardStaticData {
  const DashboardStaticData._();

  static List<MenuEntry> menu(String activeId) => [
    _entry(
      DashboardMenuIds.dashboard,
      Icons.dashboard_outlined,
      'Dashboard',
      activeId,
    ),
    _entry(
      DashboardMenuIds.validator,
      Icons.verified_user_outlined,
      'Validator',
      activeId,
    ),
    _entry(
      DashboardMenuIds.staking,
      Icons.account_tree_outlined,
      'Staking & Delegation',
      activeId,
    ),
    _entry(
      DashboardMenuIds.rewards,
      Icons.card_giftcard_outlined,
      'Rewards',
      activeId,
    ),
    _entry(
      DashboardMenuIds.transactions,
      Icons.receipt_long_outlined,
      'Transactions',
      activeId,
    ),
    _entry(
      DashboardMenuIds.governance,
      Icons.how_to_vote_outlined,
      'Governance',
      activeId,
    ),
    _entry(
      DashboardMenuIds.nodeMonitor,
      Icons.monitor_heart_outlined,
      'Node Monitor',
      activeId,
    ),
    _entry(DashboardMenuIds.network, Icons.hub_outlined, 'Network', activeId),
    _entry(DashboardMenuIds.logs, Icons.article_outlined, 'Logs', activeId),
    _entry(
      DashboardMenuIds.settings,
      Icons.settings_outlined,
      'Settings',
      activeId,
    ),
    _entry(DashboardMenuIds.help, Icons.help_outline, 'Help', activeId),
    _entry(DashboardMenuIds.exit, Icons.logout_outlined, 'Exit', activeId),
  ];

  static const List<ShortcutEntry> shortcuts = [
    ShortcutEntry('D', 'Dashboard'),
    ShortcutEntry('V', 'Validator Details'),
    ShortcutEntry('S', 'Staking'),
    ShortcutEntry('R', 'Claim Rewards'),
    ShortcutEntry('G', 'Governance'),
    ShortcutEntry('M', 'Monitor'),
    ShortcutEntry('L', 'Logs'),
    ShortcutEntry('Q', 'Exit'),
  ];

  static const List<String> quickActions = [
    'Auto refresh every 5s',
    'CometBFT /status live',
    'CometBFT /net_info live',
    'CometBFT /validators live',
    'bpsd query staking live',
    'bpsd query distribution live',
    'bpsd query slashing/gov live',
  ];

  static MenuEntry _entry(
    String id,
    IconData icon,
    String label,
    String activeId,
  ) {
    return MenuEntry(id: id, icon: icon, label: label, active: id == activeId);
  }
}
