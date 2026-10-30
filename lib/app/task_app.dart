import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/task_database.dart';
import '../models/task_record.dart';
import '../pages/task_page.dart';

class TaskApp extends StatefulWidget {
  const TaskApp({super.key, required this.database, required this.preferences, required this.initialDarkMode});

  final TaskDatabase database;
  final SharedPreferencesAsync preferences;
  final bool initialDarkMode;

  @override
  State<TaskApp> createState() => _TaskAppState();
}

class _TaskAppState extends State<TaskApp> {
  late bool _isDark = widget.initialDarkMode;
  List<TaskRecord> _tasks = const [];
  bool _isLoadingTasks = true;
  Object? _taskLoadError;

  @override
  void initState() {
    super.initState();
    _reloadTasks();
  }

  Future<void> _reloadTasks() async {
    try {
      final tasks = await widget.database.all();
      if (!mounted) return;
      setState(() {
        _tasks = tasks;
        _taskLoadError = null;
        _isLoadingTasks = false;
      });
    } catch (error) {
      if (!mounted) return;
      setState(() {
        _taskLoadError = error;
        _isLoadingTasks = false;
      });
    }
  }

  Future<void> _toggleTheme() async {
    final next = !_isDark;
    setState(() => _isDark = next);
    await widget.preferences.setBool('dark_mode', next);
  }

  @override
  Widget build(BuildContext context) {
    const seed = Color(0xFF4D6B57);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Daymark',
      themeMode: _isDark ? ThemeMode.dark : ThemeMode.light,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: seed),
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF7F8F5),
        cardTheme: const CardThemeData(elevation: 0),
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: seed, brightness: Brightness.dark),
        useMaterial3: true,
        cardTheme: const CardThemeData(elevation: 0),
      ),
      home: TaskPage(
        database: widget.database,
        tasks: _tasks,
        isLoading: _isLoadingTasks,
        loadError: _taskLoadError,
        isDark: _isDark,
        onToggleTheme: _toggleTheme,
        onTasksChanged: _reloadTasks,
      ),
    );
  }
}
