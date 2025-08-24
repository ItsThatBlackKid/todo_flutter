
class ExistsException implements Exception {
  final String message;

  ExistsException(String field, String value) : message = '$field with value $value already exists';

  @override
  String toString() => 'ExistsException: $message';
}
