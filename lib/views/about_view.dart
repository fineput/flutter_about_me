import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../viewmodels/github_viewmodel.dart';

class AboutView extends StatelessWidget {
  final String name;
  final String description;
  final String? githubUsername;

  const AboutView({
    super.key,
    required this.name,
    required this.description,
    this.githubUsername,
  });

  @override
  Widget build(BuildContext context) {
    final githubViewModel = Provider.of<GitHubViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(name.isNotEmpty ? name : 'Резюме'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ===== ОПИС =====
              Text(
                description.isNotEmpty
                    ? description
                    : 'Опис відсутній',
                style: const TextStyle(fontSize: 18),
              ),

              const SizedBox(height: 30),

              // ===== GITHUB =====
              const Text(
                'GitHub статистика',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),

              // якщо username немає
              if (githubUsername == null || githubUsername!.isEmpty)
                const Text(
                  'GitHub username не вказаний',
                  style: TextStyle(color: Colors.grey),
                )

              // якщо йде завантаження
              else if (githubViewModel.isLoading)
                const Center(child: CircularProgressIndicator())

              // якщо ще не завантажували
              else if (githubViewModel.userData == null)
                ElevatedButton(
                  onPressed: () {
                    githubViewModel.loadUserData(githubUsername!);
                  },
                  child: const Text('Завантажити GitHub дані'),
                )

              // якщо дані є
              else
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundImage: NetworkImage(
                            githubViewModel.userData!['avatar_url'],
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          githubViewModel.userData!['name'] ??
                              githubUsername!,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
                        'Публічні репозиторії: ${githubViewModel.userData!['public_repos']}'),
                    Text(
                        'Підписники: ${githubViewModel.userData!['followers']}'),
                    Text(
                        'Підписки: ${githubViewModel.userData!['following']}'),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
