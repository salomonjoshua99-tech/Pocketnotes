import 'package:flutter/material.dart';

import '../models/task_record.dart';
import '../molecule/app_bar_brand.dart';
import '../organism/task_list.dart';

class TaskPageTemplate extends StatelessWidget {
  const TaskPageTemplate({
    super.key,
    required this.tasks,
    required this.isDark,
    required this.onToggleTheme,
    required this.onAddTask,
    required this.onRefresh,
    required this.onEditTask,
    required this.onDeleteTask,
  });

  final List<TaskRecord> tasks;
  final bool isDark;
  final VoidCallback onToggleTheme;
  final VoidCallback onAddTask;
  final Future<void> Function() onRefresh;
  final ValueChanged<TaskRecord> onEditTask;
  final ValueChanged<TaskRecord> onDeleteTask;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final today = DateTime.now();
    final dueToday = tasks.where((task) => task.dueDate.year == today.year && task.dueDate.month == today.month && task.dueDate.day == today.day).length;
    return Scaffold(
      appBar: AppBar(
        title: const AppBarBrand(),
        actions: [
          IconButton(
            tooltip: isDark ? 'Switch to light theme' : 'Switch to dark theme',
            onPressed: onToggleTheme,
            icon: Icon(isDark ? Icons.light_mode_outlined : Icons.dark_mode_outlined),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: onRefresh,
          child: ListView(
            padding: const EdgeInsets.fromLTRB(22, 22, 22, 100),
            children: [
              Text('YOUR SPACE', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, letterSpacing: 2, color: colors.primary)),
              const SizedBox(height: 8),
              Text('Make room for\nwhat matters.', style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w700, height: 1.12, letterSpacing: -1)),
              const SizedBox(height: 10),
              Text(
                tasks.isEmpty ? 'A little clarity goes a long way.' : '${tasks.length} ${tasks.length == 1 ? 'task' : 'tasks'} in your list · $dueToday due today',
                style: TextStyle(color: colors.onSurfaceVariant),
              ),
              const SizedBox(height: 28),
              TaskList(tasks: tasks, onEdit: onEditTask, onDelete: onDeleteTask),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(onPressed: onAddTask, icon: const Icon(Icons.add), label: const Text('Add task')),
    );
  }
}
