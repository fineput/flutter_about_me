import 'package:flutter/foundation.dart';
import '../data/database.dart';
import '../repositories/user_repository.dart';

class UserViewModel extends ChangeNotifier {
  final UserRepository _repository;

  List<User> _users = [];
  List<User> get users => _users;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  UserViewModel(AppDatabase db) : _repository = UserRepository(db) {
    loadUsers();
  }

  // ---------- LOAD ----------
  Future<void> loadUsers() async {
    _isLoading = true;
    notifyListeners();

    _users = await _repository.getAll();

    _isLoading = false;
    notifyListeners();
  }

  // ---------- ADD ----------
  Future<void> addUser({
    required String name,
    required String description,
    String? githubUsername,
  }) async {
    await _repository.add(
      name: name,
      description: description,
      githubUsername: githubUsername,
    );

    await loadUsers();
  }

  // ---------- DUPLICATE ----------
  Future<void> duplicateUser(User user) async {
    await _repository.duplicate(user);
    await loadUsers();
  }

  // ---------- DELETE ----------
  Future<void> deleteUser(int id) async {
    await _repository.delete(id);
    await loadUsers();
  }
}
