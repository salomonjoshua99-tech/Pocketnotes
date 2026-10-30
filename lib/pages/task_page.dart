import 'package:flutter/material.dart';

import '../data/task_database.dart';
import '../molecule/task_editor_dialog.dart';
import '../template/task_page_template.dart';
import '../models/task_record.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({super.key, required this.database, required this.tasks, required this.isLoading, required this.loadError, required this.isDark, required this.onToggleTheme, required this.onTasksChanged});

  final TaskDatabase database;
  final List<TaskRecord> tasks;
  final bool isLoading;
  final Object? loadError;
  final bool isDark;
  final VoidCallback onToggleTheme;
  final Future<void> Function() onTasksChanged;

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {

  Future<void> _refresh() => widget.onTasksChanged();

  Future<void> _edit([TaskRecord? record]) async {
    final result = await showDialog<TaskInput>(context: context, builder: (_) => TaskEditorDialog(record: record));
    if (result == null) return;
    try {
      if (record == null) {
        await widget.database.insert(result.task, result.dueDate);
      } else {
        await widget.database.update(record, result.task, result.dueDate);
      }
      await widget.onTasksChanged();
    } catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not save task: $error')),
      );
    }
  }

  Future<void> _delete(TaskRecord record) async {
    try {
      await widget.database.delete(record);
      await widget.onTasksChanged();
    } catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not delete task: $error')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    if (widget.loadError != null) {
      return Scaffold(
        body: Center(
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Text('Could not load tasks: ${widget.loadError}'),
            const SizedBox(height: 12),
            FilledButton(onPressed: widget.onTasksChanged, child: const Text('Try again')),
          ]),
        ),
      );
    }
    return TaskPageTemplate(
      tasks: widget.tasks,
      isDark: widget.isDark,
      onToggleTheme: widget.onToggleTheme,
      onAddTask: () => _edit(),
      onRefresh: _refresh,
      onEditTask: (record) => _edit(record),
      onDeleteTask: _delete,
    );
  }
}
