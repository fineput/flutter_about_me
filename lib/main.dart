import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

import 'views/home_view.dart';


import 'app/app_routes.dart';
import 'data/database.dart';
import 'viewmodels/user_viewmodel.dart';
import 'viewmodels/github_viewmodel.dart';
import 'repositories/github_repository.dart';
import 'services/github_service.dart';
import 'viewmodels/theme_viewmodel.dart';

import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'services/ad_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (!kIsWeb) {
    await MobileAds.instance.initialize();
  }

  getAdService().init();

  /// create DB instance
  final db = AppDatabase();

  runApp(MyAppProviders(db));
}

class MyAppProviders extends StatelessWidget {
  final AppDatabase db;

  const MyAppProviders(this.db, {super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
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
    );
  }
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeVM = context.watch<ThemeViewModel>();

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'About Me App',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: themeVM.isDark ? ThemeMode.dark : ThemeMode.light,
      routerConfig: AppRoutes.router,
    );
  }
}

