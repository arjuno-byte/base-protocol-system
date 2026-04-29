import 'package:flutter/material.dart';

class StatusMetric {
  const StatusMetric({
    required this.label,
    required this.primary,
    required this.secondary,
    this.accent,
  });

  final String label;
  final String primary;
  final String secondary;
  final Color? accent;
}

class InfoRow {
  const InfoRow(this.label, this.value, {this.valueColor});

  final String label;
  final String value;
  final Color? valueColor;
}

class ProgressRow {
  const ProgressRow({
    required this.label,
    required this.value,
    required this.progress,
  });

  final String label;
  final String value;
  final double progress;
}

class EventLine {
  const EventLine({
    required this.time,
    required this.message,
    required this.tag,
    required this.color,
  });

  final String time;
  final String message;
  final String tag;
  final Color color;
}

class MenuEntry {
  const MenuEntry({
    required this.id,
    required this.icon,
    required this.label,
    this.active = false,
  });

  final String id;
  final IconData icon;
  final String label;
  final bool active;
}

class ShortcutEntry {
  const ShortcutEntry(this.keyLabel, this.label);

  final String keyLabel;
  final String label;
}
