import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../viewmodels/user_viewmodel.dart';
import '../app/app_routes.dart';

class AboutView extends StatelessWidget {
  const AboutView({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = UserViewModel();
    final user = viewModel.user;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Детальніше'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go(AppRoutes.home),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Хобі: ${user.hobby}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 16),
            const Text('Контакти:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            const Text('Email: yaroslav@example.com'),
            const Text('Telegram: @fineput'),
          ],
        ),
      ),
    );
  }
}
