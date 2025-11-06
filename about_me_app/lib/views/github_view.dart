import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/github_viewmodel.dart';
import 'package:url_launcher/url_launcher.dart';

class GitHubView extends StatelessWidget {
  final String username;

  const GitHubView({super.key, required this.username});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<GitHubViewModel>(context);

    final data = viewModel.userData;

    return Scaffold(
      appBar: AppBar(title: Text('GitHub: $username')),
      body: Center(
        child: viewModel.isLoading
            ? const CircularProgressIndicator()
            : data == null
                ? const Text('Не вдалося завантажити дані користувача.')
                : Card(
                    elevation: 3,
                    margin: const EdgeInsets.all(20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CircleAvatar(
                            radius: 40,
                            backgroundImage: NetworkImage(data['avatar_url']),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            (data['name'] != null && data['name'].toString().isNotEmpty)
                                ? data['name']
                                : data['login'],
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text('Публічні репозиторії: ${data['public_repos']}'),
                          Text('Підписники: ${data['followers']}'),
                          Text('Підписки: ${data['following']}'),
                          const SizedBox(height: 15),
                          ElevatedButton.icon(
                            onPressed: () async {
                              final url = Uri.parse('https://github.com/$username');
                              if (await canLaunchUrl(url)) {
                                await launchUrl(url, mode: LaunchMode.externalApplication);
                              }
                            },
                            icon: const Icon(Icons.open_in_new),
                            label: const Text('Відкрити GitHub'),
                          ),
                        ],
                      ),
                    ),
                  ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => viewModel.loadUserData(username),
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
