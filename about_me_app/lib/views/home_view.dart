import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../viewmodels/user_viewmodel.dart';
import '../app/app_routes.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = UserViewModel();
    final user = viewModel.user;

    return Scaffold(
      appBar: AppBar(title: const Text('Про мене')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 60,
              backgroundImage: NetworkImage(user.imageUrl),
            ),
            const SizedBox(height: 16),
            Text(user.name, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(user.bio, textAlign: TextAlign.center),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => context.go(AppRoutes.about),
              child: const Text('Детальніше'),
            ),
          ],
        ),
      ),
    );
  }
}
