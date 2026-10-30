import 'package:flutter/material.dart';

import '../models/task_record.dart';
import '../atom/eyebrow_label.dart';
import '../molecule/task_card.dart';

class TaskList extends StatelessWidget {
  const TaskList({super.key, required this.tasks, required this.onEdit, required this.onDelete});

  final List<TaskRecord> tasks;
  final ValueChanged<TaskRecord> onEdit;
  final ValueChanged<TaskRecord> onDelete;

  @override
  Widget build(BuildContext context) => Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text('Your tasks', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700)),
          EyebrowLabel('${tasks.length} total', letterSpacing: 1.2),
        ]),
        const SizedBox(height: 14),
        if (tasks.isEmpty)
          const _EmptyTaskState()
        else
          ...tasks.map((task) => TaskCard(task: task, onEdit: () => onEdit(task), onDelete: () => onDelete(task))),
      ]);
}

class _EmptyTaskState extends StatelessWidget {
  const _EmptyTaskState();

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(color: colors.surfaceContainerLow, borderRadius: BorderRadius.circular(22)),
      child: Column(children: [
        Container(
          width: 58,
          height: 58,
          decoration: BoxDecoration(color: colors.primary.withValues(alpha: .1), shape: BoxShape.circle),
          child: Icon(Icons.edit_note_rounded, size: 30, color: colors.primary),
        ),
        const SizedBox(height: 16),
        const Text('Start with one thing', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700)),
        const SizedBox(height: 6),
        Text('Add a task and give it a due date.\nIt’ll be here when you come back.', textAlign: TextAlign.center,
            style: TextStyle(color: colors.onSurfaceVariant, height: 1.45)),
      ]),
    );
  }
}
