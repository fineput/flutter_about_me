import '../services/github_service.dart';

class GitHubRepository {
  final GitHubService _service;

  GitHubRepository(this._service);

  Future<Map<String, dynamic>?> getUserStats(String username) async {
    return await _service.fetchUserData(username);
  }
}
