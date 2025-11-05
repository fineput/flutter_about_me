import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../app/app_routes.dart';
import '../viewmodels/user_viewmodel.dart';
import '../models/user_model.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = UserViewModel();
    final List<UserModel> users = viewModel.users;

    return Scaffold(
      appBar: AppBar(title: const Text('Список резюме')),
      body: ListView.separated(
        itemCount: users.length,
        separatorBuilder: (_, __) => const Divider(height: 1),
        itemBuilder: (context, index) {
          final user = users[index];
          return ListTile(
            leading: const CircleAvatar(child: Icon(Icons.person)),
            title: Text(user.name),
            subtitle: Text(user.description),
            onTap: () {
              context.push(
                AppRoutes.about,
                extra: user,
              );
            },
          );
        },
      ),
    );
  }
}
