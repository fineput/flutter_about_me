import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/user_model.dart';
import '../viewmodels/user_viewmodel.dart';
import 'user_form_view.dart';

class UserListView extends StatelessWidget {
  const UserListView({super.key});

  @override
  Widget build(BuildContext context) {
    final userVM = Provider.of<UserViewModel>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Мої резюме')),
      body: ListView.builder(
        itemCount: userVM.users.length,
        itemBuilder: (context, index) {
          final user = userVM.users[index];
          return Card(
            margin: const EdgeInsets.all(8),
            child: ListTile(
              title: Text(user.name),
              subtitle: Text(user.description),
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
            MaterialPageRoute(builder: (context) => const UserFormView()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
