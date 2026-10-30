import 'package:sqflite/sqflite.dart';

import '../models/task_record.dart';

/// Opens the database once at startup; the resulting instance is injected into
/// the app and reused for every task operation.
class TaskDatabase {
  TaskDatabase._(this.database);

  final Database database;
  static const table = 'tasks';

  static Future<TaskDatabase> open() async {
    final path = '${await getDatabasesPath()}/tasks.db';
    final db = await openDatabase(path, version: 1, onCreate: (db, version) async {
      await db.execute('''CREATE TABLE tasks (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        task TEXT NOT NULL,
        due_date TEXT NOT NULL
      )''');
    });
    return TaskDatabase._(db);
  }

  Future<List<TaskRecord>> all() async {
    final rows = await database.query(table, orderBy: 'due_date ASC, id DESC');
    return rows.map(TaskRecord.fromMap).toList();
  }

  Future<void> insert(String task, DateTime dueDate) async {
    await database.insert(table, {'task': task, 'due_date': _date(dueDate)});
  }

  Future<void> update(TaskRecord record, String task, DateTime dueDate) async {
    await database.update(table, {'task': task, 'due_date': _date(dueDate)},
        where: 'id = ?', whereArgs: [record.id]);
  }

  Future<void> delete(TaskRecord record) async {
    await database.delete(table, where: 'id = ?', whereArgs: [record.id]);
  }

  static String _date(DateTime date) =>
      '${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
}
