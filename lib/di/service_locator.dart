import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_flutter/core/db/database_helper.dart';
import 'package:todo_flutter/core/services/services.dart';
import 'package:todo_flutter/features/auth/controller/repositories/auth_repository.dart';
import 'package:todo_flutter/features/auth/controller/usecases/signin.dart';
import 'package:todo_flutter/features/auth/controller/usecases/signup.dart';
import 'package:todo_flutter/features/auth/data/datasources/abstract_auth_secure_storage_data_source.dart';
import 'package:todo_flutter/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:todo_flutter/features/auth/data/datasources/auth_secure_storage_data_source.dart';
import 'package:todo_flutter/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:todo_flutter/features/auth/ui/notifiers/signin_notifier.dart';
import 'package:todo_flutter/features/auth/ui/notifiers/signup_notifier.dart';

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

  // Auth Feature
  serviceLocator.registerLazySingleton<AbstractAuthLocalDataSource>(
    () => AuthLocalDataSource(databaseHelper: serviceLocator()),
  );

  serviceLocator.registerLazySingleton<AbstractAuthSecureStorageDataSource>(
    () => AuthSecureStorageDataSource(serviceLocator()),
  );

  serviceLocator.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(serviceLocator(), serviceLocator()),
  );

  // Use Cases
  serviceLocator.registerLazySingleton(() => SignUpUseCase(serviceLocator()));
  serviceLocator.registerLazySingleton(() => SignInUseCase(serviceLocator()));

  // Notifiers
  serviceLocator.registerFactory(
    () => SignupNotifier(signupUseCase: serviceLocator()),
  );

  serviceLocator.registerFactory(
    () => SigninNotifier(signInUseCase: serviceLocator()),
  );
}
