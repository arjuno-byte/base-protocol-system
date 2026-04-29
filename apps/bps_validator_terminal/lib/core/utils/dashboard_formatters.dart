class DashboardFormatters {
  const DashboardFormatters._();

  static String formatInt(num? value) {
    if (value == null) {
      return 'N/A';
    }

    final raw = value.round().toString();
    final buffer = StringBuffer();
    for (var index = 0; index < raw.length; index++) {
      final remaining = raw.length - index;
      buffer.write(raw[index]);
      if (remaining > 1 && remaining % 3 == 1) {
        buffer.write(',');
      }
    }
    return buffer.toString();
  }

  static String formatPercent(double? value, {int decimals = 2}) {
    if (value == null || value.isNaN || value.isInfinite) {
      return 'N/A';
    }
    return '${value.toStringAsFixed(decimals)}%';
  }

  static String formatAgo(DateTime? dateTime) {
    if (dateTime == null) {
      return 'N/A';
    }

    final diff = DateTime.now().toUtc().difference(dateTime.toUtc()).abs();
    if (diff.inSeconds < 60) {
      return '${diff.inSeconds}s ago';
    }
    if (diff.inMinutes < 60) {
      return '${diff.inMinutes}m ago';
    }
    if (diff.inHours < 24) {
      return '${diff.inHours}h ago';
    }
    return '${diff.inDays}d ago';
  }

  static String formatClock(DateTime dateTime) {
    final local = dateTime.toLocal();
    return '${_two(local.hour)}:${_two(local.minute)}:${_two(local.second)}';
  }

  static String formatDate(DateTime dateTime) {
    final local = dateTime.toLocal();
    return '${_two(local.day)} ${_month(local.month)} ${local.year}';
  }

  static String formatDuration(Duration duration) {
    if (duration.inMilliseconds < 1000) {
      return '${duration.inMilliseconds}ms';
    }
    return '${(duration.inMilliseconds / 1000).toStringAsFixed(2)}s';
  }

  static String shortValue(String? value, {int head = 12, int tail = 6}) {
    if (value == null || value.isEmpty) {
      return 'N/A';
    }
    if (value.length <= head + tail + 3) {
      return value;
    }
    return '${value.substring(0, head)}...${value.substring(value.length - tail)}';
  }

  static String _two(int value) => value.toString().padLeft(2, '0');

  static String _month(int month) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return months[month - 1];
  }
}
