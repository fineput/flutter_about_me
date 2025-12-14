import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/user_viewmodel.dart';
import 'about_view.dart';
import 'user_form_view.dart';

class UserListView extends StatelessWidget {
  const UserListView({super.key});

  @override
  Widget build(BuildContext context) {
    final userVM = Provider.of<UserViewModel>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Мої резюме')),
      body: userVM.users.isEmpty
          ? const Center(
              child: Text(
                'Резюме ще немає',
                style: TextStyle(color: Colors.grey),
              ),
            )
          : ListView.builder(
              itemCount: userVM.users.length,
              itemBuilder: (context, index) {
                final user = userVM.users[index];

                return Card(
                  margin: const EdgeInsets.all(8),
                  child: ListTile(
                    title: Text(
                      user.name.isNotEmpty
                          ? user.name
                          : 'Без імені',
                    ),
                    subtitle: Text(
                      user.description.isNotEmpty
                          ? user.description
                          : 'Опис відсутній',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),

                    
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => AboutView(
                            name: user.name,
                            description: user.description,
                            githubUsername: user.githubUsername,
                          ),
                        ),
                      );
                    },

                    
                    trailing: IconButton(
                      icon: const Icon(Icons.copy),
                      tooltip: 'Дублювати',
                      onPressed: () {
                        userVM.duplicateUser(user);
                      },
                    ),
                  ),
                );
              },
            ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const UserFormView(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
