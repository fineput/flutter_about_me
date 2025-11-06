class UserModel {
  final String name;
  final String description;
  final String githubUsername;

  UserModel({
    required this.name,
    required this.description,
    this.githubUsername = '',
  });
}
