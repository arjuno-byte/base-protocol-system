import '../../../core/utils/coin_formatters.dart';
import 'rpc_value_parser.dart';

class BpsModuleSnapshotParseHelpers {
  const BpsModuleSnapshotParseHelpers._();

  static Map<String, Object?> findValidator(
    Map<String, Object?> response,
    String? pubKeyValue,
  ) {
    if (pubKeyValue == null || pubKeyValue.isEmpty) {
      return const {};
    }

    final validators = RpcValueParser.list(
      response['validators'],
    ).map(RpcValueParser.map).toList();
    if (validators.isEmpty) {
      return const {};
    }
    return validators.firstWhere(
      (validator) =>
          RpcValueParser.string(
            RpcValueParser.map(validator['consensus_pubkey'])['value'],
          ) ==
          pubKeyValue,
      orElse: () => const {},
    );
  }

  static Map<String, Object?> description(Map<String, Object?> validator) {
    return RpcValueParser.map(validator['description']);
  }

  static Map<String, Object?> params(Map<String, Object?> response) {
    return RpcValueParser.map(response['params']);
  }

  static Map<String, Object?> signingInfo(
    Map<String, Object?> response,
    String? consensusAddress,
  ) {
    final rows = RpcValueParser.list(
      response['info'],
    ).map(RpcValueParser.map).toList();
    if (consensusAddress != null && consensusAddress.isNotEmpty) {
      return rows.firstWhere(
        (row) => RpcValueParser.string(row['address']) == consensusAddress,
        orElse: () => const {},
      );
    }
    return rows.length == 1 ? rows.first : const {};
  }

  static double? commissionRate(Map<String, Object?> validator) {
    final commission = RpcValueParser.map(validator['commission']);
    final rates = RpcValueParser.map(commission['commission_rates']);
    return RpcValueParser.doubleValue(rates['rate']);
  }

  static double delegationAmount(Object? item) {
    final row = RpcValueParser.map(item);
    return CoinFormatters.microAmountFromCoinObject(row['balance']);
  }

  static double selfStake(List<Object?> rows, String? delegator) {
    if (delegator == null) {
      return 0;
    }
    for (final item in rows) {
      final row = RpcValueParser.map(item);
      final delegation = RpcValueParser.map(row['delegation']);
      if (RpcValueParser.string(delegation['delegator_address']) == delegator) {
        return CoinFormatters.microAmountFromCoinObject(row['balance']);
      }
    }
    return 0;
  }

  static double unbondingAmount(Map<String, Object?> response) {
    var total = 0.0;
    for (final item in RpcValueParser.list(response['unbonding_responses'])) {
      final row = RpcValueParser.map(item);
      for (final entry in RpcValueParser.list(row['entries'])) {
        total +=
            RpcValueParser.doubleValue(RpcValueParser.map(entry)['balance']) ??
            0;
      }
    }
    return total;
  }

  static double nestedCoinList(
    Map<String, Object?> response,
    List<String> path,
  ) {
    Object? current = response;
    for (final key in path) {
      current = RpcValueParser.map(current)[key];
    }
    return CoinFormatters.microAmountFromCoinList(current);
  }

  static String? operatorToDelegator(String? operator) {
    return operator?.replaceFirst('bpsvaloper', 'bps');
  }
}
