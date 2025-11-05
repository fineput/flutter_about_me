import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../views/home_view.dart';
import '../views/about_view.dart';
import '../models/user_model.dart';
import 'app_routes.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: AppRoutes.home,
      builder: (context, state) => const HomeView(),
    ),
    GoRoute(
      path: AppRoutes.about,
      builder: (context, state) {
        final user = state.extra as UserModel;
        return AboutView(name: user.name, description: user.description);
      },
    ),
  ],
);

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Resume Builder',
      routerConfig: router,
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.blue),
    );
  }
}
