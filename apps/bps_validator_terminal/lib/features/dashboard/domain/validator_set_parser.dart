import 'rpc_value_parser.dart';
import 'validator_snapshot.dart';

class ValidatorSetParser {
  const ValidatorSetParser._();

  static List<ValidatorSnapshot> parse(Map<String, Object?>? response) {
    final result = RpcValueParser.map(response?['result']);
    return RpcValueParser.list(result['validators'])
        .map(RpcValueParser.map)
        .map(
          (validator) => ValidatorSnapshot(
            address: RpcValueParser.string(validator['address']) ?? '',
            votingPower:
                RpcValueParser.intValue(validator['voting_power']) ?? 0,
          ),
        )
        .where((validator) => validator.address.isNotEmpty)
        .toList();
  }

  static ValidatorSnapshot? find(
    List<ValidatorSnapshot> validators,
    String? address,
  ) {
    if (address == null) {
      return null;
    }
    for (final validator in validators) {
      if (validator.address.toLowerCase() == address.toLowerCase()) {
        return validator;
      }
    }
    return null;
  }

  static int? rank(List<ValidatorSnapshot> validators, String? address) {
    if (address == null || validators.isEmpty) {
      return null;
    }
    final sorted = [...validators]
      ..sort((a, b) => b.votingPower.compareTo(a.votingPower));
    final index = sorted.indexWhere(
      (validator) => validator.address.toLowerCase() == address.toLowerCase(),
    );
    return index < 0 ? null : index + 1;
  }

  static int? totalValidators(Map<String, Object?>? response) {
    final result = RpcValueParser.map(response?['result']);
    return RpcValueParser.intValue(result['total']);
  }

  static int? peerCount(Map<String, Object?>? response) {
    final result = RpcValueParser.map(response?['result']);
    return RpcValueParser.intValue(result['n_peers']) ??
        RpcValueParser.list(result['peers']).length;
  }

  static double? powerPercent(int? validatorPower, int totalVotingPower) {
    if (validatorPower == null || totalVotingPower == 0) {
      return null;
    }
    return validatorPower / totalVotingPower * 100;
  }
}
