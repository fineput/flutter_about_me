import 'package:drift/drift.dart';

import 'database_stub.dart'
  if (dart.library.html) 'database_web.dart'
  if (dart.library.io) 'database_native.dart';

part 'database.g.dart';

class Users extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get description => text()();
  TextColumn get githubUsername => text().nullable()();
}

@DriftDatabase(tables: [Users])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(openConnection());

  @override
  int get schemaVersion => 1;
}
