import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:todo_flutter/notifiers/auth_notifier.dart';
import 'package:todo_flutter/pages/router.dart';
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

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AuthNotifier _authNotifier = AuthNotifier();
  late final AppRouter appRouter;

  @override
  void initState() {
    super.initState();
    appRouter = AppRouter(_authNotifier);
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _authNotifier,
      child: MaterialApp.router(
        debugShowCheckedModeBanner: true,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        routerConfig: appRouter.router,
      ),
    );
  }
}
