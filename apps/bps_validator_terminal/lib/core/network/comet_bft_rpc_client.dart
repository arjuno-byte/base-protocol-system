import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'rpc_exception.dart';

class CometBftRpcClient {
  CometBftRpcClient({Uri? baseUri, this.timeout = const Duration(seconds: 2)})
    : baseUri = baseUri ?? Uri.parse('http://127.0.0.1:26657'),
      _client = HttpClient()..connectionTimeout = timeout;

  final Uri baseUri;
  final Duration timeout;
  final HttpClient _client;

  Future<Map<String, Object?>> getJson(
    String path, {
    Map<String, String>? queryParameters,
  }) async {
    final requestUri = baseUri.replace(
      path: path.startsWith('/') ? path : '/$path',
      queryParameters: queryParameters,
    );

    try {
      final request = await _client.getUrl(requestUri).timeout(timeout);
      request.headers.set(HttpHeaders.acceptHeader, 'application/json');

      final response = await request.close().timeout(timeout);
      final body = await response
          .transform(utf8.decoder)
          .join()
          .timeout(timeout);

      if (response.statusCode != HttpStatus.ok) {
        throw RpcException(
          'RPC returned HTTP ${response.statusCode}',
          statusCode: response.statusCode,
        );
      }

      final decoded = jsonDecode(body);
      if (decoded is! Map<String, dynamic>) {
        throw const RpcException('RPC returned invalid JSON object');
      }

      final rpcError = decoded['error'];
      if (rpcError != null) {
        throw RpcException('RPC error: $rpcError');
      }

      return Map<String, Object?>.from(decoded);
    } on TimeoutException catch (_) {
      throw RpcException('RPC timeout while calling $requestUri');
    } on SocketException catch (error) {
      throw RpcException('Cannot reach local RPC: ${error.message}');
    } on FormatException catch (error) {
      throw RpcException('Invalid RPC JSON: ${error.message}');
    }
  }

  void close() {
    _client.close(force: true);
  }
}
