import 'package:equatable/equatable.dart';

class SignUpParams extends Equatable {
  final String username;
  final String password;

  const SignUpParams({required this.username, required this.password});

  @override
  // TODO: implement props
  List<Object?> get props => [username, password];
}
