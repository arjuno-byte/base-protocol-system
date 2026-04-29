class RpcException implements Exception {
  const RpcException(this.message, {this.statusCode});

  final String message;
  final int? statusCode;

  @override
  String toString() {
    final code = statusCode == null ? '' : ' ($statusCode)';
    return 'RpcException$code: $message';
  }
}
