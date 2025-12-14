import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/user_viewmodel.dart';

class UserFormView extends StatefulWidget {
  const UserFormView({super.key});

  @override
  State<UserFormView> createState() => _UserFormViewState();
}

class _UserFormViewState extends State<UserFormView> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _githubController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _githubController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userVM = context.read<UserViewModel>();

    return Scaffold(
      appBar: AppBar(title: const Text('Нове резюме')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Імʼя'),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Введіть імʼя' : null,
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: 'Опис'),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Введіть опис' : null,
              ),
              TextFormField(
                controller: _githubController,
                decoration:
                    const InputDecoration(labelText: 'GitHub username'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    await userVM.addUser(
                      name: _nameController.text,
                      description: _descriptionController.text,
                      githubUsername: _githubController.text.isEmpty
                          ? null
                          : _githubController.text,
                    );

                    Navigator.pop(context);
                  }
                },
                child: const Text('Зберегти'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
