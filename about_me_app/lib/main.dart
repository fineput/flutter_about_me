import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app/app_routes.dart';
import 'viewmodels/user_viewmodel.dart';
import 'viewmodels/github_viewmodel.dart';
import 'repositories/github_repository.dart';
import 'services/github_service.dart';
import 'viewmodels/theme_viewmodel.dart'; // <-- додано

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserViewModel()),

        // ТЕМИ
        ChangeNotifierProvider(create: (_) => ThemeViewModel()),

        // GitHub services
        Provider(create: (_) => GitHubService()),
        ProxyProvider<GitHubService, GitHubRepository>(
          update: (_, service, __) => GitHubRepository(service),
        ),
        ChangeNotifierProxyProvider<GitHubRepository, GitHubViewModel>(
          create: (_) => GitHubViewModel(GitHubRepository(GitHubService())),
          update: (_, repo, vm) => GitHubViewModel(repo),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeVM = Provider.of<ThemeViewModel>(context);

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Resume Builder',

      // ТЕМИ
      theme: ThemeData.light(useMaterial3: true),
      darkTheme: ThemeData.dark(useMaterial3: true),
      themeMode: themeVM.isDark ? ThemeMode.dark : ThemeMode.light,

      routerConfig: AppRoutes.router,
    );
  }
}
