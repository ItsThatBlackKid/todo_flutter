import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;
  final List<Object?> properties;
  const Failure({required this.message, this.properties = const []});

  @override
  List<Object?> get props => [message, ...properties];
}
