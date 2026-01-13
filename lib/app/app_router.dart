import 'package:go_router/go_router.dart';
import '../core/di/injector.dart';
import '../features/auth/data/auth_session.dart';
import '../features/auth/presentation/pages/login_page.dart';
import '../features/home/presentation/pages/home_page.dart';

class AppRouter {
  static GoRouter get router => GoRouter(
        initialLocation: '/',
        routes: [
          GoRoute(
            path: '/',
            redirect: (context, state) async {
              final session = sl<AuthSession>();
              final isLoggedIn = await session.isLoggedIn();

              return isLoggedIn ? '/home' : '/login';
            },
          ),
          GoRoute(
            path: '/login',
            builder: (context, state) => const LoginPage(),
          ),
          GoRoute(
            path: '/home',
            builder: (context, state) => const HomePage(),
          ),
        ],
      );
}
