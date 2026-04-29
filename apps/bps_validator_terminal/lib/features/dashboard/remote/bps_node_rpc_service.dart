import '../../../core/network/comet_bft_rpc_client.dart';
import '../domain/bps_rpc_snapshot.dart';

class BpsNodeRpcService {
  BpsNodeRpcService({CometBftRpcClient? client})
    : _client = client ?? CometBftRpcClient();

  final CometBftRpcClient _client;

  Future<BpsRpcSnapshot> fetchSnapshot() async {
    final startedAt = DateTime.now();
    final status = await _client.getJson('/status');
    final netInfo = await _tryGet('/net_info');
    final validators = await _tryGet(
      '/validators',
      queryParameters: {'per_page': '100'},
    );
    final block = await _tryGet('/block');
    final txSearch = await _tryGet(
      '/tx_search',
      queryParameters: {
        'query': '"tx.height>0"',
        'prove': 'false',
        'page': '1',
        'per_page': '10',
        'order_by': '"desc"',
      },
    );
    final mempool = await _tryGet(
      '/unconfirmed_txs',
      queryParameters: {'limit': '50'},
    );
    final latency = DateTime.now().difference(startedAt);

    return BpsRpcSnapshot.fromRpc(
      rpcEndpoint: _client.baseUri.toString(),
      rpcLatency: latency,
      status: status,
      netInfo: netInfo,
      validators: validators,
      block: block,
      txSearch: txSearch,
      mempool: mempool,
    );
  }

  Future<Map<String, Object?>?> _tryGet(
    String path, {
    Map<String, String>? queryParameters,
  }) async {
    try {
      return await _client.getJson(path, queryParameters: queryParameters);
    } catch (_) {
      return null;
    }
  }

  void dispose() {
    _client.close();
  }
}
