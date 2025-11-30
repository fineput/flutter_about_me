import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_model.dart';

class UserRepository {
  static const String storageKey = 'saved_users';

  List<UserModel> _users = [];

  UserRepository() {
    loadUsers();
  }

  // ---------- LOAD FROM STORAGE ----------
  Future<void> loadUsers() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(storageKey);

    if (jsonString == null) return;

    final List decoded = jsonDecode(jsonString);
    _users = decoded.map((e) => UserModel.fromJson(e)).toList();
  }

  // ---------- SAVE TO STORAGE ----------
  Future<void> saveUsers() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = _users.map((u) => u.toJson()).toList();
    await prefs.setString(storageKey, jsonEncode(jsonList));
  }

  List<UserModel> getAll() => _users;

  // ---------- MODIFY DATA ----------
  Future<void> add(UserModel user) async {
    _users.add(user);
    await saveUsers();
  }

  Future<void> duplicate(UserModel user) async {
    _users.add(user.clone());
    await saveUsers();
  }
}
