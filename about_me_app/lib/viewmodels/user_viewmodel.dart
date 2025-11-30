import 'package:flutter/foundation.dart';
import '../models/user_model.dart';
import '../repositories/user_repository.dart';

class UserViewModel extends ChangeNotifier {
  final UserRepository _repository = UserRepository();

  List<UserModel> get users => _repository.getAll();

  // Завантаження збережених даних при запуску
  UserViewModel() {
    _load();
  }

  Future<void> _load() async {
    await _repository.loadUsers();
    notifyListeners();
  }

  Future<void> addUser(UserModel user) async {
    await _repository.add(user);
    notifyListeners();
  }

  Future<void> duplicateUser(UserModel user) async {
    await _repository.duplicate(user);
    notifyListeners();
  }
}
