import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_flutter/core/services/local_storage/abstract_local_storage_service.dart';
import 'package:todo_flutter/core/services/local_storage/abstract_secure_storage_service.dart';
import 'package:todo_flutter/core/services/local_storage/secure_storage_service.dart';
import 'package:todo_flutter/core/services/local_storage/shared_preferences_service.dart';

final serviceLocator = GetIt.instance;

Future<void> setupServiceLocator() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  final secureStorage = FlutterSecureStorage();

  // Register SharedPreferencesService
  serviceLocator.registerLazySingleton<LocalStorageService>(
    () => SharedPreferencesService(sharedPreferences),
  );

  // Register SecureStorageService
  serviceLocator.registerLazySingleton<AbstractSecureStorageService>(
    () => SecureStorageService(secureStorage: secureStorage),
  );
}