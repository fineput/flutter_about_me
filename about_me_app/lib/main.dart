import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart'; 

import 'app/app_routes.dart';
import 'viewmodels/user_viewmodel.dart';
import 'viewmodels/github_viewmodel.dart';
import 'repositories/github_repository.dart';
import 'services/github_service.dart';
import 'viewmodels/theme_viewmodel.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await MobileAds.instance.initialize();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserViewModel()),

        ChangeNotifierProvider(create: (_) => ThemeViewModel()),

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
      theme: ThemeData.light(useMaterial3: true),
      darkTheme: ThemeData.dark(useMaterial3: true),
      themeMode: themeVM.isDark ? ThemeMode.dark : ThemeMode.light,
      routerConfig: AppRoutes.router,
    );
  }
}
