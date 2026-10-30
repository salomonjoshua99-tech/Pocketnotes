import 'package:flutter/material.dart';

import '../models/task_record.dart';
import '../atom/due_date_picker_button.dart';
import '../atom/eyebrow_label.dart';
import '../atom/task_title_field.dart';

class TaskInput {
  const TaskInput(this.task, this.dueDate);
  final String task;
  final DateTime dueDate;
}

class TaskEditorDialog extends StatefulWidget {
  const TaskEditorDialog({super.key, this.record});

  final TaskRecord? record;

  @override
  State<TaskEditorDialog> createState() => _TaskEditorDialogState();
}

class _TaskEditorDialogState extends State<TaskEditorDialog> {
  late final TextEditingController _controller = TextEditingController(text: widget.record?.task ?? '');
  late DateTime _dueDate = widget.record?.dueDate ?? DateTime.now();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => AlertDialog(
        title: Text(widget.record == null ? 'Add a task' : 'Edit task'),
        content: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
          TaskTitleField(controller: _controller),
          const SizedBox(height: 8),
          const EyebrowLabel('Due date', letterSpacing: 1.2),
          const SizedBox(height: 6),
          DueDatePickerButton(date: _dueDate, onChanged: (value) => setState(() => _dueDate = value)),
        ]),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          FilledButton(
            onPressed: () {
              final task = _controller.text.trim();
              if (task.isNotEmpty) Navigator.pop(context, TaskInput(task, _dueDate));
            },
            child: const Text('Save'),
          ),
        ],
      );
}
