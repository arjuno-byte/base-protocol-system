import 'package:flutter/material.dart';

import '../../domain/dashboard_menu_ids.dart';
import '../../domain/dashboard_view_data.dart';
import 'chain_section_builders.dart';
import 'dashboard_grid.dart';
import 'validator_section_builders.dart';

class DashboardSectionGrid extends StatelessWidget {
  const DashboardSectionGrid({
    super.key,
    required this.activeMenuId,
    required this.data,
  });

  final String activeMenuId;
  final DashboardViewData data;

  @override
  Widget build(BuildContext context) {
    return switch (activeMenuId) {
      DashboardMenuIds.validator => ValidatorSectionBuilders.validator(data),
      DashboardMenuIds.staking => ValidatorSectionBuilders.staking(data),
      DashboardMenuIds.rewards => ValidatorSectionBuilders.rewards(data),
      DashboardMenuIds.transactions => ChainSectionBuilders.transactions(data),
      DashboardMenuIds.governance => ChainSectionBuilders.governance(data),
      DashboardMenuIds.nodeMonitor => ChainSectionBuilders.nodeMonitor(data),
      DashboardMenuIds.network => ChainSectionBuilders.network(data),
      DashboardMenuIds.logs => ChainSectionBuilders.logs(data),
      DashboardMenuIds.settings => ChainSectionBuilders.settings(data),
      DashboardMenuIds.help => ChainSectionBuilders.help(data),
      _ => DashboardGrid(data: data),
    };
  }
}
