import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:todo_flutter/app/view/app.dart';
import 'package:todo_flutter/utils/storage_service.dart';

final getIt = GetIt.instance;

Future<void> loadDependencies() async {
  // Initialize any dependencies here if needed
  await StorageService().init();
}

void injectDependencies() {
  // Initialize any dependencies here if needed
  getIt.registerSingleton<StorageService>(StorageService());
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await loadDependencies();
  injectDependencies();

  if (kDebugMode) {
    var storageService = StorageService();
    storageService.deletAllData();
  }

  runApp(const TodoApp());
}
