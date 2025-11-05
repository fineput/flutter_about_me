import 'package:flutter/material.dart';
import '../repositories/user_repository.dart';
import '../models/user_model.dart';

class UserListViewModel extends ChangeNotifier {
  final UserRepository _repository;
  late List<UserModel> _users;

  UserListViewModel(this._repository) {
    _users = _repository.getAllUsers();
  }

  List<UserModel> get users => _users;
}
