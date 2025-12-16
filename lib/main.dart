import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

import 'app/app_routes.dart';
import 'data/database.dart';
import 'viewmodels/user_viewmodel.dart';
import 'viewmodels/github_viewmodel.dart';
import 'repositories/github_repository.dart';
import 'services/github_service.dart';
import 'viewmodels/theme_viewmodel.dart';

// 🔽 РЕКЛАМА
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'services/ad_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (!kIsWeb) {
    await MobileAds.instance.initialize();
  }

  getAdService().init();

  final db = AppDatabase();

  final users = await db.select(db.users).get();
  debugPrint('USERS FROM DB: $users');

  runApp(
    MultiProvider(
      providers: [
        Provider<AppDatabase>(create: (_) => db),
        ChangeNotifierProvider(create: (_) => UserViewModel(db)),
        ChangeNotifierProvider(create: (_) => ThemeViewModel()),
        Provider(create: (_) => GitHubService()),
        ProxyProvider<GitHubService, GitHubRepository>(
          update: (_, service, __) => GitHubRepository(service),
        ),
        ChangeNotifierProxyProvider<GitHubRepository, GitHubViewModel>(
          create: (_) => GitHubViewModel(GitHubRepository(GitHubService())),
          update: (_, repo, __) => GitHubViewModel(repo),
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
    final themeVM = context.watch<ThemeViewModel>();

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
