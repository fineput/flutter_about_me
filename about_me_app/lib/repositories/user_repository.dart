import '../models/user_model.dart';

class UserRepository {
  final List<UserModel> _users = [
    UserModel(
      name: 'Ярослав Олефіренко',
      description:
          'Tech Support Manager з досвідом роботи з клієнтами, що прагне розвиватися як Team Lead.',
      githubUsername: 'fineput',
    ),
    UserModel(
      name: 'Анна Петрова',
      description: 'Маркетолог з креативним підходом до створення контенту.',
    ),
  ];

  List<UserModel> getAll() => _users;

  void add(UserModel user) {
    _users.add(user);
  }

  void duplicate(UserModel user) {
    _users.add(user.clone());
  }
}
