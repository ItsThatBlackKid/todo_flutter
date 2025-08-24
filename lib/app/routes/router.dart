import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:todo_flutter/app/notifiers/auth_notifier.dart';
import 'package:todo_flutter/app/notifiers/todo_notifier.dart';
import 'package:todo_flutter/pages/home/home_page.dart';
import 'package:todo_flutter/features/auth/ui/screens/signup/signp_page.dart';

class AppRouter {
  final AuthNotifier _authNotifier;

  late final router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => ChangeNotifierProvider(
          create: (context) => TodoModel(),
          child: HomePage(),
        ),
      ),
      GoRoute(path: '/signup', builder: (context, state) => SignpPage()),
    ],
    refreshListenable: _authNotifier,
    redirect: (context, state) {
      final isAuthenticated = _authNotifier.isAuthenticated;

      if (!isAuthenticated && state.matchedLocation != '/signup' || !isAuthenticated && state.matchedLocation != '/signin' ) {
        return '/signup';
      }

      return null; // No redirect
    },
  );

  AppRouter(this._authNotifier);
}
