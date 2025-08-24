import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_flutter/core/db/database_helper.dart';
import 'package:todo_flutter/core/services/services.dart';

final serviceLocator = GetIt.instance;

Future<void> setupServiceLocator() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  final secureStorage = FlutterSecureStorage();

  serviceLocator.registerLazySingleton(() => DatabaseHelper());

  // Register SharedPreferencesService
  serviceLocator.registerLazySingleton<LocalStorageService>(
    () => SharedPreferencesService(sharedPreferences),
  );

  // Register SecureStorageService
  serviceLocator.registerLazySingleton<AbstractSecureStorageService>(
    () => SecureStorageService(secureStorage: secureStorage),
  );


  
}
