import 'package:flutter/foundation.dart';
import '../models/user_model.dart';
import '../repositories/user_repository.dart';

class UserViewModel extends ChangeNotifier {
  final UserRepository _repository = UserRepository();

  List<UserModel> get users => _repository.getAll();

  void addUser(UserModel user) {
    _repository.add(user);
    notifyListeners();
  }

  void duplicateUser(UserModel user) {
    _repository.duplicate(user);
    notifyListeners();
  }
}
