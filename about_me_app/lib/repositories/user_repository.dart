import '../models/user_model.dart';

class UserRepository {
  final List<UserModel> _users = [
    UserModel(
      name: 'Ярослав Олефіренко',
      description: 'Tech Support Manager з досвідом роботи з клієнтами, що прагне розвиватися як Team Lead.',
    ),
    UserModel(
      name: 'Анна Петрова',
      description: 'Маркетолог з креативним підходом до створення контенту та брендингу.',
    ),
  ];

  List<UserModel> getAllUsers() {
    return _users;
  }
}
