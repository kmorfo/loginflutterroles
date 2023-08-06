import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:skeleton/src/features/admin/admin.dart';
import 'package:skeleton/src/features/user/presentation/screens/user_home.dart';

import '../../features/auth/auth.dart';
import '../../features/loading/loading.dart';
import '../../features/settings/settings.dart';

import 'app_router_notifier.dart';

final goRouterProvier = Provider((ref) {
  final goRouterNotifier = ref.read(goRouterNotifierProvider);
  return GoRouter(
    initialLocation: '/',
    refreshListenable: goRouterNotifier,
    routes: [
      ///* User Screen
      GoRoute(
        path: '/',
        builder: (context, state) => const UserScreen(),
      ),

      ///* Admin Screen
      GoRoute(
        path: '/admin',
        builder: (context, state) => const AdminScreen(),
      ),

      ///* Pantalla de carga y comprobaciones
      GoRoute(
        path: '/loading',
        builder: (context, state) => const LoadingScreen(),
      ),

      ///* Auth Routes
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/register',
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
        path: '/recovery-password',
        builder: (context, state) => const RecoverPasswordScreen(),
      ),
      GoRoute(
        path: '/reset-password/:token',
        builder: (context, state) {
          final token = state.pathParameters['token'] ?? '0';
          return (token != '0') ? ResetPasswordScreen(token: token) : const LoginScreen();
        },
      ),

      ///* Shared Screens
      GoRoute(
        path: '/settings',
        builder: (context, state) => const SettingsScreen(),
      ),
    ],
    redirect: (context, state) {
      final isGoingTo = state.matchedLocation;
      final authStatus = goRouterNotifier.authStatus;

      //Obtenemos el rol del usuario para redirigir a la pantalla user o admin
      final authState = ref.watch(authProvider.notifier).state;
      final bool isAdmin = authState.user?.isAdmin ?? false;

      if ((isGoingTo == '/' || isGoingTo == '/admin') && authStatus == AuthStatus.checking) {
        return '/loading';
      }

      if (authStatus == AuthStatus.notAuthenticated) {
        if (isGoingTo == '/login' ||
            isGoingTo.startsWith('/reset-password') ||
            isGoingTo == '/recovery-password' ||
            isGoingTo == '/register') return null;

        return '/login';
      }

      //Cuando estamos autenticados, redirigiremos a la pantalla del usuario, evitando que navege a las de login
      if (authStatus == AuthStatus.authenticated) {
        if (isGoingTo == '/login' ||
            isGoingTo == '/register' ||
            isGoingTo == '/recovery-password' ||
            isGoingTo.startsWith('/reset-password') ||
            isGoingTo == '/loading') {
          return isAdmin ? '/admin' : '/';
        }
      }
      return null;
    },
  );
});
