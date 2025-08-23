import 'package:todo_flutter/core/errors/failures/failure.dart';

class LocalStorageFailure extends Failure {
  final String message;
  final String code;
  final String serviceName;

  const LocalStorageFailure({
    required this.message,
    required this.code,
    required this.serviceName,
  });
  
  @override
  // TODO: implement props
  List<Object?> get props => [message, code, serviceName];
}
