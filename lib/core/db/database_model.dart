import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
abstract class DatabaseModel extends Equatable {
  const DatabaseModel([List properties = const <dynamic>[]]);

  Map<String, Object?> toMap();
  String get tableName;
  const DatabaseModel.fromMap(Map<String, Object?> map);
}
