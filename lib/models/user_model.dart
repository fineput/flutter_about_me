import 'dart:convert';

class UserModel {
  final String name;
  final String description;
  final String githubUsername;

  UserModel({
    required this.name,
    required this.description,
    this.githubUsername = '',
  });

  UserModel clone() {
    return UserModel(
      name: name,
      description: description,
      githubUsername: githubUsername,
    );
  }

  // ---- NEW ----

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'githubUsername': githubUsername,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'],
      description: json['description'],
      githubUsername: json['githubUsername'] ?? '',
    );
  }
}
