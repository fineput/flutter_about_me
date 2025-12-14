import 'package:drift/drift.dart';
import '../data/database.dart';

class UserRepository {
  final AppDatabase db;

  UserRepository(this.db);

  // ---------- READ ----------
  Future<List<User>> getAll() {
    return db.select(db.users).get();
  }

  // ---------- CREATE ----------
  Future<void> add({
    required String name,
    required String description,
    String? githubUsername,
  }) async {
    await db.into(db.users).insert(
      UsersCompanion.insert(
        name: name,
        description: description,
        githubUsername: githubUsername == null
            ? const Value.absent()
            : Value(githubUsername),
      ),
    );
  }

  // ---------- DUPLICATE ----------
  Future<void> duplicate(User user) async {
    await add(
      name: user.name,
      description: user.description,
      githubUsername: user.githubUsername,
    );
  }

  // ---------- DELETE ----------
  Future<void> delete(int id) async {
    await (db.delete(db.users)..where((u) => u.id.equals(id))).go();
  }
}
