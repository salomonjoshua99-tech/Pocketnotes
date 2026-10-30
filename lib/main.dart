import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app/task_app.dart';
import 'data/task_database.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final database = await TaskDatabase.open();
  final preferences = SharedPreferencesAsync();
  final isDark = await preferences.getBool('dark_mode') ?? false;
  runApp(TaskApp(database: database, preferences: preferences, initialDarkMode: isDark));
}
