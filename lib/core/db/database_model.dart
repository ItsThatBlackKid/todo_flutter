

import 'package:equatable/equatable.dart';

abstract class DatabaseModel extends Equatable {

  const DatabaseModel([List properties = const <dynamic>[]]);

  Map<String, Object?> toMap();
  DatabaseModel fromMap(Map<String, Object?> map);
  Map<String, Object?> toJson();
  DatabaseModel fromJson(Map<String, Object?> json);
  String get tableName;
}