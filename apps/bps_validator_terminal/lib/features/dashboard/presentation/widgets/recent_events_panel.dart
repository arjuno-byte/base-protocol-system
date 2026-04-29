import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/models/terminal_models.dart';
import '../../../../core/widgets/terminal_panel.dart';

class RecentEventsPanel extends StatelessWidget {
  const RecentEventsPanel({super.key, required this.events});

  final List<EventLine> events;

  @override
  Widget build(BuildContext context) {
    return TerminalPanel(
      title: 'RECENT EVENTS',
      icon: Icons.calendar_month_outlined,
      accent: AppColors.purple,
      children: events.map((event) => _EventRow(event: event)).toList(),
    );
  }
}

class _EventRow extends StatelessWidget {
  const _EventRow({required this.event});

  final EventLine event;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          SizedBox(
            width: 64,
            child: Text(
              event.time,
              style: const TextStyle(color: AppColors.green, fontSize: 12),
            ),
          ),
          Expanded(
            child: Text(
              event.message,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: AppColors.textPrimary,
                fontSize: 12,
              ),
            ),
          ),
          Text(
            '[${event.tag}]',
            style: TextStyle(color: event.color, fontSize: 12),
          ),
        ],
      ),
    );
  }
}
