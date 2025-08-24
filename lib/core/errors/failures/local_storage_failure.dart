import 'package:todo_flutter/core/errors/failures/failure.dart';

class LocalStorageFailure extends Failure {
  final String code;
  final String serviceName;

  LocalStorageFailure({
    required super.message,
    required this.code,
    required this.serviceName,
  }) : super(properties: [code, serviceName]);
}
