import 'dart:async';
import 'dart:convert';
import 'dart:io';

import '../../../core/network/rpc_exception.dart';

class BpsCliQueryClient {
  BpsCliQueryClient({
    this.nodeAddress = 'tcp://127.0.0.1:26657',
    this.timeout = const Duration(seconds: 4),
    String? executablePath,
  }) : _executablePath = executablePath;

  final String nodeAddress;
  final Duration timeout;
  final String? _executablePath;
  String? _resolvedExecutable;

  Future<Map<String, Object?>> query(List<String> args) async {
    final executable = await _resolveExecutable();
    final result = await _run(executable, [
      'query',
      ...args,
      '--node',
      nodeAddress,
      '--output',
      'json',
    ]);

    if (result.exitCode != 0) {
      throw RpcException('bpsd query failed: ${result.stderr}');
    }

    final decoded = jsonDecode(result.stdout.toString());
    if (decoded is! Map<String, dynamic>) {
      throw const RpcException('bpsd query returned invalid JSON');
    }
    return Map<String, Object?>.from(decoded);
  }

  Future<String?> consensusAddressFromHex(String? hexAddress) async {
    if (hexAddress == null || hexAddress.isEmpty) {
      return null;
    }

    final executable = await _resolveExecutable();
    final result = await _run(executable, ['debug', 'addr', hexAddress]);
    if (result.exitCode != 0) {
      return null;
    }

    for (final line in result.stdout.toString().split('\n')) {
      final value = line.trim();
      if (value.startsWith('Bech32 Con:')) {
        return value.replaceFirst('Bech32 Con:', '').trim();
      }
    }
    return null;
  }

  Future<String> _resolveExecutable() async {
    if (_resolvedExecutable != null) {
      return _resolvedExecutable!;
    }

    for (final candidate in _candidates()) {
      if (candidate == 'bpsd' || candidate == 'bpsd.exe') {
        _resolvedExecutable = candidate;
        return candidate;
      }
      if (await File(candidate).exists()) {
        _resolvedExecutable = candidate;
        return candidate;
      }
    }

    throw const RpcException('bpsd executable not found');
  }

  List<String> _candidates() {
    final candidates = <String>[];
    final envPath = Platform.environment['BPSD_PATH'];
    final executablePath = _executablePath;
    if (executablePath != null) {
      candidates.add(executablePath);
    }
    if (envPath != null && envPath.isNotEmpty) {
      candidates.add(envPath);
    }

    _addWalkUpCandidates(candidates, File(Platform.resolvedExecutable).parent);
    _addWalkUpCandidates(candidates, Directory.current);
    candidates.add(Platform.isWindows ? 'bpsd.exe' : 'bpsd');
    candidates.add('bpsd');
    return candidates.toSet().toList();
  }

  Future<ProcessResult> _run(String executable, List<String> args) async {
    try {
      return await Process.run(executable, args).timeout(timeout);
    } on TimeoutException {
      throw RpcException(
        'bpsd command timed out: $executable ${args.join(' ')}',
      );
    } on ProcessException catch (error) {
      throw RpcException('bpsd executable failed: ${error.message}');
    }
  }

  void _addWalkUpCandidates(List<String> candidates, Directory start) {
    var current = start.absolute;
    for (var index = 0; index < 10; index++) {
      candidates.add('${current.path}${Platform.pathSeparator}bpsd.exe');
      candidates.add(
        '${current.path}${Platform.pathSeparator}chain${Platform.pathSeparator}bpsd.exe',
      );
      final parent = current.parent;
      if (parent.path == current.path) {
        break;
      }
      current = parent;
    }
  }
}
