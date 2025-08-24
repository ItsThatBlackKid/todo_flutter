
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_flutter/app/notifiers/auth_notifier.dart';
import 'package:todo_flutter/app/routes/router.dart';

class TodoApp extends StatefulWidget {
  const TodoApp({super.key});

  @override
  State<TodoApp> createState() => _TodoAppState();
}

class _TodoAppState extends State<TodoApp> {
  final _scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

  final AuthNotifier _authNotifier = AuthNotifier();
  late final AppRouter appRouter;

  @override
  void initState() {
    super.initState();
    appRouter = AppRouter(_authNotifier);
    appRouter.router.routerDelegate.addListener(() {
      _scaffoldMessengerKey.currentState?.removeCurrentSnackBar();
    });    
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
