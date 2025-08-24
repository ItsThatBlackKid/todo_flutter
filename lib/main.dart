import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:todo_flutter/app/view/app.dart';
import 'package:todo_flutter/di/service_locator.dart';
import 'package:todo_flutter/utils/storage_service.dart';

final getIt = GetIt.instance;



void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await setupServiceLocator();

  if (kDebugMode) {
    var storageService = StorageService();
    storageService.deletAllData();
  }

  runApp(const TodoApp());
}
