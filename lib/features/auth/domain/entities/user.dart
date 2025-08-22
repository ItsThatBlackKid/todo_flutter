class User {
  final String id;
  final String username;
  User({required this.id, required this.username});

  @override
  List<Object?> get props => [id, username];
}
