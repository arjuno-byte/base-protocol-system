class CoinFormatters {
  const CoinFormatters._();

  static double microAmountFromCoinList(
    Object? value, {
    String denom = 'ubps',
  }) {
    if (value is! List) {
      return 0;
    }
    var total = 0.0;
    for (final item in value) {
      if (item is Map && item['denom']?.toString() == denom) {
        total += double.tryParse(item['amount']?.toString() ?? '') ?? 0;
      } else if (item is String && item.endsWith(denom)) {
        total += _parseDecCoin(item, denom);
      }
    }
    return total;
  }

  static double microAmountFromCoinObject(
    Object? value, {
    String denom = 'ubps',
  }) {
    if (value is! Map || value['denom']?.toString() != denom) {
      return 0;
    }
    return double.tryParse(value['amount']?.toString() ?? '') ?? 0;
  }

  static String formatBps(double? microAmount, {int decimals = 6}) {
    if (microAmount == null || microAmount.isNaN || microAmount.isInfinite) {
      return 'N/A';
    }
    final bps = microAmount / 1000000;
    return '${_trim(bps.toStringAsFixed(decimals))} BPS';
  }

  static String formatRatioPercent(double? ratio, {int decimals = 2}) {
    if (ratio == null || ratio.isNaN || ratio.isInfinite) {
      return 'N/A';
    }
    return '${(ratio * 100).toStringAsFixed(decimals)}%';
  }

  static double _parseDecCoin(String value, String denom) {
    return double.tryParse(value.substring(0, value.length - denom.length)) ??
        0;
  }

  static String _trim(String value) {
    if (!value.contains('.')) {
      return value;
    }
    return value.replaceFirst(RegExp(r'\.?0+$'), '');
  }
}
