import 'package:flutter/material.dart';
import '../repositories/github_repository.dart';

class GitHubViewModel extends ChangeNotifier {
  final GitHubRepository _repository;

  Map<String, dynamic>? _userData;
  bool _isLoading = false;

  GitHubViewModel(this._repository);

  Map<String, dynamic>? get userData => _userData;
  bool get isLoading => _isLoading;

  Future<void> loadUserData(String username) async {
    _isLoading = true;
    notifyListeners();

    _userData = await _repository.getUserStats(username);

    _isLoading = false;
    notifyListeners();
  }
}
