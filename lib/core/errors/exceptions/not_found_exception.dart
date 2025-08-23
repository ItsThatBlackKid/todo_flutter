class NotFoundException implements Exception {
  final String message;

  NotFoundException(String message): this.message = 'Not Found: $message';

  @override
  String toString() => 'NotFoundException: $message';
}
