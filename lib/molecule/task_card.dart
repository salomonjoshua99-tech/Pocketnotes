import 'package:flutter/material.dart';

import '../models/task_record.dart';

class TaskCard extends StatelessWidget {
  const TaskCard({super.key, required this.task, required this.onEdit, required this.onDelete});

  final TaskRecord task;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  String get _date => '${_month(task.dueDate.month)} ${task.dueDate.day}, ${task.dueDate.year}';
  String _month(int month) => const ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'][month - 1];

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Card(
      color: colors.surfaceContainerLow,
      margin: const EdgeInsets.only(bottom: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 13, 8, 13),
        child: Row(children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(color: colors.primary.withValues(alpha: .1), borderRadius: BorderRadius.circular(13)),
            child: Icon(Icons.check_rounded, color: colors.primary),
          ),
          const SizedBox(width: 13),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(task.task, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15)),
            const SizedBox(height: 4),
            Row(children: [
              Icon(Icons.event_outlined, size: 14, color: colors.onSurfaceVariant),
              const SizedBox(width: 5),
              Text(_date, style: TextStyle(fontSize: 12, color: colors.onSurfaceVariant)),
            ]),
          ])),
          PopupMenuButton<String>(
            tooltip: 'Task options',
            onSelected: (value) => value == 'edit' ? onEdit() : onDelete(),
            itemBuilder: (_) => const [
              PopupMenuItem(value: 'edit', child: Text('Edit')),
              PopupMenuItem(value: 'delete', child: Text('Delete')),
            ],
          ),
        ]),
      ),
    );
  }
}
