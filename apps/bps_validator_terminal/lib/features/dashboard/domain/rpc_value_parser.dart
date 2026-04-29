class RpcValueParser {
  const RpcValueParser._();

  static Map<String, Object?> map(Object? value) {
    if (value is Map<String, dynamic>) {
      return Map<String, Object?>.from(value);
    }
    if (value is Map<String, Object?>) {
      return value;
    }
    return const {};
  }

  static List<Object?> list(Object? value) {
    if (value is List) {
      return value.cast<Object?>();
    }
    return const [];
  }

  static String? string(Object? value) {
    final text = value?.toString();
    if (text == null || text.isEmpty || text == '<nil>') {
      return null;
    }
    return text;
  }

  static int? intValue(Object? value) {
    if (value is int) {
      return value;
    }
    return int.tryParse(value?.toString() ?? '');
  }

  static double? doubleValue(Object? value) {
    if (value is double) {
      return value;
    }
    if (value is int) {
      return value.toDouble();
    }
    return double.tryParse(value?.toString() ?? '');
  }

  static bool? boolOrNull(Object? value) {
    if (value is bool) {
      return value;
    }
    final normalized = value?.toString().toLowerCase();
    if (normalized == 'true') {
      return true;
    }
    if (normalized == 'false') {
      return false;
    }
    return null;
  }

  static bool boolValue(Object? value) {
    if (value is bool) {
      return value;
    }
    return value?.toString().toLowerCase() == 'true';
  }
}
