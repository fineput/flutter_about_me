import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../app/app_routes.dart';
import '../viewmodels/user_viewmodel.dart';
import '../models/user_model.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    // ✅ Отримуємо ViewModel із Provider
    final viewModel = Provider.of<UserViewModel>(context);
    final List<UserModel> users = viewModel.users;

    return Scaffold(
      appBar: AppBar(title: const Text('Список резюме')),
      body: users.isEmpty
          ? const Center(child: Text('Поки що немає жодного резюме'))
          : ListView.separated(
              itemCount: users.length,
              separatorBuilder: (_, __) => const Divider(height: 1),
              itemBuilder: (context, index) {
                final user = users[index];
                return ListTile(
                  leading: const CircleAvatar(child: Icon(Icons.person)),
                  title: Text(user.name),
                  subtitle: Text(user.description),
                  onTap: () {
                    // 👉 Перехід на сторінку перегляду резюме
                    context.push(
                      AppRoutes.about,
                      extra: user,
                    );
                  },
                  onLongPress: () {
                    // ✳️ Дублювання існуючого резюме
                    final duplicated = UserModel(
                      name: '${user.name} (копія)',
                      description: user.description,
                      githubUsername: user.githubUsername,
                    );
                    viewModel.addUser(duplicated);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Резюме "${user.name}" дубльовано')),
                    );
                  },
                );
              },
            ),

      // ➕ Додавання нового резюме
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.push(AppRoutes.form);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
