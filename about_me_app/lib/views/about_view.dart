import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../viewmodels/github_viewmodel.dart';

class AboutView extends StatelessWidget {
  final String name;
  final String description;

  const AboutView({
    super.key,
    required this.name,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    final githubViewModel = Provider.of<GitHubViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(name),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              
              Text(
                description,
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 30),

              
              const Text(
                'GitHub статистика',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),

              // Секція з даними GitHub
              if (githubViewModel.isLoading)
                const Center(child: CircularProgressIndicator())
              else if (githubViewModel.userData == null)
                Center(
                  child: ElevatedButton(
                    onPressed: () => githubViewModel.loadUserData('fineput'), // 👈 заміни на свій GitHub username
                    child: const Text('Завантажити GitHub дані'),
                  ),
                )
              else
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage(
                            githubViewModel.userData!['avatar_url'],
                          ),
                          radius: 30,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          githubViewModel.userData!['name'] ?? 'Без імені',
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w600),
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
