import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:todo_flutter/models/todo_model.dart';
import 'package:todo_flutter/pages/home/home_page.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => ChangeNotifierProvider(
        create: (context) => TodoModel(),
        child: HomePage(),
      ),
    ),
  ],
);
