import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/home/presentation/pages/home.dart';
import '../shared/model/user_model.dart';
import '../../features/login/presentation/pages/login_screen.dart';
import '../../features/message/presentation/pages/chat.dart';
import '../../features/message/presentation/pages/message.dart';
import '../../features/navigation_bar/presentation/pages/navigation_bar.dart';
import '../../features/profile/presentation/pages/profile.dart';
import '../../features/search/presentation/pages/search.dart';
import '../../features/splash/presentation/pages/splash.dart';
import 'route_name.dart';

//User
final _navigatorHome = GlobalKey<NavigatorState>();
final _navigatorSearch = GlobalKey<NavigatorState>();
final _navigatorMessage = GlobalKey<NavigatorState>();
final _navigatorProfile = GlobalKey<NavigatorState>();

/// The route configuration.
final GoRouter routerApp = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      name: RouteName().splash,
      builder: (context, state) {
        return const SplashScreen();
      },
    ),
    GoRoute(
      path: '/login',
      name: RouteName().login,
      builder: (context, state) {
        return const LoginScreen();
      },
    ),
    GoRoute(
      path: '/chat',
      name: RouteName().chat,
      builder: (context, state) {
        return ChatScreen(
          userChatTo: state.extra as UserModel,
        );
      },
    ),
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return MyNavigationBar(
          child: navigationShell,
        );
      },
      branches: [
        StatefulShellBranch(
          navigatorKey: _navigatorHome,
          routes: [
            GoRoute(
              path: "/home",
              name: RouteName().home,
              builder: (context, state) {
                return const HomeScreen();
              },
            )
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _navigatorSearch,
          routes: [
            GoRoute(
              path: "/search",
              name: RouteName().search,
              builder: (context, state) {
                return const SearchScreen();
              },
            )
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _navigatorMessage,
          routes: [
            GoRoute(
              path: "/message",
              name: RouteName().message,
              builder: (context, state) {
                return const MessageScreen();
              },
            )
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _navigatorProfile,
          routes: [
            GoRoute(
              path: "/profile",
              name: RouteName().profile,
              builder: (context, state) {
                return const ProfileScreen();
              },
            )
          ],
        ),
      ],
    )
  ],
);
