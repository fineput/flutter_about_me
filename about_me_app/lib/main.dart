import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'services/github_service.dart';
import 'repositories/github_repository.dart';
import 'viewmodels/github_viewmodel.dart';
import 'app/app.dart'; 

void main() {
  runApp(
    MultiProvider(
      providers: [
        Provider(create: (_) => GitHubService()),
        ProxyProvider<GitHubService, GitHubRepository>(
          update: (_, service, __) => GitHubRepository(service),
        ),
        ChangeNotifierProxyProvider<GitHubRepository, GitHubViewModel>(
          create: (_) => GitHubViewModel(GitHubRepository(GitHubService())),
          update: (_, repo, vm) => GitHubViewModel(repo),
        ),
      ],
      child: const App(), 
    ),
  );
}
