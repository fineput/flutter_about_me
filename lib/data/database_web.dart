import 'package:drift/web.dart';
import 'package:drift/drift.dart';

LazyDatabase openConnection() {
  return LazyDatabase(() async {
    return WebDatabase('resume_builder_db');
  });
}
